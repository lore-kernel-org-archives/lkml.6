Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520401571; cv=none;
        d=google.com; s=arc-20160816;
        b=bbuJabdfnAHCo5yldbgzjX4biEIMQDSqx/vhWpTrSlT1WiuRJiOzcj1ICiw0pFHyfZ
         RNCd/cwP4AjE/HtYpRS1cv5C9q/bFXey0DLvfojKuQzZu6XcnRheZqDvMsNuTyV8ptTx
         qRnmmHiwd5BtX/+RFutZXlav23zmEPJ9t/9TwSVZXZOka9oV8gNL5ToLgKoml7HVtmNV
         KxWv11iORVF+Yx0YzGAT9Oq4ox+f7yZD5gaRBkQHWBxe7IHefFjJ+55qxd9kXBwOnYX6
         RNvLhIn1lP6/aRygQeH86Q7mz1zbbtCrLUWxrAR4Bw7s2ov6chbkZF745fTPl5Hk+Dtl
         jM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=x5JfCzOkEunq/JJYivUAszT35eOQPYfrTlGPv5rCsOI=;
        b=i6NfJ4ZkdGyle8xFPmC1/jynXsG5vyViAKsrxtikACzk/GEGhJi/oMJl14TpG8JzaY
         Nj02n2wCybVVNQ31+9eBcYEyMfA7zYFKqEILavZagaacv37YRNItTpelClw61A2uO90e
         7RW4XSOJ6Ldg0Z+lWi+4eXzuWZDYV9cTfimVrgAVLfszn1sdyeWh+tR3et3rDVxZFYsQ
         3LZzCvFQh/p/EjjVjv2mxa38lEqB5ydmF8lrY2KyBCWI0i17Bxw1iOvcyYkyrDN4l46s
         30yumc+7UWOGyrJBQCLNEFAyJrHYfnPLA+Oj3zj5THkQHH1jJGQffQTW0VjIKVjN1W6z
         D9yA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=HLJ0m/B2;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=HLJ0m/B2;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsKetWsKTOvWly08/7y0RBFms83sZ++MnQgLlWHA50xu29k3T6KxVonxRACz/pezljBNpx2Rw==
Date: Tue, 6 Mar 2018 21:46:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Eremin <dmitry.eremin@intel.com>,
	Gargi Sharma <gs051095@gmail.com>, lustre-devel@lists.lustre.org,
	devel@driverdev.osuosl.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH] staging: lustre: Remove VLA usage
Message-ID: <20180307054608.GA9300@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256599062880718?=
X-GMAIL-MSGID: =?utf-8?q?1594256599062880718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to remove all VLA usage. This switches to a
simple kasprintf() instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 532384c91447..aab4eab64289 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -87,7 +87,7 @@ ll_xattr_set_common(const struct xattr_handler *handler,
 		    const char *name, const void *value, size_t size,
 		    int flags)
 {
-	char fullname[strlen(handler->prefix) + strlen(name) + 1];
+	char *fullname;
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
 	struct ptlrpc_request *req = NULL;
 	const char *pv = value;
@@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
 			return -EPERM;
 	}
 
-	sprintf(fullname, "%s%s\n", handler->prefix, name);
+	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
+	if (!fullname)
+		return -ENOMEM;
 	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
 			 valid, fullname, pv, size, 0, flags,
 			 ll_i2suppgid(inode), &req);
+	kfree(fullname);
 	if (rc) {
 		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
 			LCONSOLE_INFO("Disabling user_xattr feature because it is not supported on the server\n");
@@ -364,7 +367,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, void *buffer, size_t size)
 {
-	char fullname[strlen(handler->prefix) + strlen(name) + 1];
+	char *fullname;
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
 #ifdef CONFIG_FS_POSIX_ACL
 	struct ll_inode_info *lli = ll_i2info(inode);
@@ -411,9 +414,13 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
 		return -ENODATA;
 #endif
-	sprintf(fullname, "%s%s\n", handler->prefix, name);
-	return ll_xattr_list(inode, fullname, handler->flags, buffer, size,
-			     OBD_MD_FLXATTR);
+	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
+	if (!fullname)
+		return -ENOMEM;
+	rc = ll_xattr_list(inode, fullname, handler->flags, buffer, size,
+			   OBD_MD_FLXATTR);
+	kfree(fullname);
+	return rc;
 }
 
 static ssize_t ll_getxattr_lov(struct inode *inode, void *buf, size_t buf_size)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
