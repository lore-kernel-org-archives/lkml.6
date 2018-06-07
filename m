Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +U/VNK6gGFtUTQAAmS7hNA
	; Thu, 07 Jun 2018 03:10:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 86BB0608B8; Thu,  7 Jun 2018 03:10:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DF75D605BD;
	Thu,  7 Jun 2018 03:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF75D605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeFGDK1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:10:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60407 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752800AbeFGDK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:10:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 447A42B42A6F4;
        Thu,  7 Jun 2018 11:10:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Thu, 7 Jun 2018
 11:10:16 +0800
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: Andy Lutomirski <luto@amacapital.net>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com>
 <5B17A6B6.70300@huawei.com>
 <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com>
 <5B1892F5.9000206@huawei.com>
 <A95BD803-E0E2-4E49-B3EF-D056F1D69883@amacapital.net>
CC: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, <yaomin2@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B18A20C.3060509@huawei.com>
Date: Thu, 7 Jun 2018 11:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A95BD803-E0E2-4E49-B3EF-D056F1D69883@amacapital.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/7 10:39, Andy Lutomirski wrote:
> 
> 
>> On Jun 6, 2018, at 7:05 PM, Leizhen (ThunderTown) <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>>> On 2018/6/7 1:01, Andy Lutomirski wrote:
>>> On Wed, Jun 6, 2018 at 2:18 AM Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>>
>>>> I found that glibc has already dealt with this case. So this issue must have been met before, should it be maintained by libc/user?
>>>>
>>>>        if (GLRO(dl_sysinfo_dso) == NULL)
>>>>        {
>>>>                kact.sa_flags |= SA_RESTORER;
>>>>
>>>>                kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
>>>>                        ? &restore_rt : &restore);
>>>>        }
>>>>
>>>>
>>>>> On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
>>>>>
>>>>>
>>>>>> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>>>>>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, the rt_sigaction01 test case from ltp_2015 failed.
>>>>>> The test case source code please refer to the attachment, and the output as blow:
>>>>>>
>>>>>> -----------------
>>>>>> ./rt_sigaction01
>>>>>> rt_sigaction01    0  TINFO  :  signal: 34
>>>>>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0
>>>>>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>>>>>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
>>>>>>
>>>>>> Segmentation fault
>>>>>> ------------------
>>>>>>
>>>>>>
>>>>>> Is this the desired result? In function ia32_setup_rt_frame, I found below code:
>>>>>>
>>>>>>     if (ksig->ka.sa.sa_flags & SA_RESTORER)
>>>>>>             restorer = ksig->ka.sa.sa_restorer;
>>>>>>     else
>>>>>>             restorer = current->mm->context.vdso +
>>>>>>                     vdso_image_32.sym___kernel_rt_sigreturn;
>>>>>>     put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>>>>>
>>>>>> Because the vdso is disabled, so current->mm->context.vdso is NULL, which cause the result of frame->pretcode invalid.
>>>>>>
>>>>>> I'm not sure whether this is a kernel bug or just an error of test case itself. Can anyone help me?
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>> I can't tell from your email what you're testing, what behavior you
>>> expect, and what you saw.  A program that sets up a signal handler
>>> without supplying a restorer will not work if the vDSO is off, and
>>> this is by design.
>> OK, so that the user should take care whether the vDSO is disabled by itself or not, and use different strategies to process it appropriately, like glibc.
>>
>>>
>>> (FWIW, there is a very longstanding libc bug that causes this case to
>>> get severely screwed up if the user's SS is not the expected value,
>>> and that bug was just fixed very recently.  But I doubt this is what
>>> you're seeing.)
>>>
>>> I suppose we could improve the kernel to at least push NULL instead of
>>> some random address a bit above 0, but it'll still crash.
>> Should we add a warning? Which may help the user to aware this error in time.
>>
> 
> It’s entirely valid to have a non working restorer if you never plan to return from a signal handler. And anyone who writes their own libc should be able to figure this out on their own, I think.

OK. Thanks a lot.

> 
>>>
>>> .
>>>
>>
>> -- 
>> Thanks!
>> BestRegards
>>
> 
> .
> 

-- 
Thanks!
BestRegards
