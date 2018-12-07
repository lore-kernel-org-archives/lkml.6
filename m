Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49578C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834A20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3JL37VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0834A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLGPLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:11:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+K/Q3C8Zh/PtzsONM7k7nq3ejdyDZ6Iu/lVeDRTdWOI=; b=C3JL37VEZqE1SNEdktIy6/j0o
        7vmVQrdZL+0D6gUbIfP61MuuyzDDI8Zt6Vc/ZtmCIr+u+elkg0kEwqn5FrwISxabnZ9mCvZfPeXXX
        4OErUI/f7RF/2t3SixLyAWxVxfCiKCoSHnoIiDSGNktyCP9enqAZ6dteGpgvDgIlbfM3NaOMCidy4
        uuq4/6jv5HzFK3dJx1wWn/CQlts6+11oU+MLlnDZLnA+YoKzPrm0dQ05PL6Gyw9y7fqAn3nWkP2lc
        33fIRSdfWeFXvCOmFB2IU7vfob2noKbA2gDKcghK8g0bAA9giKMBsgvMkVI7Fb5aKeCoRD5U7uWlX
        JgwCNR9bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVHmW-0006Be-En; Fri, 07 Dec 2018 15:11:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A97102072618F; Fri,  7 Dec 2018 16:11:05 +0100 (CET)
Date:   Fri, 7 Dec 2018 16:11:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181207151105.GB5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207072701.5bc564c7@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:41:18AM -0500, Steven Rostedt wrote:
> On Fri, 7 Dec 2018 09:58:39 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > These patches give no justification *what*so*ever* for why we're doing
> > ugly arse things like this. And why does this, whatever this is, need to
> > be done in perf?
> > 
> > IOW, what problem are we solving ?
> 
> I guess the cover letter should have had a link (or copy) of this:
> 
>  http://lkml.kernel.org/r/20181128134700.212ed035@gandalf.local.home

That doesn't even begin to explain. Who cares about strace and why? And
why is it such a bad thing to loose the occasional record etc..

