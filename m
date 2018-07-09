Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8CEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87A02087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qMuWcw4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87A02087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeGISEt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:04:49 -0400
Received: from mail.efficios.com ([167.114.142.138]:53192 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeGISEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:04:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AD34D22DA76;
        Mon,  9 Jul 2018 14:04:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 6SARYiNSrXys; Mon,  9 Jul 2018 14:04:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2780522DA6E;
        Mon,  9 Jul 2018 14:04:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2780522DA6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531159485;
        bh=En9yzMm74smKiIRrfWZQ1MZL3eW/Y3CEZfII3uUb3H4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qMuWcw4+p2wMbq73pLl5S/Hz1dXmSdfZQA4tmaS5JnicLC5Jh+oKCY4jvcmcBL1ss
         hzwl0XF29DIYh2XJU9LbPRiHJybK0k3mHx6iHyHCTBOZx5EUWJdnI/ZOxBAeBtyUzB
         K0tDqydHxMdofbDh96vnnrF+SznlVXk0YJKtp1sh8+dKVB3E1Pu9ZI4scKH8V/2k/0
         Pz3QgEM7oMlgPZU/U3O/TBonqvmWXVC0FH7Hdp2zkToUz86lg6Ir7m9KxHoNcnmr6M
         S4wLu5hbyizc5xZD+Thdr1tj7IGw0pYGsTgIa5AFxuwQ8IQrmKWLsDc5guBm+PFnK/
         nPtOz6zexdkwA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Ti85rH09fPxr; Mon,  9 Jul 2018 14:04:45 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0CDC022DA67;
        Mon,  9 Jul 2018 14:04:45 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:04:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <2129841179.2387.1531159484965.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH for 4.18 0/6] Restartable Sequences updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences updates
Thread-Index: HPGZEsQru3lrMJ5FszLwYei2lRelkg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 8, 2018, at 5:03 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Following the recent discussion thread [1] about rseq uapi, here is
> a set of updates submitted for integration into 4.18. Those change all
> rseq __get_user/__put_user for get_user/put_user as discussed.

Considering that ppc32 does not implement 64-bit get_user(), I will re-spin
the whole series using __copy_from_user/__copy_to_user() to replace
__get_user()/__put_user() to load/store the 64-bit rseq_cs field.

I'm aiming for a minimal change at this stage of the rc cycle.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> [1]
> https://lkml.kernel.org/r/20180702223143.4663-1-mathieu.desnoyers@efficios.com
> 
> Mathieu Desnoyers (6):
>  rseq: use __u64 for rseq_cs fields, validate user inputs
>  rseq: use get_user/put_user rather than __get_user/__put_user
>  rseq: uapi: update uapi comments
>  rseq: uapi: declare rseq_cs field as union, update includes
>  rseq: remove unused types_32_64.h uapi header
>  rseq/selftests: cleanup: update comment above rseq_prepare_unload
> 
> include/uapi/linux/rseq.h           | 102 ++++++++++++++++++++----------------
> include/uapi/linux/types_32_64.h    |  50 ------------------
> kernel/rseq.c                       |  36 ++++++++-----
> tools/testing/selftests/rseq/rseq.h |  24 ++++++---
> 4 files changed, 97 insertions(+), 115 deletions(-)
> delete mode 100644 include/uapi/linux/types_32_64.h
> 
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
