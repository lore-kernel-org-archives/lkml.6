Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF50AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E9B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D8DAm25o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oPMeRMKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E9B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeIRBMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:12:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRBMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:12:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21F1960C54; Mon, 17 Sep 2018 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537213428;
        bh=9Vd6kliHS+GxDvROhrELPpl3K9gR/Xr9YdSczQC2Np4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D8DAm25oyq2HsQEQqrgIVKZTckbKMMwgXv39rV6BZ3Yo39YGimPeJEJZPx1eqPYBB
         DgPdEO3rc3fA0lIO8UwRJ/bpvQPCqBzGY1ex6Upbm+Y57Q0IAfkRoj8ck1aFZNfKQp
         L+uoEfmjMTegKeRmkn0nh24IEcBXLWmghJmA8JLA=
Received: from [192.168.43.47] (unknown [27.59.117.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2D50602A7;
        Mon, 17 Sep 2018 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537213427;
        bh=9Vd6kliHS+GxDvROhrELPpl3K9gR/Xr9YdSczQC2Np4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oPMeRMKPEizLi0RgMV10g9nadOTKmkZyuF/3XEfKLO9oIWzDd9zyi7vrbgccI3UjA
         eztVTSmwRTZFQuyEcEj3Di7zWqpSAIMQGf+oUpmYk3VU/ZEpicJq0jOLTM8MprM+kU
         tTk4N7RiqD60rORSZRntqS4xTVmokZSCiRi9kY20=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2D50602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Stephen Boyd <sboyd@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
 <153720590027.119890.15984895820368075914@swboyd.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <03d47d84-a237-a94e-04ee-4447d8620697@codeaurora.org>
Date:   Tue, 18 Sep 2018 01:13:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153720590027.119890.15984895820368075914@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 11:08 PM, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2018-09-11 03:46:01)
>> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
>>> +void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
>>> +{
>>> +     struct trace_iterator *iter;
>>> +     struct trace_seq *s;
>>> +     struct trace_event_call *event_call;
>>> +     struct pstore_record record;
>>> +     struct trace_event *event;
>>> +     struct seq_buf *seq;
>>> +     unsigned long flags;
>>> +
>>> +     if (!psinfo)
>>> +             return;
>>> +
>>> +     if (unlikely(oops_in_progress))
>>> +             return;
>>> +
>>> +     pstore_record_init(&record, psinfo);
>>> +     record.type = PSTORE_TYPE_EVENT;
>>> +
>>> +     iter = kmalloc(sizeof(*iter), GFP_KERNEL);
>>> +     if (!iter)
>>> +             return;
>>> +
>>> +     event_call = fbuffer->trace_file->event_call;
>>> +     if (!event_call || !event_call->event.funcs ||
>>> +         !event_call->event.funcs->trace)
>>> +             goto fail_event;
>>> +
>>> +     event = &fbuffer->trace_file->event_call->event;
>>> +
>>> +     spin_lock_irqsave(&psinfo->buf_lock, flags);
>>> +
>>> +     trace_seq_init(&iter->seq);
>>> +     iter->ent = fbuffer->entry;
>>> +     event_call->event.funcs->trace(iter, 0, event);
>>> +     trace_seq_putc(&iter->seq, 0);
>>> +
>>> +     if (seq->size > psinfo->bufsize)
>>> +             seq->size = psinfo->bufsize;
>>> +
>>> +     s = &iter->seq;
>>> +     seq = &s->seq;
>>> +
>>> +     record.buf = (char *)(seq->buffer);
>>> +     record.size = seq->len;
>>> +     psinfo->write(&record);
>>> +
>>> +     spin_unlock_irqrestore(&psinfo->buf_lock, flags);
>>> +
>>> +fail_event:
>>> +     kfree(iter);
>>> +}
>>> +
>>>
>>
>> When tracing sched events on sdm845 mtp, I hit below bug repeatedly.
>> Seems like pstore_event_call can be called in atomic context.
>> I will respin the below fix in next version of the patch.
>> Reviews on other parts would be appreciated, thanks.
>>
>> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
>> index d47dc93ac098..a497cf782ee8 100644
>> --- a/fs/pstore/ftrace.c
>> +++ b/fs/pstore/ftrace.c
>> @@ -73,6 +73,7 @@ void notrace pstore_event_call(struct
>> trace_event_buffer *fbuffer)
>>           struct trace_event *event;
>>           struct seq_buf *seq;
>>           unsigned long flags;
>> +       gfp_t gfpflags;
>>
>>           if (!psinfo)
>>                   return;
>> @@ -83,7 +84,9 @@ void notrace pstore_event_call(struct
>> trace_event_buffer *fbuffer)
>>           pstore_record_init(&record, psinfo);
>>           record.type = PSTORE_TYPE_EVENT;
>>
>> -       iter = kmalloc(sizeof(*iter), GFP_KERNEL);
>> +       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC :
>> GFP_KERNEL;
>> +
>

Hi Stephen

Thanks for the comments.

> Do you need to allocate at all? Can you throw the iter on the stack?
> 

Yes since we need to copy the contents to pstore buffer.

> Using in_atomic() and irqs_disabled() to figure out if an atomic or a
> non-atomic allocation should be used is not a good solution.
> 

I took reference from a similar use by graph_trace_open() which can be 
called in atomic context via ftrace_dump(). I am open to correct this if 
there is some other way.

Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
