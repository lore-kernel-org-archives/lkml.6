Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419138-2-2273320653118431117
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
    t=1519419137; b=Y1kYh8BZB7FQLJ/+oR2CseHjNAXZrfk9KLKXJdxx3t6FEm6
    cEaJbavip7iWSFXgQ+tfF4A44JVcj+RLYOMxhNTH6uvf7TiVfU+xIy02HTnTZo8C
    OGa9ML+ZGb20pimHvy6Hwbq6TZB5Po6SSf0xlugeKbi93/evTq88YcNoezbRKHBX
    8lqwbh/08JANeT4BZZoi5tsPx4Bl76SLCi6e6Zd6Z+0Hcws0lUViMoxYxV+eXCcm
    Ia0oUVIXzFx38iBLUfA8adUnx2XmxfmyZeHkiZRpmSZ5qF1+HQ8o8CzFt8ca6MLN
    Rx8NlxRRVpSlpFW1Is+6NxrryAt3b2Y+8/LAXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419137; bh=Ae3QTxiA9Q+p7a26KMZwX3hLUb
    HBRScbnBj4Wf9EYHU=; b=l4YUc014wm1IYqIMC5vj+X5dz63rhVkXCVvZ+liAJh
    jbsDs/y7SvSQcvM0If1gW5EsggBnqwW07hEHwRLUkGsAN+hJpSh1oHzZohMw75/g
    lcfNtvY2zwnrfbXCKvS3m8C8sZ8cDFv0bj+4UeA9kKO415YnSiycv4a9zUqZ7ioY
    wyv4DbCucK0Av5+ct8jhu2DfXCj5L0ATlRiwz4xlYuiUpMRDg7W4JXRJMp0xskg8
    0J+PhFTmqG7KlptrtwPVtAiDZTXHME+skNBKwm6Y9zhKZk77Y0dzOAUGrhPB3UtK
    LQ75PL4Dpqd4GGRwGsGPmorFkBWC+iipVq76326FeLPg==
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
        id S1752586AbeBWUv7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:51:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeBWSax (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 27/58] netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
Date: Fri, 23 Feb 2018 19:26:26 +0100
Message-Id: <20180223170211.173449402@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -40,23 +40,31 @@ static void xt_rateest_hash_insert(struc
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
@@ -104,8 +112,10 @@ static int xt_rateest_tg_checkentry(cons
 		rnd_inited = true;
 	}
 
-	est = xt_rateest_lookup(info->name);
+	mutex_lock(&xt_rateest_mutex);
+	est = __xt_rateest_lookup(info->name);
 	if (est) {
+		mutex_unlock(&xt_rateest_mutex);
 		/*
 		 * If estimator parameters are specified, they must match the
 		 * existing estimator.
@@ -143,11 +153,13 @@ static int xt_rateest_tg_checkentry(cons
 
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
 
