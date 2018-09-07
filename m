Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD8020652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WW7EO6mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD8020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIGMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:25:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeIGMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KHrvaYeXIIgA+417jxFT+Z7+8wNU+z/p+Xy6hNS2uts=; b=WW7EO6mBhGLxJHYQvZP/4JyAH
        KgmP4SFmtDSN3DmnSmiVLBXvu8QqdSEQ9Q/FuOb9UUH3eKeCNS2BlbBe1rW7iizM38Cw3zl/toUqg
        BowRlsqnekwk/ZM5nKBhzSafJSRrIUF+VAHxKuTKi6/AlG43055Jn774hpknxZ3LcwtZDxRPRwTwr
        LhoTYVhx/IEBptoNYJlqeX3vl/ESn9aXaW6qESYAIlBOMvDTyZ1fSFvDeblqtbPHDIJoPV0GsWQBG
        XqBOnp17ecfKMBpjTW/GwzsZpYS8uk6ArPKA0wuLMuzxX5MB1DBy82JzzHxor1cKC9/Uo9E3cTuOo
        EXdT+rZqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyBSV-0004V2-J3; Fri, 07 Sep 2018 07:45:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7575A201F9C52; Fri,  7 Sep 2018 09:45:31 +0200 (CEST)
Date:   Fri, 7 Sep 2018 09:45:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907074531.GM24106@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
 <20180906023151.GA749@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906023151.GA749@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:31:51AM +0900, Sergey Senozhatsky wrote:
> An alternative option, thus, could be re-instating back the rule that
> lockdep_off/on should be the first and the last thing we do in
> nmi_enter/nmi_exit. E.g.
> 
> nmi_enter()
> 	lockdep_off();
> 	printk_nmi_enter();
> 
> nmi_exit()
> 	printk_nmi_exit();
> 	lockdep_on();

Yes that. Also, those should probably be inline functions.

---
Subject: locking/lockdep: Fix NMI handling

Someone put code in the NMI handler before lockdep_off(). Since lockdep
is not NMI safe, this wrecks stuff.

Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk in NMI")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/hardirq.h  |  4 ++--
 include/linux/lockdep.h  | 11 +++++++++--
 kernel/locking/lockdep.c | 12 ------------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 0fbbcdf0c178..8d70270d9486 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -62,8 +62,8 @@ extern void irq_exit(void);
 
 #define nmi_enter()						\
 	do {							\
-		printk_nmi_enter();				\
 		lockdep_off();					\
+		printk_nmi_enter();				\
 		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi());				\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
@@ -78,8 +78,8 @@ extern void irq_exit(void);
 		BUG_ON(!in_nmi());				\
 		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		ftrace_nmi_exit();				\
-		lockdep_on();					\
 		printk_nmi_exit();				\
+		lockdep_on();					\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0d0b51c4d85..70bb9e8fc8f9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -272,8 +272,15 @@ extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
 extern asmlinkage void lockdep_sys_exit(void);
 
-extern void lockdep_off(void);
-extern void lockdep_on(void);
+static inline void lockdep_off(void)
+{
+	current->lockdep_recursion++;
+}
+
+static inline void lockdep_on(void)
+{
+	current->lockdep_recursion--;
+}
 
 /*
  * These methods are used by specific locking variants (spinlocks,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..da51ed1c0c21 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -317,18 +317,6 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 	return k0 | (u64)k1 << 32;
 }
 
-void lockdep_off(void)
-{
-	current->lockdep_recursion++;
-}
-EXPORT_SYMBOL(lockdep_off);
-
-void lockdep_on(void)
-{
-	current->lockdep_recursion--;
-}
-EXPORT_SYMBOL(lockdep_on);
-
 /*
  * Debugging switches:
  */
