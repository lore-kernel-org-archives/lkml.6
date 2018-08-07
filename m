Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFD0215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFD0215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeHGK3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:29:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbeHGK3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:29:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9041487A70;
        Tue,  7 Aug 2018 08:16:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 78EC621568A1;
        Tue,  7 Aug 2018 08:16:17 +0000 (UTC)
Date:   Tue, 7 Aug 2018 10:16:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 3/2] perf/hw_breakpoint: Remove superfluous
 bp->attr.disabled = 0 new attr has disabled set
Message-ID: <20180807081616.GB7716@krava>
References: <20180806101241.6444-1-jolsa@kernel.org>
 <20180806101241.6444-3-jolsa@kernel.org>
 <20180806124839.GC7840@redhat.com>
 <20180806132353.GA7463@krava>
 <20180806150836.GD16446@krava>
 <20180806163436.GH7840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163436.GH7840@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 08:16:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 08:16:19 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 06:34:36PM +0200, Oleg Nesterov wrote:
> On 08/06, Jiri Olsa wrote:
> >
> > Once the breakpoint was succesfully modified, the attr->disabled
> > value is in bp->attr.disabled. So there's no reason to set it
> > again, removing that.
> > 
> > Link: http://lkml.kernel.org/n/tip-v5oaellzsmyszv3rfucuxkp0@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/hw_breakpoint.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index fb229d9c7f3c..3e560d7609fd 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -526,10 +526,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
> >  	if (err)
> >  		return err;
> >  
> > -	if (!attr->disabled) {
> > +	if (!attr->disabled)
> >  		perf_event_enable(bp);
> > -		bp->attr.disabled = 0;
> > -	}
> > +
> 
> Yes, but again, this still looks confusing.
> 
> IMO, we should either remove "bp->attr.disabled = attr->disabled" in
> modify_user_hw_breakpoint_check() because bp->attr.disabled  is not really
> used, or we should set bp->attr.disabled = 1 on failure just for consistency.
> 
> 
> Hmm... actually ptrace_get_dr7() checks ->attr.disabled, so we can hit
> WARN_ON(second_pass) in ptrace_write_dr7() in case when attr.disabled is
> falsely 0 because modify_user_hw_breakpoint_check() failed before?

hum, I can't see how modify_user_hw_breakpoint_check could falsely set disabled
new attr stuff is copied once all checks passed

jirka
