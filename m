Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A908C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF82799F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pEdx7QFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CF82799F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935619AbeF1Uz7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:55:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:50064 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeF1Uz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:55:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2DF6A22EA22;
        Thu, 28 Jun 2018 16:55:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id QiA4YQtKdm_Q; Thu, 28 Jun 2018 16:55:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 69C6522EA17;
        Thu, 28 Jun 2018 16:55:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 69C6522EA17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530219355;
        bh=IcQd3NTPIgp6VsYT2ufu57V1GnAc6U8MoK5VS3Hu+K8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pEdx7QFtZ4V81u+fup6R3isYTt9/PAO7ZAg8Lakl/ibFrncJfLBYh+SavWjobGuSM
         jwlkDfBzUlgl68hOLDVlH8T0c7Syi16ld5Xgcut15NgSgpjnv7ySkXrLVVG4zM05SB
         z2w9yDFqXR3cuWsMDOEH2xSrfQ8MJJaY/40fd/XVXS4Av/OYo81WnX73JDEh60uNF1
         fZThUno04qsy+IDf48GyJu0CbLs8vuqGrvLIvDpW6tdy9V1s6WQ/je4WcA2syIlgAS
         2VfjeiChREq9UHypZgs5bt5OxyFNdsq4oMJlaimz8fL9/UMPA8d6v4MddbsQx4CFMU
         BwwwDoojWA/Mw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QJQWKQx0Y4hl; Thu, 28 Jun 2018 16:55:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4BF6622EA0C;
        Thu, 28 Jun 2018 16:55:55 -0400 (EDT)
Date:   Thu, 28 Jun 2018 16:55:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <145668759.9406.1530219355192.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180628165348.GE10751@arm.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <20180628162359.9054-2-mathieu.desnoyers@efficios.com> <20180628165348.GE10751@arm.com>
Subject: Re: [RFC PATCH for 4.18 2/2] rseq: check that rseq->rseq_cs padding
 is zero
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: check that rseq->rseq_cs padding is zero
Thread-Index: 0yd5tDgqkI8JsxsjRwSMAAu3hkRTxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 12:53 PM, Will Deacon will.deacon@arm.com wrote:

> Hi Mathieu,
> 
> On Thu, Jun 28, 2018 at 12:23:59PM -0400, Mathieu Desnoyers wrote:
>> On 32-bit kernels, the rseq->rseq_cs_padding field is never read by the
>> kernel. However, 64-bit kernels dealing with 32-bit compat tasks read the
>> full 64-bit in its entirety, and terminates the offending process with
>> a segmentation fault if the upper 32 bits are set due to failure of
>> copy_from_user().
>> 
>> Ensure that both 32-bit and 64-bit kernels dealing with 32-bit tasks end
>> up terminating offending tasks with a segmentation fault if the upper
>> 32-bit padding bits (rseq->rseq_cs_padding) are set by adding an explicit
>> check that padding is zero on 32-bit kernels.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Paul Turner <pjt@google.com>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Andy Lutomirski <luto@amacapital.net>
>> CC: Andi Kleen <andi@firstfloor.org>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: Chris Lameter <cl@linux.com>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: "H. Peter Anvin" <hpa@zytor.com>
>> CC: Ben Maurer <bmaurer@fb.com>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Josh Triplett <josh@joshtriplett.org>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Michael Kerrisk <mtk.manpages@gmail.com>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: linux-api@vger.kernel.org
>> ---
>>  kernel/rseq.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>> 
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 4ba582046fcd..b038f35a60d6 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -112,6 +112,29 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>>  	return 0;
>>  }
>>  
>> +#ifndef __LP64__
>> +/*
>> + * Ensure that padding is zero.
>> + */
>> +static int check_rseq_cs_padding(struct task_struct *t)
>> +{
>> +	unsigned long pad;
>> +	int ret;
>> +
>> +	ret = __get_user(pad, &t->rseq->rseq_cs_padding);
>> +	if (ret)
>> +		return ret;
>> +	if (pad)
>> +		return -EFAULT;
>> +	return 0;
>> +}
>> +#else
>> +static int check_rseq_cs_padding(struct task_struct *t)
>> +{
>> +	return 0;
>> +}
>> +#endif
> 
> I'm still not sure how this works with a 64-bit kernel and a compat (32-bit)
> task. The check_rseq_cs_padding() will return 0 regardless of the upper bits
> of the rseq_cs field, whereas a native 32-bit kernel would actually go and
> check them.
> 
> What am I missing here?

With a 64-bit kernel, we end up in the #else, which means check_rseq_cs_padding()
always returns 0.

On that 64-bit kernel, all 64 bits of rseq->rseq_cs are read, including the
padding. Therefore, all those bits are contained in the pointer passed as
argument to copy_from_user(), which will cause copy_from_user() to accurately
fail on an invalid user-space address.

Therefore, 64-bit kernels already check those padding bits by means of trying to use
that pointer to access user-space data with copy_from_user, which does an access_ok
check.

So both 32-bit and 64-bit kernels will end up killing the process with segmentation
fault if a 32-bit userland populates those padding bits with anything other than
0.

Does it seem acceptable ?

Thanks,

Mathieu

> 
> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
