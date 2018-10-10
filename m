Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41F521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41F521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJJOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeJJOfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:35:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B5A883F46;
        Wed, 10 Oct 2018 07:15:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9266417DF3;
        Wed, 10 Oct 2018 07:14:59 +0000 (UTC)
Date:   Wed, 10 Oct 2018 09:14:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Anthony LaTorre <tlatorre9@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf report segfault
Message-ID: <20181010071458.GA15790@krava>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
 <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
 <20181009214158.GB31206@krava>
 <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
 <20181009222004.GA19295@krava>
 <f5ce21f8-6c80-b6a0-8b8a-e7a90c23a98c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ce21f8-6c80-b6a0-8b8a-e7a90c23a98c@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 10 Oct 2018 07:15:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:13:47AM +0530, Sandipan Das wrote:
> Hi Jiri,
> 
> Yes, this happens when entry->map is NULL. While your fix seems correct, the
> following commit from Milian Wolff had already addressed this. I think this
> was pulled in with one of Arnaldo's recent perf/urgent updates.
> 
> ff4ce2885af8 ("perf report: Don't try to map ip to invalid map")
> 
> Adding Milian to the loop as well.

yea.. I knew I saw that code just recently ;-)

thanks,
jirka

> 
> With Regards,
> Sandipan
> 
> On 10/10/18 3:50 AM, Jiri Olsa wrote:
> > On Tue, Oct 09, 2018 at 04:47:31PM -0500, Anthony LaTorre wrote:
> >> I can try building perf from the latest sources. I've attached the
> >> perf.data and perf.data.tar.bz2 from the test program I sent earlier.
> > 
> > cool, reproduced.. it seems to get introduced by:
> >   2a9d5050dc84 perf script: Show correct offsets for DWARF-based unwinding
> > 
> > reverting that patch fixes the issue for me, but looks like
> > we could just make th attached check and prevent the crash
> > 
> > adding Sandipan Das to the loop, the author of that commit, any idea?
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index c4acd2001db0..ea68c805c7ac 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2312,7 +2312,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
> >  {
> >  	struct callchain_cursor *cursor = arg;
> >  	const char *srcline = NULL;
> > -	u64 addr;
> >  
> >  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
> >  		return 0;
> > @@ -2320,13 +2319,15 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
> >  	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
> >  		return 0;
> >  
> > -	/*
> > -	 * Convert entry->ip from a virtual address to an offset in
> > -	 * its corresponding binary.
> > -	 */
> > -	addr = map__map_ip(entry->map, entry->ip);
> > +	if (entry->map) {
> > +		/*
> > +		 * Convert entry->ip from a virtual address to an offset in
> > +		 * its corresponding binary.
> > +		 */
> > +		u64 addr = map__map_ip(entry->map, entry->ip);
> > +		srcline = callchain_srcline(entry->map, entry->sym, addr);
> > +	}
> >  
> > -	srcline = callchain_srcline(entry->map, entry->sym, addr);
> >  	return callchain_cursor_append(cursor, entry->ip,
> >  				       entry->map, entry->sym,
> >  				       false, NULL, 0, 0, 0, srcline);
> > 
> 
