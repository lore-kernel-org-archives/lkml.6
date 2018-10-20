Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC12C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B6521470
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Cn+tkxJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJTNet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 09:34:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39190 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeJTNet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 09:34:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so16642513pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 22:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=95hQ0cElUXwFweOIF1T469SY81PeUDO4Y40jbpl1PbE=;
        b=Cn+tkxJ5NdAQN/++5+8TCtU4mQWxu6USG5aIUFg3wUidOinctPa872ZuT8UYcwwZWw
         vrq4KqnGbdMg/+91j7vU88EZm3uU2q39WZgFBbPcZ9lVmSPSDuPCwGS2tIQRAOPhje5r
         SNWPe+Hgt5b+/vAJX8IN7wTiCmQnQ6hPSQj8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95hQ0cElUXwFweOIF1T469SY81PeUDO4Y40jbpl1PbE=;
        b=st8J6lnEVBLh6uF+VZ67yjzwOffMfBzj3v330lZezaAyKdOcWX3rc9TDyEwafoCWBD
         fxEsLI7SRMldTRE5U79+7TZe8bk5tjGny7JCUbo5dfrxmAFYEEdGFS4Gvn9MnaA2kdNo
         aqAvtxCvsnj3ow49CDuleiyUsjkGMgiiDLOsQkVd1L1TqumO7S5lJCNLpj8uNFrG8k8z
         d7jz56Lq6pFEShI443L8o0ytOjOK1xlk3fiWogBCV9IVfY9UUAAB04lRJspB4NY2iNY+
         G6hMmcwSBlILW240aIUxMbI5/6d7xay2uPtASkQF6pyKHaUB/Oh3c5mM08CnxItaQfnR
         o79A==
X-Gm-Message-State: ABuFfoiI7I8VY8OccaCI19aZA33RoQQz/VdC64H/c0nAiPMZX6/A0NGB
        CbJ4Eq8ukeOF7XhPhLzkC0FgtA==
X-Google-Smtp-Source: ACcGV60BjNR7T2eblvW3CZW/Fp3xTPtdBQed9VL0H4p7RqCcWRdGjRg/5U5wJA38eTl9H0QTiCFK3Q==
X-Received: by 2002:a62:cd8a:: with SMTP id o132-v6mr4677308pfg.12.1540013137550;
        Fri, 19 Oct 2018 22:25:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x15-v6sm38945452pfd.27.2018.10.19.22.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 22:25:36 -0700 (PDT)
Date:   Fri, 19 Oct 2018 22:25:35 -0700
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
Message-ID: <20181020052535.GA155509@joelaf.mtv.corp.google.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> Hi,
> 
> This patch series adds Event tracing support to pstore and is continuation
> to the RFC patch introduced to add a new tracing facility for register
> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> a separate framework to trace register accesses and use existing framework
> like tracepoints, I have moved from RFC. Details of the RFC in link below:
> 
> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/
> 
> MSR tracing example given by Steven was helpful in using tracepoints for
> register accesses instead of using separate trace. But just having these
> IO traces would not help much unless we could have them in some persistent
> ram buffer for debugging unclocked access or some kind of bus hang or an
> unexpected reset caused by some buggy driver which happens a lot during
> initial development stages. By analyzing the last few entries of this buffer,
> we could identify the register access which is causing the issue.

Hi Sai,

I wanted to see if I could make some time to get your patches working. We are
hitting usecases that need something like this as well. Basically devices
hanging and then the ramdump does not tell us much, so in this case pstore
events can be really helpful. This usecase came up last year as well.

Anyway while I was going through your patches, I cleaned up some pstore code
as well and I have 3 more patches on top of yours for this clean up. I prefer
we submit the patches together and sync our work together so that there is
least conflict.

Here's my latest tree:
https://github.com/joelagnel/linux-kernel/commits/pstore-events
(note that I have only build tested the patches since I just wrote them and
its quite late in the night here ;-))

thanks,

- Joel

