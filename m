Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBFFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30A2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cePcWO8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C30A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeI1AVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:21:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:41714 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI1AVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:21:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AF9F4242677;
        Thu, 27 Sep 2018 14:02:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id l0Q7b_oDttTC; Thu, 27 Sep 2018 14:02:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8BD3224266F;
        Thu, 27 Sep 2018 14:02:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8BD3224266F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1538071328;
        bh=yXlhQ35jnZf6icPPCSOWEouOm7NFShHC25nup+qr6Qw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cePcWO8Dak50DE69JL99ikvnNySdMt3Yqgrz6BMdzNKBKUatC4PWRZ/VIU60zIdhS
         JNfqrx5b66pXg3kpz43cTXO3jK6MAUgzElWb4CrlV+bpiWWw7JAQ29VvuUfT2bNojM
         t1aYSqXQQOQH+HfwM8GptgJemKytnRVzFcl8R4qwHSoGdkWD6CEzDrUozfsxjvYC8R
         aJbJEswf01d4CVFWFeXe7Ywd8JwnU3tc7hBL05qsjPs4bvnOq/j/ilXD87kAMKBc8B
         qKDHzony/uVITcw/+6JST/666wgeIvWAJ85tLdcqu8xB2ttYKa2IeVZS4e2WAJ2Kte
         XXJr5g0tVka3w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ucwMxwGiL1Or; Thu, 27 Sep 2018 14:02:08 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6A5A4242668;
        Thu, 27 Sep 2018 14:02:08 -0400 (EDT)
Date:   Thu, 27 Sep 2018 14:02:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah kh <shuah.kh@samsung.com>
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
        stable <stable@vger.kernel.org>, shuah <shuah@kernel.org>
Message-ID: <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
In-Reply-To: <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com> <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com> <CGME20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416@epcas4p3.samsung.com> <20180927092235.77282e35@vmware.local.home> <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: rseq/selftests: fix parametrized test with -fpie
Thread-Index: eUxmozW8H4gJdhHOEwUVY+Vn8yzteA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 27, 2018, at 9:58 AM, Shuah Khan shuah.kh@samsung.com wrote:

> On 09/27/2018 07:22 AM, Steven Rostedt wrote:
>> On Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>>> ----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>>
>>>> On x86-64, the parametrized selftest code for rseq crashes with a
>>>> segmentation fault when compiled with -fpie. This happens when the
>>>> param_test binary is loaded at an address beyond 32-bit on x86-64.
>>>>
>>>> The issue is caused by use of a 32-bit register to hold the address
>>>> of the loop counter variable.
>>>>
>>>> Fix this by using a 64-bit register to calculate the address of the
>>>> loop counter variables as an offset from rip.
>>>
>>> Should this fix go through tip or the selftests tree ?
>>>
>> 
>> I usually have changes like this pulled through Shuah's tree with an
>> ack from the maintainer of the code that it tests.
>> 
>> -- Steve
>> 
> 
> Right that is what I prefer. I usually wait for an Ack. I can pull this
> in.

I am maintainer of the code that it tests as well, so being both author
of the selftest patch and giving an ack to it seems a bit silly. :) Other
rseq co-maintainers could weight in though: Peter, Paul, and Boqun.

Thanks,

Mathieu

> 
> thanks,
> -- Shuah
> 
> --
> Shuah Khan
> Sr. Linux Kernel Developer
> Open Source Innovation Group
> Samsung Research America(Silicon Valley)
> shuah.kh@samsung.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
