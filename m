Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FFD25A08
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S70rcPkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FFD25A08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeFYNNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeFYNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:13:09 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C38A25A07;
        Mon, 25 Jun 2018 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529932389;
        bh=bObiuvWHaDlYbCRs/LunuflahNyWca43scWM2MUj3OU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S70rcPkhD8lUKCaWpaW/y/UhdLgFRjFmHgwGfuZpd7eE1bn1Yd+uDjR0baQvTh7oX
         ZiYBCAC19oPhwKSdTTbuwhwq12YyTDPmM1EAgSHtguczx9IxTcvytuTWQA2m0Cn0rf
         31YPlg17HXmKIi9hbExnNuuCkv/czD8DROdnrfPA=
Date:   Mon, 25 Jun 2018 22:13:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <20180625221302.8507c98e500d8efc70c19d88@kernel.org>
In-Reply-To: <20180621223236.211495-8-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
        <20180621223236.211495-8-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Thu, 21 Jun 2018 15:32:36 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:
[...]
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: test for the preemptirqsoff tracer
> +
> +MOD=test_atomic_sections
> +
> +fail() {
> +    reset_tracer
> +    rmmod $MOD || true
> +    exit_fail
> +}
> +
> +unsup() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unsupported
> +}
> +
> +modprobe $MOD || unsup "$MOD module not available"
> +rmmod $MOD
> +
> +grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> +grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
> +
> +reset_tracer
> +
> +# Simulate preemptoff section for half a second couple of times
> +echo preemptoff > current_tracer
> +sleep 1
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail

Why don't you use $MOD for these operations?

> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: preemptoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +
> +# Simulate irqsoff section for half a second couple of times
> +echo irqsoff > current_tracer
> +sleep 1
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail

Ditto.

Other parts looks good to me.

Thanks,

> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: irqsoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +exit 0
> +
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
