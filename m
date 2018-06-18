Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14025C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0846208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dV6qzy88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0846208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934837AbeFRKl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:41:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbeFRKl5 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LDycdvsS6IWs4GMxyCn79FrnC51QOu9SYF5TU829ao8=; b=dV6qzy886PrU5Z87sJwlbQi3V
        hg/FQK0dKJxjrhqZFP6jZX3OdTAAhBtC7cYPctSJKHNKJHYSDloPghTGLlvEHKOV8tbOvzLgvNndO
        aE5+p2cTWEDke287jTpmS1uJAuXqo7jSgHJgLmQH1Pz7KTkJn5eYZzBIs06ikSwjKfOEz96ES6CkA
        0WslyQiTu/tLOq98vxTLV6LLi3ImwY/UZv6Xi36/jCS+TWNaJDDyuAERAK0jmej5I2JqAr/n3TnD9
        9OlTq9MxV416K2Hncj8YfxmRDPNsfwlBssYN+3MRpe7VIT+NmjizM1BGkpBEuQmMUs2g776FU+6vO
        OXBpLR1Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUrbb-0006R6-4x; Mon, 18 Jun 2018 10:41:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F5B92029FA11; Mon, 18 Jun 2018 12:41:49 +0200 (CEST)
Date:   Mon, 18 Jun 2018 12:41:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "me@kylehuey.com" <me@kylehuey.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180618104149.GH2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <CABPqkBTyEZX7DebLR-nbzXs0ZYGT1xWNmOmvKgRsvr4mxWJg=w@mail.gmail.com>
 <20180615081656.GC2458@hirez.programming.kicks-ass.net>
 <37D7C6CF3E00A74B8858931C1DB2F07753939C70@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07753939C70@SHSMSX103.ccr.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:31:34PM +0000, Liang, Kan wrote:
> > On Thu, Jun 14, 2018 at 11:02:53PM -0700, Stephane Eranian wrote:
> > > On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> > > > +       /*
> > > > +        * Due to interrupt latency (AKA "skid"), we may enter the
> > > > +        * kernel before taking an overflow, even if the PMU is only
> > > > +        * counting user events.
> > > > +        * To avoid leaking information to userspace, we must always
> > > > +        * reject kernel samples when exclude_kernel is set.
> > > > +        */
> > > > +       if (event->attr.exclude_kernel && !user_mode(regs))
> > > > +               return false;
> > > > +
> > > And how does that filter PEBS or LBR records?
> > 
> > I suspect the user_mode() thing actually covers PEBS, but yes LBR might need
> > additional filtering.
> 
> I think the large PEBS still need to be specially handled.

large pebs should be fine too, all pebs stuff eventually calls
perf_event_output() with a synthesized register set.
