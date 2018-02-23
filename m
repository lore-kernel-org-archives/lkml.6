Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415997-2-16739286592047687562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415996; b=QWJHp4VE9uyUn40BqB9BQQsmqEMnx+vaGDWH5EBEWM2Iwu9
    dpgzXoYwiI8kl/ksG/Bat5ECWkkmo7Ydix6xh8lsb0xXRATsdBZe+ctj+oG1yhku
    3gOyfiZXIsjVLX7mvScO1W5CzM8B1kBOP00QN67zpQ0swWtsP/ntq0N/WGz9VdB4
    HZKv5z7+nUKBc2zR4oRuhTT98xMniqX+BquU1EZMpeS4QF9O5TTRFP0jr9cBuI21
    jFUS9hytEmvmIPcHyc0r138VMuICLlExvRsGCF1CTR5OFqv/js8mhF/tJUWVuWFJ
    +zs/Z3KbHKhpg/c9kMlnLdLpadUhFWvhwMqSjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415996; bh=2jMw+xSAHBrlmkhxpnBZfNpFeQ
    1VEYy2/M24ezRfNkI=; b=Q82/SCOL6L5q7FvG9g3QUzYV5KKNvlx0LxINjW2QR/
    lfGHV/MEPSn0ARNZgq0fTLBg6RTjKPPzcPiuJibU8J6Dquapo0W7Rp4gcbMBmlXf
    /tgX6fbCHk1SY/bI3nDKfSjYObx14ifx1HBC6R2vjtUmEN8u4btOMNp4zxQlYRW4
    6ZnrsNI3sysBHOnBRszItqM4ucQOI565HjnGTJW/yeQRw+7+icKJ5EuHMm3Depr9
    TMqb5uPYtbe9CWFX/hzC+/sdfwN5zefVXUGiWhqBCaJjfo3JuwsV8GITukV1LnkO
    K9/a+h4cseBKRrBgfhfjN01+c7x32vN4fNR5spltF5Ug==
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
        id S933053AbeBWSnv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:43:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeBWSnt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.9 038/145] binder: check for binder_thread allocation failure in binder_poll()
Date: Fri, 23 Feb 2018 19:25:44 +0100
Message-Id: <20180223170729.872536682@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.

If the kzalloc() in binder_get_thread() fails, binder_poll()
dereferences the resulting NULL pointer.

Fix it by returning POLLERR if the memory allocation failed.

This bug was found by syzkaller using fault injection.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2628,6 +2628,8 @@ static unsigned int binder_poll(struct f
 	binder_lock(__func__);
 
 	thread = binder_get_thread(proc);
+	if (!thread)
+		return POLLERR;
 
 	wait_for_proc_work = thread->transaction_stack == NULL &&
 		list_empty(&thread->todo) && thread->return_error == BR_OK;
