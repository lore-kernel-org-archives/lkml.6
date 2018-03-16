Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuCJdEFPuPonNrTkJS2PKC41zRbqoEwk1nXbTKQVZNZ5OIbmQ4WAXCly1dk+ldU2O8kh+KP
ARC-Seal: i=1; a=rsa-sha256; t=1521214174; cv=none;
        d=google.com; s=arc-20160816;
        b=s5FGRJNNHGlzUF7kkUOEJ8D7uGN4BLZXaG2vqdX5YSSYPAUSIbbprDzThaa5KZebwO
         NMzMq87iPcJkWzy1wxG1p0QHgmE5fUrb+XBueklxXpH/md16LvqQRa87zmfDtacmlNFM
         tigrcHmQWHfw8t9wa9fnrC4gCzHz67Az+GtkC85J9Bp8AVjH90tNzdFW3/Qjnq+H9pqQ
         E2VTP0pJ0E+8afjZmHoUF432r2PGL3Zz3ZI+o6VMZGwjiuNuFiZJPZjCkFNJOKd8XA1u
         z9tEGmZDOeYOIcPhsuzEmetkDIBsK8TsbjCdiwakHFn61WtzM3RNQcho1QpjqoxsFZt+
         UA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ig868ZkbdCw0qwddWzUHJWcPTMi5vNI/ILcSP1I2V9o=;
        b=VZU2mHqSXlY/lNz09oWYbAsFzSVZ/muC7XQw58tDCjVoYdW7m1uJd/ICRIhJqdhXoD
         kUMArNcGQsz2iWxN0P954Kccw4QzriSnbTUZZDnlAC9yatEymzc7Yen2WGmLuYjWtPKU
         1WyhRUgrTa2fGxMuRFfzK1IFWFykwdbT4NFRCWsNStVubFG4M3bwv524hs9IOVvhYJPt
         +10d/hD748fSOZAjTsVyFrcWCLx5mj2U478fHWnM4MdM6mU2O5n0IwFyGdXgrud2s5vQ
         xE1go++ILO86uIZYvVyhz7wlZv1CqK+LfOdZBrgtV/e0rWSK0TmsumnmINIIFOlV4vHg
         HQhg==
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
Subject: [PATCH 4.4 44/63] netfilter: x_tables: pack percpu counter allocations
Date: Fri, 16 Mar 2018 16:23:16 +0100
Message-Id: <20180316152304.725620118@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108674352758169?=
X-GMAIL-MSGID: =?utf-8?q?1595108674352758169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -368,8 +368,13 @@ static inline unsigned long ifname_compa
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
@@ -511,13 +511,14 @@ static inline int check_target(struct ar
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
@@ -634,6 +635,7 @@ static inline void cleanup_entry(struct
 static int translate_table(struct xt_table_info *newinfo, void *entry0,
 			   const struct arpt_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct arpt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -707,7 +709,8 @@ static int translate_table(struct xt_tab
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
@@ -649,7 +649,8 @@ static int check_target(struct ipt_entry
 
 static int
 find_check_entry(struct ipt_entry *e, struct net *net, const char *name,
-		 unsigned int size)
+		 unsigned int size,
+		 struct xt_percpu_counter_alloc_state *alloc_state)
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
@@ -658,7 +659,7 @@ find_check_entry(struct ipt_entry *e, st
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
 
-	if (!xt_percpu_counter_alloc(&e->counters))
+	if (!xt_percpu_counter_alloc(alloc_state, &e->counters))
 		return -ENOMEM;
 
 	j = 0;
@@ -803,6 +804,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ipt_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct ipt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -872,7 +874,8 @@ translate_table(struct net *net, struct
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
@@ -662,7 +662,8 @@ static int check_target(struct ip6t_entr
 
 static int
 find_check_entry(struct ip6t_entry *e, struct net *net, const char *name,
-		 unsigned int size)
+		 unsigned int size,
+		 struct xt_percpu_counter_alloc_state *alloc_state)
 {
 	struct xt_entry_target *t;
 	struct xt_target *target;
@@ -671,7 +672,7 @@ find_check_entry(struct ip6t_entry *e, s
 	struct xt_mtchk_param mtpar;
 	struct xt_entry_match *ematch;
 
-	if (!xt_percpu_counter_alloc(&e->counters))
+	if (!xt_percpu_counter_alloc(alloc_state, &e->counters))
 		return -ENOMEM;
 
 	j = 0;
@@ -814,6 +815,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ip6t_replace *repl)
 {
+	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
 	struct ip6t_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -883,7 +885,8 @@ translate_table(struct net *net, struct
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
@@ -38,6 +38,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
+#define XT_PCPU_BLOCK_SIZE 4096
+
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
 	int delta; /* delta in 32bit user land */
@@ -1595,6 +1597,7 @@ EXPORT_SYMBOL_GPL(xt_proto_fini);
 /**
  * xt_percpu_counter_alloc - allocate x_tables rule counter
  *
+ * @state: pointer to xt_percpu allocation state
  * @counter: pointer to counter struct inside the ip(6)/arpt_entry struct
  *
  * On SMP, the packet counter [ ip(6)t_entry->counters.pcnt ] will then
@@ -1603,21 +1606,34 @@ EXPORT_SYMBOL_GPL(xt_proto_fini);
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
@@ -1626,7 +1642,7 @@ void xt_percpu_counter_free(struct xt_co
 {
 	unsigned long pcnt = counters->pcnt;
 
-	if (nr_cpu_ids > 1)
+	if (nr_cpu_ids > 1 && (pcnt & (XT_PCPU_BLOCK_SIZE - 1)) == 0)
 		free_percpu((void __percpu *)pcnt);
 }
 EXPORT_SYMBOL_GPL(xt_percpu_counter_free);
