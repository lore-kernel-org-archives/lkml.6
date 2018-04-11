Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zZ0vbKmQpEEUmbv1VbnfeDzB37Is9UHMqw5y5LfFTAI5HS9z22Rhkqu9trAlmKgj/yN8u
ARC-Seal: i=1; a=rsa-sha256; t=1523472105; cv=none;
        d=google.com; s=arc-20160816;
        b=bFMA1gPN5uFWv7JnMIxPm8zUGPAqPlZo9sTQqewGSMHWeBCRx6UnVTY3a+axiBnnWA
         8h+tb5lFchhVskaM3Ojx/wX5+LuS5evcSgyB2p2F7jfh4ToNyeNagqAn4G07meJmed9f
         Tf7deUnCDBwvJDC721GubvwJgeCz5PYafEQpAZKQqaBCsW1xdywxRjlIpaj9IasoPn9W
         GD38EyHBkUzIVY6Y0VwDx6eUNr0YSyqkoR2Y8FmeodJ2w+0kEM6YNPSjlcQJ7HdXT6u9
         gJlNMBhUFAsXxN2e84ikI+inAaQCTrU+m4ufXmOPu7zrkYHNmPFs8rA30AQoTEpP0NQW
         YtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pzXNVchT4fLIIQXqw/dIrX71//jMgRARPmSDKEOvURo=;
        b=rWYfZDDVPN/hm4p0l6oDknbqU/SBKjKrrSG4F8ktt2qOz1xeZTUR842R1OcNcYeHAR
         2kxRXXfj6Jbrbb2E7z6IjXDUN0A18JYPweR+1APqNkEfMu+Wm2XZ22SSBC+M+mMDkNFL
         Fc2zHiybYzqYlBzeqXzxSa/CUy0VatJ+XVSdS3ZyYAfVtzbp6oHJvdmfZh84P9Z+Z01G
         kPFd0PM0hDEg5qMnOgQPrZNftT8E1f50Q9AS5LcRmR5WQOJ2JNci+yaJz3yQ9Giusiq8
         +XVsBwww6dyjV2XVuoIb3M53ILMb7y4XHe7omZRrScU9Tz51+t7bL7JPvcfX/KCOtUE6
         qmcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 054/121] ovl: filter trusted xattr for non-admin
Date: Wed, 11 Apr 2018 20:35:57 +0200
Message-Id: <20180411183459.597608451@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476286452744157?=
X-GMAIL-MSGID: =?utf-8?q?1597476286452744157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>


[ Upstream commit a082c6f680da298cf075886ff032f32ccb7c5e1a ]

Filesystems filter out extended attributes in the "trusted." domain for
unprivlieged callers.

Overlay calls underlying filesystem's method with elevated privs, so need
to do the filtering in overlayfs too.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/inode.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -258,6 +258,16 @@ ssize_t ovl_getxattr(struct dentry *dent
 	return vfs_getxattr(realpath.dentry, name, value, size);
 }
 
+static bool ovl_can_list(const char *s)
+{
+	/* List all non-trusted xatts */
+	if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) != 0)
+		return true;
+
+	/* Never list trusted.overlay, list other trusted for superuser only */
+	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+}
+
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	struct path realpath;
@@ -282,7 +292,7 @@ ssize_t ovl_listxattr(struct dentry *den
 			return -EIO;
 
 		len -= slen;
-		if (ovl_is_private_xattr(s)) {
+		if (!ovl_can_list(s)) {
 			res -= slen;
 			memmove(s, s + slen, len);
 		} else {
