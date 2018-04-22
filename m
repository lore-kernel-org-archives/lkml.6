Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NKRejEWkMEfInsaeMnA6Nd5ZDNxb5UGp+F0uW5wQOb+8spgxnA7oV3iVkPwCLRv9OJ0bJ
ARC-Seal: i=1; a=rsa-sha256; t=1524406354; cv=none;
        d=google.com; s=arc-20160816;
        b=cTJh+/X3YiykQKYjcZPudkrH4rm9zKniO96yy+89WwNa5NszgCbGnq4S8FE4V7QVgv
         9qEjnJVNlJSCxS/0BiyHzFEEYUeSpReXQr0tLSmozoND+kbPdy/E+Tv8Ct+M62e3IMGk
         cSdcnugKTvRqd8VLa7nVe0jxnaH1+X7tSi4mTzO6iJfYZWecRGGcObePg4whGhg+nLvK
         TVXaNrjFWp0ByD2ioSwYJtdnKTOtXZbJumekjxeiklzWVK7ZQTvW6fCMPIN00s7Ex1NG
         uATipSDpkvPntB7WgrrGD6irH1KVawxnODPM1IlzAR4oSJIXwdsKL51JtjtjHzHi0ipC
         nHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fnCS6fKF6zpqy6wW8y9iP93qzhumWVJL69bww14oHhQ=;
        b=mTb8ZIhu/yItwBKeLKukE9XTRrENbfU7gFTWinHc/gRcP91pECOasfnFKpMYiQvd9k
         yV2BxPHt1n1LHNpEmFx457RAB+0ctsvIJrYaPMdYNO816m3yuuJq/KDFlEQvcpnM3Ica
         FPv1kKhGWGcDnFTto5lkRhblUzqt41A20dlOXAQG2Dow1NoPajFGaGKc1jAwafrEzW0t
         zjEII7dv6q51iBnYwT5yxFb/x659l1jYZmRjsxilWNGn0XHqFqNfBrbaLHVAfSw9yUl2
         VLqEyJO5x0ZVufN+VI+v6M7MmJLJOjByQiS60JbNt+KVa65Sf7iwSkphB2DkuMzOf0Bf
         pBvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.9 23/95] smb3: Fix root directory when server returns inode number of zero
Date: Sun, 22 Apr 2018 15:52:52 +0200
Message-Id: <20180422135211.388104900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455013219213358?=
X-GMAIL-MSGID: =?utf-8?q?1598455916990829323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 7ea884c77e5c97f1e0a1a422d961d27f78ca2745 upstream.

Some servers return inode number zero for the root directory, which
causes ls to display incorrect data (missing "." and "..").

If the server returns zero for the inode number of the root directory,
fake an inode number for it.

Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h |    1 +
 fs/cifs/inode.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1412,6 +1412,7 @@ struct dfs_info3_param {
 #define CIFS_FATTR_NEED_REVAL		0x4
 #define CIFS_FATTR_INO_COLLISION	0x8
 #define CIFS_FATTR_UNKNOWN_NLINK	0x10
+#define CIFS_FATTR_FAKE_ROOT_INO	0x20
 
 struct cifs_fattr {
 	u32		cf_flags;
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -701,6 +701,18 @@ cgfi_exit:
 	return rc;
 }
 
+/* Simple function to return a 64 bit hash of string.  Rarely called */
+static __u64 simple_hashstr(const char *str)
+{
+	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	__u64 hash = 0;
+
+	while (*str)
+		hash = (hash + (__u64) *str++) * hash_mult;
+
+	return hash;
+}
+
 int
 cifs_get_inode_info(struct inode **inode, const char *full_path,
 		    FILE_ALL_INFO *data, struct super_block *sb, int xid,
@@ -810,6 +822,14 @@ cifs_get_inode_info(struct inode **inode
 						 tmprc);
 					fattr.cf_uniqueid = iunique(sb, ROOT_I);
 					cifs_autodisable_serverino(cifs_sb);
+				} else if ((fattr.cf_uniqueid == 0) &&
+						strlen(full_path) == 0) {
+					/* some servers ret bad root ino ie 0 */
+					cifs_dbg(FYI, "Invalid (0) inodenum\n");
+					fattr.cf_flags |=
+						CIFS_FATTR_FAKE_ROOT_INO;
+					fattr.cf_uniqueid =
+						simple_hashstr(tcon->treeName);
 				}
 			}
 		} else
@@ -826,6 +846,16 @@ cifs_get_inode_info(struct inode **inode
 				&fattr.cf_uniqueid, data);
 			if (tmprc)
 				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			else if ((fattr.cf_uniqueid == 0) &&
+					strlen(full_path) == 0) {
+				/*
+				 * Reuse existing root inode num since
+				 * inum zero for root causes ls of . and .. to
+				 * not be returned
+				 */
+				cifs_dbg(FYI, "Srv ret 0 inode num for root\n");
+				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			}
 		} else
 			fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
 	}
@@ -887,6 +917,9 @@ cifs_get_inode_info(struct inode **inode
 	}
 
 cgii_exit:
+	if ((*inode) && ((*inode)->i_ino == 0))
+		cifs_dbg(FYI, "inode number of zero returned\n");
+
 	kfree(buf);
 	cifs_put_tlink(tlink);
 	return rc;
