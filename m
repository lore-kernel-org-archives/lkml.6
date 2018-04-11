Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XJg+Xe/FqDSaKp1/i4iZqJsdStDo604pKIs01KYjNnAr2mVS08MMSFHsvKVkDvH+5f87I
ARC-Seal: i=1; a=rsa-sha256; t=1523473167; cv=none;
        d=google.com; s=arc-20160816;
        b=Tvj/UZv9IgEJWCWwy3V5ennozX7lBfV/VVYOdbz5VWbHcKixuwvHWvcIp1+7KdopuS
         zYgHcKmWHyAQIUgaBN2Q8tm4B7+owBsY6eisVTGCfjSGhigIZp66+VizgJpHcoYonG10
         d9y26Q7f3Dpsm4dq5X7wusrrMGje7rSm14TbHb+sqt8VQwOy/vslaN2iZC9ZGcvE+JiE
         10PobdsdbhvXD25rF7MhT7TpVsxwLMw9tC4S7ssIYPTmqmfyQlAy0YjsMiXLDmMztMqC
         MfTzCNMBlaQ9X7Hbx+rBjhqL1jFz4qhztJShHAn8AP63d2PKZEx2XwQR1pWfZFrE+Xve
         bjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tCuoBpycNHb3sBGqRliA33sFU4rwMjHZrWMLtacGO0M=;
        b=IOgccw1l8BfOcQI7f5/4goWmBw2BnZyofDTYyKdgBQa6/5TYIU+a1bAEY9Sr2iXDkP
         P4yws3BccjIza6OiBBjpF9yZbs6fFv8erQodMr4Cj2snkjjJ6Vc1uqutLAlU77KBAvBQ
         yH94stHCAIHGnBx0Z/9SjXPyS23YOVd1KZt+A7Hion7BvSUjm52TTR/Rpy+Md1jUcdqL
         NNPbbeXcdwpKJ9fMgHxlDVWAgkS2wPqYmHWNZ/UPohofJmNXQsw3LclzlGROsp1GS8x8
         ridg5ALIYDUNQfsyKmm3XSiMtBdfaPToNfyI+0MZdGLp09F1jbpErbVoSDhXybCuH5Q3
         qJhA==
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
Subject: [PATCH 4.9 152/310] ovl: filter trusted xattr for non-admin
Date: Wed, 11 Apr 2018 20:34:51 +0200
Message-Id: <20180411183628.971060285@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476286452744157?=
X-GMAIL-MSGID: =?utf-8?q?1597477399451785286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -227,6 +227,16 @@ int ovl_xattr_get(struct dentry *dentry,
 	return res;
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
 	struct dentry *realdentry = ovl_dentry_real(dentry);
@@ -250,7 +260,7 @@ ssize_t ovl_listxattr(struct dentry *den
 			return -EIO;
 
 		len -= slen;
-		if (ovl_is_private_xattr(s)) {
+		if (!ovl_can_list(s)) {
 			res -= slen;
 			memmove(s, s + slen, len);
 		} else {
