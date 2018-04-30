Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrtfsFwKtNjICcWIYemzNGaj3AOXEXTrge+WQAxaMoJEi7YGdMOTrTwGV3BykU6QuwyXrXn
ARC-Seal: i=1; a=rsa-sha256; t=1525116390; cv=none;
        d=google.com; s=arc-20160816;
        b=Z4X9IhjHELBzUU7UAupcsAzMvRfNz3xB0+zh2bLaQkCMe1kOZFK4wE1LeM5LU3OKjd
         417CP+j5q5qLc3Qp5729F0dHF0KCqQOlKFZKLniqmmtb9rN/U3/NdRgssGJtOmie/pID
         t6x6dPzjvB48Bh0oaXW6X4K9clQ0ZGKnTuz/YeNWAGT7ozcfc/+S/TICwvjmqC53jlmL
         Oc9BKsEQoM55Qxfhx603qvgT2uc6oiIjZ0D0OGuJVCQRVH73S7osdWFTsUF/tt+bUNRE
         rdrrpCo7TtG7DmVtx9ajvegjS2PWl9fdCmmrK4/KaX4f73o0sRsl7F/PS45MdemI9nsG
         pptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=8ktO0D7MH9bjr1tGKE1gyg46AiO8hl0gsuRBTiFa29s=;
        b=EpqLMP6Mc/awyYN1wMEjymPjnwozMsYX+Tdm/eHivvR2e3JW344w5mKNh9l4gJQARm
         TTjyZk0Anvlo38eyJZZ+oIxtfEcgcck7pQj7HDLi/N/egsekG6l+0AOGJ95+4s6HytHr
         Jy0ZC8J+p/rKdkfD29AzFuhX1Kb5HOdYqXFZ43dPlVPOM0bhQeuhf7Cr/j+pKvAUQXHW
         1m6B9oyLvGM003bDfO0PT1R9xn3qI2NWjBxh3T2x8Kjhyqu10qnFOorNb4J2DecZOxQx
         s0nMLRroE8mL8yUSY2l5Ez9bQFR/1jkMUrUmLO8GtSlCVpznWzDMQbbub0AgPhXh2KdO
         tLXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A897122DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Czerner <lczerner@redhat.com>,
	Theodore Tso <tytso@mit.edu>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.9 04/61] ext4: fix bitmap position validation
Date: Mon, 30 Apr 2018 12:24:07 -0700
Message-Id: <20180430183951.709934183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200288532951391?=
X-GMAIL-MSGID: =?utf-8?q?1599200444144188630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -320,6 +320,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t offset;
 	ext4_grpblk_t next_zero_bit;
+	ext4_grpblk_t max_bit = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_fsblk_t blk;
 	ext4_fsblk_t group_first_block;
 
@@ -337,7 +338,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether block bitmap block number is set */
 	blk = ext4_block_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
@@ -345,7 +346,7 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether the inode bitmap block number is set */
 	blk = ext4_inode_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
@@ -353,8 +354,8 @@ static ext4_fsblk_t ext4_valid_block_bit
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
