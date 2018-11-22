Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C413FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDE320878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDE320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbeKVLeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:34:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:34:35 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F37F386B;
        Thu, 22 Nov 2018 00:57:42 +0000 (UTC)
Date:   Wed, 21 Nov 2018 16:57:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Add /proc/pid_gen
Message-Id: <20181121165741.ef089df784482632c4a66370@linux-foundation.org>
In-Reply-To: <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
References: <20181121201452.77173-1-dancol@google.com>
        <20181121205428.165205-1-dancol@google.com>
        <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
        <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
        <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
        <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
        <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org>
        <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 16:28:56 -0800 Daniel Colascione <dancol@google.com> wrote:

> > > The problem here is the possibility of confusion, even if it's rare.
> > > Does the naive approach of just walking /proc and ignoring the
> > > possibility of PID reuse races work most of the time? Sure. But "most
> > > of the time" isn't good enough. It's not that there are tons of sob
> > > stories: it's that without completely robust reporting, we can't rule
> > > out of the possibility that weirdness we observe in a given trace is
> > > actually just an artifact from a kinda-sort-working best-effort trace
> > > collection system instead of a real anomaly in behavior. Tracing,
> > > essentially, gives us deltas for system state, and without an accurate
> > > baseline, collected via some kind of scan on trace startup, it's
> > > impossible to use these deltas to robustly reconstruct total system
> > > state at a given time. And this matters, because errors in
> > > reconstruction (e.g., assigning a thread to the wrong process because
> > > the IDs happen to be reused) can affect processing of the whole trace.
> > > If it's 3am and I'm analyzing the lone trace from a dogfooder
> > > demonstrating a particularly nasty problem, I don't want to find out
> > > that the trace I'm analyzing ended up being useless because the
> > > kernel's trace system is merely best effort. It's very cheap to be
> > > 100% reliable here, so let's be reliable and rule out sources of
> > > error.
> >
> > So we're solving a problem which isn't known to occur, but solving it
> > provides some peace-of-mind?  Sounds thin!
> 
> So you want to reject a cheap fix for a problem that you know occurs
> at some non-zero frequency? There's a big difference between "may or
> may not occur" and "will occur eventually, given enough time, and so
> must be taken into account in analysis". Would you fix a refcount race
> that you knew was possible, but didn't observe? What, exactly, is your
> threshold for accepting a fix that makes tracing more reliable?

Well for a start I'm looking for a complete patch changelog.  One which
permits readers to fully understand the user-visible impact of the
problem.

If it is revealed that is a theoretical problem which has negligible
end-user impact then sure, it is rational to leave things as they are. 
That's what "negligible" means!

