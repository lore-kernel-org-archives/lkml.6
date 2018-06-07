Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 62qMHAeTGFtVJAAAmS7hNA
	; Thu, 07 Jun 2018 02:06:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3D51607E4; Thu,  7 Jun 2018 02:06:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB5A1607DC;
	Thu,  7 Jun 2018 02:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB5A1607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeFGCGM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:06:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932444AbeFGCGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:06:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1DEFE4B839E7;
        Thu,  7 Jun 2018 10:05:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Thu, 7 Jun 2018
 10:05:51 +0800
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: Andy Lutomirski <luto@kernel.org>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com>
 <5B17A6B6.70300@huawei.com>
 <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, <yaomin2@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B1892F5.9000206@huawei.com>
Date: Thu, 7 Jun 2018 10:05:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/7 1:01, Andy Lutomirski wrote:
> On Wed, Jun 6, 2018 at 2:18 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>> I found that glibc has already dealt with this case. So this issue must have been met before, should it be maintained by libc/user?
>>
>>         if (GLRO(dl_sysinfo_dso) == NULL)
>>         {
>>                 kact.sa_flags |= SA_RESTORER;
>>
>>                 kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
>>                         ? &restore_rt : &restore);
>>         }
>>
>>
>> On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>>>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, the rt_sigaction01 test case from ltp_2015 failed.
>>>> The test case source code please refer to the attachment, and the output as blow:
>>>>
>>>> -----------------
>>>> ./rt_sigaction01
>>>> rt_sigaction01    0  TINFO  :  signal: 34
>>>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0
>>>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>>>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
>>>>
>>>> Segmentation fault
>>>> ------------------
>>>>
>>>>
>>>> Is this the desired result? In function ia32_setup_rt_frame, I found below code:
>>>>
>>>>      if (ksig->ka.sa.sa_flags & SA_RESTORER)
>>>>              restorer = ksig->ka.sa.sa_restorer;
>>>>      else
>>>>              restorer = current->mm->context.vdso +
>>>>                      vdso_image_32.sym___kernel_rt_sigreturn;
>>>>      put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>>>
>>>> Because the vdso is disabled, so current->mm->context.vdso is NULL, which cause the result of frame->pretcode invalid.
>>>>
>>>> I'm not sure whether this is a kernel bug or just an error of test case itself. Can anyone help me?
>>>>
>>>
>>
>>
> 
> I can't tell from your email what you're testing, what behavior you
> expect, and what you saw.  A program that sets up a signal handler
> without supplying a restorer will not work if the vDSO is off, and
> this is by design.
OK, so that the user should take care whether the vDSO is disabled by itself or not, and use different strategies to process it appropriately, like glibc.

> 
> (FWIW, there is a very longstanding libc bug that causes this case to
> get severely screwed up if the user's SS is not the expected value,
> and that bug was just fixed very recently.  But I doubt this is what
> you're seeing.)
> 
> I suppose we could improve the kernel to at least push NULL instead of
> some random address a bit above 0, but it'll still crash.
Should we add a warning? Which may help the user to aware this error in time.

> 
> .
> 

-- 
Thanks!
BestRegards
