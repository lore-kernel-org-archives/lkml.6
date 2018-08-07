Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD73AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DA621757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DA621757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbeHGQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:54:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389073AbeHGQya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E11C40201A3;
        Tue,  7 Aug 2018 14:39:51 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 142232026D66;
        Tue,  7 Aug 2018 14:39:48 +0000 (UTC)
Date:   Tue, 7 Aug 2018 16:39:48 +0200
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
Message-ID: <20180807143948.GF7716@krava>
References: <20180806101241.6444-1-jolsa@kernel.org>
 <20180806101241.6444-3-jolsa@kernel.org>
 <20180806124839.GC7840@redhat.com>
 <20180806132353.GA7463@krava>
 <20180806150836.GD16446@krava>
 <20180806163436.GH7840@redhat.com>
 <20180807081616.GB7716@krava>
 <20180807091008.GA19831@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807091008.GA19831@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 14:39:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 14:39:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:10:08AM +0200, Oleg Nesterov wrote:
> On 08/07, Jiri Olsa wrote:
> >
> > On Mon, Aug 06, 2018 at 06:34:36PM +0200, Oleg Nesterov wrote:
> > > > --- a/kernel/events/hw_breakpoint.c
> > > > +++ b/kernel/events/hw_breakpoint.c
> > > > @@ -526,10 +526,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
> > > >  	if (err)
> > > >  		return err;
> > > >
> > > > -	if (!attr->disabled) {
> > > > +	if (!attr->disabled)
> > > >  		perf_event_enable(bp);
> > > > -		bp->attr.disabled = 0;
> > > > -	}
> > > > +
> > >
> > > Yes, but again, this still looks confusing.
> > >
> > > IMO, we should either remove "bp->attr.disabled = attr->disabled" in
> > > modify_user_hw_breakpoint_check() because bp->attr.disabled  is not really
> > > used, or we should set bp->attr.disabled = 1 on failure just for consistency.
> > >
> > >
> > > Hmm... actually ptrace_get_dr7() checks ->attr.disabled, so we can hit
> > > WARN_ON(second_pass) in ptrace_write_dr7() in case when attr.disabled is
> > > falsely 0 because modify_user_hw_breakpoint_check() failed before?
> >
> > hum, I can't see how modify_user_hw_breakpoint_check could falsely set disabled
> > new attr stuff is copied once all checks passed
> 
> Hmm. So modify_user_hw_breakpoint() does perf_event_disable(bp) first and afaics
> this doesn't set bp->attr.disabled = 1.
> 
> If modify_user_hw_breakpoint_check() fails after that we do not update bp->attr,
> so bp->attr.disabled is still zero while this bp is actually disabled.

this seems to be cared of the 2nd pass restore logic, where the
old dr7 value will make the breakpoint to be enabled again:

bp0.attr.disabled = 0 (enabled)

ptrace_write_dr7(newdr7)
   dr7 = newdr7
   ptrace_modify_breakpoint(bp0)
     perf_event_disable                        -> bp0 disabled, but bp0.attr.disabled = 0
     modify_user_hw_breakpoint_check fails
       return -1                               -> leaving with bp0 disabled, bp0.attr.disabled = 0

   dr7 = olddr7                                -> bp0 bit enabled
   second_pass = true
   ptrace_modify_breakpoint                    -> attr->disabled = 0
     perf_event_disable
     modify_user_hw_breakpoint_check
       hw_breakpoint_copy_attr
     perf_event_enable                         -> bp0 enabled, bp0.attr.disabled = 0



but this could be problem for ptrace_set_breakpoint_addr, because
the new address modification in modify_user_hw_breakpoint_check,
can fail and leave enabled breakpoint with disabled = 0

might be enough to manualy disable it in case of error like below
(squashed with my previou change) need to test this..

jirka


---
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fb229d9c7f3c..eff7ab716139 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -523,13 +523,14 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 		perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, false);
-	if (err)
+	if (err) {
+		bp->attr.disabled = 1;
 		return err;
+	}
 
-	if (!attr->disabled) {
+	if (!attr->disabled)
 		perf_event_enable(bp);
-		bp->attr.disabled = 0;
-	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
-- 
2.17.1
