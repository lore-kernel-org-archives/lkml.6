Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscIViSvsFUFbgZ0iq0J7N2KgxW0QpCntKa2o2IdyyhgR5cbqHAqnw2InYnvOltoZlwOfOT
ARC-Seal: i=1; a=rsa-sha256; t=1521214343; cv=none;
        d=google.com; s=arc-20160816;
        b=O7o3p9ljzRDW1l5eorBFT13VhTcPcfC6y0tlBqfv0wyOC6TZVQyot87ob4fahAH19v
         1G/ap3n4zvP1aEKEHNXN9Xv6IGpa+YgIbbD/Bqr5jFRbuRIb89DGRMjroHodjLwrquuN
         +CLztYwhkK0Zps03zdmNXdz4n5aeWw9O8XpN9B8o6NcJG+SfNTb1FOdkc0xmWs1TyWA1
         LeVT6yk3RSyl7FwiOOAL3cjF+kw/lZb2z4mx+jEgdgcQCfMvnU7ntHBBuFuM3RNEGEcj
         GyQHBsNZT7Q4V/e9vghmvFiEDtJtmHLqzy27grpscP+NU6bnFuNicxfus/bvW5iV7uT7
         3Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VTLIejDXSPVwjzrEGVj/QlLISO9H/Y4bYhaVPKZjTSQ=;
        b=d/46T1f06jhD52Ys/IePZfZ5BNdZmur/Y6mJ5YyQXiXkt93EXfQHPFHglenc4OZ9EW
         qSNLI7SUIQCZo696GPqKj39uAix/XA0hUATGR1PXtmveEliYhxROxo2+leuUv/grOfbS
         KMvC5WNEGHueJGg9JFsGX2DB5XBAc1fijLK+ZBY9i8sFKl+m7HB0VTgKsH1gxNtQzhK6
         Escczmtu/4Y2ldVhhWsr90cb3gChvq7pt8nSTH8ZwXcxyCPFulsc2bycDVszN1VJt2CA
         ZyhOUqHfUWqrCDj6KpQeEPckfcy7Dq9wBbBlS9cobJmBAI8QSnQjv6GLqwUPAvEiObOC
         ogUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 61/86] netfilter: x_tables: pass xt_counters struct instead of packet counter
Date: Fri, 16 Mar 2018 16:23:24 +0100
Message-Id: <20180316152321.493160668@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108668101201030?=
X-GMAIL-MSGID: =?utf-8?q?1595108851061399016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 4d31eef5176df06f218201bc9c0ce40babb41660 upstream.

On SMP we overload the packet counter (unsigned long) to contain
percpu offset.  Hide this from callers and pass xt_counters address
instead.

Preparation patch to allocate the percpu counters in page-sized batch
chunks.

Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    6 +-----
 net/ipv4/netfilter/arp_tables.c    |    4 ++--
 net/ipv4/netfilter/ip_tables.c     |    4 ++--
 net/ipv6/netfilter/ip6_tables.c    |    5 ++---
 net/netfilter/x_tables.c           |    9 +++++++++
 5 files changed, 16 insertions(+), 12 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -402,11 +402,7 @@ static inline unsigned long xt_percpu_co
 
 	return 0;
 }
-static inline void xt_percpu_counter_free(u64 pcnt)
-{
-	if (nr_cpu_ids > 1)
-		free_percpu((void __percpu *) (unsigned long) pcnt);
-}
+void xt_percpu_counter_free(struct xt_counters *cnt);
 
 static inline struct xt_counters *
 xt_get_this_cpu_counter(struct xt_counters *cnt)
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -447,7 +447,7 @@ find_check_entry(struct arpt_entry *e, c
 err:
 	module_put(t->u.kernel.target->me);
 out:
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -527,7 +527,7 @@ static inline void cleanup_entry(struct
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -591,7 +591,7 @@ find_check_entry(struct ipt_entry *e, st
 		cleanup_match(ematch, net);
 	}
 
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -679,7 +679,7 @@ cleanup_entry(struct ipt_entry *e, struc
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -620,7 +620,7 @@ find_check_entry(struct ip6t_entry *e, s
 		cleanup_match(ematch, net);
 	}
 
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -707,8 +707,7 @@ static void cleanup_entry(struct ip6t_en
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1619,6 +1619,15 @@ void xt_proto_fini(struct net *net, u_in
 }
 EXPORT_SYMBOL_GPL(xt_proto_fini);
 
+void xt_percpu_counter_free(struct xt_counters *counters)
+{
+	unsigned long pcnt = counters->pcnt;
+
+	if (nr_cpu_ids > 1)
+		free_percpu((void __percpu *)pcnt);
+}
+EXPORT_SYMBOL_GPL(xt_percpu_counter_free);
+
 static int __net_init xt_net_init(struct net *net)
 {
 	int i;
