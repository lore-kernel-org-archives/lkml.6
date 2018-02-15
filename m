Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227lZew4gJVEzsmNFnvH/8Al20G2lhQfqolvUyI3h10oBEUBtxPoxLQHzKrVhewksQ0fU/Cl
ARC-Seal: i=1; a=rsa-sha256; t=1518708482; cv=none;
        d=google.com; s=arc-20160816;
        b=gH7ip6C9iSaKidXwGofr8viYvZcok2OC2dHcyADZJTHSnMqofj9DYC22j+/2i0Z0TM
         oFpmTSA6aoX+mO8oS7SVnM9JhXhO7mbuhPED38qGxHsQINVX4wDEuycSsakC0QaRw3SY
         9QpySs+lJSv5YqkAL12zew3SFmMunH2flTZRckjfp9wkTbG+j0WgSvq6A27CACLUNkR7
         HBsn9xVGGRT+KE18w8k7J4UJ0FNa0BKQcXPQ9isUYXdpTicj3Qpqvavl8QCvzBC0jjsg
         TfJ1u94TDss0RJLFnwsdwjdxEdQuJBpXTqfxadPZ9AKJ0uA6ZSuJDLQ59sjpTGx+xmMW
         TEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CnoMLr8zWeJtNpPstkPboelK1eApijle6Cc2lyuOhG8=;
        b=PYqygvSLOxLx21IIj1dYCaPGHXeFBaOdggFeDsLWuY7JrypJ7oAuXa/audSR9627z5
         DFIFteLYehboFI/7PGCiun1jn0o1HpWh//EzRi0geHUoe//7ZnCB8aQ4n+CzOJRz++1j
         BcJOI1udbUTwqz8HAmHasPeqWpE2LN517wcC2Sx5NMbnhXPbwDpbvEgu3tpyYoU+dIGb
         cu3L2ZYtY9enrZ0l2x4tVnpcd23kskRwyAHdgE8FHhXyK1Cgc12TEpzDIVe/q6uLfKFt
         N1/L0IQbJGu7YfiqG4KHEmQGox7eA4n9fZkgH6qHvBSQ2Y/7iY0RbrgqtC/WeNz8Dfy9
         AHSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiaolei Li <xiaolei.li@mediatek.com>,
	Richard Weinberger <richard@nod.at>,
	Julia Cartwright <julia@ni.com>
Subject: [PATCH 4.9 21/88] ubifs: Massage assert in ubifs_xattr_set() wrt. init_xattrs
Date: Thu, 15 Feb 2018 16:16:48 +0100
Message-Id: <20180215151225.658636468@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481265404403731?=
X-GMAIL-MSGID: =?utf-8?q?1592481265404403731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Li <xiaolei.li@mediatek.com>

commit d8db5b1ca9d4c57e49893d0f78e6d5ce81450cc8 upstream.

The inode is not locked in init_xattrs when creating a new inode.

Without this patch, there will occurs assert when booting or creating
a new file, if the kernel config CONFIG_SECURITY_SMACK is enabled.

Log likes:

UBIFS assert failed in ubifs_xattr_set at 298 (pid 1156)
CPU: 1 PID: 1156 Comm: ldconfig Tainted: G S 4.12.0-rc1-207440-g1e70b02 #2
Hardware name: MediaTek MT2712 evaluation board (DT)
Call trace:
[<ffff000008088538>] dump_backtrace+0x0/0x238
[<ffff000008088834>] show_stack+0x14/0x20
[<ffff0000083d98d4>] dump_stack+0x9c/0xc0
[<ffff00000835d524>] ubifs_xattr_set+0x374/0x5e0
[<ffff00000835d7ec>] init_xattrs+0x5c/0xb8
[<ffff000008385788>] security_inode_init_security+0x110/0x190
[<ffff00000835e058>] ubifs_init_security+0x30/0x68
[<ffff00000833ada0>] ubifs_mkdir+0x100/0x200
[<ffff00000820669c>] vfs_mkdir+0x11c/0x1b8
[<ffff00000820b73c>] SyS_mkdirat+0x74/0xd0
[<ffff000008082f8c>] __sys_trace_return+0x0/0x4

Signed-off-by: Xiaolei Li <xiaolei.li@mediatek.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: stable@vger.kernel.org
(julia: massaged to apply to 4.9.y, which doesn't contain fscrypto support)
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/xattr.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -270,7 +270,8 @@ static struct inode *iget_xattr(struct u
 }
 
 static int __ubifs_setxattr(struct inode *host, const char *name,
-			    const void *value, size_t size, int flags)
+			    const void *value, size_t size, int flags,
+			    bool check_lock)
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
@@ -279,7 +280,8 @@ static int __ubifs_setxattr(struct inode
 	union ubifs_key key;
 	int err;
 
-	ubifs_assert(inode_is_locked(host));
+	if (check_lock)
+		ubifs_assert(inode_is_locked(host));
 
 	if (size > UBIFS_MAX_INO_DATA)
 		return -ERANGE;
@@ -548,7 +550,8 @@ static int init_xattrs(struct inode *ino
 		}
 		strcpy(name, XATTR_SECURITY_PREFIX);
 		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
-		err = __ubifs_setxattr(inode, name, xattr->value, xattr->value_len, 0);
+		err = __ubifs_setxattr(inode, name, xattr->value,
+				       xattr->value_len, 0, false);
 		kfree(name);
 		if (err < 0)
 			break;
@@ -594,7 +597,8 @@ static int ubifs_xattr_set(const struct
 	name = xattr_full_name(handler, name);
 
 	if (value)
-		return __ubifs_setxattr(inode, name, value, size, flags);
+		return __ubifs_setxattr(inode, name, value, size, flags,
+					true);
 	else
 		return __ubifs_removexattr(inode, name);
 }
