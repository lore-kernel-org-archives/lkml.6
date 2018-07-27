Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD96C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F9C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F9C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbeG0RsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:48:01 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35547 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbeG0RsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:48:00 -0400
Received: by mail-qk0-f194.google.com with SMTP id u21-v6so3650494qku.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/lSHzE430aXs465bW969DzHsmQxzWeoM827lISk+1s=;
        b=MEP4LaDdKXxeGZwd8lRGPa2f0R4n0X3HtbcJk/6Ggujps28Ikx9OlSOjGhn9YjrNCG
         eTHr/fjwQQDmnvTCix0/LotX+r/VFziDrvsAWUgkDiBZIdxSoW/cCuFQE/yGwUJwowZ5
         gZoTC3UlLuOzTcOcFQiXq0M0vRsWn0l4KQVausmJ0Hanm4IzyW1MojO0XcJBRnmUiNRV
         fhXNIbuY14E8+o6xaEyFd3B1bgqX15B8jImrabGtoltQAmayYB/n7mNp63yVToeJ6SYc
         QnKlP9rZJOsCfIqdJ4EmFTVPE88ELVxAOpegj8ITjlrEYm8dNwEb/E9thfCqLVv8vYGG
         nVoQ==
X-Gm-Message-State: AOUpUlErDhKuLBez89RZC1Sua72eme8PNRckZDV5p6qZvjTVwK4DxOoe
        TeHRY2tpdU2HPGgCQDyV1BGUo73RtIM=
X-Google-Smtp-Source: AAOMgpeq4J9nlGWZZ5HkPKrTAJKZiBSBVEsJlG4mvF/D+HtR3MKa+bQh/amVUJ+HR/Sq6UWoEMJ4Qg==
X-Received: by 2002:a37:bf82:: with SMTP id p124-v6mr6367499qkf.46.1532708722116;
        Fri, 27 Jul 2018 09:25:22 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3137342qkl.65.2018.07.27.09.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:25:21 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/3] ext4: super: Fix spectre gadgets in ext4_quota_{read,write,off}
Date:   Fri, 27 Jul 2018 16:23:56 +0000
Message-Id: <20180727162357.30801-3-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727162357.30801-1-jcline@redhat.com>
References: <20180727162357.30801-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is a user-controlled value used to index 'sb_dqopt(sb)->files'.
Clamp 'type' to the size of the array to avoid a speculative
out-of-bounds read.

These gadgets were found with the help of smatch:

* fs/ext4/super.c:5741 ext4_quota_read() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]

* fs/ext4/super.c:5778 ext4_quota_write() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 fs/ext4/super.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c04a09b51742..de358eba024a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5693,10 +5693,13 @@ static int ext4_enable_quotas(struct super_block *sb)
 
 static int ext4_quota_off(struct super_block *sb, int type)
 {
-	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct inode *inode;
 	handle_t *handle;
 	int err;
 
+	type = array_index_nospec(type, MAXQUOTAS);
+	inode = sb_dqopt(sb)->files[type];
+
 	/* Force all delayed allocation blocks to be allocated.
 	 * Caller already holds s_umount sem */
 	if (test_opt(sb, DELALLOC))
@@ -5740,13 +5743,17 @@ static int ext4_quota_off(struct super_block *sb, int type)
 static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 			       size_t len, loff_t off)
 {
-	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct inode *inode;
 	ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
 	size_t toread;
 	struct buffer_head *bh;
-	loff_t i_size = i_size_read(inode);
+	loff_t i_size;
+
+	type = array_index_nospec(type, MAXQUOTAS);
+	inode = sb_dqopt(sb)->files[type];
+	i_size = i_size_read(inode);
 
 	if (off > i_size)
 		return 0;
@@ -5777,13 +5784,16 @@ static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				const char *data, size_t len, loff_t off)
 {
-	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct inode *inode;
 	ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
 	int err, offset = off & (sb->s_blocksize - 1);
 	int retries = 0;
 	struct buffer_head *bh;
 	handle_t *handle = journal_current_handle();
 
+	type = array_index_nospec(type, MAXQUOTAS);
+	inode = sb_dqopt(sb)->files[type];
+
 	if (EXT4_SB(sb)->s_journal && !handle) {
 		ext4_msg(sb, KERN_WARNING, "Quota write (off=%llu, len=%llu)"
 			" cancelled because transaction is not started",
-- 
2.17.1

