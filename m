Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709513-2-9065184722030249806
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
    t=1518709512; b=t52rjZoZfno78AMOxfD9M8LzHPpKSyHUK5VLOrM0oNjGm0I
    SttU1T29byfuuvXuo6F/C/kUrmvqXcYpRCswdkrB75LRK8g5ha1z51eRpSrhDZsd
    UtSXBsLnNobOkab1mOSKuhpXpjqur8Djg2BUdezY7qINGm3ubKLNUFX4KEJvsYKn
    b7/+Dt0hm8ho9hShitzsUilbPg61ILuiFR/NcBnZFY/AWUlpTCnjS0NsdUjPf01q
    K/uAyAfRhNUWlTuQNhJQz/O0VJK2w1O8yM2RLhtFpF/lchAmz5zS4HXGDGVIRFxe
    Y3H3YNVQ30DP4uGJPKyvJZeYXRdowecLdi8qw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709512; bh=UxgYJ7ijw+W7w3Lk101JG6eHEf
    IibiRhdLL5C/g5BGw=; b=WY/dKyg96XJfWXcWA70ian9oVbUmW63LuvsCW1bGNc
    AiI6j61+hhmFqQgWJrjZ8mZfejGxMoSAdMW12qPOjQQtfQKiEtFsa5KYbm6DilfK
    e4aL6OJwolWJbGCXTeJm0KvkhekYFuHptxFgxrBLExZHOI5JgO+SATEdxXS/+v9Z
    t413skBJqr+5U2eLi8HJKCu8xGl6u9W4IODfGHJI+VUe6fwawz5HB3hLqmoAieEp
    EI0foVCv0YM/VRNkOb8s5GCMvUrMhZo+9XbgIBMcYhOwC6O8bJOCmm8GOhgPtigv
    D9kqz2TVHoOap8fFyeK9+sKRccASFxkmjn3aw1/qqrGQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424393AbeBOPpJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424390AbeBOPpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 143/202] afs: Need to clear responded flag in addr cursor
Date: Thu, 15 Feb 2018 16:17:23 +0100
Message-Id: <20180215151720.540681038@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

commit 8305e579c653b127b292fcdce551e930f9560260 upstream.

In afs_select_fileserver(), we need to clear the ->responded flag in the
address list when reusing it.  We should also clear it in
afs_select_current_fileserver().

To this end, just memset() the object before initialising it.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/rotate.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -383,6 +383,7 @@ use_server:
 	afs_get_addrlist(alist);
 	read_unlock(&server->fs_lock);
 
+	memset(&fc->ac, 0, sizeof(fc->ac));
 
 	/* Probe the current fileserver if we haven't done so yet. */
 	if (!test_bit(AFS_SERVER_FL_PROBED, &server->flags)) {
@@ -397,11 +398,8 @@ use_server:
 	else
 		afs_put_addrlist(alist);
 
-	fc->ac.addr  = NULL;
 	fc->ac.start = READ_ONCE(alist->index);
 	fc->ac.index = fc->ac.start;
-	fc->ac.error = 0;
-	fc->ac.begun = false;
 	goto iterate_address;
 
 iterate_address:
@@ -458,12 +456,10 @@ bool afs_select_current_fileserver(struc
 			return false;
 		}
 
+		memset(&fc->ac, 0, sizeof(fc->ac));
 		fc->ac.alist = alist;
-		fc->ac.addr  = NULL;
 		fc->ac.start = READ_ONCE(alist->index);
 		fc->ac.index = fc->ac.start;
-		fc->ac.error = 0;
-		fc->ac.begun = false;
 		goto iterate_address;
 
 	case 0:
