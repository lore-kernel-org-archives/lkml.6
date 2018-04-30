Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDRl5+TnwbZOFLMSRxJaCKIfO41RceBrFQjweZFKca5NCPw6kKHWo5pN7hmMMU6eXvSLqH
ARC-Seal: i=1; a=rsa-sha256; t=1525116426; cv=none;
        d=google.com; s=arc-20160816;
        b=t5flCnnlXonT5N/miuHYkZOMvVUcJuV1Ysiz3y0WzmfzHMbYqSj/bZzmJzGAFozGMr
         0pveWitPQli80J+cWCR42WJdasS+Fh0jlXAnEtL/OZ+7MIB3YLDyJWWnG3IHhQ7dSG78
         Y9L5T6GF903nHqqSsP/vNOrcSzvDqsX7ETx6+G+rwnQ6pH+Q2ZbtTfvFE1g3at4sx8Q5
         3s+GJzSE8XNaPCDN54I9TaRlKKf8sFaFLGJxpLRziEtETVWfuVQ59PnJfPQ6/o75kl+U
         b5OqCv0Hg91qsTcx7xFoH+PXHv/h5907dsW+beDXaTiWeA+ZEB7C6jODm6/wvUqQBKHE
         ndWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TiY4Wuww0uzUsZP8bc8c2XwVKakHacJn06hYsNRDDsE=;
        b=gV4OEX8rXpzZzigMqKLze6WIyGFV5bg2PXPWN3yGcrf3s5W5ysIJD8+y9GithQfE8X
         /qH8ck9X0HiyMePuZ4Te98cXusxpvn09OsZcu1yRTzDeif6WvlyNRo1tVVP36iRE8DvF
         iiLd0JzznkreXHkuaKP8Q6ZRU+YZOtXaXMx2eyFkwCEsngMdPRJGrV2szbpBOIFvmGMR
         uWVYVwYp+Jup9dBeqlf3R01OncCE9yCv/dpRk4qWWJwv47Hv8DwCPgS/+jFNevxEUcHy
         iVzK1lBGFnVeNQDlfgP5vOR7KrsM5iGIPgnjAPt6nqX1NzFZCIv8Yp5AlgyIwpc6x3jW
         3ZBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728E222DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Czerner <lczerner@redhat.com>,
	Theodore Tso <tytso@mit.edu>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 05/91] ext4: fix bitmap position validation
Date: Mon, 30 Apr 2018 12:23:47 -0700
Message-Id: <20180430184004.492294634@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200288532951391?=
X-GMAIL-MSGID: =?utf-8?q?1599200482678742198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

commit 22be37acce25d66ecf6403fc8f44df9c5ded2372 upstream.

Currently in ext4_valid_block_bitmap() we expect the bitmap to be
positioned anywhere between 0 and s_blocksize clusters, but that's
wrong because the bitmap can be placed anywhere in the block group. This
causes false positives when validating bitmaps on perfectly valid file
system layouts. Fix it by checking whether the bitmap is within the group
boundary.

The problem can be reproduced using the following

mkfs -t ext3 -E stride=256 /dev/vdb1
mount /dev/vdb1 /mnt/test
cd /mnt/test
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.3.tar.xz
tar xf linux-4.16.3.tar.xz

This will result in the warnings in the logs

EXT4-fs error (device vdb1): ext4_validate_block_bitmap:399: comm tar: bg 84: block 2774529: invalid block bitmap

[ Changed slightly for clarity and to not drop a overflow test -- TYT ]

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Fixes: 7dac4a1726a9 ("ext4: add validity checks for bitmap block numbers")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -321,6 +321,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t offset;
 	ext4_grpblk_t next_zero_bit;
+	ext4_grpblk_t max_bit = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_fsblk_t blk;
 	ext4_fsblk_t group_first_block;
 
@@ -338,7 +339,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether block bitmap block number is set */
 	blk = ext4_block_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
@@ -346,7 +347,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether the inode bitmap block number is set */
 	blk = ext4_inode_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
@@ -354,8 +355,8 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether the inode table block number is set */
 	blk = ext4_inode_table(sb, desc);
 	offset = blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
-	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= sb->s_blocksize)
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= max_bit)
 		return blk;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
 			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
