Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB63C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A56B2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A56B2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeI0Plj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:41:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeI0Plj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:41:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7CC9E1113;
        Thu, 27 Sep 2018 09:24:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 56/64] ext4: fix online resizing for bigalloc file systems with a 1k block size
Date:   Thu, 27 Sep 2018 11:04:13 +0200
Message-Id: <20180927090257.632455561@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 5f8c10936fab2b69a487400f2872902e597dd320 upstream.

An online resize of a file system with the bigalloc feature enabled
and a 1k block size would be refused since ext4_resize_begin() did not
understand s_first_data_block is 0 for all bigalloc file systems, even
when the block size is 1k.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -19,6 +19,7 @@
 
 int ext4_resize_begin(struct super_block *sb)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int ret = 0;
 
 	if (!capable(CAP_SYS_RESOURCE))
@@ -29,7 +30,7 @@ int ext4_resize_begin(struct super_block
          * because the user tools have no way of handling this.  Probably a
          * bad time to do it anyways.
          */
-	if (EXT4_SB(sb)->s_sbh->b_blocknr !=
+	if (EXT4_B2C(sbi, sbi->s_sbh->b_blocknr) !=
 	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
 		ext4_warning(sb, "won't resize using backup superblock at %llu",
 			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);


