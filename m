Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOqpWmH4JGPG4c9nAj3RPNXj18w083ISwNIqFany0LZ59JkcaUra9iwYyCviNcF0MuQC2L
ARC-Seal: i=1; a=rsa-sha256; t=1521214351; cv=none;
        d=google.com; s=arc-20160816;
        b=Pv00CjrwWDBW9wW3gR3Lro8WpLXafU0THYvE7NwKcG/mr7bMv8K7cUtLQL1MtfaoRU
         jxIum97yOpu8kyxKAzwihqDFrIo0+HwkNQtlvsd4b4FFMYSFNu8yiYUDDOsD3RCr/ogD
         5gK706JBwqnFtxEfENqw2UgIayHZJrn9CZLV3o7TCU7rlhTlkwAM1SayspHyU6PweICf
         yvi0d/lhVskdpMx0aXxVhoO28lfUd2O1xJX9ZKTV6VLUAUSeqHpQ9xy8K9ydpidU0yco
         xNkGVE749s4DQXH9+mQZgCCLvWb5QsWRnhpHjmsXq3MQd6MPpb2Hs1YExQCma7rQLZ7/
         vFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+6mvDr7I6p7iI4mFOVD2G9uRGJirf/Psw/2N7W8mkYs=;
        b=q7n6waKRKLoBjhGgjR5oUQI4379PN2+OAG3QwD07bRLgn3vDMC7OM5cVq5ANJEROcb
         g25CwodWxBgcA2aww0+EZntyLRsL/K/1kEGDXEbUgBnI/hMdrkT1ypd90QIz1czLnfSQ
         YmQAeGWSCnfKyX9TlAxSf1zTYICyTjlZjNQL9tDoNnTedbHV7NRNSTe54TU2yjGT3Hov
         pXABxvX693LFz/Xc52XAwWYbYyXSQf60E1yxFkPQa6btfQvuw+t4Y5Og0rMVMvE9s7qE
         5oOM3n1QxlN7bQqYV9D2k8MnolWH6gvnSIWlVAB89wtoSnm0zzW0iZUm1XUNdwml8Qiv
         B0Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 63/86] netfilter: x_tables: pack percpu counter allocations
Date: Fri, 16 Mar 2018 16:23:26 +0100
Message-Id: <20180316152321.630850276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108674352758169?=
X-GMAIL-MSGID: =?utf-8?q?1595108859877944971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit ae0ac0ed6fcf5af3be0f63eb935f483f44a402d2 upstream.

instead of allocating each xt_counter individually, allocate 4k chunks
and then use these for counter allocation requests.

This should speed up rule evaluation by increasing data locality,
also speeds up ruleset loading because we reduce calls to the percpu
allocator.

As Eric points out we can't use PAGE_SIZE, page_allocator would fail on
arches with 64k page size.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    7 ++++++-
 net/ipv4/netfilter/arp_tables.c    |    9 ++++++---
 net/ipv4/netfilter/ip_tables.c     |    9 ++++++---
 net/ipv6/netfilter/ip6_tables.c    |    9 ++++++---
 net/netfilter/x_tables.c           |   34 +++++++++++++++++++++++++---------
 5 files changed, 49 insertions(+), 19 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -375,8 +375,13 @@ static inline unsigned long ifname_compa
 	return ret;
 }
 
+struct xt_percpu_counter_alloc_state {
+	unsigned int off;
+	const char __percpu *mem;
+};
 
-bool xt_percpu_counter_alloc(struct xt_counters *counters);
+bool xt_percpu_counter_alloc(struct xt_percpu_counter_alloc_state *state,
+			     struct xt_counters *counter);
 void xt_percpu_counter_free(struct xt_counters *cnt);
 
 static inline struct xt_counters *
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -419,13 +419,14 @@ static inline int check_target(struct ar
 }
 
 static inline int
-find_check_entry(struct arpt_entry *e, const char *name, unsigned int size)
+find_check_entry(struct arpt_entry *e, const char *name, unsigned int size,
+		 struct xt_percpu_counter_alloc_state *alloc_state)
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
 	int ret;
 
-	if (!xt_percpu_counter_alloc(&e->counters))
+	if (!xt_percpu_counter_alloc(alloc_state, &e->counters))
 		return -ENOMEM;
 
 	t = arpt_get_target(e);
@@ -533,6 +534,7 @@ static inline void cleanup_entry(struct
 static int translate_table(struct xt_table_info *newinfo, void *entry0,
 			   const struct arpt_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct arpt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -595,7 +597,8 @@ static int translate_table(struct xt_tab
 	/* Finally, each sanity check must pass */
 	i = 0;
 	xt_entry_foreach(iter, entry0, newinfo->size) {
-		ret = find_check_entry(iter, repl->name, repl->size);
+		ret = find_check_entry(iter, repl->name, repl->size,
+				       &alloc_state);
 		if (ret != 0)
 			break;
 		++i;
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -540,7 +540,8 @@ static int check_target(struct ipt_entry
 
 static int
 find_check_entry(struct ipt_entry *e, struct net *net, const char *name,
-		 unsigned int size)
+		 unsigned int size,
+		 struct xt_percpu_counter_alloc_state *alloc_state)
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
@@ -549,7 +550,7 @@ find_check_entry(struct ipt_entry *e, st
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
 
-	if (!xt_percpu_counter_alloc(&e->counters))
+	if (!xt_percpu_counter_alloc(alloc_state, &e->counters))
 		return -ENOMEM;
 
 	j = 0;
@@ -685,6 +686,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ipt_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct ipt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -744,7 +746,8 @@ translate_table(struct net *net, struct
 	/* Finally, each sanity check must pass */
 	i = 0;
 	xt_entry_foreach(iter, entry0, newinfo->size) {
-		ret = find_check_entry(iter, net, repl->name, repl->size);
+		ret = find_check_entry(iter, net, repl->name, repl->size,
+				       &alloc_state);
 		if (ret != 0)
 			break;
 		++i;
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -570,7 +570,8 @@ static int check_target(struct ip6t_entr
 
 static int
 find_check_entry(struct ip6t_entry *e, struct net *net, const char *name,
-		 unsigned int size)
+		 unsigned int size,
+		 struct xt_percpu_counter_alloc_state *alloc_state)
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
@@ -579,7 +580,7 @@ find_check_entry(struct ip6t_entry *e, s
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
 
-	if (!xt_percpu_counter_alloc(&e->counters))
+	if (!xt_percpu_counter_alloc(alloc_state, &e->counters))
 		return -ENOMEM;
 
 	j = 0;
@@ -713,6 +714,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ip6t_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct ip6t_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -772,7 +774,8 @@ translate_table(struct net *net, struct
 	/* Finally, each sanity check must pass */
 	i = 0;
 	xt_entry_foreach(iter, entry0, newinfo->size) {
-		ret = find_check_entry(iter, net, repl->name, repl->size);
+		ret = find_check_entry(iter, net, repl->name, repl->size,
+				       &alloc_state);
 		if (ret != 0)
 			break;
 		++i;
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -39,6 +39,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
+#define XT_PCPU_BLOCK_SIZE 4096
+
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
 	int delta; /* delta in 32bit user land */
@@ -1622,6 +1624,7 @@ EXPORT_SYMBOL_GPL(xt_proto_fini);
 /**
  * xt_percpu_counter_alloc - allocate x_tables rule counter
  *
+ * @state: pointer to xt_percpu allocation state
  * @counter: pointer to counter struct inside the ip(6)/arpt_entry struct
  *
  * On SMP, the packet counter [ ip(6)t_entry->counters.pcnt ] will then
@@ -1630,21 +1633,34 @@ EXPORT_SYMBOL_GPL(xt_proto_fini);
  * Rule evaluation needs to use xt_get_this_cpu_counter() helper
  * to fetch the real percpu counter.
  *
+ * To speed up allocation and improve data locality, a 4kb block is
+ * allocated.
+ *
+ * xt_percpu_counter_alloc_state contains the base address of the
+ * allocated page and the current sub-offset.
+ *
  * returns false on error.
  */
-bool xt_percpu_counter_alloc(struct xt_counters *counter)
+bool xt_percpu_counter_alloc(struct xt_percpu_counter_alloc_state *state,
+			     struct xt_counters *counter)
 {
-	void __percpu *res;
+	BUILD_BUG_ON(XT_PCPU_BLOCK_SIZE < (sizeof(*counter) * 2));
 
 	if (nr_cpu_ids <= 1)
 		return true;
 
-	res = __alloc_percpu(sizeof(struct xt_counters),
-			     sizeof(struct xt_counters));
-	if (!res)
-		return false;
-
-	counter->pcnt = (__force unsigned long)res;
+	if (!state->mem) {
+		state->mem = __alloc_percpu(XT_PCPU_BLOCK_SIZE,
+					    XT_PCPU_BLOCK_SIZE);
+		if (!state->mem)
+			return false;
+	}
+	counter->pcnt = (__force unsigned long)(state->mem + state->off);
+	state->off += sizeof(*counter);
+	if (state->off > (XT_PCPU_BLOCK_SIZE - sizeof(*counter))) {
+		state->mem = NULL;
+		state->off = 0;
+	}
 	return true;
 }
 EXPORT_SYMBOL_GPL(xt_percpu_counter_alloc);
@@ -1653,7 +1669,7 @@ void xt_percpu_counter_free(struct xt_co
 {
 	unsigned long pcnt = counters->pcnt;
 
-	if (nr_cpu_ids > 1)
+	if (nr_cpu_ids > 1 && (pcnt & (XT_PCPU_BLOCK_SIZE - 1)) == 0)
 		free_percpu((void __percpu *)pcnt);
 }
 EXPORT_SYMBOL_GPL(xt_percpu_counter_free);
