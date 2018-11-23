Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A2C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A2C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440017AbeKXBQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:16:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46516 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391009AbeKXBQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:16:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DB03620;
        Fri, 23 Nov 2018 06:32:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391283F575;
        Fri, 23 Nov 2018 06:32:15 -0800 (PST)
Date:   Fri, 23 Nov 2018 14:32:13 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] perf/core: Add macro to test for event exclusion
 flags
Message-ID: <20181123143213.GB1617@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
 <87sgzw0yzh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgzw0yzh.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:28:34PM +1100, Michael Ellerman wrote:
> Andrew Murray <andrew.murray@arm.com> writes:
> 
> > Add a macro that tests if any of the perf event exclusion flags
> > are set on a given event.
> >
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  include/linux/perf_event.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 53c500f..89ee7fa 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
> >  extern void
> >  perf_log_lost_samples(struct perf_event *event, u64 lost);
> >  
> > +static inline bool event_has_exclude_flags(struct perf_event *event)
> > +{
> > +	struct perf_event_attr *attr = &event->attr;
> > +
> > +	return attr->exclude_idle || attr->exclude_user ||
> > +	       attr->exclude_kernel || attr->exclude_hv ||
> > +	       attr->exclude_guest || attr->exclude_host;
> > +}
> 
> Sorry to be a total PITA, but using "flags" plural suggests that it only
> returns true if there is more than one exclude flag set.
> 
> A better name would be event_has_exclude_flag() or maybe
> event_has_any_exclude_flag().
> 
> If you're doing a respin anyway it'd be nice to fix the name, but
> obviously it's not high priority.

No problem - I'll go with event_has_any_exclude_flag.

Thanks,

Andrew Murray

> 
> cheers
