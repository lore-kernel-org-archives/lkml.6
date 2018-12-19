Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F9A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeLSW21 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:28:27 -0500
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:36904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728740AbeLSW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:28:27 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 17:28:26 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 1470418033CFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 22:21:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3B455181D341D;
        Wed, 19 Dec 2018 22:21:29 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: part32_cdec7f437637
X-Filterd-Recvd-Size: 5156
Received: from ip-30-183-4-93.pools.spcsdns.net (ip-66-87-124-93.spfdma.spcsdns.net [66.87.124.93])
        (Authenticated sender: rostedt@goodmis.org)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 22:21:28 +0000 (UTC)
Date:   Wed, 19 Dec 2018 17:21:26 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <b6cc5327509148fb26bfba2ca34f9c2927437707.camel@perches.com>
References: <20181219163207.792e0f97@gandalf.local.home> <b6cc5327509148fb26bfba2ca34f9c2927437707.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC][PATCH] string.h: Add strncmp_prefix() helper macro
To:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <0A30C9FF-1E99-454A-B935-AD14819DBF1C@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that I sent this as my daughter.

I'm not home now but will resend again as myself when I am.

-- Steve

On December 19, 2018 4:54:57 PM EST, Joe Perches <joe@perches.com> wrote:
>On Wed, 2018-12-19 at 16:32 -0500, Bryana Rostedt wrote:
>> A discussion came up in the trace triggers thread about converting a
>> bunch of:
>> 
>>  strncmp(str, "const", sizeof("const") - 1)
>> 
>> use cases into a helper macro. It started with:
>> 
>> #define strncmp_const(str, const) \
>> 	strncmp(str, const, sizeof(const) - 1)
>> 
>> But then Joe Perches mentioned that if a const is not used, the
>> sizeof() will be the size of a pointer, which can be bad. And that
>> gcc will optimize strlen("const") into "sizeof("const") - 1".
>> 
>> Thinking about this more, a quick grep in the kernel tree found
>several
>> (thousands!) of cases that use this construct. A quick grep also
>> revealed that there's probably several bugs in that use case. Some
>are
>> that people forgot the "- 1" (which I found) and others could be that
>> the constant for the sizeof is different than the constant (although,
>I
>> haven't found any of those, but I also didn't look hard).
>> 
>> I figured the best thing to do is to create a helper macro and place
>it
>> into include/linux/string.h. And go around and fix all the open coded
>> versions of it later.
>> 
>> I plan on only applying this patch and updating the tracing hooks for
>> this merge window. And perhaps use it to fix some of the bugs that
>were
>> found.
>> 
>> I was going to just use:
>> 
>> #define strncmp_prefix(str, prefix) \
>> 	strncmp(str, prefix, strlen(prefix))
>> 
>> but then realized that "prefix" is used twice, and will break if
>> someone does something like:
>> 
>> 	strncmp_prefix(str, ptr++);
>> 
>> So instead I check with __builtin_constant_p() to see if the second
>> parameter is truly a constant, which I use sizeof() anyway (why
>bother
>> gcc to optimize it, if we already know it's a constant), and copy the
>> parameter into a local variable and use that local variable for the
>non
>> constant part (with strlen).
>> 
>> Link:
>http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
>> 
>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> ---
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 27d0482e5e05..3dc743e3a0ba 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -14,6 +14,27 @@ extern void *memdup_user(const void __user *,
>size_t);
>>  extern void *vmemdup_user(const void __user *, size_t);
>>  extern void *memdup_user_nul(const void __user *, size_t);
>>  
>> +/*
>> + * A common way to test a prefix of a string is to do:
>> + *  strncmp(str, prefix, sizeof(prefix) - 1)
>> + *
>> + * But this can lead to bugs due to typos, or if prefix is a pointer
>> + * and not a constant. Instead use strncmp_prefix().
>> + */
>> +#define strncmp_prefix(str, prefix)					\e
>> +	({								\
>> +		int ____strcmp_prefix_ret____;				\
>> +		char *____strcmp_prefix____ = prefix;			\
>
>This creates a warning and discards any const from prefix when used
>like
>
>	static const char foo[] = "bar";
>
>	strncmp_prefix(str, foo);
>
>> +		if (__builtin_constant_p(&prefix))			\
>> +			____strcmp_prefix_ret____ =			\
>> +				strncmp(str, prefix, sizeof(prefix) - 1); \
>> +		else							\
>> +			____strcmp_prefix_ret____ =			\
>> +				strncmp(str, ____strcmp_prefix____,	\
>> +					strlen(____strcmp_prefix____));	\
>> +		____strcmp_prefix_ret____;				\
>> +	})
>> +
>
>Perhaps
>
>#define strncmp_prefix(str, prefix)					\
>({									\
>	typeof(prefix) p = (prefix);					\
>	strncmp(str, p, strlen(p));					\
>})

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
