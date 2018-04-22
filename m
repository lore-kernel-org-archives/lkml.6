Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx487mCRyiMty1n0/0+JYwRsYmP1Hpxh3ePvDVkfnfrOeKQaKaRn+i7sW5zGzfMdfcyxFzVKP
ARC-Seal: i=1; a=rsa-sha256; t=1524406012; cv=none;
        d=google.com; s=arc-20160816;
        b=DPe00fD8B/RbLfkBx3BsT5c83XyDmfObGXVeh4Ex8zKS7YCwZhhknUxvScG74Sj0qZ
         B5J+J8xgIcCCi+52+Oq/hFZLZJTuuvIVlkwC2wej02anUQN4gQOCGAr0ji43Zq9GoDbX
         U3EbhPJPXd7b0P4LBL2O57xcwpzY5dwiG2PdNfWynjRhuhiN+RaXMRyFxviIOxDp/FAs
         Go1bSN272EiqOKfhlq12eycuPcYnkgc8Hrm6RbAk+yYcElHKsG5qfSH13Jljz/hLsiYJ
         QK3S0Uhl5WH+fU1likGUM3LnK/XCq85gKFefijUHVMckhC2I6K5hOqh9oYmFCFu0vLm8
         PCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BYjOxy6Cl3YAhDQ7CgmOf+sGk4wo9toSiH7b1ZBOZxc=;
        b=ZfcjRRCEdADJWOOfu2osidJry8PUFJdfJNkvqxru6yH4OniIkXBiVoShSbqQuZyfGD
         h3IgJ18KyIkcqKop8jLFzDInVjBZdHOW9z8kKbDX7ftD6GiQAzQ+E32yCJ6gvN//CfVe
         lz5nNb0S7ERf/ydczAOlhSpNtTlZu8yiUR2aL7gcPkTjLvwkgOMdzMnS3a0RGZpTHTvS
         nQJfZZYnnU3zxjxxteNue9mg3/m96sQT1MCUxXR4AaFe2hDUbtKc6hyDI/nImgztHShj
         XzITHJFc5QQjj+vx9OrywekZ85FkMDZxRVaAeMESo5/JcVKc03benmxq+uJ0rDdluEU2
         IuGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 081/164] ext4: dont allow r/w mounts if metadata blocks overlap the superblock
Date: Sun, 22 Apr 2018 15:52:28 +0200
Message-Id: <20180422135138.758813202@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455035769736899?=
X-GMAIL-MSGID: =?utf-8?q?1598455558690199926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 18db4b4e6fc31eda838dd1c1296d67dbcb3dc957 upstream.

If some metadata block, such as an allocation bitmap, overlaps the
superblock, it's very likely that if the file system is mounted
read/write, the results will not be pretty.  So disallow r/w mounts
for file systems corrupted in this particular way.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2330,6 +2330,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2342,6 +2344,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2354,6 +2358,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
