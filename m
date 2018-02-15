Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710112-2-1224759941610791609
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
    t=1518710111; b=kNF4L8yOxzxAp+fpuszbAE4p4z6jWulv7S8GPjb4TDXqeUu
    1Qu5AUk1xWBY1dmXU3pFXaU5cUreFcrKg1Ain1M0kAWUNSC6kSO90Y+peBttOGIB
    iztFF6begS1toA5EO1GMpbaZ5nEyCuAQbc7ZRuJn8wj/VD1aX5ChXqbs8GthIyzN
    ExTYLThO5nDdAC9rP2KfON2LIEHSTvkJrka/fXsFpkC4nGpadxWWVt8Rg67+KCsy
    d/HIlblaIY7kmUvAeL6279ZFeNXDJ88sdbcCRuYPxU4XuM9wDe8Z3gMCVXArfEXr
    /QrxRh0Eyoda2xPciwJauIFV+vkuHboirOfZjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710111; bh=G3wUDcPGf8FLa6PUPaH0CJp0Hw
    0hUH7lpQAhV2Pso1k=; b=ko9YHzliwUykk+3wNNw0q3wo7kng9Pr/2/zy6ylm9t
    2ock917tEof1FK/lWMz7RsZPXrKiEGbIdDG1Aw5qfSIqEOL+n+t3CGc9stBflPpl
    i2+4HlH6WwdKCzcWuYQhL94LBl0esjUhfDqzl9s0U3YhhhGCnxw1rBPBz+LE2RWq
    AMny95++VGWpiuvNevgHM4Xc4pMOKQ84JO6IIcp+EQOUrc/BtngKrmejZ85VK3wT
    zuWhDTH9UgHWNRDx8zaqcyAkEF2AkSanxdbyJKSxIYfeNGojijxVY2iWKsvaGzJz
    mIesRSsuAO8C3DkqWS8ooWY8FogPnSvoAva40eKiu+zg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425155AbeBOPy5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:54:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424460AbeBOPr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 192/202] ovl: force r/o mount when index dir creation fails
Date: Thu, 15 Feb 2018 16:18:12 +0100
Message-Id: <20180215151722.765961034@linuxfoundation.org>
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

commit 972d0093c2f7b1bd57e47a1780a552dde528fd16 upstream.

When work dir creation fails, a warning is emitted and overlay is
mounted r/o. Trying to remount r/w will fail with no work dir.

When index dir creation fails, the same warning is emitted and overlay
is mounted r/o, but trying to remount r/w will succeed. This may cause
unintentional corruption of filesystem consistency.

Adjust the behavior of index dir creation failure to that of work dir
creation failure and do not allow to remount r/w. User needs to state
an explicitly intention to work without an index by mounting with
option 'index=off' to allow r/w mount with no index dir.

When mounting with option 'index=on' and no 'upperdir', index is
implicitly disabled, so do not warn about no file handle support.

The issue was introduced with inodes index feature in v4.13, but this
patch will not apply cleanly before ovl_fill_super() re-factoring in
v4.15.

Fixes: 02bcd1577400 ("ovl: introduce the inodes index dir feature")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/super.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -703,7 +703,8 @@ static int ovl_lower_dir(const char *nam
 	 * The inodes index feature needs to encode and decode file
 	 * handles, so it requires that all layers support them.
 	 */
-	if (ofs->config.index && !ovl_can_decode_fh(path->dentry->d_sb)) {
+	if (ofs->config.index && ofs->config.upperdir &&
+	    !ovl_can_decode_fh(path->dentry->d_sb)) {
 		ofs->config.index = false;
 		pr_warn("overlayfs: fs on '%s' does not support file handles, falling back to index=off.\n", name);
 	}
@@ -1257,11 +1258,16 @@ static int ovl_fill_super(struct super_b
 		if (err)
 			goto out_free_oe;
 
-		if (!ofs->indexdir)
+		/* Force r/o mount with no index dir */
+		if (!ofs->indexdir) {
+			dput(ofs->workdir);
+			ofs->workdir = NULL;
 			sb->s_flags |= SB_RDONLY;
+		}
+
 	}
 
-	/* Show index=off/on in /proc/mounts for any of the reasons above */
+	/* Show index=off in /proc/mounts for forced r/o mount */
 	if (!ofs->indexdir)
 		ofs->config.index = false;
 
