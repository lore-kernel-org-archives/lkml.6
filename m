Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fV8DLA8PGlulSQAAmS7hNA
	; Fri, 08 Jun 2018 05:14:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A2B27607DC; Fri,  8 Jun 2018 05:14:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2W9epIFp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E95F2602FC;
	Fri,  8 Jun 2018 05:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E95F2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeFHFOh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbeFHFOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:14:36 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FA820874;
        Fri,  8 Jun 2018 05:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528434875;
        bh=bR3QsnNTDfsAtGYe2KsRx1NhzKcusA9FpmFMx7dxz70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2W9epIFpZ7RCTm+OqK7HekXP9NQlBNPkKpzeWjQxK9S3H8RYlZUDZmQhlES0l/KkS
         Vnz1FFrHcc2hW53pg6/sv3+UEW/4YG7oJkzvqNEK7rQGobC2XZHHMzJeNX+x3ZyDey
         wuqedLh6zShGJrNAZzyBIh7TheXswl8rX25sXTBk=
Date: Fri, 8 Jun 2018 14:14:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-Id: <20180608141431.c0196a2c80a8d4701bc9db58@kernel.org>
In-Reply-To: <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
        <20180608101023.cbf20db485026213d490cb7c@kernel.org>
        <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 07:59:38 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Masami,
> 
> On 06/08/2018 06:40 AM, Masami Hiramatsu wrote:
> > On Wed,  6 Jun 2018 14:03:37 +0530
> > Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> > 
> >> Why RFC again:
> >>
> >> This series is different from earlier versions[1]. Earlier series
> >> implemented this feature in trace_uprobe while this has implemented
> >> the logic in core uprobe. Few reasons for this:
> >>  1. One of the major reason was the deadlock between uprobe_lock and
> >>  mm->mmap inside trace_uprobe_mmap(). That deadlock was not easy to fix
> >>  because mm->mmap is not in control of trace_uprobe_mmap() and it has
> >>  to take uprobe_lock to loop over trace_uprobe list. More details can
> >>  be found at[2]. With this new approach, there are no deadlocks found
> >>  so far.
> >>  2. Many of the core uprobe function and data-structures needs to be
> >>  exported to make earlier implementation simple. With this new approach,
> >>  reference counter logic is been implemented in core uprobe and thus
> >>  no need to export anything.
> > 
> > I agree with you. Moreover, since uprobe_register/unregister() are
> > exported to modules, this enablement would better be implemented
> > inside uprobe so that all uprobe users benefit from this.
> 
> 
> Sorry, I think you got me wrong. I meant, I don't need to expose all core
> uprobe _static_ functions to tarce_uprobe.
> 
> Now, about kernel modules, basically uprobe_register() takes three parameters:
>     inode, offset and consumer.
> There is no scope for the reference counter there. So I've created one more
> function: uprobe_register_refctr(). But this function is not exported as ABI
> to kernel module. i.e. kernel modules still does not have a way to create
> uprobe with reference counter.

OK, I got it from your patches. :)

> So for kernel modules,
> 
> is it fine to change current ABI from
>     uprobe_register(inode, offset, consumer)
> to
>     uprobe_register(inode, offset, ref_ctr_offset, consumer)
> 
> Or I should introduce new function for this:
>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> and export it to kernel module?
> 
> What's your suggestion?

Latter is fine to me. Since the refctr is introduced totally in userspace
(for SDT) and free-address userspace probing doesn't need refctr, maybe
we should keep those separated.

> [...]
> 
> >> 
> >>  - This patches still has one issue. If there are multiple instances of
> >>    same application running and user wants to trace any particular
> >>    instance, trace_uprobe is updating reference counter in all instances.
> >>    This is not a problem on user side because instruction is not replaced
> >>    with trap/int3 and thus user will only see samples from his interested
> >>    process. But still this is more of a correctness issue. I'm working on
> >>    a fix for this.
> > 
> > Hmm, it sounds like not a correctness issue, but there maybe a performace
> > tradeoff. Tracing one particulear instance, other instances also will get
> > a performance loss
> 
> 
> Right, but it's temporary. I mean, putting everything in to this series was making
> it complex. So this is the initial one and I'll send followup patches which will
> optimize the reference counter update.

Ah, OK. If you have prepared the followup patches, could you also send it
with this series? Perhups it will help us to understand the issue clearer.

> 
> > (Only if the parameter preparation block is heavy,
> > because the heaviest part of probing - trap/int3 and recording data - isn't
> > executed.)
> >> BTW, why this happens? I thought the refcounter part is just a data which
> > is not shared among processes...
> > 
> 
> This happens because we are not calling consumer_filter function. consumer_filter
> is the one who decides whether to change the instruction to trap or not in a given
> mm. We also need to call it before updating reference counter.

Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
remove_breakpoint?

Thank you,

> 
> Let me know your thoughts.
> 
> Thanks,
> Ravi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
