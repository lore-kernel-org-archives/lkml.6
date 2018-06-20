Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B7CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BA120874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lg/7g4gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BA120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFTMcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:32:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753619AbeFTMcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2s/eL9JHaseZHZ9/UkO1EdbXVfvWypSWz6ifnzNIPr4=; b=Lg/7g4gixsAqCOchV3KrgeWB+
        2/WIovewCtQcqRd6DUuaZo0gvMIZLyzVWHZMd/BVKqXO1koB/+3SiDvQSN/1UrYyi4oax2dqcMbnm
        k7UtgL1gnSRixlnfPeYSzMZn4uilLSuUvY2ZBf2LTjv4prOzmpbMqnNIfvS4gqzIrjWLjHkggEHXE
        QzPcUZBw95DWOBqaxgKHJwMznFK2IkgvvZf9uRZcOZCpxSkpR0pGGGXj+A+VOcs/WMw2brybu3RsU
        OjA9K034E3PIsnlrxAnZRSnNkXVLXr6ux3snvvnM29+xQBKf4xslFlTtMXvNTrvjSh2Atyg4Vd1vC
        XGALYe8rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVcHS-0006tZ-Sv; Wed, 20 Jun 2018 12:32:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE1ED2029F1D7; Wed, 20 Jun 2018 14:32:08 +0200 (CEST)
Date:   Wed, 20 Jun 2018 14:32:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
Message-ID: <20180620123208.GN2476@hirez.programming.kicks-ass.net>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-8-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
 <20180620091532.GK2476@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806201231030.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201231030.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:42:40PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Jun 2018, Peter Zijlstra wrote:

> > I'm still puzzled by the entire need for tsc_early_enabled and all that.
> > Esp. since both branches do the exact same thing:
> > 
> > 	return cycles_2_ns(rdtsc());
> 
> Right. But up to the point where the real sched_clock initialization can be
> done and the static keys can be flipped, there must be a way to
> conditinally use TSC depending on availablility and early initialization.

Ah, so we want to flip keys early, can be done, see below.

> You might argue, that we shouldn't care becasue the jiffies case is just
> the worst case fallback anyway. I wouldn't even disagree as those old
> machines which have TSC varying with the CPU frequency really should not
> matter anymore. Pavel might disagree of course.

You forgot (rightfully) that we even use TSC on those !constant
machines, we adjust the cycles_2_ns thing from the cpufreq notifiers.

The only case we should _ever_ use that jiffies callback is when TSC
really isn't there. Basically, if we kill notsc, we could make
native_sched_clock() := cycles_2_ns(rdtsc()) (for CONFIG_X86_TSC), the
end.

No static keys, nothing.

That said; flipping static keys early isn't hard. We should call
jump_label_init() early, because we want the entries sorted and the
key->entries link set. It will also replace the GENERIC_NOP5_ATOMIC
thing, which means we need to also do arch_init_ideal_nop() early, but
since that is pure CPUID based that should be doable.

And then something like the below could be used.

---
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..2dd8c5bdd87b 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -140,4 +140,38 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
 
+void jump_label_update_early(struct static_key *key, bool enable)
+{
+	struct jump_entry *entry, *stop = __stop___jump_table;
+
+	/*
+	 * We need the table sorted and key->entries set up.
+	 */
+	WARN_ON_ONCE(!static_key_initialized);
+
+	entry = static_key_entries(key);
+
+	/*
+	 * Sanity check for early users, there had beter be a core kernel user.
+	 */
+	if (!entry || !entry->code || !core_kernel_text(entry->code)) {
+		WARN_ON(1);
+		return;
+	}
+
+	for ( ; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+		enum jump_label_type type = enable ^ jump_entry_branch(entry);
+		__jump_label_transform(entry, type, text_poke_early, 0);
+	}
+
+	atomic_set_release(&key->enabled, !!enabled);
+}
+
+#else
+
+void jump_label_update_early(struct static_key *key, bool enable)
+{
+	atomic_set(&key->enabled, !!enabled);
+}
+
 #endif
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..cac61beca25f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -79,6 +79,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/bug.h>
 
 extern bool static_key_initialized;
 
@@ -110,6 +111,17 @@ struct static_key {
 	};
 };
 
+#define JUMP_TYPE_FALSE		0UL
+#define JUMP_TYPE_TRUE		1UL
+#define JUMP_TYPE_LINKED	2UL
+#define JUMP_TYPE_MASK		3UL
+
+static inline struct jump_entry *static_key_entries(struct static_key *key)
+{
+	WARN_ON_ONCE(key->type & JUMP_TYPE_LINKED);
+	return (struct jump_entry *)(key->type & ~JUMP_TYPE_MASK);
+}
+
 #else
 struct static_key {
 	atomic_t enabled;
@@ -119,6 +131,17 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+
+static inline struct static_key *jump_entry_key(struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_branch(struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
 #endif
 
 #ifndef __ASSEMBLY__
@@ -132,11 +155,6 @@ struct module;
 
 #ifdef HAVE_JUMP_LABEL
 
-#define JUMP_TYPE_FALSE		0UL
-#define JUMP_TYPE_TRUE		1UL
-#define JUMP_TYPE_LINKED	2UL
-#define JUMP_TYPE_MASK		3UL
-
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	return arch_static_branch(key, false);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..9710fa7582aa 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -295,12 +295,6 @@ void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry
 	arch_jump_label_transform(entry, type);
 }
 
-static inline struct jump_entry *static_key_entries(struct static_key *key)
-{
-	WARN_ON_ONCE(key->type & JUMP_TYPE_LINKED);
-	return (struct jump_entry *)(key->type & ~JUMP_TYPE_MASK);
-}
-
 static inline bool static_key_type(struct static_key *key)
 {
 	return key->type & JUMP_TYPE_TRUE;
@@ -321,16 +315,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
