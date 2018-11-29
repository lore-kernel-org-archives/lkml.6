Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9961A2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9961A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeK2VR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:17:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeK2VR6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:17:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 525EF37EE0;
        Thu, 29 Nov 2018 10:13:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43E304388;
        Thu, 29 Nov 2018 10:13:06 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:13:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/3] perf report/annotate: Support average IPC and IPC
 coverage for function
Message-ID: <20181129101303.GC25884@krava>
References: <1543418098-10435-1-git-send-email-yao.jin@linux.intel.com>
 <20181128101757.GA11280@krava>
 <20181128101846.GB11280@krava>
 <4f05c9c6-f82f-1a23-ce8b-b061d5758400@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f05c9c6-f82f-1a23-ce8b-b061d5758400@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 29 Nov 2018 10:13:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:24:27PM +0800, Jin, Yao wrote:
> 
> 
> On 11/28/2018 6:18 PM, Jiri Olsa wrote:
> > On Wed, Nov 28, 2018 at 11:17:57AM +0100, Jiri Olsa wrote:
> > > On Wed, Nov 28, 2018 at 11:14:55PM +0800, Jin Yao wrote:
> > > > Add supporting of displaying the average IPC and IPC coverage
> > > > percentage per function.
> > > > 
> > > > For example,
> > > > 
> > > > $ perf record -b ...
> > > > $ perf report -s symbol or
> > > >    perf report -s symbol --stdio
> > > > 
> > > > Overhead  Symbol                           IPC   [IPC Coverage]
> > > >    39.60%  [.] __random                     2.30  [ 54.8%]
> > > >    18.02%  [.] main                         0.43  [ 54.3%]
> > > >    14.21%  [.] compute_flag                 2.29  [100.0%]
> > > >    14.16%  [.] rand                         0.36  [100.0%]
> > > >     7.06%  [.] __random_r                   2.57  [ 70.5%]
> > > >     6.85%  [.] rand@plt                     0.00  [  0.0%]
> > > >    ...
> > > > 
> > > > $ perf annotate --stdio2
> > > > 
> > > > Percent  IPC Cycle (Average IPC: 2.30, IPC Coverage: 54.8%)
> > > > 
> > > >                          Disassembly of section .text:
> > > > 
> > > >                          000000000003aac0 <random@@GLIBC_2.2.5>:
> > > >    8.32  3.28              sub    $0x18,%rsp
> > > >          3.28              mov    $0x1,%esi
> > > >          3.28              xor    %eax,%eax
> > > >          3.28              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
> > > >   11.57  3.28     1      ↓ je     20
> > > >                            lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
> > > >                          ↓ jne    29
> > > >                          ↓ jmp    43
> > > >   11.57  1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
> > > >   ...
> > > > 
> > > > v3:
> > > > ---
> > > >      Remove the sortkey "ipc" from command-line. The columns "IPC"
> > > >      and "[IPC Coverage]" are automatically enabled when "symbol"
> > > >      is specified.
> > > > 
> > > >      Patch "perf report: Display average IPC and IPC coverage per symbol"
> > > >      is impacted.
> > > > 
> > > > v2:
> > > > ---
> > > >    1. Merge in Jiri's patch to support stdio mode
> > > > 
> > > >    2. Add a new patch "perf annotate: Create a annotate2 flag
> > > >       in struct symbol" which records if the symbol has been
> > > >       annotated yet.
> > > > 
> > > >    3. Minor update such as adding { } for multiline code in 'if'
> > > >       condition.
> > > > 
> > > > Jin Yao (3):
> > > >    perf annotate: Compute average IPC and IPC coverage per symbol
> > > >    perf annotate: Create a annotate2 flag in struct symbol
> > > >    perf report: Display average IPC and IPC coverage per symbol
> > > 
> > > hi,
> > > I took he liberty and moved the annotation retrieval into
> > > resort phase under progress bar scope. It's currently on top
> > > of my perf/fixes branch, could you please check it?
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > 
> > commits:
> > 7f3ffdb9783f perf tools: Move symbol annotation to resort
> > e87f7d3c4f10 perf tools: Add perf_evsel__output_resort_cb function
> > 40012b422108 perf tools: Add argument to hists__resort_cb_t callback
> > 
> > jirka
> > 
> 
> Hi Jiri,
> 
> Thanks for your patches. I have tested with your repo. Now I can see 2
> progress bars. One is displayed at the events processing phase, the other is
> displayed at resorting phase.
> 
> I have only one concern that is, in my test, much of time is consumed by the
> event processing phase, for example, 90% of time. Only 10% of time is
> consumed at resorting phase.
> 
> So do we really need the second progress bar?

well I did not add it, it's been always there, it just must
have been real quick for you so u did not notice I guess

it's strange, because for me the resorting takes much longer
even for small data.. let's have your patchset applied and
have this discussion when I send out the patches

thanks,
jirka
