Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414450-2-6258696349379377530
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
    t=1519414450; b=cJD9O0slEpHYYnuRT7SzRpk76bj7TvHhCxIZgWkCO/TBQ/5
    LEfov7nO7FV7zlDxDFmjZSgEB3AYw92ZAkr5zE/dOxsfF32h9mDx69QeuCHit//d
    5or+gvpLwZ4vLC1Jv7HpeuKiVBSuIy+rkef0BFGsqOoOKM13hxQijPV5A/PTK/hA
    asciUAkksbpw14q6EMDTv+Iyu8I5oMuYlruvcSoMNlj9/nbHErPJfAJLqKiSDsP6
    DguKc9o0+HzShWJEae3Yc51MPl03D8FKyBDml1n6ePCPQHhXNpUU9jvT2Dq3VUbG
    nZuyXaM1/3/QeOMgLTQmZEKnnZtlhWc/7jEQ/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414450; bh=rc149ZYmTO26lYpZbgspMRvs0i
    C9bWhQ0J0IucxtaxM=; b=d54zaT40wY99MMyXy9udHtmV8GSjGfa2nViD4LHnkA
    KJEk2ohixBjhCk23wRUR3xydaarsWfW9/pmEfQ6gAlNA/1O60Asdq4w15JCIxPIY
    hT1xJOK61bJhj/i12k8eMk5SqzLhudQXQovD6cuump9jzt5TDM5FxP6rDPFzN15N
    7v+Ss18o0eYlHbUciqWE9ZTwP8GmBb7MbKO9w2C/hb3RItMGDQeWhtPPvV4/cytc
    OUhPADHLBLp4KrizGmZpssr5iaj0EdiRO9OCvI5J7j38isjckEbUK1TEVbKNcxOG
    AbFjORYWpTH99wTek0LR9RhHZnOaRQ0otniZiWVcabCg==
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
        id S934321AbeBWSvH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934306AbeBWSvF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 044/159] net_sched: gen_estimator: fix lockdep splat
Date: Fri, 23 Feb 2018 19:25:52 +0100
Message-Id: <20180223170748.719730598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 40ca54e3a686f13117f3de0c443f8026dadf7c44 upstream.

syzbot reported a lockdep splat in gen_new_estimator() /
est_fetch_counters() when attempting to lock est->stats_lock.

Since est_fetch_counters() is called from BH context from timer
interrupt, we need to block BH as well when calling it from process
context.

Most qdiscs use per cpu counters and are immune to the problem,
but net/sched/act_api.c and net/netfilter/xt_RATEEST.c are using
a spinlock to protect their data. They both call gen_new_estimator()
while object is created and not yet alive, so this bug could
not trigger a deadlock, only a lockdep splat.

Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/gen_estimator.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -159,7 +159,11 @@ int gen_new_estimator(struct gnet_stats_
 	est->intvl_log = intvl_log;
 	est->cpu_bstats = cpu_bstats;
 
+	if (stats_lock)
+		local_bh_disable();
 	est_fetch_counters(est, &b);
+	if (stats_lock)
+		local_bh_enable();
 	est->last_bytes = b.bytes;
 	est->last_packets = b.packets;
 	old = rcu_dereference_protected(*rate_est, 1);
