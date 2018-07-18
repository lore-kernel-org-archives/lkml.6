Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B20CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F6F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SykOm7S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F6F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbeGRAvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:51:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41102 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGRAvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:51:32 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so1165768ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YEBOMDgg/8F1IJXXI7it6zElK1vgSZR6eIj3ZBqC6Uc=;
        b=SykOm7S+4aJ1Wz1S3slTiZeapVL909WYDWUW6aBZbkz4829ePcihvsGyyiKN9LZJKA
         FdABgc+Rn471+863OnBVC3ViJQXu/P0Cd4gDJy369TEqGCKiz4nbh/P+A8CW3WbmU9hv
         B8r/OFHtJ3I1EllhHkRUmxYO3qLU9z9g15ujw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YEBOMDgg/8F1IJXXI7it6zElK1vgSZR6eIj3ZBqC6Uc=;
        b=c+Lu54+AMGdF2FEMaDu/Kzhx4kTCG8sJ1y7H7tkluUa5QHAifdXk+c2ynlvOmKYib3
         hTZn46k12nDgA2QcFBCAGNTtB35SKBhQKolQ/gSHTP8wGQdooK19PrSuQ2SyvUmkMpip
         yT49znhAmxNZ8g8iFNdB+rUJ967RGkks5qJT6BxiOwR4zjqKlh3Jq2nras4pqVMNfDaa
         O6/5dx70wGpYa0wcnnzh4spNSlflO0s0kvaIHbEso4o7bo8nHkzqlG6ML90HAGLdY2bG
         2sWYs0tDOCxG8j50FwRHueWZm0iKWEBEezBMnpt1N/sK8U6s4jNcS+TGJxFhOaCjJ/Cr
         sZqg==
X-Gm-Message-State: AOUpUlEDQS8OF7orm4YNfWRQO5P95F0sp/JtE9DU8gLravjLjyIzbH/l
        HdhXuHCKTjIPjhgmcbg4uQEZnQ==
X-Google-Smtp-Source: AAOMgpd2FyRNTObJBh5ZNmJj/4wFchbFElNjTzex9PpOwHtcRxXbDT1zWPW4AvfTrdNXil3T/JE3zA==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr3635216plb.204.1531872986813;
        Tue, 17 Jul 2018 17:16:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l3-v6sm3026012pff.8.2018.07.17.17.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:16:26 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:16:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180718001625.GA154046@joelaf.mtv.corp.google.com>
References: <20180713215547.255620-1-joel@joelfernandes.org>
 <20180713215547.255620-3-joel@joelfernandes.org>
 <20180717182528.GK2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717182528.GK2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:25:28PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 13, 2018 at 02:55:46PM -0700, Joel Fernandes wrote:
> > +		/* keep srcu and sched-rcu usage consistent */		\
> > +		preempt_disable_notrace();				\
> > +									\
> > +		/*							\
> > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > +		 * doesn't work from the idle path.			\
> > +		 */							\
> > +		if (rcuidle)						\
> > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > +		else							\
> > +			rcu_read_lock_sched_notrace();			\
> 
> That else is completely superfluous. rcu_read_lock_sched_notrace() :=
> prempt_disable_notrace().

I have a patch as below on top of this series. Thanks for the suggestion.

Steve, Peter,

Is it Ok with you to take the below patch ontop of this series? I avoided
resending the 3-patch series since this is the only change, but let me know
what you prefer or makes it easy for you.

------->8--------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] tracepoint: Remove extra unneeded rcu_read_lock_sched_notrace

A great idea was provided that rcu_read_lock_sched_notrace being the
equivalent of preempt_disable_notrace is unnecessary to call in
tracepoint code, since we already call preempt_disable_notrace in
advance. So lets remove the extra call.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/tracepoint.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 97e1d365a817..6e7bc6ebfcd8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -161,8 +161,6 @@ extern void syscall_unregfunc(void);
 		 */							\
 		if (rcuidle)						\
 			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
-		else							\
-			rcu_read_lock_sched_notrace();			\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -176,8 +174,6 @@ extern void syscall_unregfunc(void);
 									\
 		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
-		else							\
-			rcu_read_unlock_sched_notrace();		\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
-- 
2.18.0.203.gfac676dfb9-goog

