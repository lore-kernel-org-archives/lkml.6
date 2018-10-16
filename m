Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D54C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4BC21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4BC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJQBjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeJQBjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:39:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E7820645;
        Tue, 16 Oct 2018 17:48:04 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:48:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181016134803.1b9260c1@gandalf.local.home>
In-Reply-To: <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
        <20181016125721.236ada82@gandalf.local.home>
        <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 23:06:24 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 10/16/2018 10:27 PM, Steven Rostedt wrote:
> > 
> > OK, can you add to the command line:
> > 
> >   ftrace=function ftrace_filter=*schedule*
> > 
> > to see if it's a specific function that may be causing the issue (but
> > hopefully it's not one of the scheduling functions that caused it).
> >   
> 
> Target boots fine with this. So its not scheduling functions that is 
> causing it. Also I tried with ftrace_filter=*msm* just to be sure if
> tracing driver functions is causing any issue but its NOT.

OK, seems that something is being traced that shouldn't be.

When this happens after boot up, it's easy to bisect down to the
problem function. But since it's at boot up, it will take a lot longer.

I would suggest to start by going down the alphabet.

	ftrace_filter=a*
 	ftrace_filter=b*
	ftrace_filter=c*
	[...]

And at least find the letter the bad function starts with.

Note, it could be more than one function (I've had that a couple of
times), and to find that out, you can test with "ftrace_notrace". Say
you find that the problem function starts with 'x'. You can do:

	ftrace_notrace=x*

Which will trace all functions except those that start with an 'x', to
make sure it still boots.

Remember, you still need to have ftrace=function for all of this.

Once you find the letter of the function, you can try the next letter,
or perhaps come up with another method. I would say look at the
functions in /sys/kernel/debug/tracing/available_filter_functions, but
they don't list the init function (that can be traced). But you can
use /proc/kallsyms instead.

-- Steve
