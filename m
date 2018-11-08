Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A6D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M60xUu57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A6D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeKIHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbeKIHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C016E208A3;
        Thu,  8 Nov 2018 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714756;
        bh=DLyn47qxYj4dlRuAnhH82gByNHApHyZ0HxcV98cE2Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M60xUu57kSsl8zTeU7HNELXSngv4W/36ja9vWVre8m315K6rnISaFyi4wfDDJsM3n
         I0yx3Ic9p0DxNbug3ATobtnd17xPCKuuq3DMXBbMkCiyFre2QA+MRLlnLX1fnoX/L2
         1Zeg+2FgpIN/7MsEqBCRy0OOXLPG2KvGqMSE4p5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/171] usb: renesas_usbhs: gadget: fix spin_lock_init() for &uep->lock
Date:   Thu,  8 Nov 2018 13:50:49 -0800
Message-Id: <20181108215133.263428962@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



