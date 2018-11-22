Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEEAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD95E20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DriWMKxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD95E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437718AbeKWCHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:07:12 -0500
Received: from mail.efficios.com ([167.114.142.138]:39868 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437703AbeKWCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:07:12 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EE7CA250B34;
        Thu, 22 Nov 2018 10:27:20 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id j-X7tUyjBKv0; Thu, 22 Nov 2018 10:27:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 757C3250B21;
        Thu, 22 Nov 2018 10:27:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 757C3250B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542900440;
        bh=AgnIwdAK236VoKYA3hUes3qnopMWQ3Gm0U+9TZRlV2I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DriWMKxgdzeiKD6BaJdfXr0Acyt8Y4bi0gPwuKuiB4dCyyTG5kB6awePQlAEEL1Qh
         q5sw4qcWSIb3LfxJ2dkqzecGTQ9E8sCSzT6EdSwnZQ+YLUo55qi9fCyh1GgBSkkLL6
         44cvS1/4q6HYUnGUsuXvMtzoyDUKY1TNQXzvoE+Rl7QemiIdocOb2ldcQxd1zML9NQ
         pmijPjYS+wcfGDvs++J2yJUEb2vlqXLmem+8BFlOK30defGGcHjbpir+8Ca5rFc4Ln
         0BjgYU1Xhk2cfsd0YzIu1tVu7VpBaRPYl2Z2GtqyMdGsBfUxW45lRKBW9jbXAanz+7
         1ADnmXphDlAOw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id lb2uKHMi9GYY; Thu, 22 Nov 2018 10:27:20 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4F350250B1B;
        Thu, 22 Nov 2018 10:27:20 -0500 (EST)
Date:   Thu, 22 Nov 2018 10:27:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux@dominikbrodowski.net,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Message-ID: <1320611605.10033.1542900440206.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKOZueuV=X4eqc+-8Jh3Z-2iQO+4fp2otEOs03yQoaa88C9zUA@mail.gmail.com>
References: <20181121201452.77173-1-dancol@google.com> <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org> <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com> <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org> <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com> <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org> <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com> <CAKOZueuV=X4eqc+-8Jh3Z-2iQO+4fp2otEOs03yQoaa88C9zUA@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: Add /proc/pid_gen
Thread-Index: jO0zrNcB96YX4gIU2FfZ/D9op3CHfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 21, 2018, at 7:30 PM, Daniel Colascione dancol@google.com wrote:
[...]
>> > >
>> > > The problem here is the possibility of confusion, even if it's rare.
>> > > Does the naive approach of just walking /proc and ignoring the
>> > > possibility of PID reuse races work most of the time? Sure. But "most
>> > > of the time" isn't good enough. It's not that there are tons of sob
>> > > stories: it's that without completely robust reporting, we can't rule
>> > > out of the possibility that weirdness we observe in a given trace is
>> > > actually just an artifact from a kinda-sort-working best-effort trace
>> > > collection system instead of a real anomaly in behavior. Tracing,
>> > > essentially, gives us deltas for system state, and without an accurate
>> > > baseline, collected via some kind of scan on trace startup, it's
>> > > impossible to use these deltas to robustly reconstruct total system
>> > > state at a given time. And this matters, because errors in
>> > > reconstruction (e.g., assigning a thread to the wrong process because
>> > > the IDs happen to be reused) can affect processing of the whole trace.
>> > > If it's 3am and I'm analyzing the lone trace from a dogfooder
>> > > demonstrating a particularly nasty problem, I don't want to find out
>> > > that the trace I'm analyzing ended up being useless because the
>> > > kernel's trace system is merely best effort. It's very cheap to be
>> > > 100% reliable here, so let's be reliable and rule out sources of
>> > > error.
>> >

[...]

I've just been CC'd on this thread for some reason, so I'll add my 2 cents.

WHIW, I think using /proc to add stateful information to a time-based
trace is the wrong way to do things. Here, the fact that you need to
add a generation counter struct pid_namespace and expose it via /proc
just highlights its limitations when it comes to dealing with state
that changes over time. Your current issue is with PID re-use, but
you will eventually face the same issue for re-use of all other resources
you are trying to model. For instance, a file descriptor may be associated
to a path as some point in time, but that is not true anymore after a
sequence of close/open which re-uses that file descriptor. Does that
mean we will eventually end up needing per-file-descriptor generation
counters as well ?

LTTng solves this by dumping the system state as events within the
trace [1], which associates time-stamps with the state being dumped.
It is recorded while the rest of the system is being traced, so tools
can reconstruct full system state by combining this statedump with the
rest of the events recording state transitions.

So while I agree that it's important to have a way to reconstruct
system state that is aware of PID re-use, I think trying to extend
/proc for this is the wrong approach. It adds extra fields to struct
pid_namespace that seem to be only useful for tracing, whereas using
the time-stamp at which the thread/process was first seen in the trace
(either fork or statedump) as secondary key should suffice to uniquely
identify a thread/process. I would recommend extending tracing
facilities to dump the data you need rather than /proc.

Thanks,

Mathieu

[1] http://git.lttng.org/?p=lttng-modules.git;a=blob;f=lttng-statedump-impl.c;h=dc037508c055b7f61b8c758d581bd0178e26552a;hb=HEAD


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
