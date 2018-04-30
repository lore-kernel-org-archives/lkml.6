Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp3toNYYWRLEpCWbhORtJID6s4IfJylL9yTOW9wNXau+qEYCHApTptFus43/3h5VKdqzlKt
ARC-Seal: i=1; a=rsa-sha256; t=1525116350; cv=none;
        d=google.com; s=arc-20160816;
        b=ap6+VunJ/CTEJ+IyNLbbK1SwWCDBmRkVpj18L/mS+Qj+23p9aoOe9twXkxP2bFUV7P
         bcW1hF0RUVmBKWKdz9KIW+BnuTMk0S3v+u76Mk11RHl0XO9vxrQilsjbBKvFo+P+ouBf
         vC/dmQAJ6bOJy8DB/+fbE3UJpNARCdM2c5Q0N4z9pSuNmkfleitYrCzWMQ+4N7EqapOo
         g7biQNOqMxsRgDBsf+vJSTLotZM6Qu+EhVdSgMxzcS6Hm3DZKfXwiWM0Fev///rpbD8I
         55OAZJn9cVLz7uOdq0ZcSJk0b6dUog9FN3vfMtsJcbHPJQbTcPxCbDdl6mEBfGyc9ZPl
         jNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=7EzYqReFzrKEEnLobbVf+Zv8BrBI8LVwklW0AYuCyu0=;
        b=ammK0M4Q19M0zl3MuHShduJ0KC1QqnbB+JDjRofATjx8lrAecs8acmn74LTs9W6+Pb
         izwfgBxOBWq2vf12jF1XV/s0VmRnNTn0lCGoaXnTMwDftNl/Ub4pjqA723MUPY8YLeAo
         sXDQZSM8CUvlIxU0OeQ2hkfeOc4dCyeIPYsp11vtsLplXsJkK3y4c2UBhnlff5LaN/1E
         SRQ+F/iBplzGvn7i4eDTmqsHtYQo3XklEkHoSM2V4GNShoXR7GJlR7fU7YhMLg1V++ZT
         UGf5pFdmjOvSozD0HnRbPaFVy8fX0mNXs+s6gm0Dy7ZQzgiluOoXhCOP7WFMZmhAftAj
         427g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD18F22DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Czerner <lczerner@redhat.com>,
	Theodore Tso <tytso@mit.edu>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.4 04/44] ext4: fix bitmap position validation
Date: Mon, 30 Apr 2018 12:24:15 -0700
Message-Id: <20180430190946.504097014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200288532951391?=
X-GMAIL-MSGID: =?utf-8?q?1599200401849761461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
