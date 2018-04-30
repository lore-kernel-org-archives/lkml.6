Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZocxefSSKGUKny4vB1Ju2IuBt+T6/EKi3jiMEK4cJdEVxL5LzMCBHXWJGYKBR/fWrEyMsE9
ARC-Seal: i=1; a=rsa-sha256; t=1525116490; cv=none;
        d=google.com; s=arc-20160816;
        b=EuuZmhS823SKWUdWPkr5J9pbpIDWDxF5slR+Hp5oBmSB7+9t2wJ0fTcuygc3FovGFv
         Ncz9P6vGV5phW+Qe5TIwX+YJI9YS+WtvuJfBZX2RKgRcL17RtwcHMPhoJv9CNrDs4pLo
         z/Y6Vfz6tjBtTXWSZhAyzpVXhkMQe4ysYBAX/WEcXAFVueVwa3g3qBGStun6NcuQww5I
         8A8IXBGoOZxQNknTDyNDQoS0rOM0Lsit2fdjwt6h9CPZFJuwZ7TeVR2AaZezHqVK5ldp
         /v/3tSWJony5eAJJouFo9qB2SuvtaE8FnN8XR851CO8UqGj2o/hI5ikoqBgre5rIKjP/
         R61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zht4xJTJ4szQILfemZYBs0YUHVQKwDPwB/wGTLgSMzs=;
        b=uq9B8+YcP3Pu9JLIVYdzdoI1tFMWyyaKmfFMUwE2x3CUwqma+vPo/kCvp//lEMsmdM
         DQAC+p92Kay2mZ9YvRT9bG3vWOqGqU9aL179YBeO6MiZUs7vdpTDeeCZ163WvLjzockX
         NM9q1dOqGemiNtkUjEiZof34WwgidLB4DyqKnWvTSWIf+QYShBfKMqS2cHBYQirjfXUF
         uUFTTBEWnDZm8SWKl/QAIrom+mS+utalk3Gx+yjb6N3oKHq2uFh3TeHvVbZvwmBBAjWZ
         /w0iQ4JxJCSqPA2cQlaT+3c97gHzwHQMPBa7L5sW3v8HNljq2uTecNwglq+7pZbQpvTq
         OZUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72B022DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Czerner <lczerner@redhat.com>,
	Theodore Tso <tytso@mit.edu>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.16 005/113] ext4: fix bitmap position validation
Date: Mon, 30 Apr 2018 12:23:36 -0700
Message-Id: <20180430184015.299588711@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200288532951391?=
X-GMAIL-MSGID: =?utf-8?q?1599200549058809340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 			EXT4_B2C(sbi, offset + sbi->s_itb_per_group),
