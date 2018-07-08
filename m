Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C7C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B0E208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B0E208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeGHPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:19:35 -0400
Received: from www.osadl.org ([62.245.132.105]:59958 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753825AbeGHPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:19:34 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w68FJQaX030104;
        Sun, 8 Jul 2018 17:19:26 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ARM: ux500: add missing of_node_put()
Date:   Sun,  8 Jul 2018 17:18:45 +0200
Message-Id: <1531063125-31813-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 of_find_compatible_node() returns a pointer with refcount incremented
so both in the error path as well as after usage in soc_info_populate()
respectively actually b8500_read_soc_id() an explicit of_node_put is
needed to release backupram.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 18a992787896 ("ARM: ux500: move soc_id driver to drivers/soc")
---

Problem located with experimental cocinelle script

get_maintainer.pl only returns linux-kernel@vger.kernel.org for
this file ? Is MAINTAINERS entry missing ?

Not really sure about the referenced fixes commit 18a992787896
("ARM: ux500: move soc_id driver to drivers/soc") the commit log notes
only that the driver is being moved and not expected to change (v4.8)
but looking at the previous version in v4.7 it does seem that while
moving the driver there was also a relevant change to the driver code
including the switch to using of_find_compatible_node().

Patch was compiletested with: u8500_defconfig (implies
ONFIG_UX500_SOC_ID=y)

Patch is against 4.18-rc3 (localversion-next is next-20180706)

 drivers/soc/ux500/ux500-soc-id.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ux500/ux500-soc-id.c b/drivers/soc/ux500/ux500-soc-id.c
index 6c1be74..e22597d 100644
--- a/drivers/soc/ux500/ux500-soc-id.c
+++ b/drivers/soc/ux500/ux500-soc-id.c
@@ -203,10 +203,13 @@ static int __init ux500_soc_device_init(void)
 	ux500_setup_id();
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
+	if (!soc_dev_attr) {
+		of_node_put(backupram);
 		return -ENOMEM;
+	}
 
 	soc_info_populate(soc_dev_attr, backupram);
+	of_node_put(backupram);
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
-- 
2.1.4

