Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAEBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFD720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFD720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeGXRmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:42:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388324AbeGXRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:42:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A372840201A3;
        Tue, 24 Jul 2018 16:35:19 +0000 (UTC)
Received: from treble (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20CA92026D68;
        Tue, 24 Jul 2018 16:35:19 +0000 (UTC)
Date:   Tue, 24 Jul 2018 11:35:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180724163517.flt3pmdphvsqbegc@treble>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <20180723133006.7mkzrdeaa4jo56md@treble>
 <20180723141427.GA2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723141427.GA2458@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 16:35:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 16:35:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:14:27PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 23, 2018 at 08:30:06AM -0500, Josh Poimboeuf wrote:
> > On Thu, Jul 19, 2018 at 11:19:54PM +0200, Peter Zijlstra wrote:
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> > >  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> > >  
> > >  	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> > > +
> > > +	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1UL << 63,
> > 
> > Given the kbuild test robot errors for building on 32-bit, looks like
> > the 63 needs to be changed to 31 so it fits in an int?
> 
> I made it 1ULL << 63. The actual field (perf_event_attr::sample_type is
> u64).

Ok, did you post this somewhere?

-- 
Josh
