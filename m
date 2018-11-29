Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F9C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673252146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiwDK/1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673252146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbeK3Bc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbeK3BcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2262F2145D;
        Thu, 29 Nov 2018 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501613;
        bh=I+MgIhWl17b+Yy5SPJJ2d/DNeHQW9fGpBx5vJJFW+PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiwDK/1QQJjxMQSuMOgE5iQTLpkAi4LoP3XMCnwBR3cX9LT8svrJkT9cK2lLF7O+K
         /0FetONIyiZxs9HE2Wul28wghgbdEZIzkhnF/RV9TzZai3wCC4HtkBj+IOR6PztG4w
         r2jrQp0W9o2r6sLLWNQW5ABDN4ynR8AmdLO/ZGzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 069/100] power: supply: twl4030-charger: fix OF sibling-node lookup
Date:   Thu, 29 Nov 2018 15:12:39 +0100
Message-Id: <20181129140104.857998365@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9844fb2e351311210e6660a9a1c62d17424a6145 ]

Use the new of_get_compatible_child() helper to lookup the usb sibling
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related phy-node reference leak.

Fixes: f5e4edb8c888 ("power: twl4030_charger: find associated phy by more reliable means.")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index a5915f498eea..0cc12bfe7b02 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -996,12 +996,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	if (bci->dev->of_node) {
 		struct device_node *phynode;
 
-		phynode = of_find_compatible_node(bci->dev->of_node->parent,
-						  NULL, "ti,twl4030-usb");
+		phynode = of_get_compatible_child(bci->dev->of_node->parent,
+						  "ti,twl4030-usb");
 		if (phynode) {
 			bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			of_node_put(phynode);
 			if (IS_ERR(bci->transceiver)) {
 				ret = PTR_ERR(bci->transceiver);
 				if (ret == -EPROBE_DEFER)
-- 
2.17.1



