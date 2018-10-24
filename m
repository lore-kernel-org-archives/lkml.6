Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353FECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108AC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108AC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJYHNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:13:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:13:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5ED9B14C1;
        Wed, 24 Oct 2018 22:43:17 +0000 (UTC)
Date:   Wed, 24 Oct 2018 15:43:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     sebhtml@videotron.qc.ca, Steven Rostedt <rostedt@goodmis.org>,
        acme@redhat.com, tz.stoyanov@gmail.com,
        Namhyung Kim <namhyung@kernel.org>, zwisler@kernel.org,
        arangradient@gmail.com, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
Message-Id: <20181024154316.810676f4b8eb9be637a34e28@linux-foundation.org>
In-Reply-To: <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
        <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 10:13:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> [ added Andrew ]
> 
> Patch here: https://lore.kernel.org/patchwork/patch/1002234/
> 
> On Sun, Oct 21, 2018 at 8:00 AM Sebastien Boisvert
> <sebhtml@videotron.qc.ca> wrote:
> >
> > Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
> > warning:
> >       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
> >
> > It is printed in process_op (tools/lib/traceevent/event-parse.c) because '~'
> > is parsed as a binary operator.
> >
> > perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
> > /sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .
> >
> > The format contains:
> >
> > ~(((u64) ~(~(((1UL) << 12)-1)))
> >          ^
> >          \ interpreted as a binary operator by process_op().
> >
> > This part is generated in the declaration of the event class
> > dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :
> >
> >                 __print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
> >                         PFN_FLAGS_TRACE),
> >
> > This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK to
> > make sure that '~' is parsed as a unary operator by perf.
> >
> > The part of the format that was problematic is now:
> >
> > ~(((u64) (~(~(((1UL) << 12)-1))))
> >
> > Now, all the '~' are parsed as unary operators.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> 
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 

I grabbed it, and added cc:stable.

But aren't we fixing this in the wrong place?  That's a valid
expression and if this isn't addressed in perf then we may hit a
similar issue elsewhere...

