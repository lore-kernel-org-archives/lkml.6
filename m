Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708605-2-330441639189466768
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
    t=1518708604; b=TD3DTEQojJPXquMMCUpUUCkqlITuw3K1i6Fo9oEnrvZ0hPT
    OrAZvCfjWmi5WzI0rXogm/epGa1vHffKRtTjIBJ8YMm/D/5TSL6LIE1K+OL+OljK
    Eo7OY45U3gDA/b5cTwartgcbDraQVJsdnZL6jSYy0IEbvjQl6/R5kB07ygVbEG0j
    C21zNIOR8uRQqPyGEVX2GYDkaP/7dJdFtJzwCQrR8KZgZdmRkytaKFWNcRwKOi1g
    IwwhRZRqLNhPwQrzHIWiKbvSGP4e06i9tXpMeXpyZYIWNYZ77Njb27CEoxyF/No5
    vLEYD31qiFzns9wnzyKotsXLbVsDdPTZAI2iQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708604; bh=ft6JqW1JyoCijbEZ8eXdkeAITM
    ZmNpYr3iwdl4uxoAY=; b=s/Lu39p/etbaiqJk0dSfNRsfkvt2Rhfg+f8oSZ87Yb
    +2qv+S24e3Op0veil/R2u5V3agUQvoN+6bVmBrkj5PBUriKIg6a5bMFJuPBn3RXf
    pq3tGSznpJ9CCXKE1Blz4zlL+DoQl9K2V+L5dWA5Fn4aGDMrbbMQmLEW9jRlQ3IF
    hz3ly7ZgReb2QBzi7KpLsapOHzO4Bbxk+RJ/XooVEX30pJ49fofqEKN09fBYPUFj
    1Ay0VwMoF0MUOg22ZXNHHbmUYbMKI5MTspYE5033g4EuddSKtUxc2Crivd1DENGx
    B8DNRR9yxQv1eLtwv/0StOLPn/vWf4zkNPZxNGKFO6zg==
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
        id S1164124AbeBOP37 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:29:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164121AbeBOP35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:29:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 003/195] cifs: Fix missing put_xid in cifs_file_strict_mmap
Date: Thu, 15 Feb 2018 16:14:54 +0100
Message-Id: <20180215151705.905248931@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit f04a703c3d613845ae3141bfaf223489de8ab3eb upstream.

If cifs_zap_mapping() returned an error, we would return without putting
the xid that we got earlier.  Restructure cifs_file_strict_mmap() and
cifs_file_mmap() to be more similar to each other and have a single
point of return that always puts the xid.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3488,20 +3488,18 @@ static const struct vm_operations_struct
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int rc, xid;
+	int xid, rc = 0;
 	struct inode *inode = file_inode(file);
 
 	xid = get_xid();
 
-	if (!CIFS_CACHE_READ(CIFS_I(inode))) {
+	if (!CIFS_CACHE_READ(CIFS_I(inode)))
 		rc = cifs_zap_mapping(inode);
-		if (rc)
-			return rc;
-	}
-
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	free_xid(xid);
 	return rc;
 }
@@ -3511,16 +3509,16 @@ int cifs_file_mmap(struct file *file, st
 	int rc, xid;
 
 	xid = get_xid();
+
 	rc = cifs_revalidate_file(file);
-	if (rc) {
+	if (rc)
 		cifs_dbg(FYI, "Validation prior to mmap failed, error=%d\n",
 			 rc);
-		free_xid(xid);
-		return rc;
-	}
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	free_xid(xid);
 	return rc;
 }
