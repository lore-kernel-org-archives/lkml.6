Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F295C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764B2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eFfpLWVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfBEP1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:27:52 -0500
Received: from mail.efficios.com ([167.114.142.138]:41986 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfBEP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:27:52 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 642FAF903;
        Tue,  5 Feb 2019 10:27:50 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id jrfHY2V_ALsa; Tue,  5 Feb 2019 10:27:49 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B94A7F8F8;
        Tue,  5 Feb 2019 10:27:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B94A7F8F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549380469;
        bh=qatQcb1PI6THg9uorQ3fdoPQUyj/4Rf1+jJVN0UJG1o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eFfpLWVkjUwU4aza3nCDeBt/Ey5fTS5duTHCut2578cimEQi0+Y54vLMrby2esUdU
         HU8KLPcRBW+yxH/cIaAIko65JU3+MwPeW78CoaG9uVmaVRcvjIZsX90nsBA6ZWx5RA
         8kMhq/QOTFAe3piqc1h/lz1KAyQuLwUnoZKP1o8te0k/q+Xe/pUvWpCHOhAW78ZCKu
         HiM0p3pJyJd3XQ8dDoF0JSQey8xZzKVi4+XqP5MlZP6C881hezHOlE4tSDNIh/75Fx
         5Z+MFEEDBjWI5BE9uJ3Tjqvcv7gUvfdcUp9xc7GD7jUiVIzezUfdxux9Ts91e9AW58
         JUIVS95Z9Kg3A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id MzJiH3mzM8dx; Tue,  5 Feb 2019 10:27:49 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9F300F8EC;
        Tue,  5 Feb 2019 10:27:49 -0500 (EST)
Date:   Tue, 5 Feb 2019 10:27:49 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        robert berger <Robert.Berger@reliableembeddedsystems.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        stable <stable@vger.kernel.org>
Message-ID: <894646307.256.1549380469415.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAGXu5j+iP7FuL8VdQMTHaUPpjxF=rhoFi_2_9w31GmFLZvTPrg@mail.gmail.com>
References: <20190204215219.5691-1-mathieu.desnoyers@efficios.com> <CAGXu5j+iP7FuL8VdQMTHaUPpjxF=rhoFi_2_9w31GmFLZvTPrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal
 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: kprobes: optimized kprobes illegal instruction
Thread-Index: fyj0M65b8KjaA657kUmPxjMtoXUszQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 5, 2019, at 10:04 AM, Kees Cook keescook@chromium.org wrote:

> On Mon, Feb 4, 2019 at 9:52 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> commit e46daee53bb5 "ARM: 8806/1: kprobes: Fix false positive with
>> FORTIFY_SOURCE"
>> introduced a regression in optimized kprobes. It triggers "invalid
>> instruction" oopses when using kprobes instrumentation through lttng and
>> perf. This commit was introduced in kernel v4.20, and has been backported
>> to stable kernels 4.19 and 4.14.
>>
>> This crash was also reported by Hongzhi Song on the redhat bugzilla
>> where the patch was originally introduced.
> 
> Ew, yes. Thanks for catching this.
> 
> Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> FORTIFY_SOURCE")
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Can you send this to the ARM patch tracker, please?

Sure, will do right away,

Thanks!

Mathieu

> 
> -Kees
> 
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
>> Link: https://bugs.lttng.org/issues/1174
>> Link:
>> https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
>> Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
>> CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
>> CC: Masami Hiramatsu <mhiramat@kernel.org>
>> CC: William Cohen <wcohen@redhat.com>
>> CC: Laura Abbott <labbott@redhat.com>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Russell King <rmk+kernel@armlinux.org.uk>
>> CC: <stable@vger.kernel.org> # v4.14+
>> ---
>>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/probes/kprobes/opt-arm.c
>> b/arch/arm/probes/kprobes/opt-arm.c
>> index 2c118a6ab358..0dc23fc227ed 100644
>> --- a/arch/arm/probes/kprobes/opt-arm.c
>> +++ b/arch/arm/probes/kprobes/opt-arm.c
>> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe
>> *op, struct kprobe *or
>>         }
>>
>>         /* Copy arch-dep-instance from template. */
>> -       memcpy(code, (unsigned char *)optprobe_template_entry,
>> +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>>                         TMPL_END_IDX * sizeof(kprobe_opcode_t));
>>
>>         /* Adjust buffer according to instruction. */
>> --
>> 2.11.0
>>
> 
> 
> --
> Kees Cook

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
