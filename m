Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2182075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="DEIw7t0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2182075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeIGWWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:22:42 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:60319 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeIGWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:22:42 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id DDF23AE0B81;
        Fri,  7 Sep 2018 19:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536341716; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rbTc0Cze7uMG1Zf0ndLu9i1seMNFMJK4hMAr6DqnFmw=;
        b=DEIw7t0EiKmVlk6K64LKBz0IhpSBesFGTxlqs4/lXmPU9fFiQXkyS2LIfh6KZKgyc4XU0r
        XDlbFRf9dzpwCStGHdOMFWVxFeMHrn5s6Tv0R6AxZz526KQaNYcrZxPt/KoL58+bT/gaz3
        1NNUhMsLBcC0GEqj+2SssgyDdjkLxaco1pa+4VJaXM5iNmfo8YdiwwRSLRikPUll2ODHQt
        H9SZjjDN2z/ecrWF36ZNVMFJiczw8JP++eNXagIoglQ6R9o1UF2+edzbVDCTF/cc30zvBw
        a41IdVEC51O0kTK8Pc20F0ZW0yWo2ExP15+XeQpno0k70QpQKWySnha/4U5/ig==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mtd: core: add get_mtd_device_by_node
Date:   Fri,  7 Sep 2018 19:35:13 +0200
Message-Id: <20180907173515.19990-2-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907173515.19990-1-kernel@nospam.obeliks.de>
References: <20180907173515.19990-1-kernel@nospam.obeliks.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to retrieve a mtd device by its OF node. Since drivers can
assign arbitrary names to mtd devices in the absence of a label
property, there is no other reliable way to retrieve a mtd device for a
given OF node.

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/mtdcore.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 97ac219c082e..87dd63926bc9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -926,6 +926,44 @@ struct mtd_info *get_mtd_device_nm(const char *name)
 }
 EXPORT_SYMBOL_GPL(get_mtd_device_nm);
 
+/**
+ *	get_mtd_device_by_node - obtain a validated handle for an MTD device
+ *	by of_node
+ *	@of_node: OF node of MTD device to open
+ *
+ *	This function returns MTD device description structure in case of
+ *	success and an error code in case of failure.
+ */
+struct mtd_info *get_mtd_device_by_node(const struct device_node *of_node)
+{
+	int err = -ENODEV;
+	struct mtd_info *mtd = NULL, *other;
+
+	mutex_lock(&mtd_table_mutex);
+
+	mtd_for_each_device(other) {
+		if (of_node == other->dev.of_node) {
+			mtd = other;
+			break;
+		}
+	}
+
+	if (!mtd)
+		goto out_unlock;
+
+	err = __get_mtd_device(mtd);
+	if (err)
+		goto out_unlock;
+
+	mutex_unlock(&mtd_table_mutex);
+	return mtd;
+
+out_unlock:
+	mutex_unlock(&mtd_table_mutex);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(get_mtd_device_by_node);
+
 void put_mtd_device(struct mtd_info *mtd)
 {
 	mutex_lock(&mtd_table_mutex);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index cd0be91bdefa..fe71358f8eaa 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -570,6 +570,8 @@ extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
 extern int __get_mtd_device(struct mtd_info *mtd);
 extern void __put_mtd_device(struct mtd_info *mtd);
 extern struct mtd_info *get_mtd_device_nm(const char *name);
+extern struct mtd_info *get_mtd_device_by_node(
+		const struct device_node *of_node);
 extern void put_mtd_device(struct mtd_info *mtd);
 
 
-- 
2.17.1

