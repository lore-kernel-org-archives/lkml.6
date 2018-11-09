Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9304C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DD20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zgdzlJMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeKIRF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbeKIRF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:05:58 -0500
Received: from devnote (p19194-mobac01.tokyo.ocn.ne.jp [153.233.10.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FD620855;
        Fri,  9 Nov 2018 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541748399;
        bh=M6T4E9xx/y9bpDP/2rpIU3wM9auGO38j8453Y/n0AA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zgdzlJMB6EuPrfKyIoKfdMq58CeRYB7WQRZKRwmv0oaOFcCpJd0KwUC3CsUeHlgXT
         cnxQIzbnuFefgvIH0Bve/gfvSwkXmQ6Js7sqTbATBs5AeyEQ+4ShU4TuFVBLTsZJfK
         nvL4PVBarcoRc83jX2y2TkRcwMKuWTCU2RVF4fpQ=
Date:   Fri, 9 Nov 2018 16:26:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181109162632.9a3694eea8ac8056302a8262@kernel.org>
In-Reply-To: <20181108144437.l3proaovfqm5osnr@treble>
References: <20181101083551.3805-2-cyphar@cyphar.com>
        <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181103070253.ajrqzs5xu2vf5stu@yavin>
        <20181104115913.74l4yzecisvtt2j5@yavin>
        <20181106171501.59ccabbc@gandalf.local.home>
        <20181108074612.ldy6rozdpsdps6bf@yavin>
        <20181108080448.rggfn4zawi3por23@yavin>
        <20181108144437.l3proaovfqm5osnr@treble>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 08:44:37 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Nov 08, 2018 at 07:04:48PM +1100, Aleksa Sarai wrote:
> > On 2018-11-08, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > I will attach what I have at the moment to hopefully explain what the
> > > issue I've found is (re-using the kretprobe architecture but with the
> > > shadow-stack idea).
> > 
> > Here is the patch I have at the moment (it works, except for the
> > question I have about how to handle the top-level pt_regs -- I've marked
> > that code with XXX).
> > 
> > -- 
> > Aleksa Sarai
> > Senior Software Engineer (Containers)
> > SUSE Linux GmbH
> > <https://www.cyphar.com/>
> > 
> > --8<---------------------------------------------------------------------
> > 
> > Since the return address is modified by kretprobe, the various unwinders
> > can produce invalid and confusing stack traces. ftrace mostly solved
> > this problem by teaching each unwinder how to find the original return
> > address for stack trace purposes. This same technique can be applied to
> > kretprobes by simply adding a pointer to where the return address was
> > replaced in the stack, and then looking up the relevant
> > kretprobe_instance when a stack trace is requested.
> > 
> > [WIP: This is currently broken because the *first entry* will not be
> >       overwritten since it looks like the stack pointer is different
> >       when we are provided pt_regs. All other addresses are correctly
> >       handled.]
> 
> When you see this problem, what does regs->ip point to?  If it's
> pointing to generated code, then we don't _currently_ have a way of
> dealing with that.  If it's pointing to a real function, we can fix that
> with unwind hints.

As I replied, If the stackdump is called from kretprobe event, regs->ip
always points trampoline function. Otherwise (maybe from kprobe event,
or panic, BUG etc.) it always be the address which the event occurs.

So fixing regs->ip is correct.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
