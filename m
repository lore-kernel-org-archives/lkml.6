Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtg85wSSLeYR/UYlYtnTuE2t4EUAVsnos+ZREOYxMOYImS483XVRP+vgd1d0PET9Vd+3QsQ
ARC-Seal: i=1; a=rsa-sha256; t=1519412253; cv=none;
        d=google.com; s=arc-20160816;
        b=J5zfEhp6dAom1ObySd6nlRCgXbWPsrPskjTrcuQmAKoE9KmZ+5dIwbX50Pr0YgVpB+
         Bj8e7OL/aW8sJOwNDQH4en8isx4dM2IXXGSwwHfj2DXqMFTI9YHphmPk4HrOnSgIxpqV
         krxfq0YH4fOtlFUeTHFvKKvl2DiMNMX7XlAsddLKMYdwO2IFMsdSr+3gRI23I3zU8BBk
         lQUArIQqsjp0+eRPXHugsMDA1TByBC64r/+IG75iPb4uj6b8LhEQJ+TcUCfM33YJUstE
         T98zc2tIdA9L1KOajOyjAxjusepaOaOrjxvJiVqv0qVxMvrkCvzZpKji7RpQ9uFP0WFj
         l7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t++N3aqvbN4wVfJh2AdrgwdUcONkTCGgcMSW0jp1/zw=;
        b=XRt+d+02+eqS/c5rV6jpZH6Qe6bBBoyRLRz5l+V0w/k30Sb2+a5vMIc39eqKrzLCMs
         M7fmNTnIrpVo3KxL/dz7/7YzMc7LFXj43PK/vncYiDQGxLqhDkTLc3koCoQpKPIEcmkF
         aaMJk+FZLxgWauCEuIPoud9dfzjTSF1SU72vDaqUR3KgVMQaqjDzxBI5MHH+iw+q7piy
         /ff2dfi11Km60USyZ/yOc+i3mcgfVGtjV3UW7ZbtdDXxPF8vmB/+rqRDxnaLA8Zbdegd
         X7zq7t7ybH/Nb86B4yUiPDJxJxvz8UyegoFuMZirUUKIScWQ+YhpKSlbuEniHUCr9WRb
         Smsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 18/45] netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
Date: Fri, 23 Feb 2018 19:28:57 +0100
Message-Id: <20180223170718.257734414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217546378915154?=
X-GMAIL-MSGID: =?utf-8?q?1593219222353059728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
