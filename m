Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67671C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44CF213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Al1IhW7L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dpAjkwSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44CF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJHV20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:28:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:28:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B7D0560C81; Mon,  8 Oct 2018 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539008188;
        bh=L8eCwkElQAoVaF+tgzgzoms9PXdotRcRo6vnJsuxsu0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Al1IhW7LzgMLAsEo30RQkxcTmYV8JXCPs0fWCaOifIb93JwNAu8IAGDwtOYM2siKC
         9rkwlTL7ea+YU68ZIRXatU046svBnm5RMxxXGl2amxIFMfBQaLQvNA8M+VDYOdpVC7
         xDJLQja9SQSnvlctTiOPbO8o8wtyy0PcKOk4FLTM=
Received: from [10.79.129.75] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4C886021C;
        Mon,  8 Oct 2018 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539008186;
        bh=L8eCwkElQAoVaF+tgzgzoms9PXdotRcRo6vnJsuxsu0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dpAjkwSJIcop39sMU6BnJHb2/Re3udyI9xwRIpGdAj4BHnh7byYlAXkI0ygor9j16
         0FCNlYIuM2X55/PeFG+GKCU+gI+D1AJgRRuZK1g5tqQCxxfQCLkWcwRcKWR4T/hBK5
         DPFQENFhJm7iY3AytSDQr4B2Ha0j/1ZqtSHeKaw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4C886021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go
 to pstore
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
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
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
Message-ID: <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
Date:   Mon, 8 Oct 2018 19:46:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 3:16 PM, Sai Prakash Ranjan wrote:
> On 9/26/2018 2:55 AM, Joel Fernandes wrote:
>> On Sat, Sep 8, 2018 at 1:28 PM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> Add the kernel command line tp_pstore option that will have
>>> tracepoints go to persistent ram buffer as well as to the
>>> trace buffer for further debugging. This is similar to tp_printk
>>> cmdline option of ftrace.
>>>
>>> Pstore support for event tracing is already added and we enable
>>> logging to pstore only if cmdline is specified.
>>>
>>> Passing "tp_pstore" will activate logging to pstore. To turn it
>>> off, the sysctl /proc/sys/kernel/tracepoint_pstore can have '0'
>>> echoed into it. Note, this only works if the cmdline option is
>>> used. Echoing 1 into the sysctl file without the cmdline option
>>> will have no affect.
>>>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         | 21 ++++++++
>>>   include/linux/ftrace.h                        |  6 ++-
>>>   kernel/sysctl.c                               |  7 +++
>>>   kernel/trace/Kconfig                          | 22 +++++++-
>>>   kernel/trace/trace.c                          | 51 +++++++++++++++++++
>>>   kernel/trace/trace.h                          |  7 +++
>>>   6 files changed, 112 insertions(+), 2 deletions(-)
>>>
>> [...]
>>>   config GCOV_PROFILE_FTRACE
>>>          bool "Enable GCOV profiling on ftrace subsystem"
>>>          depends on GCOV_KERNEL
>>> @@ -789,4 +810,3 @@ config GCOV_PROFILE_FTRACE
>>>   endif # FTRACE
>>>
>>>   endif # TRACING_SUPPORT
>>> -
>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>> index bf6f1d70484d..018cbbefb769 100644
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -73,6 +73,11 @@ struct trace_iterator *tracepoint_print_iter;
>>>   int tracepoint_printk;
>>>   static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
>>>
>>> +/* Pipe tracepoints to pstore */
>>> +struct trace_iterator *tracepoint_pstore_iter;
>>> +int tracepoint_pstore;
>>> +static DEFINE_STATIC_KEY_FALSE(tracepoint_pstore_key);
>>> +
>>>   /* For tracers that don't implement custom flags */
>>>   static struct tracer_opt dummy_tracer_opt[] = {
>>>          { }
>>> @@ -238,6 +243,14 @@ static int __init set_tracepoint_printk(char *str)
>>>   }
>>>   __setup("tp_printk", set_tracepoint_printk);
>>>
>>> +static int __init set_tracepoint_pstore(char *str)
>>> +{
>>> +       if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
>>> +               tracepoint_pstore = 1;
>>> +       return 1;
>>> +}
>>> +__setup("tp_pstore", set_tracepoint_pstore);
>>> +
>>>   unsigned long long ns2usecs(u64 nsec)
>>>   {
>>>          nsec += 500;
>>> @@ -2376,11 +2389,45 @@ int tracepoint_printk_sysctl(struct ctl_table 
>>> *table, int write,
>>>          return ret;
>>>   }
>>>
>>> +static DEFINE_MUTEX(tracepoint_pstore_mutex);
>>> +
>>> +int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
>>> +                            void __user *buffer, size_t *lenp,
>>> +                            loff_t *ppos)
>>> +{
>>> +       int save_tracepoint_pstore;
>>> +       int ret;
>>> +
>>> +       mutex_lock(&tracepoint_pstore_mutex);
>>> +       save_tracepoint_pstore = tracepoint_pstore;
>>> +
>>> +       ret = proc_dointvec(table, write, buffer, lenp, ppos);
>>> +
>>> +       if (!tracepoint_pstore_iter)
>>> +               tracepoint_pstore = 0;
>>> +
>>> +       if (save_tracepoint_pstore == tracepoint_pstore)
>>> +               goto out;
>>> +
>>> +       if (tracepoint_pstore)
>>> +               static_key_enable(&tracepoint_pstore_key.key);
>>> +       else
>>> +               static_key_disable(&tracepoint_pstore_key.key);
>>> +
>>> + out:
>>> +       mutex_unlock(&tracepoint_pstore_mutex);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>   void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>>>   {
>>>          if (static_key_false(&tracepoint_printk_key.key))
>>>                  output_printk(fbuffer);
>>>
>>> +       if (static_key_false(&tracepoint_pstore_key.key))
>>> +               pstore_event_call(fbuffer);
>>
>> Can you not find a way to pass the size of the even record here, to
>> pstore? Then you can directly allocate and store the binary record in
>> pstore itself instead of rendering and storing the text in pstore
>> which will be more space (and I think time) efficient. I also think if
>> you do this, then you will not need to use the spinlock in the pstore
>> (which AIUI is preventing the warning you're seeing in the
>> event_call->event.funcs->trace() call).
>>
> 
> Right, I can check this out.
> 

Hi Joel,

Sorry for the long delay in updating this thread.
But I just observed one weird behaviour in ftrace-ramoops when I was 
trying to use binary record instead of rendering text for event-ramoops.

Even though we set the ftrace-size in device tree for ramoops, the 
actual ftrace-ramoops record seems to have more records than specified size.
Is this expected or some bug?

Below is the ftrace-ramoops size passed in dtsi for db410c and we can 
see that the ftrace record is more.

# cat /sys/module/ramoops/parameters/ftrace_size
131072
#
# cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
560888
#
# cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
137758
#
# cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
140560
#
# cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
141174
#
# cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
141396
#

I don't see this in console or dmesg ramoops and also with the 
event-ramoops which I have posted since we don't use binary record, only 
ftrace-ramoops uses binary record to store trace data.

Also regarding the warning on "event_call->event.funcs->trace()" call,
I see it everytime without spinlock. Also we see output_printk using 
spinlock when making this call. I could not find a way to pass event 
buffer size and allocate in pstore. Steven can give some hints with this 
I guess.

Steven Rostedt gave some reviews about using raw_spinlocks for this call 
earlier in this thread. So is it right to not use spinlocks for trace 
events?

One difference I see in ftrace-ramoops and event-ramoops is that 
ftrace-ramoops  is not started on boot and event-ramoops logging can be 
enabled from boot (late initcall however).

Do let me know if you have any way to avoid this warning which is a race 
I think without spinlock.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
