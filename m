Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68CF23E3A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68CF23E3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGBJ64 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:58:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbeGBJ6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D3F18A;
        Mon,  2 Jul 2018 02:58:53 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10D543F5BA;
        Mon,  2 Jul 2018 02:58:53 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 57EF81AE2FEE; Mon,  2 Jul 2018 10:59:32 +0100 (BST)
Date:   Mon, 2 Jul 2018 10:59:32 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>, catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: Clear the stack
Message-ID: <20180702095931.GB28665@arm.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
 <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com>
 <CAGXu5jLW5FJdRdRXcP=xPOEcQ=Tg+uSi=vj6vQ39iVp=QHSRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLW5FJdRdRXcP=xPOEcQ=Tg+uSi=vj6vQ39iVp=QHSRAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Jun 29, 2018 at 01:25:20PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 1:22 PM, Laura Abbott <labbott@redhat.com> wrote:
> > On 06/29/2018 01:19 PM, Kees Cook wrote:
> >>
> >> On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> >>>
> >>> Implementation of stackleak based heavily on the x86 version
> >>>
> >>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> >>> [...]
> >>> +#define current_top_of_stack() (task_stack_page(current) + THREAD_SIZE)
> >>> +#define on_thread_stack()      (on_task_stack(current,
> >>> current_stack_pointer))
> >>
> >>
> >> nit on types here. I get some warnings:
> >>
> >> kernel/stackleak.c:55:12: warning: assignment makes integer from
> >> pointer without a cast [-Wint-conversion]
> >>     boundary = current_top_of_stack();
> >>              ^
> >> kernel/stackleak.c:65:24: warning: assignment makes integer from
> >> pointer without a cast [-Wint-conversion]
> >>    current->lowest_stack = current_top_of_stack() - THREAD_SIZE / 64;
> >>                          ^
> >>
> >> So I think this needs to be:
> >>
> >> +#define current_top_of_stack() ((unsigned long)task_stack_page(current) +
> >> \
> >> +                                THREAD_SIZE)
> >>
> >
> > Argh, missed that in an amend, can fix for next version if there
> > are no other objections to this approach.
> 
> No worries! I've made the change locally and will push this out to
> -next unless there are objections?

I'm a bit wary of conflicts in entry.S, since it's likely that we're going
to have a lot going on in there for 4.19.

Could I take this via arm64 instead, please, or are there dependencies
on other parts of your tree?

Will
