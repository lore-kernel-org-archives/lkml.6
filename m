Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCBC208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utjv+Qjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCBC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbeGQPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbeGQPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:20:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6306320858;
        Tue, 17 Jul 2018 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531838857;
        bh=ftrHJDk3oEpck5511hdVBQiH6Brzhpf1CiXVb9xT93w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Utjv+Qjl/yxsr7q7H/qBmYJWzRhT3nY1/QvapZ+bRVfl2D8Rb9N5cLeCQMu6D0JHJ
         VnuzgQyjDBwDgPUMS0/52BbEp6Nuz85VS/4u+4b4G7/SvDGiyygyzxEEQSBF5Uda/6
         rLuvMzXkuAL4kcXHSY2Mb8oq5DHHN13A65jr52QY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 25DC5144881; Tue, 17 Jul 2018 10:47:35 -0400 (EDT)
Date:   Tue, 17 Jul 2018 10:47:35 -0400
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V4 3/3] x86: Add entry trampolines to kcore
Message-ID: <20180717144735.GA3614@kernel.org>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-4-git-send-email-adrian.hunter@intel.com>
 <20180606131631.GD12180@hirez.programming.kicks-ass.net>
 <20180606131946.GF24381@kernel.org>
 <90e24c0c-6ec9-f2c0-54af-0a946b05e574@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e24c0c-6ec9-f2c0-54af-0a946b05e574@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 17, 2018 at 11:54:30AM +0300, Adrian Hunter escreveu:
> On 06/06/18 16:19, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 06, 2018 at 03:16:31PM +0200, Peter Zijlstra escreveu:
> >> On Wed, Jun 06, 2018 at 03:54:11PM +0300, Adrian Hunter wrote:
> >>> Without program headers for PTI entry trampoline pages, the trampoline
> >>> virtual addresses do not map to anything.
> >>>
> >>
> >>>
> >>> In addition, entry trampolines all map to the same page.  Represent that by
> >>> giving the corresponding program headers in kcore the same offset.
> >>>
> >>> This has the benefit that, when perf tools uses /proc/kcore as a source for
> >>> kernel object code, samples from different CPU trampolines are aggregated
> >>> together.  Note, such aggregation is normal for profiling i.e. people want
> >>> to profile the object code, not every different virtual address the object
> >>> code might be mapped to (across different processes for example).
> >>>
> >>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> Acked-by: Andi Kleen <ak@linux.intel.com>
> >>> ---
> >>>  arch/x86/mm/cpu_entry_area.c | 10 ++++++++++
> >>>  fs/proc/kcore.c              |  7 +++++--
> >>>  include/linux/kcore.h        | 13 +++++++++++++
> >>>  3 files changed, 28 insertions(+), 2 deletions(-)
> >>
> >> This also adds the KCORE_REMAP functionality, but isn't mentioned at all
> >> in the Changelog.
> >>
> >> Still, looks OK I suppose,
> > 
> > I can add a note about that,
> >  
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Thanks, giving it some more hours and will apply and try to test it.
> 
> Any update on this?

On the post-vacation pile, will get to it.

- Arnaldo
