Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC37ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F6320869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co9mKufj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeJYWsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbeJYWse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:34 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5597B2085B;
        Thu, 25 Oct 2018 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476937;
        bh=wOc5kPQ70iLUHv+kQwC8LvSjMpuN8n5k2tyy8jB552U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Co9mKufjPkP3d+yvybOdG3+uwdJxIQYdo5oHk160Oh3vwVXLWS8qRHM1h5Ycnhrjl
         ei22vi7NIivuB0rGUpWb4tbpOquQJXIMNNKKU2/kkJRYZNFk5JvI8pAgLIN9rQApUq
         4/UvERaJYAKSQE26tO2pgpVeqwO8BBvy4ihQGDJs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 49/98] usb: renesas_usbhs: gadget: fix spin_lock_init() for &uep->lock
Date:   Thu, 25 Oct 2018 10:13:34 -0400
Message-Id: <20181025141423.213774-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 14a8d4bfc2102f85ce097563d151370c91c1898a ]

This patch fixes an issue that the spin_lock_init() is not called
for almost all pipes. Otherwise, the lockdep output the following
message when we connect a usb cable using g_ncm:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.

Reported-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Fixes: b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps when the driver stops")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 93fba9033b00..54a3237aac08 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1085,7 +1085,6 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		ret = -ENOMEM;
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
-	spin_lock_init(&uep->lock);
 
 	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
@@ -1135,6 +1134,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		uep->ep.name		= uep->ep_name;
 		uep->ep.ops		= &usbhsg_ep_ops;
 		INIT_LIST_HEAD(&uep->ep.ep_list);
+		spin_lock_init(&uep->lock);
 
 		/* init DCP */
 		if (usbhsg_is_dcp(uep)) {
-- 
2.17.1

