Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37215C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C6B25A24
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O24Kt//B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C6B25A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeGBWD0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:03:26 -0400
Received: from mail.efficios.com ([167.114.142.138]:43496 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeGBWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:03:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 80E2122F735;
        Mon,  2 Jul 2018 18:03:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id eI1dcFjV2Z-B; Mon,  2 Jul 2018 18:03:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D928222F732;
        Mon,  2 Jul 2018 18:03:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D928222F732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530569002;
        bh=S3tJMHgueLoLcS7R7ww3nE4GmdUi+EgKSGdlLUWWjLY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O24Kt//BX6OLkxCGaF3JeJ4fT9KuPlAg+uAyduYg0ypNPIi9rBC7K26OOSIyo8cKu
         b8kHJOw55PxKieAI7msjRT8+DH9jusG5P55QlAR5j/YA15tNatVyjKPY3WJV9HGzNx
         xjtHYWy2mcQft14PNRS9GmWbm3iqGzrlfo6+gteM7K0ytEvRIRJ0uIbEHre93dwGAr
         wRKTc1vYCPoVMYRfTtn/ZXL5BR+A60q7l8j+iVX47qD8mPObvQhCF9WZAWcXM69SDj
         ZiwCC1CzGJgOBVt5rxw+fkfzVzaFPt2KOrkhne9HpdY0Oz6hL1Nyu5QxZqXIAzBz3M
         7hB122imf6APg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id W91EeuZJHjw7; Mon,  2 Jul 2018 18:03:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BBC1D22F729;
        Mon,  2 Jul 2018 18:03:22 -0400 (EDT)
Date:   Mon, 2 Jul 2018 18:03:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <522686232.10814.1530569002544.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFwuBef8ajmeE-mw=6YHwYOQdnCMir7h2ebWxOzNrSQQFw@mail.gmail.com>
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com> <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com> <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com> <CA+55aFwuBef8ajmeE-mw=6YHwYOQdnCMir7h2ebWxOzNrSQQFw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields,
 validate abort_ip < TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate abort_ip < TASK_SIZE
Thread-Index: SpdtVeA9tHtDYNztXFBPUmcICvROng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 5:20 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 2:03 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>         /* Ensure that abort_ip is not in the critical section. */
>>         if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
>>                 return -EINVAL;
>> ...
>> What underflow issues are you concerned with ?
> 
> That.
> 
> Looking closer, it looks like what you want to do is
> 
>     if (rseq_cs->abort_ip >= rseq_cs->start_ip && rseq_cs->abort_ip <
> rseq_cs->start_ip + rseq_cs->post_commit_offset)
> 
> but you're not actually verifying that the range you're testing is
> even vlid, because "rseq_cs->start_ip + rseq_cs->post_commit_offset"
> could be something invalid that overflowed (or, put another way, the
> subtraction you did on both sides to get the simplified version
> underflowed).
> 
> So to actually get the range check you want, you should check the
> overflow/underflow condition. Maybe it ends up being
> 
>        if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
>                return -EINVAL;
> 
> after which your simplified conditional looks fine.
> 
> But I think you should also do
> 
>        if (rseq_cs->start_ip + rseq_cs->post_commit_offset > TASK_SIZE)
>                return -EINVAL;
> 
> to make sure the range is valid in the first place.

Taking into account your comments, and adding also an extra check for
rseq_cs->start_ip >= TASK_SIZE, and restricting the end of range
rseq_cs->start_ip + rseq_cs->post_commit_offset to exclude TASK_SIZE
(>= rather than >), the resulting function now looks like this:

static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
{
        struct rseq_cs __user *urseq_cs;
        unsigned long ptr;
        u32 __user *usig;
        u32 sig;

        if (__get_user(ptr, &t->rseq->rseq_cs))
                return -EINVAL;
        if (check_rseq_cs_padding(t))
                return -EINVAL;
        if (!ptr) {
                memset(rseq_cs, 0, sizeof(*rseq_cs));
                return 0;
        }
        urseq_cs = (struct rseq_cs __user *)ptr;
        if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)) ||
            rseq_cs->start_ip >= TASK_SIZE ||
            rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
            rseq_cs->abort_ip >= TASK_SIZE ||
            rseq_cs->version > 0)
                return -EINVAL;

        /* Check for overflow. */
        if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
                return -EINVAL;
        /* Ensure that abort_ip is not in the critical section. */
        if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
                return -EINVAL;

        usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
        if (get_user(sig, usig))
                return -EINVAL;

        if (current->rseq_sig != sig) {
                printk_ratelimited(KERN_WARNING
                        "Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
                        sig, current->rseq_sig, current->pid, usig);
                return -EINVAL;
        }
        return 0;
}

The end of range exclusion with (rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE)
stems from the reasoning that we need a valid user-space instruction _after_ the range, so
having the range end exactly at the very last byte of TASK_SIZE would require to have a
user-space instruction at TASK_SIZE, which is not valid.

Does it capture your intent ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
