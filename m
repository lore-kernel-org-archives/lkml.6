Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvpLbptjExqjxJhnqwlnliSQ5bLgGgISmwr/KgsPXLvPPbGsinoI+wz2CUBlH/ADBRPNLbd
ARC-Seal: i=1; a=rsa-sha256; t=1521214345; cv=none;
        d=google.com; s=arc-20160816;
        b=cQwkwp0gN/gFoM565lp0xJptPRYpLXShKEe+aqN+5QxMXmj21B785ake1zPrhYXz1x
         PnhWvoVdXPh73n6QuDMjcQfSgsaavMYdcrBFeDHAIMrZYm55nfZLMBRf5lroB7uXvu9U
         UCSFnCQOksNgmlB5ACgByH/0X3vwqXMJRmVw8qBSAoefHTlajU0wXi4EGvvwMtQP3aUv
         r8+X7z1Wtr7X41WM0lrVhOgCldDbtGvHh9AbwTg38AasyjYvB246OrPl1owyb7XUKyb2
         Mfz7wN5p4iFeHPAay0NoqcaNHqMY4xZvPHHKb1kGJke1qzFfIN81uxffElEUoEJERIKC
         XNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9CMWIK+F5zug8tdnf5ReBmXoIvGA3yioeFykeLzIHGU=;
        b=ItUK8wsJ2s6CDYVjWYFqdPXE2nPmWHg8tnME/K4eFKshoEJip54kv52BXqAjObfBg3
         4nnLv0K0lEWCDeyg59hNFjyK9Mf96ikww423xSG5eoeDUyYzohVA7DMR+I5XAcJHGODt
         eu7goVl7lj6sLA+UZWitfMQ546zyj8YyOP53DOFm2ywNnFD7QGUvNUu36h3LTo7Arr9c
         BInuAKkdiI8wXqZXY1o2GajzJssy5QRr/BrCoFML4iU25Thou1GPoLYTtGgTvgOMK/Ug
         H85F4vzogK62VYeUpdFljpJNFJP5Ot3D1QEAQ2a9g8kbuiWye4pli5NjXeWFX9YFFkL+
         PHnw==
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
Subject: [PATCH 4.9 62/86] netfilter: x_tables: pass xt_counters struct to counter allocator
Date: Fri, 16 Mar 2018 16:23:25 +0100
Message-Id: <20180316152321.581568157@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108670870923583?=
X-GMAIL-MSGID: =?utf-8?q?1595108854123041881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit f28e15bacedd444608e25421c72eb2cf4527c9ca upstream.

Keeps some noise away from a followup patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |   27 +--------------------------
 net/ipv4/netfilter/arp_tables.c    |    5 +----
 net/ipv4/netfilter/ip_tables.c     |    5 +----
 net/ipv6/netfilter/ip6_tables.c    |    5 +----
 net/netfilter/x_tables.c           |   30 ++++++++++++++++++++++++++++++
 5 files changed, 34 insertions(+), 38 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -376,32 +376,7 @@ static inline unsigned long ifname_compa
 }
 
 
-/* On SMP, ip(6)t_entry->counters.pcnt holds address of the
- * real (percpu) counter.  On !SMP, its just the packet count,
- * so nothing needs to be done there.
- *
- * xt_percpu_counter_alloc returns the address of the percpu
- * counter, or 0 on !SMP. We force an alignment of 16 bytes
- * so that bytes/packets share a common cache line.
- *
- * Hence caller must use IS_ERR_VALUE to check for error, this
- * allows us to return 0 for single core systems without forcing
- * callers to deal with SMP vs. NONSMP issues.
- */
-static inline unsigned long xt_percpu_counter_alloc(void)
-{
-	if (nr_cpu_ids > 1) {
-		void __percpu *res = __alloc_percpu(sizeof(struct xt_counters),
-						    sizeof(struct xt_counters));
-
-		if (res == NULL)
-			return -ENOMEM;
-
-		return (__force unsigned long) res;
-	}
-
-	return 0;
-}
+bool xt_percpu_counter_alloc(struct xt_counters *counters);
 void xt_percpu_counter_free(struct xt_counters *cnt);
 
 static inline struct xt_counters *
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -423,13 +423,10 @@ find_check_entry(struct arpt_entry *e, c
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
-	unsigned long pcnt;
 	int ret;
 
-	pcnt = xt_percpu_counter_alloc();
-	if (IS_ERR_VALUE(pcnt))
+	if (!xt_percpu_counter_alloc(&e->counters))
 		return -ENOMEM;
-	e->counters.pcnt = pcnt;
 
 	t = arpt_get_target(e);
 	target = xt_request_find_target(NFPROTO_ARP, t->u.user.name,
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -548,12 +548,9 @@ find_check_entry(struct ipt_entry *e, st
 	unsigned int j;
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
-	unsigned long pcnt;
 
-	pcnt = xt_percpu_counter_alloc();
-	if (IS_ERR_VALUE(pcnt))
+	if (!xt_percpu_counter_alloc(&e->counters))
 		return -ENOMEM;
-	e->counters.pcnt = pcnt;
 
 	j = 0;
 	mtpar.net	= net;
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -578,12 +578,9 @@ find_check_entry(struct ip6t_entry *e, s
 	unsigned int j;
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
-	unsigned long pcnt;
 
-	pcnt = xt_percpu_counter_alloc();
-	if (IS_ERR_VALUE(pcnt))
+	if (!xt_percpu_counter_alloc(&e->counters))
 		return -ENOMEM;
-	e->counters.pcnt = pcnt;
 
 	j = 0;
 	mtpar.net	= net;
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1619,6 +1619,36 @@ void xt_proto_fini(struct net *net, u_in
 }
 EXPORT_SYMBOL_GPL(xt_proto_fini);
 
+/**
+ * xt_percpu_counter_alloc - allocate x_tables rule counter
+ *
+ * @counter: pointer to counter struct inside the ip(6)/arpt_entry struct
+ *
+ * On SMP, the packet counter [ ip(6)t_entry->counters.pcnt ] will then
+ * contain the address of the real (percpu) counter.
+ *
+ * Rule evaluation needs to use xt_get_this_cpu_counter() helper
+ * to fetch the real percpu counter.
+ *
+ * returns false on error.
+ */
+bool xt_percpu_counter_alloc(struct xt_counters *counter)
+{
+	void __percpu *res;
+
+	if (nr_cpu_ids <= 1)
+		return true;
+
+	res = __alloc_percpu(sizeof(struct xt_counters),
+			     sizeof(struct xt_counters));
+	if (!res)
+		return false;
+
+	counter->pcnt = (__force unsigned long)res;
+	return true;
+}
+EXPORT_SYMBOL_GPL(xt_percpu_counter_alloc);
+
 void xt_percpu_counter_free(struct xt_counters *counters)
 {
 	unsigned long pcnt = counters->pcnt;
