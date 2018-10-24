Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB2ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79020831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnoP2zDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D79020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeJYDov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYDov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:44:51 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEE42082F;
        Wed, 24 Oct 2018 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540408534;
        bh=64L2UZV1uJuYnUXy+xo1F4+Lz6VvJ1+/1wfI4wxy/0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnoP2zDzLpV2itganNf2nX0pUfEohcwHn6xXvcWLdc6KrEV3IB6l/ArPd8z1YT4ZF
         6gJerJZ/0FGqt3mxsQcwNjPEy4bahKaBkw3gWc4KfcjGsSm9iN3gRiiQjXPSWCFh7G
         +anhFVtylmKM4S52IjiciDYnf+l78yMjypjRn8ms=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 56A27142C5F; Wed, 24 Oct 2018 16:15:29 -0300 (-03)
Date:   Wed, 24 Oct 2018 16:15:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181024191529.GF15106@kernel.org>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181024162334.GG6218@tassilo.jf.intel.com>
 <20181024163208.GC15106@kernel.org>
 <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 24, 2018 at 02:12:54PM -0400, Liang, Kan escreveu:
> 
> 
> On 10/24/2018 12:32 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Oct 24, 2018 at 09:23:34AM -0700, Andi Kleen escreveu:
> > > > +void perf_event_munmap(void)
> > > > +{
> > > > +	struct perf_cpu_context *cpuctx;
> > > > +	unsigned long flags;
> > > > +	struct pmu *pmu;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> > > 
> > > Would be good have a fast path here that checks for the list being empty
> > > without disabling the interrupts. munmap can be somewhat hot. I think
> > > it's ok to make it slower with perf running, but we shouldn't impact
> > > it without perf.
> > 
> > Right, look at how its counterpart, perf_event_mmap() works:
> > 
> > void perf_event_mmap(struct vm_area_struct *vma)
> > {
> >          struct perf_mmap_event mmap_event;
> > 
> >          if (!atomic_read(&nr_mmap_events))
> >                  return;
> > <SNIP>
> > }
> > 
> 
> Thanks. I'll add the nr_mmap_events check in V2.

That would be a nr_munmap_events, if this is tied to PERF_RECORD_MUNMAP
(right?), which it isn't right now, check Andi's response, mine was more
of a "hey, perf_event_mmap does an atomic check, before grabbing any
locks".

- Arnaldo
