Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2007D215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007D215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeI1ArR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:47:17 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46339 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1ArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:47:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 4EAD62232F;
        Thu, 27 Sep 2018 18:27:42 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y_SIp0luZpsl; Thu, 27 Sep 2018 18:27:42 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 70E1B20EE1;
        Thu, 27 Sep 2018 18:27:03 +0000 (UTC)
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        stable <stable@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
 <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com>
 <CGME20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416@epcas4p3.samsung.com>
 <20180927092235.77282e35@vmware.local.home>
 <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
 <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
 <2bfea3f5-b251-d4b8-d03a-28b575aefae0@samsung.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <da7ed2a7-8e0f-3465-1662-e8e20735d9a6@kernel.org>
Date:   Thu, 27 Sep 2018 12:26:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bfea3f5-b251-d4b8-d03a-28b575aefae0@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 12:10 PM, Shuah Khan wrote:
> On 09/27/2018 12:02 PM, Mathieu Desnoyers wrote:
>> ----- On Sep 27, 2018, at 9:58 AM, Shuah Khan shuah.kh@samsung.com wrote:
>>
>>> On 09/27/2018 07:22 AM, Steven Rostedt wrote:
>>>> On Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>>> ----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers
>>>>> mathieu.desnoyers@efficios.com wrote:
>>>>>
>>>>>> On x86-64, the parametrized selftest code for rseq crashes with a
>>>>>> segmentation fault when compiled with -fpie. This happens when the
>>>>>> param_test binary is loaded at an address beyond 32-bit on x86-64.
>>>>>>
>>>>>> The issue is caused by use of a 32-bit register to hold the address
>>>>>> of the loop counter variable.
>>>>>>
>>>>>> Fix this by using a 64-bit register to calculate the address of the
>>>>>> loop counter variables as an offset from rip.
>>>>>
>>>>> Should this fix go through tip or the selftests tree ?
>>>>>
>>>>
>>>> I usually have changes like this pulled through Shuah's tree with an
>>>> ack from the maintainer of the code that it tests.
>>>>
>>>> -- Steve
>>>>
>>>
>>> Right that is what I prefer. I usually wait for an Ack. I can pull this
>>> in.
>>
>> I am maintainer of the code that it tests as well, so being both author
>> of the selftest patch and giving an ack to it seems a bit silly. :) Other
>> rseq co-maintainers could weight in though: Peter, Paul, and Boqun.
>>
> 
> I was commenting in general, not specific to this patch. No worries. I will
> apply this right away.
> 
> I have been traveling the last couple of weeks and in the catch up mode still.
> 

Hmm. this patch doesn't apply to linux-kselftest fixes branch which is at 4.19-rc4.
Also you don't have my current email from getmaintainers.

Could you please rebase and send it to me.

thanks,
-- Shuah

