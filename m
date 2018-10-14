Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4C7C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF64620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF64620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeJNXcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:32:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36170 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbeJNXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLm-0004cU-MH; Sun, 14 Oct 2018 16:30:39 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000ch-Ew; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Chao Yu" <chao2.yu@samsung.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.539267260@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 287/366] udf: avoid unneeded up_write when fail to
 add entry in ->symlink
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao2.yu@samsung.com>

commit 85cd083b498572fb9fa575cce3ed910c8ee84294 upstream.

We have released the ->i_data_sem before invoking udf_add_entry(),
so in following error path, we should not release this lock again.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/udf/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1015,7 +1015,7 @@ static int udf_symlink(struct inode *dir
 
 	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
 	if (!fi)
-		goto out_no_entry;
+		goto out_fail;
 	cfi.icb.extLength = cpu_to_le32(sb->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
 	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
@@ -1037,6 +1037,7 @@ out:
 
 out_no_entry:
 	up_write(&iinfo->i_data_sem);
+out_fail:
 	inode_dec_link_count(inode);
 	iput(inode);
 	goto out;

