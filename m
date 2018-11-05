Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE2C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DF420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rtXwI1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DF420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbeKEWaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbeKEWaO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:30:14 -0500
Received: from jouet.infradead.org (unknown [189.40.101.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C42620819;
        Mon,  5 Nov 2018 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541423431;
        bh=33s/d90Ew2qHFhhpur0DgTIWcUp4wKKsoumnQGFQXAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0rtXwI1mh7RZPf9Yz1W73FSiamI1eRhehlnjlzGomqMbs2UROxBMIW18mk5z8nLVL
         m/l0JCamNbWeQEBxcgwG/IsOKPhZzYv7j1Ea3krExC3bo/vgC/R8dgBANWA0ExUs+1
         O2ZF4U+b8shdf9e1vHNquXMysCBujBCRDA5BEDJQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 50D7E142D18; Mon,  5 Nov 2018 10:10:27 -0300 (-03)
Date:   Mon, 5 Nov 2018 10:10:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf top: Display the LBR stats in callchain entry
Message-ID: <20181105131027.GC11147@kernel.org>
References: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
 <cb124f2d-a7b6-689e-c41d-0dec33a8cf0f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb124f2d-a7b6-689e-c41d-0dec33a8cf0f@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 08:31:59AM +0800, Jin, Yao escreveu:
> Hi,
> 
> Any comments for this patch?

I'll check it today, I'm just a bit behind while preparing for plumbers,
I'll get to all the patches :-)

- Arnaldo
 
> Thanks
> Jin Yao
> 
> On 10/31/2018 7:06 PM, Jin Yao wrote:
> > Perf report has supported the displaying of LBR stats
> > (such as cycles, predicted%) in callchain entry.
> > 
> > For example,
> > perf report --branch-history --stdio
> > 
> > --1.01%--intel_idle mwait.h:29
> >            intel_idle cpufeature.h:164 (cycles:5)
> >            intel_idle cpufeature.h:164 (predicted:76.4%)
> >            intel_idle mwait.h:102 (cycles:41)
> >            intel_idle current.h:15
> > 
> > While perf top has not supported that.
> > 
> > For example,
> > perf top -a -b --call-graph branch
> > 
> > -   13.86%     0.23%  [kernel]		[k] __x86_indirect_thunk_rax
> >     - 13.65% __x86_indirect_thunk_rax
> >        + 1.69% do_syscall_64
> >        + 1.68% do_select
> >        + 1.41% ktime_get
> >        + 0.70% __schedule
> >        + 0.62% do_sys_poll
> >          0.58% __x86_indirect_thunk_rax
> > 
> > Actually it's very easy to enable this feature in perf top.
> > 
> > With this patch, the result is:
> > 
> > perf top -a -b --call-graph branch
> > 
> > -   13.58%     0.00%  [kernel]		[k] __x86_indirect_thunk_rax
> >     - 13.57% __x86_indirect_thunk_rax (predicted:93.9%)
> >        + 1.78% do_select (cycles:2)
> >        + 1.68% perf_pmu_disable.part.99 (cycles:1)
> >        + 1.45% ___sys_recvmsg (cycles:25)
> >        + 0.81% unix_stream_sendmsg (cycles:18)
> >        + 0.80% ktime_get (cycles:400)
> >          0.58% pick_next_task_fair (cycles:47)
> >        + 0.56% i915_request_retire (cycles:2)
> >        + 0.52% do_sys_poll (cycles:4)
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/builtin-top.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index d21d875..7691b21 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1420,6 +1420,9 @@ int cmd_top(int argc, const char **argv)
> >   		}
> >   	}
> > +	if (opts->branch_stack && callchain_param.enabled)
> > +		symbol_conf.show_branchflag_count = true;
> > +
> >   	sort__mode = SORT_MODE__TOP;
> >   	/* display thread wants entries to be collapsed in a different tree */
> >   	perf_hpp_list.need_collapse = 1;
> > 
