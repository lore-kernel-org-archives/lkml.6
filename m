Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RCkmFcbJGVvlDgAAmS7hNA
	; Fri, 08 Jun 2018 00:12:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4AEDB6074D; Fri,  8 Jun 2018 00:12:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B884560290;
	Fri,  8 Jun 2018 00:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B884560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeFHAMJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:12:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752178AbeFHAMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE66CBB42F;
        Fri,  8 Jun 2018 00:12:07 +0000 (UTC)
Received: from krava (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE59B1117648;
        Fri,  8 Jun 2018 00:12:04 +0000 (UTC)
Date: Fri, 8 Jun 2018 02:12:03 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>, frederic@kernel.org
Subject: Re: [PATCH 09/10] perf/cputime: Don't stop idle tick if there's live
 cputime event
Message-ID: <20180608001203.GB12322@krava>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-10-jolsa@kernel.org>
 <20180607154522.hyjmxn3q6zgcvsnx@two.firstfloor.org>
 <CABPqkBR88VBZB1mLttUx0UxnFgWTJ=ggb66PsMti--svJU70UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBR88VBZB1mLttUx0UxnFgWTJ=ggb66PsMti--svJU70UQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 00:12:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 00:12:07 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:01:30AM -0700, Stephane Eranian wrote:
> Hi Jiri,
> 
> On Thu, Jun 7, 2018 at 8:45 AM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > On Thu, Jun 07, 2018 at 12:15:12AM +0200, Jiri Olsa wrote:
> > > Disable stopping of the idle tick when having live cputime
> > > event. When the tick is disabled, the idle counts are out
> > > of date until next tick/update and perf cputime PMU provides
> > > misleading counts.
> >
> > I really don't like this. This can totally change performance
> > (e.g. less Turbo due to less idle) and performance tools shouldn't
> > change the performance profile drastically.
> >
> You do not want to change the behavior of the kernel just because you
> are monitoring.
> This may introduce side effects on other events which may not otherwise exist.

right.. I guess we can survive few seconds of misleading idle counts
and perhaps we could detect nohz is enabled and warn about this

thanks,
jirka
