Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DA20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5DA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLGLMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:12:52 -0500
Received: from ozlabs.org ([203.11.71.1]:40411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGLMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:12:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43B8vj1x8Gz9s0n;
        Fri,  7 Dec 2018 22:12:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call
In-Reply-To: <20181207011946.GA18558@altlinux.org>
References: <20181116121701.14359da0@akathisia> <87ftw12nyn.fsf@concordia.ellerman.id.au> <20181119210139.GA8360@altlinux.org> <87efbe166y.fsf@concordia.ellerman.id.au> <20181203031823.GE11573@altlinux.org> <20181207011946.GA18558@altlinux.org>
Date:   Fri, 07 Dec 2018 22:12:49 +1100
Message-ID: <87y391k2tq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Mon, Dec 03, 2018 at 06:18:23AM +0300, Dmitry V. Levin wrote:
>> From: Elvira Khabirova <lineprinter@altlinux.org>
>> 
>> Arch code should use tracehook_*() helpers, as documented
>> in include/linux/tracehook.h,
>> ptrace_report_syscall() is not expected to be used outside that file.
>> 
>> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
>> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
>> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> ---
>> v4: rewritten to call tracehook_report_syscall_entry() once, compile-tested
>> v3: add a descriptive comment
>> v2: explicitly ignore tracehook_report_syscall_entry() return code
>> 
>>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
>>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> Sorry, this patch does not work, please ignore it.

Hmm OK. Why exactly?

I wrote more or less the same patch, although I used a temporary bool.

> However, the bug blocks PTRACE_GET_SYSCALL_INFO, so please fix it.

Sorry, didn't realise it was blocking you.

> I'm going to use
> 	if (tracehook_report_syscall_entry(regs))
> 		return -1;
> 	return -1;
> in the series until you have a better fix.

Yeah that's fine by me. I could send that to Linus for 4.20 if you want
me to, otherwise I'm fine for you to carry it in your series.

cheers
