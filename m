Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99768205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99768205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJQAso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbeJQAso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:48:44 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B97205C9;
        Tue, 16 Oct 2018 16:57:23 +0000 (UTC)
Date:   Tue, 16 Oct 2018 12:57:21 -0400
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
Message-ID: <20181016125721.236ada82@gandalf.local.home>
In-Reply-To: <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 22:05:23 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 10/16/2018 8:59 PM, Steven Rostedt wrote:
> > On Tue, 16 Oct 2018 17:08:25 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >   
> >> Hi,
> >>
> >> On dragonboard 410c, with "ftrace=function" boot args, the console
> >> output slows down and board resets without any backtrace as below. This
> >> is tested on latest kernel and seems to exist even in older kernels as well.  
> > 
> > So this only happens when ftrace=function is on the boot console.
> >   
> 
> Yes. If I do not use boot console, target does not crash.
> 


> > 
> > Does function tracing work after boot up? That is, without the
> > ftrace=function, can you do:
> > 
> >   echo function > /sys/kernel/debug/tracing/current_tracer
> > 
> > without any issue?
> >   
> 
> Yes ftrace in general works without any issue. I have also tested on 
> db820c and sdm845 where "ftrace=function" works fine. I am seeing this 
> issue only on db410c board.

OK, can you add to the command line:

 ftrace=function ftrace_filter=*schedule*

to see if it's a specific function that may be causing the issue (but
hopefully it's not one of the scheduling functions that caused it).

> 
> >>
> >> One more thing is for pstore dmesg-ramoops, I had to change
> >> late_initcall to postcore_initcall which brings the question as to why
> >> we changed to late_initcall?
> >> Simple git blame shows to support crypto compress api, but is it really
> >> helpful? A lot of boottime issues can be caught with pstore enabled at
> >> postcore_initcall rather than late_initcall, this backtrace
> >> is just one example. Is there any way we could change this?  
> > 
> > Does it break if the crypto is not initialized? Perhaps add a command
> > line flag to have it happen earlier:
> >  
> 
> I didnt see any breakage, have been using ramoops with postcore_initcall 
> for sometime now.
> 
> >   ramoops=earlyinit
> > 
> > and add a postcore_initcall that checks if that flag is set, and if so,
> > it does the work then, and the late_initcall() will do nothing.
> > 
> > That way, you can still have unmodified kernels use pstore when it
> > crashes at boot up.
> >   
> 
> Sounds good.

Great, I guess you can write a patch to do that ;-)

-- Steve

