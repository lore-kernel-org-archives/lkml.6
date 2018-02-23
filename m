Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413973-2-17507787656240369230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413972; b=X0Fcixz5FOCa6Aa+BbhAmcmjLJq0zhUP3FtNre0aT7H6tOL
    oWAegQPP5qZu2gZM3UZoCOc6unMActZTXej6njO5UQa8PcW/Ra+Dl5+qq+6xmcS3
    +vOfQS7p28RaF/GAgpz5ZgvW8aR7A+20wEkwfFlLv/2cuI/hawpz/CAW2LqVS3j6
    S9FY3oLxmRXRNMXBxN/yFEcQB5E1i4lqw/3HvffrUGTk5MBOvVHOB1zuQSIqrUZF
    aEDSAnmmn9uNy2RX/ioETERJCyU7EhKgEiWx6GPSxzhOK9INvs5s1RXRoeWmNG4B
    IAvy2C/8QRIsO0FKCebGqmCQBrQ2vm2p6mtlhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413972; bh=RH0lYvq9OBLMDwtZDesALYffQL
    j7J0ZKwLPtqxos7NY=; b=QSXkG/MErPjeXKBB/939HqPBvMxFyokbb1EuD4q13Y
    bjSJT5QcJ9f/N5dbl+Fe+XI9MtGH2xzu4rHSADIx4zt9LlU9Ei6YqKeoKyEFKPka
    XAkPBrEo6OjRJXk9taV9CLYt19IuL0jD4ZbAfOjBtwQrGxlOCayndECi0d1vc0aV
    CRlLdWELqkqTTXSeiwGat0AnQEB3DaWfNBr9ZbnoylyON99N+3eXdLIy7Qhgi3Id
    G4z5tMc8TTPQJet9rUgWvXctv44FkRB6zjddpMTy2TLAz7aDPkdrovh+8Jmr8OOm
    hs2a7KXALSO7f+RV88ipWAeB3Rgb48Dfg4DrwjUGHFaQ==
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
        id S934952AbeBWSwp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935166AbeBWSwn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 040/159] netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
Date: Fri, 23 Feb 2018 19:25:48 +0100
Message-Id: <20180223170748.289683050@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 7dc68e98757a8eccf8ca7a53a29b896f1eef1f76 upstream.

rateest_hash is supposed to be protected by xt_rateest_mutex,
and, as suggested by Eric, lookup and insert should be atomic,
so we should acquire the xt_rateest_mutex once for both.

So introduce a non-locking helper for internal use and keep the
locking one for external.

Reported-by: <syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com>
Fixes: 5859034d7eb8 ("[NETFILTER]: x_tables: add RATEEST target")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_RATEEST.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -39,23 +39,31 @@ static void xt_rateest_hash_insert(struc
 	hlist_add_head(&est->list, &rateest_hash[h]);
 }
 
-struct xt_rateest *xt_rateest_lookup(const char *name)
+static struct xt_rateest *__xt_rateest_lookup(const char *name)
 {
 	struct xt_rateest *est;
 	unsigned int h;
 
 	h = xt_rateest_hash(name);
-	mutex_lock(&xt_rateest_mutex);
 	hlist_for_each_entry(est, &rateest_hash[h], list) {
 		if (strcmp(est->name, name) == 0) {
 			est->refcnt++;
-			mutex_unlock(&xt_rateest_mutex);
 			return est;
 		}
 	}
-	mutex_unlock(&xt_rateest_mutex);
+
 	return NULL;
 }
+
+struct xt_rateest *xt_rateest_lookup(const char *name)
+{
+	struct xt_rateest *est;
+
+	mutex_lock(&xt_rateest_mutex);
+	est = __xt_rateest_lookup(name);
+	mutex_unlock(&xt_rateest_mutex);
+	return est;
+}
 EXPORT_SYMBOL_GPL(xt_rateest_lookup);
 
 void xt_rateest_put(struct xt_rateest *est)
@@ -100,8 +108,10 @@ static int xt_rateest_tg_checkentry(cons
 
 	net_get_random_once(&jhash_rnd, sizeof(jhash_rnd));
 
-	est = xt_rateest_lookup(info->name);
+	mutex_lock(&xt_rateest_mutex);
+	est = __xt_rateest_lookup(info->name);
 	if (est) {
+		mutex_unlock(&xt_rateest_mutex);
 		/*
 		 * If estimator parameters are specified, they must match the
 		 * existing estimator.
@@ -139,11 +149,13 @@ static int xt_rateest_tg_checkentry(cons
 
 	info->est = est;
 	xt_rateest_hash_insert(est);
+	mutex_unlock(&xt_rateest_mutex);
 	return 0;
 
 err2:
 	kfree(est);
 err1:
+	mutex_unlock(&xt_rateest_mutex);
 	return ret;
 }
 
