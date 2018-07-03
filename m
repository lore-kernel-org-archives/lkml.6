Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7B1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B682248BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c2hn0iUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B682248BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934553AbeGCSlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:41:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:33412 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934514AbeGCSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:41:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 77F1223076F;
        Tue,  3 Jul 2018 14:41:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Nallk0_ds1Ns; Tue,  3 Jul 2018 14:41:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0BC4023076C;
        Tue,  3 Jul 2018 14:41:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0BC4023076C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530643262;
        bh=diPdcaiZSxGj+ZAIRAO/+s3rcg3AVdoI46D/JFFE9dg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=c2hn0iUFZHLZKDl9JdBfYHpXI5U92Tm+sfLDoCEKpM6Y6Vgkkvq2EC08kqvedcxJO
         vEV3ItX0ALa6eK/LUazisrGF8Egq0ydSj+06qC2RMwr627bx9CkJaprbm3njHFweO1
         vSDi72ttfuPK6q+LpG1st40eed2k5ZYeFCdqYF8Qv8TPA9znZf1Hda8+QF30LihKvo
         mjRdbBJNVxp+Ma1j09LSgVbZ8wuefTAByQVkR6+N4OsZYmlmejMAMikDqgNksMkHtF
         DVz44Rt3fK38SwQ+fkur/S0wWX5FM4Pa0mmi11PJIlQDXfUZCbLlmNsJSW3V/2MamS
         jfcbv8SIAoTtA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id khWHDsH_6CW2; Tue,  3 Jul 2018 14:41:01 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DC375230762;
        Tue,  3 Jul 2018 14:41:01 -0400 (EDT)
Date:   Tue, 3 Jul 2018 14:41:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        schwidefsky <schwidefsky@de.ibm.com>, gor <gor@linux.ibm.com>
Message-ID: <1368400582.11897.1530643261772.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180703182837.GC2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <20180703173451.GX2494@hirez.programming.kicks-ass.net> <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com> <20180703174833.GZ2494@hirez.programming.kicks-ass.net> <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com> <20180703181143.GB2494@hirez.programming.kicks-ass.net> <1708848118.11868.1530641734202.JavaMail.zimbra@efficios.com> <20180703182837.GC2494@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: SR4kmDGS9PpmQ3sS6yVWOtbnSeZRbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 2:28 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 03, 2018 at 02:15:34PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 3, 2018, at 2:11 PM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Jul 03, 2018 at 01:58:37PM -0400, Mathieu Desnoyers wrote:
>> >> I can modify the ABI to put the cpu_id_start and cpu_id fields inside
>> >> a union, and update it with a single store.
>> >> 
>> >> Thoughts ?
>> > 
>> > Let's keep them for now, we can always frob this later, they are aligned
>> > and proper, no need to expose that union to userspace.
>> 
>> Isn't it weird to change the API of an exposed public uapi header ?
> 
> Sure, just keep it as is. We don't need an exposed union to do a single
> store there.
> 
> Something like the ugly below preserves API but still does a single
> store.
> 
> But sure, if you want to expose that union for some reason, then now is
> the time.

User-space won't ever want to read cpu_id_start and cpu_id from a single
u64 load, it serves no purpose to do so. So I'm OK with keeping those as
is and defining a local union for the __put_user() update.

Thanks!

Mathieu

> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 22b6acf1ad63..e956c48b5f83 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -85,10 +85,17 @@ static int rseq_update_cpu_id(struct task_struct *t)
> {
> 	u32 cpu_id = raw_smp_processor_id();
> 
> -	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
> -		return -EFAULT;
> -	if (__put_user(cpu_id, &t->rseq->cpu_id))
> +	union {
> +		struct {
> +			u32 cpu_id_start;
> +			u32 cpu_id;
> +		};
> +		u64 val;
> +	} x = { { .cpu_id_start = cpu_id, .cpu_id = cpu_id, } };
> +
> +	if (__put_user(x.val, (u64 *)&t->rseq->cpu_id_start))
> 		return -EFAULT;
> +
> 	trace_rseq_update(t);
> 	return 0;
>  }

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
