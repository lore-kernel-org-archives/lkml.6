Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81212C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF3A21777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqchevp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF3A21777
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeHCSfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:35:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36350 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeHCSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:35:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so3091809pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SMSiMZFV2xmqIyEx2X/LLari/l23gt20gJWmoc5OjSs=;
        b=vqchevp08TNUf+W43vibFh4Lml9nbon5lz2Yc/c5qeC3tSn10uefS32HGuGkzUmzOh
         o8iqDX5cuMM2BkviIwBYGbYF+LG5YfR6WVzCWOgE1TkogR8C2N2axww77oWsqSPf93ge
         0TnOjHQfQWPlzEt+2EVgdaf41XApMG6xUlBgtrwGLYH9AG/ximNxPN7A3YluMV3yG/jf
         4ZV+uNlj0NMWlFcA5ncQXfkTK4UPINjYX+nd6M4c3GinIQ8zRxy4ZArgE3R1Bad/jdfi
         ZN+/8BxcY4x2eqdu9AkJzCaF7ozhIhymWjNjgDkCEibiDUYRZjDb8hpc983If+QadAii
         FN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SMSiMZFV2xmqIyEx2X/LLari/l23gt20gJWmoc5OjSs=;
        b=m+NhWJWKbX8TY75/6GOpB5apJ/yHfXdcPTbaLS/R9RN42W7AD2zHsHqHG7nQSCirGN
         vZOOY5ENOMLK0qNZW3aD3CR3KwFckRtgUF5MarDiVTwcA8n0EZNVXvltcApJADS3kA69
         6NjFLlKOFmkEwGeu1tVEbTqBbjV3CDuW+q31j3b/py3M4eOSSZE2mHPxuS/PkoId3sII
         3rj5Xn/gv/uGm7XrMZCFhHsp5ZJJjKwdzp8/B2S7OjA+jGy6yLBw992TPvoN7A+Yz5UZ
         lka6MhKpvtzSlpksLgOOdaIMAnY21TOzS4hyMKhbV88A1W5QPtjR/4ivavKYtZgLQ2te
         LoUg==
X-Gm-Message-State: AOUpUlFYOahD+caQt48m0kcqzm7EzYjfh1R6HY1JRcsqlzt1J/01Kpdt
        MhRYM+eLjCAg/al/wfh4f/Udl1OvMYLRfrChSm7VXw==
X-Google-Smtp-Source: AAOMgpdYZh0j4UrmjpiNFlk/Vcl/mojzPz0wFCxUt90YTH6MtScA3CilKBA0WA4aefZO6hlVQdPbidB3eBAtJlXlLIU=
X-Received: by 2002:a62:106:: with SMTP id 6-v6mr5430076pfb.168.1533314294547;
 Fri, 03 Aug 2018 09:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180803151035.238a19d2@endymion>
In-Reply-To: <20180803151035.238a19d2@endymion>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Aug 2018 09:38:03 -0700
Message-ID: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
Subject: Re: native_save_fl() causes a warning
To:     jdelvare@suse.de
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, hpa@zytor.com,
        tstellar@redhat.com, sedat.dilek@gmail.com, jgross@suse.com,
        Ingo Molnar <mingo@kernel.org>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 6:10 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi Nick,
>
> It seems that this linux kernel commit of yours:
>
> commit d0a8d9378d16eb3c69bd8e6d23779fbdbee3a8c7
> Author: Nick Desaulniers
> Date:   Thu Jun 21 09:23:24 2018 -0700
>
>     x86/paravirt: Make native_save_fl() extern inline
>
> introduced a new warning (with W=3D1):
>
> ./arch/x86/include/asm/irqflags.h:16:29: warning: no previous prototype f=
or =E2=80=98native_save_fl=E2=80=99 [-Wmissing-prototypes]
>  extern inline unsigned long native_save_fl(void)
>                              ^
>
> Please fix it.

Hi Jean, thanks for the report.  David Laight also reported this
warning; he tested a patch I sent him overnight.

Let me guess, you're using a version of GCC < 4.9?  It seems that GCC
< 4.9 will produce that warning for extern inline functions without
previous declarations.

I'll add your Reported-By tag to the patch that I will send out in a
few minutes.

> Secondly, I am quite curious why you changed only native_save_fl() from
> static inline to extern inline, when native_restore_fl(),
> native_irq_disable() and native_irq_enable() are equally referenced by
> address in arch/x86/kernel/paravirt.c and thus should suffer from the
> same problem. Can you explain?

This is a good point.  With native_save_fl, we were not able to boot
the kernel at all.  Maybe this was called from the boot sequence
(maybe Juergen knows more)?  It seems that the other functions aren't
preventing us from booting, but maybe exercising other paths in
paravirt would expose such an issue?  Or maybe paravirt doesn't have
the same calling convention requirements for those functions?

Is there a standard testing procedure for paravirt? I'd be happy to
try it to see if we can expose more things that should have the same
cleanup.
--=20
Thanks,
~Nick Desaulniers
