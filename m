Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE4120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE4120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeGYPRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbeGYPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:17:34 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B2F20882;
        Wed, 25 Jul 2018 14:05:43 +0000 (UTC)
Date:   Wed, 25 Jul 2018 10:05:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Artem Savkov <asavkov@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix trace_probe flags in enable_trace_kprobe
Message-ID: <20180725100541.36f27954@gandalf.local.home>
In-Reply-To: <20180725135632.zmjq7cuqc7eshpsh@treble>
References: <20180725102826.8300-1-asavkov@redhat.com>
        <20180725135632.zmjq7cuqc7eshpsh@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 08:56:32 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Jul 25, 2018 at 12:28:26PM +0200, Artem Savkov wrote:
> > If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> > it returns an error, but does not unset the tp flags it set previosly.  
> 
> "previously"

I tentatively added this to my queue. I updated the subject as:

 tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure

But yeah, that needs to be fixed.

> 
> > @@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> >  		else
> >  			ret = enable_kprobe(&tk->rp.kp);
> >  	}
> > +
> > +	if (ret) {
> > +		if (file) {
> > +			list_del(&link->list);  
> 
> Should this be list_del_rcu(), since it was added to the list with
> list_add_tail_rcu()?
> 

Good catch. Yes, that should be list_del_rcu().

Artem,

Can you send a v2 with the changes.

Thanks,

-- Steve
