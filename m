Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710783-2-10279385004433405135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710782; b=jvA63zzECRnJ5UE0SWi9uloiVn3mhttk+xLRvqN/+gCfHM5
    U3U0b67HhPxy4WnbQjR0nm1eTggwjgY3VvkOxmZs0QPCxjlMwSHwgmQyOTYDjNpx
    fr3HggWJz2faQdiCh5AVe8sQeNNpsuktwFRTGiO1+8cH6SA04kZQy6yVjO2QUJQu
    8vUPV54j91Vkaq+Y7cBdbo2Ecg1MzwE2fvQSEZ31lCMVATdSpb3cQD94wbaajhwn
    da4pbU+3bQxa0CMWywj+inwfFKp1sypivRprBiZke0uwS255NFOCXaxTD7RdQwP1
    +5y4aGh2HBC1FdCP0SmMHoyUqnJK+UPJdTJylIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710782; bh=mrjaWqk+75qCa2JjYST/MZIDRl
    LTq6BddtTLt6OHFg8=; b=Uz6ALIwQz87kg5BCU6m3sH7cY1mTKqHDhhEPy0cijg
    rB7QfqiWFisbbVUhvXcgFp2tyjWtjCfd9z79HfioL8veDqLKybSJ6L980gKjSj0F
    X88vWkvu066RNWsqwsevQZ2dqXKQuNuYqJXz54unCyaKXHIoXmPjcuppaQ8yltVI
    aLjluzHWCWOB6VaiDpG7/UsTL0FEc4A+R26IxoAsRZK746G/szmmdizpqu9gJLZz
    8hFnhd6K3osieDFYs/Kbs+MDpe8gw7+PeYyvmIixA7/uwZwVTGbigcPfG1G1WLps
    HcgVgMfGQ1YghVHyeJ69/K2yI3TXkMISQVEO2ZKQVDHw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424572AbeBOPp7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424564AbeBOPpy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhouyi Zhou <yizhouzhou@ict.ac.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 158/202] kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"
Date: Thu, 15 Feb 2018 16:17:38 +0100
Message-Id: <20180215151721.162546627@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit a1be1f3931bfe0a42b46fef77a04593c2b136e7f upstream.

This reverts commit ba62bafe942b ("kernel/relay.c: fix potential memory leak").

This commit introduced a double free bug, because 'chan' is already
freed by the line:

    kref_put(&chan->kref, relay_destroy_channel);

This bug was found by syzkaller, using the BLKTRACESETUP ioctl.

Link: http://lkml.kernel.org/r/20180127004759.101823-1-ebiggers3@gmail.com
Fixes: ba62bafe942b ("kernel/relay.c: fix potential memory leak")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/relay.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -611,7 +611,6 @@ free_bufs:
 
 	kref_put(&chan->kref, relay_destroy_channel);
 	mutex_unlock(&relay_channels_mutex);
-	kfree(chan);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(relay_open);
