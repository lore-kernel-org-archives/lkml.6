Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQwpcgFDbfHV73njxL9WF2S6kRcxC92RBPJzIMcj7uC84zjlCzRpk52FShslJZynvVlqPL
ARC-Seal: i=1; a=rsa-sha256; t=1521214171; cv=none;
        d=google.com; s=arc-20160816;
        b=OAHDSnmlrvwJeA6UunHJWfDmLIHH5WM2BqnZ5rKiYFg0HI2k/6e1hH8a8Ai7Jw2ZAL
         sKO1i6Il7in63UJrsEQM0AW0WcW7yUoGW3E+AJL76lhX+flzGLouf2reuN0KfU6yWhQR
         AP3SmkCr3ZKiavnB+yKvaZWbl86sZ08UoTnU1XvNJUEPghL+UQWZVIp68DNnJJMXylF8
         gzLPb0RJ7fK2kx3irZTOVxld7aQ5Pb6IJCIcVBWmS0DNQ3rrpphCSQdcYMAboLhVBYm0
         4S9jlDD+0HmTifvZk/cKWAJeM4P8aap6CzvN3mcDG2FPK2ij6GQJXjALGEobCa1H8jK8
         m2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1dlOtY77NJ4g8pcwOLMfePCac094RLdDH3EaymP9KK8=;
        b=nkca8xT8QIe8phuGVRJD9DuCsOz9yBuKaC8KtdisYT28CfGMTD1Hm1veAYBli5JYCk
         cmoWKUnyZXr9GOFdva4TrQaFs4Ytm3AR2H9H6wZ2F+usssJC8AEdJaG0ubWCfmG9BpTQ
         3d1uFAVtqDY8pVyiOEZZ+oEy3EYHXbgAU3xQ3E3XJMOM9ZORTCY6v6Bx+eZTQwladAbi
         Nw5LTa2gGGQkfC4bbfVlrsOFzQHQ7dg5xJbtXODycPATZuLUCjK6nWezLj91xH8yVzKC
         ytj7ZnDHFy+OqOQne0ZOBMT8J6BR342MIgWXFzSkhJv3QsTywow3UF8GLIzifkv2aKhO
         vPxA==
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
Subject: [PATCH 4.4 43/63] netfilter: x_tables: pass xt_counters struct to counter allocator
Date: Fri, 16 Mar 2018 16:23:15 +0100
Message-Id: <20180316152304.686103870@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108670870923583?=
X-GMAIL-MSGID: =?utf-8?q?1595108670870923583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -369,32 +369,7 @@ static inline unsigned long ifname_compa
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
@@ -515,13 +515,10 @@ find_check_entry(struct arpt_entry *e, c
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
@@ -657,12 +657,9 @@ find_check_entry(struct ipt_entry *e, st
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
@@ -670,12 +670,9 @@ find_check_entry(struct ip6t_entry *e, s
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
@@ -1592,6 +1592,36 @@ void xt_proto_fini(struct net *net, u_in
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
