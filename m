Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0431DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14F525316
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Aqprwe3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14F525316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeGBQE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:04:26 -0400
Received: from mail.efficios.com ([167.114.142.138]:49726 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGBQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:04:22 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8EFC01C3A37;
        Mon,  2 Jul 2018 12:04:21 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id kD-IIupezc1v; Mon,  2 Jul 2018 12:04:21 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1F6931C3A32;
        Mon,  2 Jul 2018 12:04:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1F6931C3A32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530547461;
        bh=U1dqsbvXtwxHzrMnSb5rQAmsEYMWW8zLp5Wyj0Ib2Fs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Aqprwe3LyZ7FfqffamX7wZ2plxlEqSOyrGYty2z59HXa45XXO2evjksJ6FzWwWuI4
         eEn3ugZHu7TTL7WwFPPfzuAwmLlVxxbcUbqbQkksJjmbjaL/acAe+XxZK0zYZhqVF3
         Mj2zIBiKUA4a8XIPzqDWmtzm8LmOb4YOOhnGK6+Gt9bNgXvr5IMQzt55Y9dw1r1gdd
         Zt9jIlEqRLaTiZ/UE5KSJJB/DodXCI/uXo/kXY4573N8/GN5dxZ6mlUq4jkNaq0182
         JqHC+wicy+bqyqnED51ZDWqnDBRWaMFWNnLIIjMlHdE6KsrwPEnGdste8QRGKJN13M
         vcS5ovLSNPjdg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7-BByj4dMqCR; Mon,  2 Jul 2018 12:04:21 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DD3661C3A2B;
        Mon,  2 Jul 2018 12:04:20 -0400 (EDT)
Date:   Mon, 2 Jul 2018 12:04:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <4741715.10696.1530547460698.JavaMail.zimbra@efficios.com>
In-Reply-To: <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com> <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com> <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com> <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com> <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com> <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com> <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: EfNoEXYdmNtWTN5CDgNZeik/VS9bfCDUAY2S
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 10:32 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
[...]
> 
> But rather than trying to play games with input validation, I would
> favor an approach that would allow rseq to validate all its inputs
> straightforwardly. Introducing user_64bit_mode(struct pt_regs *)
> across all architectures would allow doing just that. rseq signal
> delivery and return to usermode code could then ensure that high bits are
> cleared by 32-bit tasks for all fields and thus provide a consistent
> behavior for 32-bit tasks running on 32-bit and 64-bit kernels.

AFAIU this could be achieved by re-introducing is_compat_task() on x86 as:

#ifdef CONFIG_COMPAT
static bool is_compat_task(void)
{
        return user_64bit_mode(current_pt_regs()));
}
#else
static bool is_compat_task(void) { return false; };
#endif

Or am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
