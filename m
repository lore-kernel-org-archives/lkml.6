Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837691-2-677999367376703077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837690; b=PlE3QM/URCmRqte7CS31fWgypod0DauoJRKfRAQC0+y9spM
    unGzkEzYTpGXBnBxBYLQqJr12rVaOuOvFUhUebRiBJ4An1EGY3uZTLlJ2s/MxicG
    k//u+wD9z0ukFZ6PfxYOVWspgNG0zYNAfTCfEy35w2LPICGfk1AkWaAyTJ1g+vt3
    drxugzdIrhFEVjYiuvsAH+gMYR7O+xuz7NwCRF384qj+K0IC8atI65r7eQIKKQom
    x2hgboH+GknhJCLPW92ncBwSgmwOV7IQ4GcgyYie2enP/cJvyk2MzccIk67e9XtR
    fdara+yWwhtPrBPR5D5pXh0w+pHIrcqZDj8ShxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837690; bh=JyqsWcN1PQ6A4ZanHON
    xfCQKf7IRghs/aR2j6oMu238=; b=NLz9kQDvElpnHU1osgPUHPBJJIzPv7THbma
    YYevQ2fHFRbKRIstLQwdBS+MNtD5EyIjUbGloSLkp043p64mky2q1ZfUjGhLXBbT
    M/UbJZKRBTMVyhyA2ZWsTt6+FuOhEfPBK0udoCtWVWSzhli+AzzJ62xHo0N0NsqJ
    n6nf4yUZCvUT5xT7U+Jg/KAdVrTgb6JXp+LQhilkbkytsya6NKmhZ0rEjMWHeOCh
    atUwtc7+Omu6RmBfXFydOSqvq+Ex00PjWPnMyMFa90Xi/imK5e92HeoOl/5tkYRb
    cCXm2wLTLJ7BW8M8Nzq0eEDGhfRpESPfwa3RxtwuvqlerxowdVw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeB1RHe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:07:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34310 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933212AbeB1PuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.499547565@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 016/254] blktrace: fix trace mutex deadlock
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 2967acbb257a6a9bf912f4778b727e00972eac9b upstream.

A previous commit changed the locking around registration/cleanup,
but direct callers of blk_trace_remove() were missed. This means
that if we hit the error path in setup, we will deadlock on
attempting to re-acquire the queue trace mutex.

Fixes: 1f2cac107c59 ("blktrace: fix unlocked access to init/start-stop/teardown")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -562,7 +562,7 @@ static int __blk_trace_setup(struct requ
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
@@ -608,7 +608,7 @@ static int compat_blk_trace_setup(struct
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 
