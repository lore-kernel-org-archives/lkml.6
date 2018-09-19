Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F586C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185BC2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKMWNYxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185BC2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeISWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbeISWL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:11:56 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C252083A;
        Wed, 19 Sep 2018 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537374795;
        bh=kTcQyM9dUSSsp3fkmPtNg7hFZ5FW296wkv4ufjKGyVk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uKMWNYxHZXGzzHmly4jQZk9RqgepEGxyBFqTHGKjTEn7onE0iEGIVxugXAIhvuVXI
         Ah4WxLv/cqrg8Zrtv5eiWhky+r8jrXoxiiIgNYJcS8WcJ7JOX8SUszxBrD58MUD5ul
         lVkzUFmSo6Ui5za6nyNuTyn5XjO/ik+f/z1CTrP0=
Message-ID: <1537374792.11628.20.camel@kernel.org>
Subject: Re: [PATCH v4 8/8] trace: Add alternative synthetic event trace
 action syntax
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Sep 2018 11:33:12 -0500
In-Reply-To: <20180919085447.53b1e87f4c76fdb38bf5ad98@kernel.org>
References: <cover.1536605847.git.tom.zanussi@linux.intel.com>
         <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
         <20180919035446.4fb6b856ab51229984eb2736@kernel.org>
         <1537298203.11628.8.camel@kernel.org>
         <20180919085447.53b1e87f4c76fdb38bf5ad98@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 2018-09-19 at 08:54 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 18 Sep 2018 14:16:43 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > On Wed, 2018-09-19 at 03:54 +0900, Masami Hiramatsu wrote:
> > > Hi Tom,
> > > 
> > > On Mon, 10 Sep 2018 14:10:46 -0500
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > > 
> > > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > 
> > > > Add a 'trace(synthetic_event_name, params)' alternative to
> > > > synthetic_event_name(params).
> > > > 
> > > > Currently, the syntax used for generating synthetic events is
> > > > to
> > > > invoke synthetic_event_name(params) i.e. use the synthetic
> > > > event
> > > > name
> > > > as a function call.
> > > > 
> > > > Users requested a new form that more explicitly shows that the
> > > > synthetic event is in effect being traced.  In this version, a
> > > > new
> > > > 'trace()' keyword is used, and the synthetic event name is
> > > > passed
> > > > in
> > > > as the first argument.
> > > 
> > > Hmm, what is the advantage of adding this new form?
> > > 
> > 
> > There's no real advantage other than user preference - Namhyung
> > thought
> > that since the event-name-as-function-call actions are all defined
> > as
> > ACTION_TRACE, there should also be an explicit 'trace' action.
> 
> Ah, got it. Would this needs documentation and testcase update too?
> 

The first part of the patch does contain the Documentation change to
trace/histograms.txt.

But I didn't do a testcase for it, will do that in the next iteration.

> > 
> > So I added it as alternative syntax - the event-name-as-function-
> > call
> > form remains unchanged.
> > 
> > By the way, I also have a patch implementing your alternative
> > syntax
> > change, where if you have only one handler, you can do away with
> > the
> > explicit action.handler form e.g.
> > 
> >   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-ts0: 
> > \
> >     onmax($wakeup_lat): \
> >     save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):snapshot
> > () \
> 
> Hmm, in this case, I think comma-connected syntax will be clearer
> when
> the action is kicked.
> 
>      onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,p
> rev_comm),snapshot()
> 
> any thought?
> 

With the above I was trying to implement something close to your
original suggestion of:

<actions> onchange(<var>)

So what I described was:

<actions>:onchange(<var>)

where <actions> would expand to action1[:action2:..]

But as I mentioned both only make sense if you only have one
onchange(<var>).

Your new version:

onchange(<var>).action1[,action2,..]

is probably better as it would allow for multiple onchange<var> and/or
other handlers.

Thanks,

Tom

