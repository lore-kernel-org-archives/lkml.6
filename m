Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B1BECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4CE2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xBMjys3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4CE2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJUNWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 09:22:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42887 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeJUNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 09:22:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so18293694pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1rzGI9IkuhiKa4GS+wm8nRkdjxf9ckjMYbv1sOdSZxA=;
        b=xBMjys3SxlJOO4eTzjyc8FXsV0lYeNW8ZcK07YXuqPzBCjYvqPDMgA+oEeW1Mebgd/
         zxOhynT+/Tiqmd9fV1Kf2FG8eGuZsLQWDtIeR+UL9rdHKTjBqMlgF7y10gat4POQPYkV
         Sa2xQVhTDBY1Lc4ZM0V1jscsWYUmrJiFEME3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1rzGI9IkuhiKa4GS+wm8nRkdjxf9ckjMYbv1sOdSZxA=;
        b=Pu9bUEurQnRF0R1BgU7Jq+Az9CmXM08w29GLmUDeb7dbiHZIAYbZklbY2LvI5H6HJ4
         i2ZWDVoBBVLTP7/LI7AvBKl+fQHkGj6GPCmkjebqt+XhZeBpEfFEVGWb9y5BJpAqVrHj
         PKy96nmLsqf7t1wbwMyHd7LBGOC0nr+T/cwF93UL8UTe2UpTm0Ftmno0Aj2Drxrvk0bD
         xj7zK+ec5bom0e9IiQDmiptKByBpmpMtJ86qIBEb9OGGduc+5MFcxQusts+tCVxEZg+S
         bVgBjbSlOWi7/Xnd2eMA2BeXMG1aFSbbudxyLWZmM8LNhzsLX/PvVmBTEJf/Xxe9TIp7
         O3IA==
X-Gm-Message-State: ABuFfojgQCk6WTOe7Ky+b8VOcPjQSWb2d6R1VFdjZ1O3fgDnBa2QHgOH
        TH9sjmxWD2XDAgqTrbZJpFTGTw==
X-Google-Smtp-Source: ACcGV63ZRQp5sofVTU02lZ2MF86vmR5H+te4ui1qvzzRDy7jHt2yht0qlskO57tLu6iSu/cSigKt8A==
X-Received: by 2002:a62:be1a:: with SMTP id l26-v6mr41722819pff.204.1540098548431;
        Sat, 20 Oct 2018 22:09:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z14-v6sm6990306pge.47.2018.10.20.22.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 22:09:07 -0700 (PDT)
Date:   Sat, 20 Oct 2018 22:09:06 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        rostedt@goodmis.org, Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>, tkjos@google.com
Subject: Re: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
Message-ID: <20181021050906.GA238354@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ec736d-bd54-5519-4b99-47dd161bc556@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 09:16:59AM +0530, Sai Prakash Ranjan wrote:
> On 10/20/2018 9:57 PM, Joel Fernandes wrote:
> > On Sat, Oct 20, 2018 at 12:02:37PM +0530, Sai Prakash Ranjan wrote:
> > > On 10/20/2018 10:55 AM, Joel Fernandes wrote:
> > > > On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> > > > > Hi,
> > > > > 
> > > > > This patch series adds Event tracing support to pstore and is continuation
> > > > > to the RFC patch introduced to add a new tracing facility for register
> > > > > accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> > > > > a separate framework to trace register accesses and use existing framework
> > > > > like tracepoints, I have moved from RFC. Details of the RFC in link below:
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/
> > > > > 
> > > > > MSR tracing example given by Steven was helpful in using tracepoints for
> > > > > register accesses instead of using separate trace. But just having these
> > > > > IO traces would not help much unless we could have them in some persistent
> > > > > ram buffer for debugging unclocked access or some kind of bus hang or an
> > > > > unexpected reset caused by some buggy driver which happens a lot during
> > > > > initial development stages. By analyzing the last few entries of this buffer,
> > > > > we could identify the register access which is causing the issue.
> > > > 
> > > > Hi Sai,
> > > > 
> > > > I wanted to see if I could make some time to get your patches working. We are
> > > > hitting usecases that need something like this as well. Basically devices
> > > > hanging and then the ramdump does not tell us much, so in this case pstore
> > > > events can be really helpful. This usecase came up last year as well.
> > > > 
> > > > Anyway while I was going through your patches, I cleaned up some pstore code
> > > > as well and I have 3 more patches on top of yours for this clean up. I prefer
> > > > we submit the patches together and sync our work together so that there is
> > > > least conflict.
> > > > 
> > > > Here's my latest tree:
> > > > https://github.com/joelagnel/linux-kernel/commits/pstore-events
> > > > (note that I have only build tested the patches since I just wrote them and
> > > > its quite late in the night here ;-))
> > > > 
> > > 
> > > Hi Joel,
> > > 
> > > Thanks for looking into this. Sure, I will be happy to sync up with you on
> > 
> > Thanks. And added a fourth patch in the tree too.


While at it, I was thinking about the problem we are trying to solve in
another way. If ftrace itself can use pages from the persistent ram store,
instead of the kernel's buddy allocator, then the ftrace ring buffer itself
could persist across a system reboot.

The clear advantage of that for Sai's pstore events work is, not having to
duplicate a lot of the ring buffer code and stuff into pstore (for the pstore
events for example, I wanted time stamps as well and ftrace's ring buffer has
some nice time management code to deal with time deltas). We already have
other ring buffers maintained in other parts of the kernel for tracing right?
So I'm a bit averse to duplicating that into pstore as well for tracing. The
other advantage of persisting the ftrace ring buffer would also mean data
from other tracers such as function-graph tracer and irqsoff tracers would
also persist and then we can also probably get rid of ftrace-in-pstore stuff
which is kind of incomplete anyway since it does not have time stamps for
recorded functions.

Steven and Kees: what do you think, is persisting ftrace ring buffer across
reboots a worthwhile idea? Any thoughts on how feasible something like that
could be, code wise? Off the top, I think the ring buffer state that ftrace
needs other than the trace data itself will also have to be persisted.

thanks,

 - Joel

