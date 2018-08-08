Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F68CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC702219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XV2PMj6H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NR2bcfOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC702219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHHQti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:49:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeHHQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:49:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 419CC60B22; Wed,  8 Aug 2018 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533738582;
        bh=lRwvRV2Ws5zJRnTM/iDtTrs/DN8DMoBTydND7ur1nL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XV2PMj6Hbf0qP649bz7KzPZHGWrih0KqpPriYKQoESLewZim9m5Oyv6KCK6ngQjNd
         suiIrPdvOvoOSS8vB3jIG6X+1TwT4A39JI3fQfcYdDEXOcPOvNJO55UwUjSp/fDiph
         fOOodKzj2+2vv0+YmScfrsIiPa0nwaMCCLH9/c0U=
Received: from [192.168.31.253] (unknown [103.66.79.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C52F607C6;
        Wed,  8 Aug 2018 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533738579;
        bh=lRwvRV2Ws5zJRnTM/iDtTrs/DN8DMoBTydND7ur1nL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NR2bcfOJtYDoVs/sk5y8IJLwqhJbhKq7dihSzCDiSAp4pw8czVBM0EXGVmzINtXu1
         s1p5qjmjDRujBw5lljM3Zhus0D5EG1WK/Z9KjEgkwLJg+feJUAANSy8xMyA3gMsRaG
         gcyxbYtN78BeP45WLfNaZaH6MatMQxfJeaMXatkw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C52F607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC PATCH 3/3] dynamic_debug: Add support for dynamic register
 trace
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Cross <ccross@android.com>, Joe Perches <joe@perches.com>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
 <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
 <20180807165713.GJ21809@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <eb55098d-6825-ab50-e1e9-0d95b1e1ea14@codeaurora.org>
Date:   Wed, 8 Aug 2018 19:59:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807165713.GJ21809@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2018 10:27 PM, Will Deacon wrote:
> On Fri, Aug 03, 2018 at 07:58:44PM +0530, Sai Prakash Ranjan wrote:
>> Introduce dynamic debug filtering mechanism to register
>> tracing as dynamic_rtb() which will reduce a lot of
>> overhead otherwise of tracing all the register reads/writes
>> in all files.
>>
>> Now we can just specify the file name or any wildcard pattern
>> as any other dynamic debug facility in bootargs and dynamic rtb
>> will just trace them and the output can be seen in pstore.
>>
>> TODO: Now we use same 'p' flag but will add a separate flag for register trace
>> later.
>>
>> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
>>
>>    # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>>    # reboot -f
>>    # mount -t pstore pstore /sys/fs/pstore
>>    # cat /sys/fs/pstore/rtb-ramoops-0
>>      [LOGK_WRITEL ] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>      [LOGK_WRITEL ] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>
>> Also we add uncached_logk api to readl/writel definitions for arm64
>> as of now. This can be extended to arm as well later for tracing.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/io.h   | 93 +++++++++++++++++++++++++++++++++++
> 
> Putting all of this in the arch code, which basically duplicates everything,
> feels very wrong to me. Perhaps take a look at the ongoing work for
> instrumenting the atomics and take some inspiration from there?
> 
> Ideally, the architecture just needs to provide the low-level primivites
> (which it already does) and the core can generate instruments versions if
> required.
> 

Hi Will,

Thanks for the review. Will look at instrumented atomics implementation 
and get back. Let me know if anything else can be improved.

  - Sai Prakash
