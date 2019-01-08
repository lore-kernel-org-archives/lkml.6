Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E62070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JE1daqmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfAHBdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:33:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39017 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAHBdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:33:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so2744188qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lcz5KfuAyBOzpAe0BCTTyF2ULlYw5X8eZKWd0j89fGk=;
        b=JE1daqmw/z/WyCIBQ7mBT250iCz++GSjP5ZeV9ix5nrB881B428Qrp+3nzesJop82E
         K4r9uPp8ALIOBH2EL+acywnUSKGNoS+SYyCdZrVjLP3l4EwgZlslnFrSh1+a3mKfQY8u
         aHo4zC0pYuknGfFpx4bWHB50lRU4f4IYTr0OlmHVU20R7RU4C2Ndx+SGn3nPuwe6Ujia
         qj7q6FWY+a/uW4GM1XaApeuz7lJMoSq8lVx+EYKkLU5GWRNbSxl7J5k9ZrXQqcdn9aN3
         dINpcByGpMRlFOAKYv5IL2+02zDpP2JPiRLuOYhhFGBiVO/Q2oNqlh8BQqOrzohjopKF
         I+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lcz5KfuAyBOzpAe0BCTTyF2ULlYw5X8eZKWd0j89fGk=;
        b=nBcJbDGRMAyss3AWKktnRB/JAqMUAfMHekS99+fSSIcq300nx9JNsHyY2McyiPWe8e
         xeMV5vQWVQuQJbdx9pm1W8zftrv33ga/sWFQuhcQArf5HwRU0WWpgLqnMZZfuG3quYXo
         /vJONn5mF3/n3GMBWvSkpXBPqz8iUOI/zSpaECu8AwlPVadEM7oa5ydANunWrIT2WdsE
         dSqp9wtTXNZdcs5M/oNBKY2btNclMdMkEf6yZKzhCznPG8CufbTU7Vxxhvo5Ahf2719a
         9Xk4J/+z5BJ2KtP3lCaPN5lGnsjg+JaePpAcvP17mvo4bhSZV9zbZJ2Sp7zDzFM1VjZ4
         8OTQ==
X-Gm-Message-State: AJcUukc12ChwyK8xTtOMvh4Ait+5ExKBm6ZYw4iE+t3VAh4tZk3Z9ir1
        gc+3LhJ9keWeNxyxFTTtjBCapg==
X-Google-Smtp-Source: ALg8bN43TinIE+BKwPh0E+CIlJLeCJTsogN4nvGQKY0yqoPvEoKxrQLoIX4oMgeW0tNQtqXnLN+D5Q==
X-Received: by 2002:a0c:c993:: with SMTP id b19mr59932415qvk.126.1546911202437;
        Mon, 07 Jan 2019 17:33:22 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a3sm13749491qkd.86.2019.01.07.17.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:33:22 -0800 (PST)
Subject: Re: [PATCH] signal: allow the null signal in rt_sigqueueinfo()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20190105054729.40397-1-cai@lca.pw>
 <20190107150336.4fc75d2aa20b637a259e50b3@linux-foundation.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <2960cc66-5f53-84e3-cf30-1ebee8a37beb@lca.pw>
Date:   Mon, 7 Jan 2019 20:33:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107150336.4fc75d2aa20b637a259e50b3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 6:03 PM, Andrew Morton wrote:
> On Sat,  5 Jan 2019 00:47:29 -0500 Qian Cai <cai@lca.pw> wrote:
> 
>> Running the trinity fuzzer triggered this,
>>
>> UBSAN: Undefined behaviour in kernel/signal.c:2946:7
>> shift exponent 4294967295 is too large for 64-bit type 'long unsigned
>> int'
>> [ 3752.406618]  dump_stack+0xe0/0x17a
>> [ 3752.419817]  ubsan_epilogue+0xd/0x4e
>> [ 3752.423429]  __ubsan_handle_shift_out_of_bounds+0x1d6/0x227
>> [ 3752.447269]  known_siginfo_layout.cold.9+0x16/0x1b
>> [ 3752.452105]  __copy_siginfo_from_user+0x4b/0x70
>> [ 3752.466620]  do_syscall_64+0x164/0x7ea
>> [ 3752.565030]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> This is because signo is 0 from userspace, and then it ends up calling
>> (1UL << -1) in sig_specific_sicodes(). Since the null signal (0) is
>> allowed in the spec, just deal with it accordingly.
>>
>> ...
>>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2943,7 +2943,7 @@ static bool known_siginfo_layout(unsigned sig, int si_code)
>>  	if (si_code == SI_KERNEL)
>>  		return true;
>>  	else if ((si_code > SI_USER)) {
>> -		if (sig_specific_sicodes(sig)) {
>> +		if (sig && sig_specific_sicodes(sig)) {
>>  			if (si_code <= sig_sicodes[sig].limit)
>>  				return true;
>>  		}
> 
> Maybe.
> 
> - What happens if userspace passes in si_code == -1?  

I suppose you meant sig (signo) instead of si_code which is this patch is for.
Sig can never be -1 because it is unsigned int. si_code is an int which is fine
to be -1.

in /include/uapi/asm-generic/siginfo.h,

/*
 * si_code values
 * Digital reserves positive values for kernel-generated signals.
 */
#define SI_USER		0
#define SI_KERNEL	0x80
#define SI_QUEUE	-1
#define SI_TIMER	-2
#define SI_MESGQ	-3
#define SI_ASYNCIO	-4
#define SI_SIGIO	-5
#define SI_TKILL	-6
#define SI_DETHREAD	-7
#define SI_ASYNCNL	-60

> 
> - If we are to check the validity of the userspace-provided input
>   then it would be better to do that up-front, right at the point where
>   the data is copied in from userspace.  That's better than checking it
>   several layers deep in one particular place which hit an issue.
> 

Well, the thing here is that signo 0 is a valid input, so it has to process as
further as possible for error checking if I read it correctly.

in man rt_sigqueueinfo,

"As with kill(2), the null signal (0) can be used to check if the specified
process or thread exists."

Then, in man 2 kill

"If sig is 0, then no signal is sent, but error checking is still performed;
this can be used to check for the existence of a process ID or process group ID."

Later, it will will be dealt with properly in group_send_sig_info()

if (!ret && sig)
	ret = do_send_sig_info(sig, info, p, type);

return ret;

Hence the only problem here is that sig_specific_sicodes(sig) forgot to deal
with sig 0 in the first place.
