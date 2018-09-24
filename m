Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88099ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0BD208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0BD208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbeIXSNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:13:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeIXSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:13:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEA101086;
        Mon, 24 Sep 2018 12:11:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/111] mtdchar: fix overflows in adjustment of `count`
Date:   Mon, 24 Sep 2018 13:52:42 +0200
Message-Id: <20180924113112.413050665@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

[ Upstream commit 6c6bc9ea84d0008024606bf5ba10519e20d851bf ]

The first checks in mtdchar_read() and mtdchar_write() attempt to limit
`count` such that `*ppos + count <= mtd->size`. However, they ignore the
possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
pread/pwrite syscalls bypass this.

I haven't found any codepath on which this actually causes dangerous
behavior, but it seems like a sensible change anyway.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/mtdchar.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file
 
 	pr_debug("MTD_read\n");
 
-	if (*ppos + count > mtd->size)
-		count = mtd->size - *ppos;
+	if (*ppos + count > mtd->size) {
+		if (*ppos < mtd->size)
+			count = mtd->size - *ppos;
+		else
+			count = 0;
+	}
 
 	if (!count)
 		return 0;
@@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file
 
 	pr_debug("MTD_write\n");
 
-	if (*ppos == mtd->size)
+	if (*ppos >= mtd->size)
 		return -ENOSPC;
 
 	if (*ppos + count > mtd->size)


