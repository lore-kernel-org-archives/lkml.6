Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49y/0QQo14sW5aSO/U7hQ7oVnLX8EygXorORE2w/BWftKpBEXMmBz1Be+RWIhL2BOQVnSN2
ARC-Seal: i=1; a=rsa-sha256; t=1524406777; cv=none;
        d=google.com; s=arc-20160816;
        b=tFiIm4PD05cmCltEVgzqOo4+l9U/7UaBkLZ5qysIhSVa7DtWDpPXNTIg1TBkH5/Mbc
         xPtGnKD5Xt1+IG/sZi7GxF+QyOpdQjW3vKHmrk9r69PRekzHLrR7K7oJr8yDNQpldSWM
         CFxg8eR+9dWFHbGQBumyYMcg+NjPAmVD1iDuuJUY5GEX5wy5SpD6Q/2OdjNmgCdPCWPM
         JraRDUZttn6fqziLfbEEST9qiXJqUQXgYstdMXVq1A/tzYsDoU7Fjsy5mUM3tIeC5XaS
         O3I+7YhXL9KfL5EZNX23vaFv8xxRoKL1gblH291DwTrbo3ZNfuXydKv/XOTYYX0268IS
         ozXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LothE92tO+Atq3UzzkUMNzspeA1nMmb1r6vOr7Q2ElA=;
        b=ijKFvGyODctO2UK/7qv6GkB5hAXktEnX1bRf+MuUyMcRcEFkWDlFiclP+jf3gjWSag
         6Ua6QKp9J4uuV/RUp9j6C9wzAK5CQW/QLaKyaGd/Z7+w5mG5lOJqLtGlVAmoZ8dsm8zc
         PaVHJ2l8Ip+B+V1qQxv3GtIoe9dn2yjywT+12Puw6UtCuvEm5S63ByyXf1jshnbsDkyg
         JjAGlpIKI7/LGU+i1MDp5cfN6zm/6Bh9Q45A6xnK095HWgRnf5F1NYb7OM0Gy6ktfW5O
         oOKyBX4rUJCvSW0HKZAL8wRVnDlk8Snly5tYlUW1qesn+4t/NLj0vYehO9fgdv2ggHzb
         rqOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 4.4 74/97] ext4: dont allow r/w mounts if metadata blocks overlap the superblock
Date: Sun, 22 Apr 2018 15:53:52 +0200
Message-Id: <20180422135309.287086064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455035769736899?=
X-GMAIL-MSGID: =?utf-8?q?1598456360571440200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 18db4b4e6fc31eda838dd1c1296d67dbcb3dc957 upstream.

If some metadata block, such as an allocation bitmap, overlaps the
superblock, it's very likely that if the file system is mounted
read/write, the results will not be pretty.  So disallow r/w mounts
for file systems corrupted in this particular way.

Backport notes:
3.18.y is missing bc98a42c1f7d ("VFS: Convert sb->s_flags & MS_RDONLY to sb_rdonly(sb)")
and e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
so we simply use the sb MS_RDONLY check from pre bc98a42c1f7d in place of the sb_rdonly
function used in the upstream variant of the patch.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2131,6 +2131,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2143,6 +2145,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2155,6 +2159,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
