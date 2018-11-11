Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE720817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0v+AjgqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbeKLJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389795AbeKLIVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7FE224E0;
        Sun, 11 Nov 2018 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975502;
        bh=EI6jJY2Ht2oGvQzh2VxmkgBCNzaNeQ2lTsLmFAnR4O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0v+AjgqZnGWIdkuJW1iKn+3Sca49hqpEh7XKIgOIqlK9PEjz2K7Bc7sTquO2NqYE9
         luQ6zxHbnaVNqo4/8XT/OTNE7nHqQA+OiYoldHOXEiXWoU4VOIiaI7MpHwca6lHBD/
         ul2mPMQp7cx51O5Ohkkq2vUghXjt+4yedbVRskN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.18 280/350] power: supply: twl4030-charger: fix OF sibling-node lookup
Date:   Sun, 11 Nov 2018 14:22:24 -0800
Message-Id: <20181111221719.758385059@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9844fb2e351311210e6660a9a1c62d17424a6145 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/twl4030_charger.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -996,12 +996,13 @@ static int twl4030_bci_probe(struct plat
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


