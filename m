Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A9C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A646214AB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mMbWmvxR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kM/Prqas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A646214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHYLCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:02:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeHYLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:02:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7E256055C; Sat, 25 Aug 2018 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535181857;
        bh=e7jVJWcDYw2pbZt/HaT13VjaCVY7glP9Ej4cy7e/7Fo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mMbWmvxRziuE+1B3/1SfQfqVuI21uMltxBmOC4AZDFDzWnpVk/gAm8C9Y3HxN3SAV
         yY3kOIgvENft4pqkQmx0VrqNCRRx3hPnoKObpQ2d4u7DpXknOraKNIOvSXlvKjRZzx
         37vtXFSSzQkPyePRpOJsd/5T5LNwAJBcAoUx4LCM=
Received: from [192.168.31.253] (unknown [103.66.79.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3386C601D1;
        Sat, 25 Aug 2018 07:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535181856;
        bh=e7jVJWcDYw2pbZt/HaT13VjaCVY7glP9Ej4cy7e/7Fo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kM/PrqasvGPBpJ5sLmVPxsKpqnf4Bxab/tfn9dxOqBp92YHGHd79i6Z8UZUMkvhVu
         22LrIaSRBYwDwhuCdHrKAaFWqysOIueoQwiKUMZNZDJrX8IbAznwhafBZ69EV0RhbH
         NIumpSxJG0i6dRd3X3E6gwpq51Nx/A9gje8GQh80=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3386C601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
 <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
Date:   Sat, 25 Aug 2018 12:54:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/2018 8:59 PM, Kees Cook wrote:
> On Fri, Aug 24, 2018 at 7:45 AM, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> read/write{b,w,l,q} are typically used for reading from memory
>> mapped registers, which can cause hangs if accessed
>> unclocked. Tracing these events can help in debugging
>> various issues faced during initial development.
>>
>> We log this trace information in persistent ram buffer which
>> can be viewed after reset.
>>
>> We use pstore_rtb_call() to write the RTB log to pstore.
>> RTB buffer size is taken from ramoops dt node with additional
>> property called rtb-size.
>>
>> For reading the trace after mounting pstore, rtb-ramoops entry
>> can be seen in /sys/fs/pstore/ as in below sample output.
>>
>> Sample output of tracing register reads/writes in drivers:
>>
>>   # mount -t pstore pstore /sys/fs/pstore
>>   # tail /sys/fs/pstore/rtb-ramoops-0
>>   [LOGK_READ ] ts:36468476204  data:ffff00000800d0fc  <ffff0000084e9ee0>  gic_check_gicv2+0x58/0x60
>>   [LOGK_WRITE] ts:36468477715  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>>   [LOGK_READ ] ts:36468478548  data:ffff00000800d000  <ffff0000084e9fd8>  gic_cpu_if_up+0xf0/0x110
>>   [LOGK_WRITE] ts:36468480319  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>>   [LOGK_READ ] ts:36468481048  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468482923  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>   [LOGK_READ ] ts:36468483184  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468485215  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>   [LOGK_READ ] ts:36468486309  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468488236  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>
>> Output has below 5 fields:
>>
>>   * Log type, Timestamp, Data from caller which is the address of
>>     read/write{b,w,l,q}, Caller ip and Caller name.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> As this is a tracing-like method, could this instead be added to
> ftrace? That would mean it could reuse all the ftrace tools and you'd
> get pstore storage for free.
> 

Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not 
sure why and how it is filtered out because I do not see any notrace 
flag in those functions, maybe that whole directory is filtered out.
So adding this functionality to ftrace would mean removing the notrace 
for these functions i.e., something like using 
__raw{read,write}{b,l,w,q}() as the available filter functions. Also 
pstore ftrace does not filter functions to trace I suppose?

Coming to the reason as to why it would be good to keep this separate 
from ftrace would be:
* Ftrace can get ip and parent ip, but suppose we need extra data (field 
data) as in above sample output we would not be able to get through ftrace.

* Although this patch is for tracing register read/write, we can easily
add more functionality since we have dynamic_rtb api which can be hooked 
to functions and start tracing events(IRQ, Context ID) something similar 
to tracepoints.
Initially thought of having tracepoints for logging register read/write 
but I do not know if we can export tracepoint data to pstore since the 
main usecase is to debug unknown resets and hangs.

* This can be something similar to mmiotrace in x86 and kept seperate 
from function tracer.

Thanks,
Sai Prakash
