Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UTKoKXB9NE9Ow1rE5asT6CD/gFDAiOUo836hDS4nrSNOfuiOFW8JtzLKPexB/Cde/jH+0
ARC-Seal: i=1; a=rsa-sha256; t=1524406883; cv=none;
        d=google.com; s=arc-20160816;
        b=z+sQuSxsJ75Dlv7r8S8cGZQoN8gwZ6kNhw4QMnQnIU8vhYI5XNcWaSz5JNRlViOX25
         s9mhm/ektj6bymrhhnqr7uNTY9slTVgCnYPMCxFylbDTcr8UV3w1x9Y947AH72kFvFWU
         6oRiijMIpTmkA847GdrnyDqXm/g6IckN1w0Lv7AbHQjUwTAtGIocufL3ipYeh50iN8E/
         vs2i2uHIETYSZkdOcsCWLTeyq0B2OxBjCbT6fxxvMp2ZcWrmIgHM4ZMtelmkzAH5Ias6
         CXu2+DapynQGpHZmCdnwJm4BZDEphaTbHcB3OaOAkbtxEvLjo6nmbDdWHA6R5wAYQHFc
         8ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A+1QO3qpxp+OYW4my3vIxJrAYCeqheujje87Ba7Fjn0=;
        b=kE7NNyJtJpwELTnbvgPA8CKu61ZpWwfWckRDE4iJC9hAn1G0r+dch2Zv6LUomyyXKA
         HfMI0M4+k0i0fWW28GnDp1yyEZthdfAo9KZ3YOktT7T7QfVZffmInTSi81KT9MZMT3of
         qZ70YcN6ENILQb2AJrLgxzGMWvJMBx0t7aa+2U/Q9wa4YjWtS46rEglbhPOYYdzG/lUx
         Ni0hMPoeNrMN5FFAfmQkfV+oL5C1nzCad2dr0SzmVlIq8J3TIQsBXZeFvO91/gMCaGKx
         rMvlkaY5EWziHO0p6h4XzBJc6Jivc2JfuDwnY/Di+fs1H5sxxmnwmVX5PIcskZEx5ZVO
         rRtg==
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
Subject: [PATCH 3.18 39/52] ext4: dont allow r/w mounts if metadata blocks overlap the superblock
Date: Sun, 22 Apr 2018 15:54:12 +0200
Message-Id: <20180422135317.199122697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455035769736899?=
X-GMAIL-MSGID: =?utf-8?q?1598456472603252180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2093,6 +2093,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2105,6 +2107,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2117,6 +2121,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
