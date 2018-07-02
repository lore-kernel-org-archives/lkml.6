Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3625C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7622D258C9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RxdpwI1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7622D258C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeGBWQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:16:49 -0400
Received: from mail.efficios.com ([167.114.142.138]:45428 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:16:47 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6114F22FA7B;
        Mon,  2 Jul 2018 18:16:46 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iek0s1XL0nbb; Mon,  2 Jul 2018 18:16:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D8DBC22FA78;
        Mon,  2 Jul 2018 18:16:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D8DBC22FA78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530569805;
        bh=4/InqIB0XubKRaJKkCIpbp04m140OlVvwAIMI6YhQOA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RxdpwI1dNbS/D7L2i222YT6AC9+bvjUsyl362QSIugDUzPcadBhgueJ1cRx6Lnd92
         EAXbFkiYxUgpwda73FKPqU9MWTufdL7jhhmETM9fOpebk8w5tEmOrawVq/mfpNQvv/
         P6CJST2ZNPj5BAoCxIOaYNzMog9Ed4CMIlxNC2iO/n7zcVOxRXb/E69nurQ2E6n+Jc
         rdjEXEZh66sk1xzeZlQcWy3KtAi5OrYt2/i4TBmzE4G+54ySUGvDFmuFDtbtqZumfA
         R7cWdIGhzxVO+9eKbLjoc+co3usqX7vcrED9ESWCbdvEYQfSvhh/PGPgo8EOBzCmni
         GTrXakzJUuK9g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TVgdeTfWpgbp; Mon,  2 Jul 2018 18:16:45 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BC07B22FA71;
        Mon,  2 Jul 2018 18:16:45 -0400 (EDT)
Date:   Mon, 2 Jul 2018 18:16:45 -0400 (EDT)
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
Message-ID: <1051917568.10818.1530569805468.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFz5cq5uP7VFwAmo3BimHyMdu_FQnbxZG3i66_qZXCkjNg@mail.gmail.com>
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com> <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com> <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com> <CA+55aFwuBef8ajmeE-mw=6YHwYOQdnCMir7h2ebWxOzNrSQQFw@mail.gmail.com> <522686232.10814.1530569002544.JavaMail.zimbra@efficios.com> <CA+55aFz5cq5uP7VFwAmo3BimHyMdu_FQnbxZG3i66_qZXCkjNg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields,
 validate abort_ip < TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate abort_ip < TASK_SIZE
Thread-Index: WSd9lz113BMDj8YOtcgvhha5NoB8+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 6:08 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 3:03 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>         if (__get_user(ptr, &t->rseq->rseq_cs))
>>                 return -EINVAL;
>>         if (check_rseq_cs_padding(t))
>>                 return -EINVAL;
> 
> Small nit.
> 
> I think the _actual_ user access faults should return -EFAULT, and
> then the *validation* checks should return -EINVAL.
> 
> So when the "copy_from_user()" fails, that's -EFAULT, but when you
> have (rseq_cs->start_ip >= TASK_SIZE), that's -EINVAL.

Fair enough.

> 
> That said, nothing actually cares or exposes the error number, I
> think. Afaik, all the callers just check "did it work" or not.

Indeed, it's a static function and callers just check for zero/nonzero.

> 
> So this is more a "let's be consistent" than anything that matters.

Allright, here is the function updated accordingly:

static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
{
        struct rseq_cs __user *urseq_cs;
        unsigned long ptr;
        u32 __user *usig;
        u32 sig;
        int ret;

        ret = __get_user(ptr, &t->rseq->rseq_cs);
        if (ret)
                return ret;
        if (check_rseq_cs_padding(t))
                return -EINVAL;
        if (!ptr) {
                memset(rseq_cs, 0, sizeof(*rseq_cs));
                return 0;
        }
        urseq_cs = (struct rseq_cs __user *)ptr;
        if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
                return -EFAULT;

        if (rseq_cs->start_ip >= TASK_SIZE ||
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
        ret = get_user(sig, usig);
        if (ret)
                return ret;

        if (current->rseq_sig != sig) {
                printk_ratelimited(KERN_WARNING
                        "Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
                        sig, current->rseq_sig, current->pid, usig);
                return -EINVAL;
        }
        return 0;
}

Thanks for the feedback!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
