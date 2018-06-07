Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cS3YFUfMGFuMdwAAmS7hNA
	; Thu, 07 Jun 2018 06:22:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9882E6089E; Thu,  7 Jun 2018 06:22:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D8EA6063F;
	Thu,  7 Jun 2018 06:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D8EA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeFGGWp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:22:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbeFGGWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F8A340BC05B;
        Thu,  7 Jun 2018 06:22:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.157])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6BF01002957;
        Thu,  7 Jun 2018 06:22:40 +0000 (UTC)
Date: Thu, 7 Jun 2018 08:22:39 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 01/10] perf tools: Uniquify the event name if there's no
 other matched event
Message-ID: <20180607062239.GA18436@krava>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-2-jolsa@kernel.org>
 <20180606231902.GE7220@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606231902.GE7220@tassilo.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 07 Jun 2018 06:22:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 07 Jun 2018 06:22:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 04:19:02PM -0700, Andi Kleen wrote:
> On Thu, Jun 07, 2018 at 12:15:04AM +0200, Jiri Olsa wrote:
> > Currently by default we try to match the user specified PMU
> > name to all PMU units available and use them to aggregate
> > all matched PMUs event counts into one 'pattern' event.
> > 
> > While this is useful for uncore events, it screws up names
> > for other events, where this is not desirable, like:
> > 
> > Before:
> >   # perf stat -e cp/cpu-cycles/ kill
> 
> I assume you mean cpU/cpu-cycles/
> > 
> >    Performance counter stats for 'kill':
> > 
> >            1,573,757      cp/cpu-cycles/
> > 
> > Keeping the pattern matching logic, but making the name unique
> > in case there's no other match found. That fixes the example
> > above and hopefully does not screw up anything else.
> > 
> > After:
> >   # perf stat -e cp/cpu-cycles/ kill
> > 
> >    Performance counter stats for 'kill':
> > 
> >            1,573,757      cpu/cpu-cycles/
> 
> 
> The output is 100% identical?

nope, the U is actualy missing.. that's the thing, the patern
matching allows you to put 'cp' instead of 'cpu' and the final
output is screwed.. also the metrics won't match the proper event

jirka
