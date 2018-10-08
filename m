Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B443C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D122085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D122085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJHVtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHVtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:49:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C66204EC;
        Mon,  8 Oct 2018 14:37:00 +0000 (UTC)
Date:   Mon, 8 Oct 2018 10:36:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
        Colin Cross <ccross@android.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
Message-ID: <20181008103659.5bc14b28@gandalf.local.home>
In-Reply-To: <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
        <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
        <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 19:46:15 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> Hi Joel,
> 
> Sorry for the long delay in updating this thread.
> But I just observed one weird behaviour in ftrace-ramoops when I was 
> trying to use binary record instead of rendering text for event-ramoops.
> 
> Even though we set the ftrace-size in device tree for ramoops, the 
> actual ftrace-ramoops record seems to have more records than specified size.
> Is this expected or some bug?

If ftrace-ramoops is using logic similar to the ftrace ring buffer,
then yes, it will be able to store more events than specified. The
ftrace ring buffer is broken up into pages, and everything is rounded
up to the nearest page (note, the data may be smaller than a page,
because each page also contains a header).

> 
> Below is the ftrace-ramoops size passed in dtsi for db410c and we can 
> see that the ftrace record is more.
> 
> # cat /sys/module/ramoops/parameters/ftrace_size
> 131072

I'm assuming this too is like the ftrace ring buffer, where the size is
per cpu (and why you do a search per cpu below).

> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
> 560888
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
> 137758
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
> 140560
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
> 141174
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
> 141396
> #
> 

If you are using binary record, isn't this what you want? The
ftrace_size is the size of how much binary data is stored. When you
translate the binary into human text, the text should be bigger.

> I don't see this in console or dmesg ramoops and also with the 
> event-ramoops which I have posted since we don't use binary record, only 
> ftrace-ramoops uses binary record to store trace data.
> 
> Also regarding the warning on "event_call->event.funcs->trace()" call,
> I see it everytime without spinlock. Also we see output_printk using 
> spinlock when making this call. I could not find a way to pass event 
> buffer size and allocate in pstore. Steven can give some hints with this 
> I guess.
> 
> Steven Rostedt gave some reviews about using raw_spinlocks for this call 
> earlier in this thread. So is it right to not use spinlocks for trace 
> events?

Correct.

> 
> One difference I see in ftrace-ramoops and event-ramoops is that 
> ftrace-ramoops  is not started on boot and event-ramoops logging can be 
> enabled from boot (late initcall however).
> 
> Do let me know if you have any way to avoid this warning which is a race 
> I think without spinlock.

I guess I need to look at that code again too.

-- Steve

