Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35958ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF34D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF34D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJSXSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSXSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:18:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F278220869;
        Fri, 19 Oct 2018 15:12:06 +0000 (UTC)
Date:   Fri, 19 Oct 2018 11:12:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181019111205.5c8e98e8@gandalf.local.home>
In-Reply-To: <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
        <20181016141610.639b9000@gandalf.local.home>
        <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
        <20181016144123.24c47b38@gandalf.local.home>
        <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
        <20181016150328.3450d718@gandalf.local.home>
        <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
        <20181017223334.29ca2837@vmware.local.home>
        <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
        <20181018091706.62310b38@gandalf.local.home>
        <20181019041740.GB141835@joelaf.mtv.corp.google.com>
        <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
        <20181019095122.0f1c0946@gandalf.local.home>
        <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 20:18:19 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:


> > You said that if you add 'ftrace_filter=msm_read' to the command line,
> > it still crashes?
> > 
> > So only tracing that function we have an issue, right?
> >   
> 
> Tracing msm_read does cause the crash, but that is not the only one 
> causing the crash because even after "ftrace_notrace=msm_read" the board 
> crashes which is why I suspect msm earlycon and not ftrace.

I'm saying there's a combination of the two. Because when ftrace is not
involved, early con doesn't crash.

I would focus on why earlycon crashes when only msm_read is traced.
That should help narrow down the cause.

What we know is:

	earlycon -> boots

	ftrace=function -> boots

 	earlycon ftrace=function ftrace_filter=msm_read -> crashes

If we remove the "ftrace=function ftrace_filter=msm_read" it boots
fine, and I'm assuming that if we just remove earlycon (keeping the
ftrace_filter), it also boots too.

Thus, ftrace tracing msm_read is causing earlycon to do something that
triggers the crash.

-- Steve

