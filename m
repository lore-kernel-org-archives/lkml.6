Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20825E23
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wCRMRHks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F20825E23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbeFYQVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:21:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34415 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeFYQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:21:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id g3-v6so1937121pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXa2cTHmp8UavvBtodYFdgvv5MPzmEpNtkylk+SQCgY=;
        b=wCRMRHksPk8HktqdSaZUrDhcOzCWopIybcWZ31J7LGayOlxZLILMZk0D30eO24sUyR
         dTkv9IzQmGD2Brz6EpgYX90B26Czx1OAMGB0yh6HggRllsUz2dhORe0CAso5ycZLel1R
         WIowD2rze2uA/Q7Co9U3NNLhNhWX54eC6tAe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXa2cTHmp8UavvBtodYFdgvv5MPzmEpNtkylk+SQCgY=;
        b=NnrKhBPLnKm3dgqWvE2zpAfFUvd+TEc9kHnqctLbesnGbghOhpfTz1dbvxgpR9qW+t
         HaPp+3TguJQyAgNcbB9xYN07DpdfZ8ZuSLjf4Z6dMiMgTW59rbpUjY4Ma9rK/iVtOzAh
         0+BTMTtgGaxyJmhDzQyW9pKOFpYLmG7gpHDMiqZ1tTkT43o2V0GsGX1bHUqv1xBPmGFy
         9Q6Q47wyLYzCa4sskAl0xN8x036G87t9++FZpqMVKEQOg0uZ9ciSxSHRxsqhzgKcfUeO
         OaneJ0rsUedqGmDfc+nnzUr5EMrYGvnrOiautC3qesplxWn+aCK43iycE4ROXPD40jVv
         AQNQ==
X-Gm-Message-State: APt69E0iUb5y9kXRbALuev3dwMlWLHdS0reXnuqe2wbjoUrgUVJbAVzz
        f4Is3wyYLIrXqlK3EOqXM65dRA==
X-Google-Smtp-Source: ADUXVKLNPxu3d+OWbzoFd+uBItnshpWN6EF6zcr599z/B9zMGGhXqs6GkDXsZ7IqXC6Q8kt0oSszig==
X-Received: by 2002:a65:5144:: with SMTP id g4-v6mr2515135pgq.21.1529943664066;
        Mon, 25 Jun 2018 09:21:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h24-v6sm8648807pfd.69.2018.06.25.09.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 09:21:03 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:21:02 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and
 irqsoff tracers
Message-ID: <20180625162102.GA49367@joelaf.mtv.corp.google.com>
References: <20180621223236.211495-1-joel@joelfernandes.org>
 <20180621223236.211495-8-joel@joelfernandes.org>
 <20180625221302.8507c98e500d8efc70c19d88@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625221302.8507c98e500d8efc70c19d88@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:13:02PM +0900, Masami Hiramatsu wrote:
> Hi Joel,
> 
> On Thu, 21 Jun 2018 15:32:36 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> [...]
> > +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > @@ -0,0 +1,74 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: test for the preemptirqsoff tracer
> > +
> > +MOD=test_atomic_sections
> > +
> > +fail() {
> > +    reset_tracer
> > +    rmmod $MOD || true
> > +    exit_fail
> > +}
> > +
> > +unsup() { #msg
> > +    reset_tracer
> > +    rmmod $MOD || true
> > +    echo $1
> > +    exit_unsupported
> > +}
> > +
> > +modprobe $MOD || unsup "$MOD module not available"
> > +rmmod $MOD
> > +
> > +grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> > +grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
> > +
> > +reset_tracer
> > +
> > +# Simulate preemptoff section for half a second couple of times
> > +echo preemptoff > current_tracer
> > +sleep 1
> > +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> > +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> > +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> 
> Why don't you use $MOD for these operations?

Yes, I will. Thanks for the suggestion.

> > +
> > +cat trace
> > +
> > +# Confirm which tracer
> > +grep -q "tracer: preemptoff" trace || fail
> > +
> > +# Check the end of the section
> > +egrep -q "5.....us : <stack trace>" trace || fail
> > +
> > +# Check for 500ms of latency
> > +egrep -q "latency: 5..... us" trace || fail
> > +
> > +reset_tracer
> > +
> > +# Simulate irqsoff section for half a second couple of times
> > +echo irqsoff > current_tracer
> > +sleep 1
> > +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> > +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> > +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> > +rmmod test_atomic_sections || fail
> 
> Ditto.

Done.
 
> Other parts looks good to me.

Cool, updated this patch below as "v9.1" ;-)

thanks!

- Joel

---8<-----------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9.1 7/7] kselftests: Add tests for the preemptoff and irqsoff
 tracers

Here we add unit tests for the preemptoff and irqsoff tracer by using a
kernel module introduced previously to trigger atomic sections in the
kernel.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b01924c71c09..29588b328345 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_IRQSOFF_TRACER=y
+CONFIG_TEST_ATOMIC_SECTIONS=m
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
new file mode 100755
index 000000000000..2dcd5e4cafb4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: test for the preemptirqsoff tracer
+
+MOD=test_atomic_sections
+
+fail() {
+    reset_tracer
+    rmmod $MOD || true
+    exit_fail
+}
+
+unsup() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unsupported
+}
+
+modprobe $MOD || unsup "$MOD module not available"
+rmmod $MOD
+
+grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
+grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
+
+reset_tracer
+
+# Simulate preemptoff section for half a second couple of times
+echo preemptoff > current_tracer
+sleep 1
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
+rmmod $MOD || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: preemptoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+
+# Simulate irqsoff section for half a second couple of times
+echo irqsoff > current_tracer
+sleep 1
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
+rmmod $MOD || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: irqsoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+exit 0
+
-- 
2.18.0.rc2.346.g013aa6912e-goog

