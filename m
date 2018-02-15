Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710075-2-13673832584214646940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710074; b=HriFS9xbWDZa99ffg/k65G83A8So6dz8piRFs5YiDMLYsIc
    tg6Wd230dAq9gYKHQoagi7sGqYRxw3TI775RHT0F6yDkPcX8jf0UpHO1a4+sI8i2
    yW0+zOrqgeFchygckU4Yyrw6XiTKRlN6OWPAcAdcpIVnmlEt4/9ijP0PwGDktc5m
    8sPOx/Tub7p7zGd8UkUUbXKpNHwRenF8xWrPAY9lUxkdT4HYpbe9nnF03pSUf3TB
    b5RMHIpGhEY0iPW7L7x2+F3uyYHVwzXKjwrrewrtrmME311TECxIaVwM1So+mwGQ
    eN0ZjiApHZW6Fi5bJqgR+VmKzJJ9hQ7yPu+aLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710074; bh=4RuC3jC7TiNwW6/sUY/uE1m5IF
    aWpKTlvXBWWg9q7pw=; b=YJDEMeqfybBtv91aUr6X1n3v4aBisZls+vhyWVSY4V
    ob26XGHjFO3NJJxUeFTGIWtV8cMupyQcgRpFeYTP6TqRM+3NKXTnQaiYCc5ji5eg
    kbtPbRde2KJyi8Y7ZlEAoVzcrHEKVUz4x5gMKZnssY9Wae8xWARUgikMOKTFmIJV
    PNRwRgW+d/Gyjr+QiMHYBCcit6/VhlDhzEwURqwaHMaClAurB0NsQKNhcE3ql36E
    efEBXtBKCHhGfRGmoZNUpYPftnxKcnURniqc/DulUDIoF8zRpI7BBJMKj3BjbiNz
    vMmfGjI4TTfcPtHwLHTOs8AZYoOTCpu5EKiB21JW2eNg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424919AbeBOPrf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424903AbeBOPre (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 194/202] ovl: take mnt_want_write() for work/index dir setup
Date: Thu, 15 Feb 2018 16:18:14 +0100
Message-Id: <20180215151722.839774477@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 2ba9d57e65044859f7ff133bcb0a902769bf3bc6 upstream.

There are several write operations on upper fs not covered by
mnt_want_write():

- test set/remove OPAQUE xattr
- test create O_TMPFILE
- set ORIGIN xattr in ovl_verify_origin()
- cleanup of index entries in ovl_indexdir_cleanup()

Some of these go way back, but this patch only applies over the
v4.14 re-factoring of ovl_fill_super().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/super.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -520,10 +520,6 @@ static struct dentry *ovl_workdir_create
 	bool retried = false;
 	bool locked = false;
 
-	err = mnt_want_write(mnt);
-	if (err)
-		goto out_err;
-
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	locked = true;
 
@@ -588,7 +584,6 @@ retry:
 		goto out_err;
 	}
 out_unlock:
-	mnt_drop_write(mnt);
 	if (locked)
 		inode_unlock(dir);
 
@@ -930,12 +925,17 @@ out:
 
 static int ovl_make_workdir(struct ovl_fs *ofs, struct path *workpath)
 {
+	struct vfsmount *mnt = ofs->upper_mnt;
 	struct dentry *temp;
 	int err;
 
+	err = mnt_want_write(mnt);
+	if (err)
+		return err;
+
 	ofs->workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
 	if (!ofs->workdir)
-		return 0;
+		goto out;
 
 	/*
 	 * Upper should support d_type, else whiteouts are visible.  Given
@@ -945,7 +945,7 @@ static int ovl_make_workdir(struct ovl_f
 	 */
 	err = ovl_check_d_type_supported(workpath);
 	if (err < 0)
-		return err;
+		goto out;
 
 	/*
 	 * We allowed this configuration and don't want to break users over
@@ -969,6 +969,7 @@ static int ovl_make_workdir(struct ovl_f
 	if (err) {
 		ofs->noxattr = true;
 		pr_warn("overlayfs: upper fs does not support xattr.\n");
+		err = 0;
 	} else {
 		vfs_removexattr(ofs->workdir, OVL_XATTR_OPAQUE);
 	}
@@ -980,7 +981,9 @@ static int ovl_make_workdir(struct ovl_f
 		pr_warn("overlayfs: upper fs does not support file handles, falling back to index=off.\n");
 	}
 
-	return 0;
+out:
+	mnt_drop_write(mnt);
+	return err;
 }
 
 static int ovl_get_workdir(struct ovl_fs *ofs, struct path *upperpath)
@@ -1027,8 +1030,13 @@ out:
 static int ovl_get_indexdir(struct ovl_fs *ofs, struct ovl_entry *oe,
 			    struct path *upperpath)
 {
+	struct vfsmount *mnt = ofs->upper_mnt;
 	int err;
 
+	err = mnt_want_write(mnt);
+	if (err)
+		return err;
+
 	/* Verify lower root is upper root origin */
 	err = ovl_verify_origin(upperpath->dentry, oe->lowerstack[0].dentry,
 				false, true);
@@ -1056,6 +1064,7 @@ static int ovl_get_indexdir(struct ovl_f
 		pr_warn("overlayfs: try deleting index dir or mounting with '-o index=off' to disable inodes index.\n");
 
 out:
+	mnt_drop_write(mnt);
 	return err;
 }
 
