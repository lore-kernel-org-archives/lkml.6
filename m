Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F437ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ADF20864
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 00:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppa62+4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ADF20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeGVA5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbeGVA5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:57:14 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA3220864
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532217759;
        bh=NUIICqMFu/exJzBumAfQLJH5Bsx4WLTgsJ/5fjzOYZo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ppa62+4fRxpwzOqSOgpzDt4J8HUGNJ2d0eE8adIFzBIL9yRq4ht4YWePGt0lRwEbz
         54lTjKwDHgJFo4SdDBxJoAXB5L10DOUEfgx7xfuZmz2JYZDWrlXILxEVjLyBDSyj+D
         R85hnhqCaN6O3BzhqcXQylDMZjBLblHgtV9Tzdlo=
Received: by mail-wm0-f50.google.com with SMTP id t25-v6so3735107wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 17:02:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlEIKd2wA/rrOkNs0jd+mApiNK+xIsSxoHbypKaGlRJwxzJSbWSj
        oYqcyvYDRqWZLMQpxhoQIJMPE2cVDb4QyimsleWjqw==
X-Google-Smtp-Source: AAOMgpfe1mo1OSCxGWV98A88I4vRWp9JjBy2bt02aX+L4xGy9IokVZG5e8nctEhDUxsA8XfTVKNVoKcEJuI6pXdldow=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr4079101wmd.46.1532217757918;
 Sat, 21 Jul 2018 17:02:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 17:02:17
 -0700 (PDT)
In-Reply-To: <41ab203e-4ebd-083f-62c6-f10e649c6bb6@intel.com>
References: <41ab203e-4ebd-083f-62c6-f10e649c6bb6@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Jul 2018 17:02:17 -0700
X-Gmail-Original-Message-ID: <CALCETrURzP9N8xHd7+prOoJWZ690R2261-tHwgwnRu4pwn62VA@mail.gmail.com>
Message-ID: <CALCETrURzP9N8xHd7+prOoJWZ690R2261-tHwgwnRu4pwn62VA@mail.gmail.com>
Subject: Re: kernel %rsp code at sysenter PTI vs no-PTI
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 10:14 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> The PTI path does this:
>
>         ...
>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
>         /* Load the top of the task stack into RSP */
>         movq    CPU_ENTRY_AREA_tss + TSS_sp1 + CPU_ENTRY_AREA, %rsp
>
> And the non-PTI entry path does this:
>
>         ...
>         movq    %rsp, PER_CPU_VAR(rsp_scratch)
>         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
> Both "mov ___, %rsp" instructions have the kernel %GS value in place and
> both are running on a good kernel CR3.  Does anybody remember why we
> don't use cpu_current_top_of_stack in the PTI-on case?
>
> I'm wondering if it was because we, at some point, did the mov ...,
> %rsp before CR3 was good.  But it doesn't look like we do that now, so
> should we maybe make both copies do:
>
>         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp

Speed, sort of.  Without the CR3 switch there (i.e. PTI off, but
trampoline still in use, which is the path that actually gets used),
there's no forced serialization between swapgs and that movq.  And it
turns out that the RIP-relative load avoids a pipeline stall that the
%gs-relative access right after swapgs would cause.  So, with all the
mitigations off, the trampoline ends up being *faster*, at least in a
tight loop, than the non-trampolined path.

Of course, on a retpolined kernel, the retpoline at the end kills performance.

>
> for consistency?
