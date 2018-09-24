Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879E2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbeIXSlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:41:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387912AbeIXSlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:41:14 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7766A1092;
        Mon, 24 Sep 2018 12:39:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.18 145/235] mmc: meson-mx-sdio: fix OF child-node lookup
Date:   Mon, 24 Sep 2018 13:52:11 +0200
Message-Id: <20180924113120.036334624@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

commit c483a5cc9d09f4ceaa9abb106f863cc89cb643d9 upstream.

Use the new of_get_compatible_child() helper to lookup the slot child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

While at it, also fix up the related slot-node reference leak.

Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Cc: stable <stable@vger.kernel.org>     # 4.15
Cc: Carlo Caione <carlo@endlessm.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/meson-mx-sdio.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -517,19 +517,23 @@ static struct mmc_host_ops meson_mx_mmc_
 static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
 {
 	struct device_node *slot_node;
+	struct platform_device *pdev;
 
 	/*
 	 * TODO: the MMC core framework currently does not support
 	 * controllers with multiple slots properly. So we only register
 	 * the first slot for now
 	 */
-	slot_node = of_find_compatible_node(parent->of_node, NULL, "mmc-slot");
+	slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
 	if (!slot_node) {
 		dev_warn(parent, "no 'mmc-slot' sub-node found\n");
 		return ERR_PTR(-ENOENT);
 	}
 
-	return of_platform_device_create(slot_node, NULL, parent);
+	pdev = of_platform_device_create(slot_node, NULL, parent);
+	of_node_put(slot_node);
+
+	return pdev;
 }
 
 static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)


