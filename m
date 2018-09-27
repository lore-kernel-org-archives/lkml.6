Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12DCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466B2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A466B2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeI0PlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:41:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbeI0PlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:41:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E9B11113;
        Thu, 27 Sep 2018 09:24:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 54/64] ext4: recalucate superblock checksum after updating free blocks/inodes
Date:   Thu, 27 Sep 2018 11:04:11 +0200
Message-Id: <20180927090257.444716641@linuxfoundation.org>
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

commit 4274f516d4bc50648a4d97e4f67ecbd7b65cde4a upstream.

When mounting the superblock, ext4_fill_super() calculates the free
blocks and free inodes and stores them in the superblock.  It's not
strictly necessary, since we don't use them any more, but it's nice to
keep them roughly aligned to reality.

Since it's not critical for file system correctness, the code doesn't
call ext4_commit_super().  The problem is that it's in
ext4_commit_super() that we recalculate the superblock checksum.  So
if we're not going to call ext4_commit_super(), we need to call
ext4_superblock_csum_set() to make sure the superblock checksum is
consistent.

Most of the time, this doesn't matter, since we end up calling
ext4_commit_super() very soon thereafter, and definitely by the time
the file system is unmounted.  However, it doesn't work in this
sequence:

mke2fs -Fq -t ext4 /dev/vdc 128M
mount /dev/vdc /vdc
cp xfstests/git-versions /vdc
godown /vdc
umount /vdc
mount /dev/vdc
tune2fs -l /dev/vdc

With this commit, the "tune2fs -l" no longer fails.

Reported-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4311,11 +4311,13 @@ no_journal:
 	block = ext4_count_free_clusters(sb);
 	ext4_free_blocks_count_set(sbi->s_es, 
 				   EXT4_C2B(sbi, block));
+	ext4_superblock_csum_set(sb);
 	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
 				  GFP_KERNEL);
 	if (!err) {
 		unsigned long freei = ext4_count_free_inodes(sb);
 		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
+		ext4_superblock_csum_set(sb);
 		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
 					  GFP_KERNEL);
 	}


