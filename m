Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Vi25dGlZ/pMKT8brJACpsal037JsGClF6rwgKN6vQ0xbXqoank8RE9g4PYdnn3OXRN+uq
ARC-Seal: i=1; a=rsa-sha256; t=1524405513; cv=none;
        d=google.com; s=arc-20160816;
        b=Q9PIf+65/INnN6i070n8XY1OrNUWvlZIcJHwnPNJ7x6bpqCaRnFy5P1MGrYQEkRYvX
         GVWV9LKqKWtkeJDEBh3+iw2xRe1aOvz2UnkWVprnxXTE9zE95pmpe7J0S4jTeX9aR/1V
         ajItzPJWVa6p2W6PbaH4JjczjfkxUMHi5fYLYBEypQ8wgtnZBhYi2awqS6+BXn6FqHJ3
         +jjCsC3CKxPSeR+zJUtp6M8CTLHTQcMC4//wzeUOIK5v4H6ZkI1Pxzb9+7tkiqzCnO01
         OiPTR+FPqiI82wNbPTWgSfUTWoKLLj/D03cHWBavsLaGjJyvhUwwEQ/a9udiC/0jG0Qp
         smGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Idz60zM3ESyR+5p0vsN/bcdd/zasFzItA64mq320puw=;
        b=nUtgYFHi37IOK+Z9YYTKuVfYXUnGSycDYLE76GTpkgnHI8P8KGfCCUC6+uCt+pHZ4F
         3LoC7ICHtA0eid3+ww4WhmhTfGalKGEzVpNU5VCytWR+bc53fe4C0+3i7GORFg5o83CB
         JAWnGt2TnokVdnJY2Kp/RNWD0+0PaAtYIogQoxWAVMitUcwwlKoNuzi4vP90qyKST0cH
         6USmGuSwBAzTkf+vyNl1arNYODfj624X962k+eUj2Qev1qUFe9QKbEuUa7aJPQyuFGQw
         58Jo1C0fxCqPQ67r3/6hXVJS3c7ski7C+31n2xlWfiYA09+fX9wY1YImjoj9R7uktPK7
         jJjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 095/196] ext4: dont allow r/w mounts if metadata blocks overlap the superblock
Date: Sun, 22 Apr 2018 15:51:55 +0200
Message-Id: <20180422135109.194594813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455035769736899?=
X-GMAIL-MSGID: =?utf-8?q?1598455035769736899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2333,6 +2333,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2345,6 +2347,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2357,6 +2361,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!sb_rdonly(sb))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
