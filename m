Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710073-2-6678680785441121346
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
    t=1518710073; b=EUv+8O+z4XgAQt5rYplzNi5ctTm0qBBXM1jdbGigw+P+yxL
    hxz3Q1/X7Sk6J1mOIy7ydte9FhN2djAskhdTBZAQ/A9v8KH0AVjc4IZv8eOpCFXj
    yvmSzk7jVpsYqyWnNS/aCs1vsarrMeSdHcjkarHFrKz5rndVyfNVHblDbRvDh13f
    zhnSbM0xVdX2/57ZG4RWQZ0JqCJqe7F6ffvIR1z9C3VP04fUNPPCjxZ9f/HWSUH9
    Z4B2+9g/wyhpdFYaeivxN3fu+bh9nf6d0ilG19bFtbQkRcY06J7q2cItAnskQ0Qj
    FoSFWLajO87pxw55+2/9cqWBUfPivS0GEH00d4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710073; bh=b601dGxZFcQ5HgYuBl0doYTGzm
    BH3c2V+eourw++yjQ=; b=wxpR/f3E6XPtI/Z01+yx0G7athJq4b4Alz5Zwu/ScE
    MEg8oI8mZRyrVrVuaBlzAT6b5SsvDyf9EEiEp0cyM/x7eQLOWf+l2nyxaUFog2ea
    7QckAjvhk3JmO4ynuu6c1NoSNOzNAs68cKaJu/2nDwIAXzXWPnACGHtrLr1pskFj
    3HngDbqN2ipMdq13/y4w735C1xQB0qS1kUar41AJ5XD+Yoc4nGQw5wr0d2XnULLJ
    eCQYlDvkp7Ivth3LikBWpO/1saySeafU9jG5Ib7Th0JStshaYd6avbCsLRvRY5Yb
    GmojfCb1AbPQgkRxd2IC8UhJ7Fk/sEeDkvmZpriJwtWw==
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
        id S1424957AbeBOPyO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:54:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424926AbeBOPrg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 195/202] ovl: take mnt_want_write() for removing impure xattr
Date: Thu, 15 Feb 2018 16:18:15 +0100
Message-Id: <20180215151722.886256529@linuxfoundation.org>
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

commit a5a927a7c82e28ea76599dee4019c41e372c911f upstream.

The optimization in ovl_cache_get_impure() that tries to remove an
unneeded "impure" xattr needs to take mnt_want_write() on upper fs.

Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -593,8 +593,15 @@ static struct ovl_dir_cache *ovl_cache_g
 		return ERR_PTR(res);
 	}
 	if (list_empty(&cache->entries)) {
-		/* Good oportunity to get rid of an unnecessary "impure" flag */
-		ovl_do_removexattr(ovl_dentry_upper(dentry), OVL_XATTR_IMPURE);
+		/*
+		 * A good opportunity to get rid of an unneeded "impure" flag.
+		 * Removing the "impure" xattr is best effort.
+		 */
+		if (!ovl_want_write(dentry)) {
+			ovl_do_removexattr(ovl_dentry_upper(dentry),
+					   OVL_XATTR_IMPURE);
+			ovl_drop_write(dentry);
+		}
 		ovl_clear_flag(OVL_IMPURE, d_inode(dentry));
 		kfree(cache);
 		return NULL;
