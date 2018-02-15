Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708617-2-13028731280381177921
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
    t=1518708616; b=qZYLZgd3brh6xKNRCtlQKvu+4wypiOymyISjrOixF13m8TT
    HJUqpPb6Vv97nWQ3PP8xCxFJxrDMQqIGjR1TSMXJ36XMpbCwLE+sDmh640ngjtJF
    xilN/3OtnSgWksmcHwQVxk950/UYziChUltn9rEqu5WtTaaraJwsH7BepVg2fbJe
    K5hlMFZ1sZTbSD3GLGVVswJymwgVracnFs0PxrcKecc6mM0sqnWsSA9yJh8NhYyR
    9EaYg7Fgdo3tDUN3gJSsabhnNjc1OY5txrX9J7VIvOAtsOoHuPK5rYzwy8bI2fyO
    YzTLqfAFecnTlB8O9pk3QB28J7jVyadTk6QUOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708616; bh=wFJWLcbmfPTfVsYuDcFvDmbx69
    VaJEx1J0U0Ax95blQ=; b=OvDsEicitQtKoot5YfgmBjBblQdeiASLjIx/3wta0x
    ao4FFlvxGk6ht7fC8CBoD73C4nLbHFGyRO4xW2KJRkPmwLc6H+MYM4u1MI68IZWH
    xWVgT8K4J59AGrRVOFAJF6AvLzfmhNpRWSA1vZ8SHtGfo0k0kEaHms/ia3mkkYW0
    5y+GlYeN9c9KwawqhrmqRVG8RR/XkRNex6kBYWOL324xlbKjxfOSc3HklPL2ecZc
    OFsX/2m64zbaOEu4uJDN8Qoxswq9xzUmfgFpaJ5XeqFHN1bKuCooKk6IkwaMyJlC
    jNvfCAUhqicoajHi76I0pmFyShdbtYVL3IseKJ2jpOlA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164170AbeBOPaN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:30:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163719AbeBOPaK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:30:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 008/195] sched/wait: Fix add_wait_queue() behavioral change
Date: Thu, 15 Feb 2018 16:14:59 +0100
Message-Id: <20180215151706.164372057@linuxfoundation.org>
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

From: Omar Sandoval <osandov@fb.com>

commit c6b9d9a33029014446bd9ed84c1688f6d3d4eab9 upstream.

The following cleanup commit:

  50816c48997a ("sched/wait: Standardize internal naming of wait-queue entries")

... unintentionally changed the behavior of add_wait_queue() from
inserting the wait entry at the head of the wait queue to the tail
of the wait queue.

Beyond a negative performance impact this change in behavior
theoretically also breaks wait queues which mix exclusive and
non-exclusive waiters, as non-exclusive waiters will not be
woken up if they are queued behind enough exclusive waiters.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@fb.com
Fixes: ("sched/wait: Standardize internal naming of wait-queue entries")
Link: http://lkml.kernel.org/r/a16c8ccffd39bd08fdaa45a5192294c784b803a7.1512544324.git.osandov@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/wait.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -27,7 +27,7 @@ void add_wait_queue(struct wait_queue_he
 
 	wq_entry->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&wq_head->lock, flags);
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
+	__add_wait_queue(wq_head, wq_entry);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 EXPORT_SYMBOL(add_wait_queue);
