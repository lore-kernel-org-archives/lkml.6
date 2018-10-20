Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22381C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0ED2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bh/kc1mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0ED2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJUAiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:38:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeJUAiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:38:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so17205225plr.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8F3M6b4IChNzSESlZQJagl85VYvRdNHyowGbl1Xuu4=;
        b=Bh/kc1mxZw8WFca127OX8MJO5lSN+ZXqTKFmhqS/CXGJ1Fz23iaYhwARoJVE2FMDo4
         XU3ukuEB/3G5/ljk4xqQtCkobqwJLOKGyvL3LDPZ7x8f5fL6VwG1sPg7XxizcX2NHYpo
         R5g2gWcLXWicEFwVf5yY+dAmJfZtGzI3IMDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8F3M6b4IChNzSESlZQJagl85VYvRdNHyowGbl1Xuu4=;
        b=ZGJrk4ndDh49hn6OBred5bDXR1tfPMja9a4+8dmrZSnhZu0KzMUX+LqDIa4BzEMr9T
         QApk7a6sp/2kdPZYnbThA+TnsYPK7K/kGUP+/efN7c7jTLmNWVNHC5rvHrUO80B4rMyc
         bYd+50A4PEds7boLEUX6x73sh3ZY9j4L5MhQA0lTA4ji9i7hTKHqYDc6NOplvEn6e+hi
         huaQ9lk9X9kELJC6lvmxZBVfI9dP+PlGHobQ4yqz3W5/VgmtS8vmTRF26JQOVufOn69I
         t4yQqQYY4J0dvdyDjg+K6il4ahZ6dhM+X73qg+VAxaZNwp3opdI9fjxhR9+VEWsazxLr
         NY+w==
X-Gm-Message-State: ABuFfoipVM/HOSK0j7APNATn5l9sSlXWh4Vqy/WmvcwYEOgUEYQonGzN
        NOGh4Cx0pJcA/w1Pde6nO+bjfQ==
X-Google-Smtp-Source: ACcGV61bqwF6I1GOMEC0nSsxBNTLLKimqtbWnVSnr6twB75n9gWgjb1YFvYFvu5O1y43t8n2RHjjJg==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1-v6mr38272117plk.162.1540052842056;
        Sat, 20 Oct 2018 09:27:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 74-v6sm42242444pfx.182.2018.10.20.09.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 09:27:20 -0700 (PDT)
Date:   Sat, 20 Oct 2018 09:27:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20181020162719.GA49955@joelaf.mtv.corp.google.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20181020052535.GA155509@joelaf.mtv.corp.google.com>
 <1d3ddbe3-d3ac-aa3e-fc9e-36739ddd0c91@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d3ddbe3-d3ac-aa3e-fc9e-36739ddd0c91@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 12:02:37PM +0530, Sai Prakash Ranjan wrote:
> On 10/20/2018 10:55 AM, Joel Fernandes wrote:
> > On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> > > Hi,
> > > 
> > > This patch series adds Event tracing support to pstore and is continuation
> > > to the RFC patch introduced to add a new tracing facility for register
> > > accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> > > a separate framework to trace register accesses and use existing framework
> > > like tracepoints, I have moved from RFC. Details of the RFC in link below:
> > > 
> > > Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/
> > > 
> > > MSR tracing example given by Steven was helpful in using tracepoints for
> > > register accesses instead of using separate trace. But just having these
> > > IO traces would not help much unless we could have them in some persistent
> > > ram buffer for debugging unclocked access or some kind of bus hang or an
> > > unexpected reset caused by some buggy driver which happens a lot during
> > > initial development stages. By analyzing the last few entries of this buffer,
> > > we could identify the register access which is causing the issue.
> > 
> > Hi Sai,
> > 
> > I wanted to see if I could make some time to get your patches working. We are
> > hitting usecases that need something like this as well. Basically devices
> > hanging and then the ramdump does not tell us much, so in this case pstore
> > events can be really helpful. This usecase came up last year as well.
> > 
> > Anyway while I was going through your patches, I cleaned up some pstore code
> > as well and I have 3 more patches on top of yours for this clean up. I prefer
> > we submit the patches together and sync our work together so that there is
> > least conflict.
> > 
> > Here's my latest tree:
> > https://github.com/joelagnel/linux-kernel/commits/pstore-events
> > (note that I have only build tested the patches since I just wrote them and
> > its quite late in the night here ;-))
> > 
> 
> Hi Joel,
> 
> Thanks for looking into this. Sure, I will be happy to sync up with you on

Thanks. And added a fourth patch in the tree too.

> this. I can test your additional patches on top of my pstore patches. BTW,
> I'm still stuck at copying binary record into pstore and then extract it
> during read time. Seems like I'm missing something.

Sure, push your latest somewhere and let me know. I'll try to get you unstuck.

thanks,

 - Joel

