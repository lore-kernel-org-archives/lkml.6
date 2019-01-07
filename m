Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4816C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907122070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQmglvb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAGSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:34:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56169 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfAGSes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:34:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1780558wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euARqB5kVSyB8NpufQQY56ama9yogfHlo/3p11W57dY=;
        b=WQmglvb9jQBTTbIeHYHOveVrKsdh4LhjWK6HKkVpSKsto7fUWxchLqLtjsI+K775dX
         v5rSpBlPP3XMTFa7tfy2i2S/9mivbDBYlfIzoOt0tQlA4qPd31aiSyRNcVFj8NdlMeR4
         nWUmNqt5JEtqC4d4Gf7lrJwBWiJ61lzcYqiy/r7T1HfrSEs22whHdHchqORCLiXSvW2M
         +Zid/fmDZyakfDB9eovWSTS98DCUKyl0OOZJnrc9+lJaZTkYS4o0ZGvVUAH3oubHy9Gv
         rP/xaQZtbkg7aCPTTsZmuJXQhZ5Ya0Lh73ODFgPjkjBtqXFuMqGcLhKca2NjOmq6iXBo
         LBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euARqB5kVSyB8NpufQQY56ama9yogfHlo/3p11W57dY=;
        b=eSmGESNW9V+Nrf2a5YimZx2CVGsvd6MvILmke76HANxJnuQ97r3kpjPDm0eX5j7zrK
         0sJRPEK4aiSEe3WY0bpjot7dt4N4XjsH+BweLfJIld4cWJhQCmDHrkpZSky+Z/kKviuX
         +uXkKYAEtLrZj/ALUA/+x35TR/L0p/LKKZRyLgbhiVAMHZaFHA/TmOWIVfXeOwRRmBkK
         2MsSGRHDrBh7uK/y1ld0jbTEU9PjSNkzeWjLcSeHDBSxTt4/NDSWLQdsxNayoTVALreg
         X39dxowf/BvsuxTMhDS391sBhLInApAoJotIJdwFBp+ApLa8NOQghJa+rFs5tgVEZj6n
         f67Q==
X-Gm-Message-State: AJcUukdm08614LpZ3gMhngJQb0xA1IycuzGmNI8j0AzcVr0Vx2/3OXXA
        o0Qlso3TF2nLWZ8DknRjAQ==
X-Google-Smtp-Source: ALg8bN7zoZJsAmBqZhYiVgshx6kT0ijFTi2+EprqJtsz1+ecJ9o0AkoWPzQbJwzazMQAYRxzGKwr7w==
X-Received: by 2002:a1c:8f41:: with SMTP id r62mr9154944wmd.141.1546886086231;
        Mon, 07 Jan 2019 10:34:46 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id j124sm3064916wmb.48.2019.01.07.10.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:34:45 -0800 (PST)
Date:   Mon, 7 Jan 2019 19:34:44 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107183444.GA5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154686789378.15479.2886543882215785247.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:31:34PM +0900, Masami Hiramatsu wrote:
...
> BTW, this is not all of issues. To remove CONFIG_KPROBE_EVENTS_ON_NOTRACE
> I'm trying to find out other notrace functions which can cause
> kernel crash by probing. Mostly done on x86, so I'll post it
> after this series.

Not sure if you found it already, but it looks like some of the
_raw_spin_lock/unlock* functions (when they're not inlined) are causing
the same problem (or something similar), I can deadlock the system by
doing this for example:

 echo "r:event_1 __fdget" >> kprobe_events
 echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
 echo 1 > events/kprobes/enable
 [DEADLOCK]

Sending the following just in case...

Thanks,

 kernel/locking/spinlock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..d93e88019239 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -19,6 +19,7 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/kprobes.h>
 #include <linux/debug_locks.h>
 #include <linux/export.h>
 
@@ -128,6 +129,7 @@ int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)
 	return __raw_spin_trylock(lock);
 }
 EXPORT_SYMBOL(_raw_spin_trylock);
+NOKPROBE_SYMBOL(_raw_spin_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_TRYLOCK_BH
@@ -136,6 +138,7 @@ int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)
 	return __raw_spin_trylock_bh(lock);
 }
 EXPORT_SYMBOL(_raw_spin_trylock_bh);
+NOKPROBE_SYMBOL(_raw_spin_trylock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK
@@ -144,6 +147,7 @@ void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
 	__raw_spin_lock(lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock);
+NOKPROBE_SYMBOL(_raw_spin_lock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
@@ -152,6 +156,7 @@ unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 	return __raw_spin_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock_irqsave);
+NOKPROBE_SYMBOL(_raw_spin_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
@@ -160,6 +165,7 @@ void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 	__raw_spin_lock_irq(lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock_irq);
+NOKPROBE_SYMBOL(_raw_spin_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
@@ -168,6 +174,7 @@ void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 	__raw_spin_lock_bh(lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock_bh);
+NOKPROBE_SYMBOL(_raw_spin_lock_bh);
 #endif
 
 #ifdef CONFIG_UNINLINE_SPIN_UNLOCK
@@ -176,6 +183,7 @@ void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 	__raw_spin_unlock(lock);
 }
 EXPORT_SYMBOL(_raw_spin_unlock);
+NOKPROBE_SYMBOL(_raw_spin_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
@@ -184,6 +192,7 @@ void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long
 	__raw_spin_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_raw_spin_unlock_irqrestore);
+NOKPROBE_SYMBOL(_raw_spin_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
@@ -192,6 +201,7 @@ void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 	__raw_spin_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_raw_spin_unlock_irq);
+NOKPROBE_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
@@ -200,6 +210,7 @@ void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 	__raw_spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_raw_spin_unlock_bh);
+NOKPROBE_SYMBOL(_raw_spin_unlock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_READ_TRYLOCK

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
