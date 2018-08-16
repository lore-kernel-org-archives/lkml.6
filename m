Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40996C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF7A2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF7A2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391687AbeHPQbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:31:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeHPQbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:31:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C6A80D;
        Thu, 16 Aug 2018 06:32:57 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181393F5BC;
        Thu, 16 Aug 2018 06:32:54 -0700 (PDT)
Date:   Thu, 16 Aug 2018 14:32:49 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180816133249.GA2964@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
 <20180815105428.GA7388@e110439-lin>
 <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar!

On 15-Aug 12:59, Dietmar Eggemann wrote:
> On 08/15/2018 12:54 PM, Patrick Bellasi wrote:
> >On 15-Aug 11:37, Dietmar Eggemann wrote:
> >>On 08/14/2018 06:49 PM, Patrick Bellasi wrote:

[...]

> >>If this is only for testing/debugging, I would suggest a simple one line
> >>BUG_ON()
> >
> >These are (eventually) considered as recoverable errors... thus,
> >AFAIK, using BUG_ON is overkilling and discouraged:
> >   https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bug.h#L42
> 
> Not sure about that. If this refcounting is out of sync, that's indicating a
> serious issue here for me which should be fixed.

Well, refconting seems quite ok to me, we always inc/dec under RQ
locking and it's a per-CPU variable.

The warning is there to report issues on further testing as well as to
be safe with respect to possible future modifications of the code.

> >>You find CONFIG_SCHED_DEBUG=y in production kernels as well.
> >
> >AFAIK, that setting is discouraged for production kernels...
> >Moreover, it's still better to WARN sometimes on a production kernel
> >the crash the device, isnt't it?
> 
> IMHO, if this is something which should not happen at all, a BUG_ON() is the
> right thing to do here.

I don't agree on that. I agree it should not happen but since it's a
recoverable error it think we should not panic.

There are really few BUG_ON() in core.c and they are all for much more
serious issues than a (eventually) broken refcount.

IMHO instead an (unlikely) inconsistent refcont for an "optional
optimization" on "frequency selection" is not such a critical
failure worth a device crash.

> And you get the call stack to investigate why it hit.

We can always add a stack dump if we notice the warning.

But, since we do not agree on that point, I would say we should better
wait for what the maintainers prefers.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
