Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804030-2-755487846830273712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804030; b=L2nhOlxMXky0JYSiLVQOkviOi5NJDwN3QmLYBWeihzJ2+P9
    MQI4x/b1Z8WeliPztP3I+LejyeMrPNb58m52EoPQxm0x0P5AuzVzlemZwlGPpKxd
    cG40s1l5BUlm5rzgEUaFVg7foJTgnMiVa++clYXaVTAtoZlGEPCHvGO+lznPOkxp
    mcUKaJM0M4xqpmp2pyKOSK48BJ2ozKapegwxWVgcZGojgHTLu/gBphM6Vo0ZYybS
    stcA2YAJSYqyUEh8zAfCVs6v/mht/o6hRh+Q4scYkkxmtK3nJQ63YE5Xrh/MDR23
    0y7DSWlwbXyCwqrNBaBf15a2P/BoOxOBoKsYyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804030; bh=Wx7OKly+DH7y3OSMPpKpvUF9BJ
    mTth0sQqsstP6uAnM=; b=WZH3SNMHSijYdruqsQGRLkdRzwJRQ10QwQRuIzgrJ4
    XTcOBpt57JjJIP6iWPG5x92e5moPTFxAXR48ULTE7HmjXRVs9yz+wXAxQLrJ8OOT
    CJDkc5EG9W/2B1I8puacKXje+ArVcS411FFVVLM6y045uw3xvYivPxGWkgFs/rbM
    96w2VFfQda/x80e5boEvsxHfgAVJXe9COtkA3tjJViWz2H3weEhlDCq9r5MKECYH
    KN8zH/pj73Eb1au7yP/YrwyHK3nJ/XpL9jxyYGzdZp2B2+Q9HTSVNnSrEFnnTY4X
    EKAS6JjzauW4Exvb5lf2+R1C/fIC1JOWriwKi+6y8v1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeCWKIo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbeCWKIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 102/177] jbd2: Fix lockdep splat with generic/270 test
Date: Fri, 23 Mar 2018 10:53:50 +0100
Message-Id: <20180323094209.786100619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>


[ Upstream commit c52c47e4b4fbe4284602fc2ccbfc4a4d8dc05b49 ]

I've hit a lockdep splat with generic/270 test complaining that:

3216.fsstress.b/3533 is trying to acquire lock:
 (jbd2_handle){++++..}, at: [<ffffffff813152e0>] jbd2_log_wait_commit+0x0/0x150

but task is already holding lock:
 (jbd2_handle){++++..}, at: [<ffffffff8130bd3b>] start_this_handle+0x35b/0x850

The underlying problem is that jbd2_journal_force_commit_nested()
(called from ext4_should_retry_alloc()) may get called while a
transaction handle is started. In such case it takes care to not wait
for commit of the running transaction (which would deadlock) but only
for a commit of a transaction that is already committing (which is safe
as that doesn't wait for any filesystem locks).

In fact there are also other callers of jbd2_log_wait_commit() that take
care to pass tid of a transaction that is already committing and for
those cases, the lockdep instrumentation is too restrictive and leading
to false positive reports. Fix the problem by calling
jbd2_might_wait_for_commit() from jbd2_log_wait_commit() only if the
transaction isn't already committing.

Fixes: 1eaa566d368b214d99cbb973647c1b0b8102a9ae
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/journal.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -691,8 +691,21 @@ int jbd2_log_wait_commit(journal_t *jour
 {
 	int err = 0;
 
-	jbd2_might_wait_for_commit(journal);
 	read_lock(&journal->j_state_lock);
+#ifdef CONFIG_PROVE_LOCKING
+	/*
+	 * Some callers make sure transaction is already committing and in that
+	 * case we cannot block on open handles anymore. So don't warn in that
+	 * case.
+	 */
+	if (tid_gt(tid, journal->j_commit_sequence) &&
+	    (!journal->j_committing_transaction ||
+	     journal->j_committing_transaction->t_tid != tid)) {
+		read_unlock(&journal->j_state_lock);
+		jbd2_might_wait_for_commit(journal);
+		read_lock(&journal->j_state_lock);
+	}
+#endif
 #ifdef CONFIG_JBD2_DEBUG
 	if (!tid_geq(journal->j_commit_request, tid)) {
 		printk(KERN_ERR
