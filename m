Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7054C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DEE20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gTkLYS7L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OS33N7Yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DEE20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeH1RJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:09:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeH1RJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:09:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D1ED606FC; Tue, 28 Aug 2018 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535462264;
        bh=1q2XtT+Fu8e0S7sRqvJI5MUqggli6D+EQy06UoSsDTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gTkLYS7LOB46w5UieyY2jqDSFtH6RCM7UmUOH9bBbeu/n30ccBMnYRIzvHTb9yloi
         CfddQCzKuZoyOAPcCyHa17THcqzuY0iWq8SoM8rsg990kvlzm99BxdBceET2jZ+uTP
         PxgHcdnSKkPksrf8pplBAqVze6jxhHAbgahSZJx0=
Received: from [10.79.128.245] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFEA060241;
        Tue, 28 Aug 2018 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535462262;
        bh=1q2XtT+Fu8e0S7sRqvJI5MUqggli6D+EQy06UoSsDTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OS33N7Yku0QRpjI5JO+C+DNvfG9veb32p6uwIpnVxxsmVoThCVXzeiTu9K5eXg0Wd
         mUqcAxQxgOCbbV1Hq2qKULjAP9Wm7WRhFunnUNs6vObHO1BHA30VIp9apcqAIpxowe
         zudKFAEMXEXcz1VQUVSNyD5ZIBI+IqoapEN1h2hA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFEA060241
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
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
 <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
 <20180827121530.525299e3@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <369f384b-c419-99d8-c0a4-3ed38f1dd0f4@codeaurora.org>
Date:   Tue, 28 Aug 2018 18:47:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827121530.525299e3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2018 9:45 PM, Steven Rostedt wrote:
> On Sat, 25 Aug 2018 12:54:07 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> 
>> Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not
>> sure why and how it is filtered out because I do not see any notrace
>> flag in those functions, maybe that whole directory is filtered out.
>> So adding this functionality to ftrace would mean removing the notrace
>> for these functions i.e., something like using
>> __raw{read,write}{b,l,w,q}() as the available filter functions. Also
>> pstore ftrace does not filter functions to trace I suppose?
> 
> It's not traced because it is inlined. Simply make the __raw_read
> function a normal function and it will be traced. And then you could
> use ftrace to read the function.
> 
> If this has to be per arch, you can register your callback with the
> REGS flags, and pt_regs will be passed to your callback function you
> attached to __raw_read*() as if you inserted a break point at that
> location, and you can get any reg data you want there.
> 
>

Thank you very much for the information Steven. Ok so we can get 
function parameters with pt_regs.

>>
>> Coming to the reason as to why it would be good to keep this separate
>> from ftrace would be:
>> * Ftrace can get ip and parent ip, but suppose we need extra data (field
>> data) as in above sample output we would not be able to get through ftrace.
> 
> As mentioned above, you can get regs (and ftrace is being expanded now
> to get parameters of functions).
> 
You mean there is another way to get parameters other than regs?

>>
>> * Although this patch is for tracing register read/write, we can easily
>> add more functionality since we have dynamic_rtb api which can be hooked
>> to functions and start tracing events(IRQ, Context ID) something similar
>> to tracepoints.
>> Initially thought of having tracepoints for logging register read/write
>> but I do not know if we can export tracepoint data to pstore since the
>> main usecase is to debug unknown resets and hangs.
> 
> I don't know why not? We have read/write tracepoints for
> read/write_msr() calls in x86.
> 
> Anything can add a hook to the callback of the tracepoints, and use
> that infrastructure instead of creating yet another dynamic code
> modification infrastructure.
> 
Thanks for pointing out to read/write_msr, I checked it and was able to 
implement something similar for arm64. But still can we export 
tracepoint data to pstore because we need to debug reset cases and for 
that pstore is of real importance?. If so then it would be great to have 
various events logged into pstore which can be a lot of help for debugging.

Also with the current dynamic filtering of read/write(PATCH 3/3), it is 
a lot easier to filter register read/write since we use dynamic debug 
framework which provides file, function and line level filtering 
capacity. Maybe if we can add something like this to trace events it 
would be better?

- Sai Prakash
