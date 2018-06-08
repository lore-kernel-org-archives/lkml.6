Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KRU7LX7IGVuYCAAAmS7hNA
	; Fri, 08 Jun 2018 00:07:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 462B36089E; Fri,  8 Jun 2018 00:07:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D42E960452;
	Fri,  8 Jun 2018 00:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D42E960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeFHAHE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:07:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752411AbeFHAHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39F8F400E9BA;
        Fri,  8 Jun 2018 00:07:02 +0000 (UTC)
Received: from krava (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1B581C668;
        Fri,  8 Jun 2018 00:06:57 +0000 (UTC)
Date: Fri, 8 Jun 2018 02:06:56 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>, agustinv@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>, frederic@kernel.org
Subject: Re: [PATCH 01/10] perf tools: Uniquify the event name if there's no
 other matched event
Message-ID: <20180608000656.GA12322@krava>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-2-jolsa@kernel.org>
 <20180606231902.GE7220@tassilo.jf.intel.com>
 <20180607062239.GA18436@krava>
 <CABPqkBRCZgPEpcc0SUvefoqAHh=-jTtBr=EgoomDCFTT54aJBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRCZgPEpcc0SUvefoqAHh=-jTtBr=EgoomDCFTT54aJBg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 00:07:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 00:07:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:09:10AM -0700, Stephane Eranian wrote:
> On Wed, Jun 6, 2018 at 11:22 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Jun 06, 2018 at 04:19:02PM -0700, Andi Kleen wrote:
> > > On Thu, Jun 07, 2018 at 12:15:04AM +0200, Jiri Olsa wrote:
> > > > Currently by default we try to match the user specified PMU
> > > > name to all PMU units available and use them to aggregate
> > > > all matched PMUs event counts into one 'pattern' event.
> > > >
> > > > While this is useful for uncore events, it screws up names
> > > > for other events, where this is not desirable, like:
> > > >
> > > > Before:
> > > >   # perf stat -e cp/cpu-cycles/ kill
> > >
> > > I assume you mean cpU/cpu-cycles/
> > > >
> > > >    Performance counter stats for 'kill':
> > > >
> > > >            1,573,757      cp/cpu-cycles/
> > > >
> > > > Keeping the pattern matching logic, but making the name unique
> > > > in case there's no other match found. That fixes the example
> > > > above and hopefully does not screw up anything else.
> > > >
> And the problem I have with this approach, is that you do not really
> know what you are measuring.
> You have not way of knowing that the count comes from multiple PMU instances:
> 
> perf stat -a -e uncore_cb/clockticks/ kill
> 0 uncore_cb/clockticks/
> 
> I think you need to report that this is aggregated from uncore_cbox_0
> and uncore_cbox_1.
> Otherwise it is not clear what I am monitoring. And you hope that what
> you match in the regex
> is related.
> In my example should say:
> 0 uncore_cbox[0-1]/clockticks/

ok, makes sense.. also shouldnt be that hard to do.. will repost

thanks,
jirka
