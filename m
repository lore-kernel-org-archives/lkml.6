Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA54C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E355D20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOwSjIpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E355D20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbeKLJm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732811AbeKLIS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:27 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3212154B;
        Sun, 11 Nov 2018 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975311;
        bh=hhVpmHAkQIXVN6d7K5F5ShFL+gJCU/LTrEjQkx5Q59o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOwSjIpa5L9ikWbV0/FoiIhXJE+IEATeg/Wa/OwreuUfqVGepvNS4lzmIs3X0kF4F
         9iD36QklIyx5trNRZDKtJ7CEuVPPi/rSwwuL+E3AlBGbl0yjA68OOXQXhhLf/4HIe0
         tLNsjQt1n2BYy0XuRX/HfK1py2r8pLNMBOEoBCus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 292/361] net: bcmgenet: fix OF child-node lookup
Date:   Sun, 11 Nov 2018 14:20:39 -0800
Message-Id: <20181111221656.775078508@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit d397dbe606120a1ea1b11b0020c3f7a3852da5ac upstream.

Use the new of_get_compatible_child() helper to lookup the mdio child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: David S. Miller <davem@davemloft.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -342,7 +342,7 @@ static struct device_node *bcmgenet_mii_
 	if (!compat)
 		return NULL;
 
-	priv->mdio_dn = of_find_compatible_node(dn, NULL, compat);
+	priv->mdio_dn = of_get_compatible_child(dn, compat);
 	kfree(compat);
 	if (!priv->mdio_dn) {
 		dev_err(kdev, "unable to find MDIO bus node\n");


