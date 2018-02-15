Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711130-2-10692059492045818293
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
    t=1518711129; b=Sqdo0jd8AoYHuIes0ENZs8MGI/o/CcHNpoHmTEJ4i9A+UMN
    86hFSJ+UA0Add272gq112RdhBAVcNnn0R98ynjGuVAgM0k0WXQ5KI7QEHOrvnCtN
    A8kZynZlCjGt6FlboN6mvujT/rfRIVimgOo5YdL4UETxA56IsJtgkDa2GMj8UEFU
    JS7HkMcazd9qyIuFOzhJNlfghhWJdO9yO8Bvd+zMqfAJcuGUU4lDRnJrUZf46+AN
    EWCRxBK5rLdHb24D2qUCgEM+6FhudGkdiL8d7rMzHtWm2u1KPtYn9tb5Mr/Y6k9y
    lVg0evMK/nYlZV15XOZc+rE/QxU4j+4D7GH2j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711129; bh=kAcDUXlyj5uFqXnL/uYxEt3ZKb
    14YH4KiSGRQehKIGo=; b=d252zPlt0QO6mjeB+fJ51U2cnTqNPD5MaTrmd0w9FM
    PBRh/uIiru7OxfKij6s7Hm1Kb5530MaEX2z5KYGedGS9VMdqpkgjILjTIT0Q0sUB
    4oAGzD24SwR/WbL/M/sLKfZIIs/QEyXy2AtsrkvuhB7pBzqVCNftHjTqFVA0JIk4
    D4dwpGs4kVhj5JWoa4PYEqtEIUYPPJ0GuJ9afJ4gi8gd9KJI/dtt1RQsdWV+U/kV
    Ue9mIpK9Ehee9bsbMNCs8bz1sNcTjoYpsZTyscGa4wQW14aMvMb/yCdMH7Ob1rJa
    TEDlY0PPBzcAWpvbvl9wAQKvWCgWI/dzncK3m22DhzDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424432AbeBOPpS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424417AbeBOPpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 144/202] afs: Fix missing cursor clearance
Date: Thu, 15 Feb 2018 16:17:24 +0100
Message-Id: <20180215151720.588481731@linuxfoundation.org>
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

commit fe4d774c847398c2a45c10a780ccfde069840793 upstream.

afs_select_fileserver() ends the address cursor it is using in the case in
which we get some sort of network error and run out of addresses to iterate
through, before it jumps to try the next server.  This also needs to be
done when the server aborts with some sort of error that means we should
try the next server.

Fix this by:

 (1) Move the iterate_address afs_end_cursor() call to the next_server
     case.

 (2) End the cursor in the failed case.

 (3) Make afs_end_cursor() clear the ->begun flag and ->addr pointer in the
     address cursor.

 (4) Make afs_end_cursor() able to be called on an already cleared cursor.

Without this, something like the following oops may occur:

	AFS: Assertion failed
	18446612134397189888 == 0 is false
	0xffff88007c279f00 == 0x0 is false
	------------[ cut here ]------------
	kernel BUG at fs/afs/rotate.c:360!
	RIP: 0010:afs_select_fileserver+0x79b/0xa30 [kafs]
	Call Trace:
	 afs_statfs+0xcc/0x180 [kafs]
	 ? p9_client_statfs+0x9e/0x110 [9pnet]
	 ? _cond_resched+0x19/0x40
	 statfs_by_dentry+0x6d/0x90
	 vfs_statfs+0x1b/0xc0
	 user_statfs+0x4b/0x80
	 SYSC_statfs+0x15/0x30
	 SyS_statfs+0xe/0x10
	 entry_SYSCALL_64_fastpath+0x20/0x83

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/addr_list.c |   13 ++++++++++---
 fs/afs/rotate.c    |   12 ++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -332,11 +332,18 @@ bool afs_iterate_addresses(struct afs_ad
  */
 int afs_end_cursor(struct afs_addr_cursor *ac)
 {
-	if (ac->responded && ac->index != ac->start)
-		WRITE_ONCE(ac->alist->index, ac->index);
+	struct afs_addr_list *alist;
 
-	afs_put_addrlist(ac->alist);
+	alist = ac->alist;
+	if (alist) {
+		if (ac->responded && ac->index != ac->start)
+			WRITE_ONCE(alist->index, ac->index);
+		afs_put_addrlist(alist);
+	}
+
+	ac->addr = NULL;
 	ac->alist = NULL;
+	ac->begun = false;
 	return ac->error;
 }
 
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -334,6 +334,7 @@ start:
 
 next_server:
 	_debug("next");
+	afs_end_cursor(&fc->ac);
 	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
 	fc->cbi = NULL;
 	fc->index++;
@@ -408,16 +409,15 @@ iterate_address:
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (afs_iterate_addresses(&fc->ac)) {
-		_leave(" = t");
-		return true;
-	}
+	if (!afs_iterate_addresses(&fc->ac))
+		goto next_server;
 
-	afs_end_cursor(&fc->ac);
-	goto next_server;
+	_leave(" = t");
+	return true;
 
 failed:
 	fc->flags |= AFS_FS_CURSOR_STOP;
+	afs_end_cursor(&fc->ac);
 	_leave(" = f [failed %d]", fc->ac.error);
 	return false;
 }
