Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D25DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD09204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD09204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeKBUd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:33:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeKBUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:33:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4422430084CB;
        Fri,  2 Nov 2018 11:26:38 +0000 (UTC)
Received: from krava (unknown [10.40.205.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 599AC600C9;
        Fri,  2 Nov 2018 11:26:35 +0000 (UTC)
Date:   Fri, 2 Nov 2018 12:26:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181102112635.GD5458@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <20181024144818.GF6218@tassilo.jf.intel.com>
 <2122395.LD3O1NFKj8@agathebauer>
 <13521319.OzbRBoFVZM@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13521319.OzbRBoFVZM@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 02 Nov 2018 11:26:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:08:18PM +0100, Milian Wolff wrote:
> On Dienstag, 30. Oktober 2018 23:34:35 CET Milian Wolff wrote:
> > On Mittwoch, 24. Oktober 2018 16:48:18 CET Andi Kleen wrote:
> > > > Can someone at least confirm whether unwinding from a function prologue
> > > > via
> > > > .eh_frame (but without .debug_frame) should actually be possible?
> > > 
> > > Yes it should be possible. Asynchronous unwind tables should work
> > > from any instruction.
> 
> <snip>
> 
> > We can find `7f91345bdaf8+1 = 7f91345bdaf9" at offset 16 (search for "f9 da
> > 5b 34 91 7f"). Using that address makes unwinding work for this sample.
> > What could be the reason for this shift?
> 
> I believe I have found the culprit: PEBS seems to be at fault here - i.e. the 
> RIP/RSP and the ustack dump of the sample simply don't fit together.
> 
> Check this out:
> 
> ```
> $ for i in $(seq 10); do perf record -q -e "cycles:" --call-graph dwarf ./cpp-
> inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:p" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:pp" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 37
> 39
> 35
> 28
> 40
> 39
> 29
> 37
> 31
> 26
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:ppp" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 79
> 70
> 76
> 77
> 70
> 90
> 64
> 78
> 86
> 74
> ```
> 
> Note how precise levels 0 and 1 do not produce any samples where unwinding 
> fails. But precise level 2 produces some, and precise level 3 increases the 
> amount (by ca. ~2x).
> 
> I can reproduce this pattern on two separate Intel CPUs and kernel versions 
> currently:
> 
> Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz with 4.18.16-arch1-1-ARCH
> Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 4.14.78-1-lts
> 
> Could someone else try this? What about AMD and IBS - is it also affected? 
> What about newer/different Intel CPUs?

I tried on intel and can't actualy see that.. how do the failed samples
look like? like is there the stack dump attached, what's in the regs?

could you please paste the 'perf report -D' output for some of the
failed samples?

thanks,
jirka

