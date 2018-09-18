Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FECC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEA421471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhq4bOn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEA421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbeISF3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeISF3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:29:49 -0400
Received: from devnote (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3975B20C0E;
        Tue, 18 Sep 2018 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537314888;
        bh=9KJBq7pXzjj3IpABrn7nb4aXM1ULPzPLExzZonWTyEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bhq4bOn17+ypFwU1Ex13Pk83+jX4xIvh4J6IJNp159PpE9vy1nQPZTqdl0wsxk+sT
         G0BvdFx6BkfyoQlaI0pm+tD16BM6PAOZ1oAitPTloBKQw60Z3fZy7l7sQqPwsZu/ZQ
         k6xvNEx5begMX6EiJnT0bBVOcqyDkrAN3AWQBAsY=
Date:   Wed, 19 Sep 2018 08:54:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 8/8] trace: Add alternative synthetic event trace
 action syntax
Message-Id: <20180919085447.53b1e87f4c76fdb38bf5ad98@kernel.org>
In-Reply-To: <1537298203.11628.8.camel@kernel.org>
References: <cover.1536605847.git.tom.zanussi@linux.intel.com>
        <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
        <20180919035446.4fb6b856ab51229984eb2736@kernel.org>
        <1537298203.11628.8.camel@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, 18 Sep 2018 14:16:43 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Wed, 2018-09-19 at 03:54 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Mon, 10 Sep 2018 14:10:46 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Add a 'trace(synthetic_event_name, params)' alternative to
> > > synthetic_event_name(params).
> > > 
> > > Currently, the syntax used for generating synthetic events is to
> > > invoke synthetic_event_name(params) i.e. use the synthetic event
> > > name
> > > as a function call.
> > > 
> > > Users requested a new form that more explicitly shows that the
> > > synthetic event is in effect being traced.  In this version, a new
> > > 'trace()' keyword is used, and the synthetic event name is passed
> > > in
> > > as the first argument.
> > 
> > Hmm, what is the advantage of adding this new form?
> > 
> 
> There's no real advantage other than user preference - Namhyung thought
> that since the event-name-as-function-call actions are all defined as
> ACTION_TRACE, there should also be an explicit 'trace' action.

Ah, got it. Would this needs documentation and testcase update too?

> 
> So I added it as alternative syntax - the event-name-as-function-call
> form remains unchanged.
> 
> By the way, I also have a patch implementing your alternative syntax
> change, where if you have only one handler, you can do away with the
> explicit action.handler form e.g.
> 
>   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-ts0: \
>     onmax($wakeup_lat): \
>     save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):snapshot() \

Hmm, in this case, I think comma-connected syntax will be clearer when
the action is kicked.

     onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,prev_comm),snapshot()

any thought?

Thank you,

>     if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> It just wasn't ready to go in with the v4 patches yet, so I decided
> to submit it later as a follow-on.
> 
> Tom
> 
> 
> > Thanks,
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
