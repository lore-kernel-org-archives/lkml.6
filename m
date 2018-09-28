Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CD6216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfZhDdY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CD6216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeI1NlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:41:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1Nk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lnmbyE0X/GIFdAwtB8kPefH/UZNSRfFG2zKigVBW4Rw=; b=VfZhDdY56tzElwxYsG2Vlu0q5
        ce++gA0Oes/B8XLqk7d3mGdg5wkMESvswvp9uF5dLo+f703ZKZ2al3BQ0fPQOKaGD2l4opDPmrXTG
        oLMVWKj4p6MjSWtLSDCKqyhyKp8v70GtWG11XegxyDRAw96NzraD8iaS/oWcgvFQlwJtEJS0iEZ8P
        wrR2g+FBjam6VIEtyX50/QjD8pQPlwEe88PfoC8hvE1xZWoB5y2qobmz7dGQ7739ZSzfMlREat76V
        xqK2E0KdiM2xra2lFSoXptwK7EtAgBlU0d5HKea2HtCMCbJhairiSofUYMvsp7ZGNWsQslLKKb7W9
        l8O6rfq0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5n2S-0003sP-Cv; Fri, 28 Sep 2018 07:18:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8DBD21070941; Fri, 28 Sep 2018 09:18:09 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:18:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Message-ID: <20180928071809.GG3439@hirez.programming.kicks-ass.net>
References: <20180924211236.4149482-1-songliubraving@fb.com>
 <20180926120623.7cbf2003@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926120623.7cbf2003@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:06:23PM -0400, Steven Rostedt wrote:
> On Mon, 24 Sep 2018 14:12:36 -0700
> Song Liu <songliubraving@fb.com> wrote:
> 
> > This patch enables uprobes with reference counter in fd-based uprobe.
> > Highest 40 bits of perf_event_attr.config is used to stored offset
> > of the reference counter (semaphore).
> > 
> > Format information in /sys/bus/event_source/devices/uprobe/format/ is
> > updated to reflect this new feature.
> > 
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/trace_events.h    |  3 +-
> >  kernel/events/core.c            | 49 ++++++++++++++++++++++++++-------
> >  kernel/trace/trace_event_perf.c |  7 +++--
> 
> Peter,
> 
> This is based off of some uprobe code in my tree (which I just finished
> testing and need to push to linux-next). But can you give an ack to the
> perf parts?

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index c80549bf82c6..a4ad5235ec9b 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8368,30 +8368,39 @@ static struct pmu perf_tracepoint = {
> >   *
> >   * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
> >   *                               if not set, create kprobe/uprobe
> > + *
> > + * The following values specify a reference counter (or semaphore in the
> > + * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
> > + * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> > + *
> > + * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
> > + * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
> >   */
> >  enum perf_probe_config {
> >  	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
> > +	PERF_UPROBE_REF_CTR_OFFSET_BITS = 40,
> > +	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
> >  };
> > 
> >  PMU_FORMAT_ATTR(retprobe, "config:0");

There's a PMU_FORMAT_ATTR() missing for the new part.
