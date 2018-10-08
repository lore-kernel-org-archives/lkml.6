Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51035C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05854205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kIlp2bKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05854205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJIFy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:54:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeJIFy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:54:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5-v6so10672203plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bYzzi5MAcjQa5WZClYwFP2fAXqStDW8Tqx0hQxhWph4=;
        b=kIlp2bKZARwz7YO+jgbsx+H22BE31XCqrotiGbAoM6ni890/q+dJunbYGkEnDPwi1v
         V6PRfSTC00uG36tCcYJ+ljh/kSJh7PvkCr9A579qFSdQUcvlesU7CvMb49buL/cR98Wt
         JfO4L8EMTvzPNn4BZ76o5lw8rGX7ngNRR54ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bYzzi5MAcjQa5WZClYwFP2fAXqStDW8Tqx0hQxhWph4=;
        b=YMgmcikkoTwDWJHQn6s15/n5CtrxPCDgw/Ia0heZLSfEp1R76GpP/4/UWrLs4YTeMo
         2J18caVBiEgEGb3p09tPm/+oYQQB1ChXyJqs18HfgYSOzP9KaVkLZO+e5pX9J4Uzoh3X
         S9ap1mKCHS5h7CEDo2TcV1P0RuVEYYhGKeiXWwh60JtyUmLtTLYCOf5Y/lQACbXjcPFR
         p3Ybu7h2Ace+VKHMWDKYF6gCma6JvREQsmHNxd+AQesYkFWhkHuK2KOc1OhQS2/5i426
         IIOqHWitpGpsZ4be8SyiwQy87O+qrHIEU1iJNMaSv2EDIxjSOpBZ4K0cRxtxixPolcjG
         DEDA==
X-Gm-Message-State: ABuFfog0oTDfR8Yv/VQkqvrePvzkMQXimm/0cxdiJ7eQuKERs4ATlGRj
        3sF2qFEx1yjecnyVSrUugeFPJA==
X-Google-Smtp-Source: ACcGV62eB8LL+sOjitmyyTtyrGuSvuG+c3+iyrI7nI+CMW+cuEYJRH+MyZ0iwk5o4a2y2Z7eCz49bQ==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr25071044pla.272.1539038459969;
        Mon, 08 Oct 2018 15:40:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id l26-v6sm27258702pfg.161.2018.10.08.15.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 15:40:57 -0700 (PDT)
Date:   Mon, 8 Oct 2018 15:40:56 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>, tsoni@codeaurora.org,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Jason Baron <jbaron@akamai.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-team@android.com, Colin Cross <ccross@android.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
Message-ID: <20181008224056.GA213420@joelaf.mtv.corp.google.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
 <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
 <20181008103659.5bc14b28@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008103659.5bc14b28@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:36:59AM -0400, Steven Rostedt wrote:
> On Mon, 8 Oct 2018 19:46:15 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> > Hi Joel,
> > 
> > Sorry for the long delay in updating this thread.
> > But I just observed one weird behaviour in ftrace-ramoops when I was 
> > trying to use binary record instead of rendering text for event-ramoops.
> > 
> > Even though we set the ftrace-size in device tree for ramoops, the 
> > actual ftrace-ramoops record seems to have more records than specified size.
> > Is this expected or some bug?
> 
> If ftrace-ramoops is using logic similar to the ftrace ring buffer,
> then yes, it will be able to store more events than specified. The
> ftrace ring buffer is broken up into pages, and everything is rounded
> up to the nearest page (note, the data may be smaller than a page,
> because each page also contains a header).

In the pstore code, the pages are contiguous. The platform drivers for that
platform configure 'ftrace-size' which is in bytes. That is further divided
by the number of CPUs. The records from all the buffers are then merged at read time.

Each function trace record is of type:
struct pstore_ftrace_record {
        unsigned long ip;
        unsigned long parent_ip;
        u64 ts;
};

which should be 24 bytes.

But there is an ECC block (with ECC data and ECC header) added to each CPU in
this case of the backing store of the pstore being RAM (pstore backing stores
can be other media types too).

> > Below is the ftrace-ramoops size passed in dtsi for db410c and we can 
> > see that the ftrace record is more.
> > 
> > # cat /sys/module/ramoops/parameters/ftrace_size
> > 131072
> 
> I'm assuming this too is like the ftrace ring buffer, where the size is
> per cpu (and why you do a search per cpu below).
> 
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
> > 560888
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
> > 137758
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
> > 140560
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
> > 141174
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
> > 141396
> > #

That could be because you're counting text characters when you're counting.
You need to count the binary size.

> If you are using binary record, isn't this what you want? The
> ftrace_size is the size of how much binary data is stored. When you
> translate the binary into human text, the text should be bigger.
> 
> > I don't see this in console or dmesg ramoops and also with the 
> > event-ramoops which I have posted since we don't use binary record, only 
> > ftrace-ramoops uses binary record to store trace data.
> > 
> > Also regarding the warning on "event_call->event.funcs->trace()" call,
> > I see it everytime without spinlock. Also we see output_printk using 
> > spinlock when making this call. I could not find a way to pass event 
> > buffer size and allocate in pstore. Steven can give some hints with this 
> > I guess.

The spinlock warning you're talking about is this one correct?

[    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 trace_raw_output_prep+0x18/0xa0
[    1.389416] Modules linked in:
which you reported here:
https://lkml.org/lkml/2018/9/22/319

This warning happens I think because you're trying to format the events while
the trace events are being generated. You said you got this warning when you
didn't use the spinlock. I believe the spinlocking prevents such races, but
if you didn't need to format the events into text into text in the first
place, then you wouldn't need such locking at all. 

I believe ftrace doesn't have such issues because such locking is taken care
off when the trace events are formatted from the trace buffer and displayed,
but I could be wrong about that.. I'll let Steven provide more inputs about
how this warning can occur.

As a suggestion, please always provide references to the warnings you're
referring to, such as previous LKML posts or atleast the warning message so
folks know which warning you're talking about.

thanks,

 - Joel

