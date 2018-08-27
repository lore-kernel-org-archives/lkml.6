Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2382CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD6208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep3bWn24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AD6208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH0W5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbeH0W5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:57:04 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86EB8208B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535396951;
        bh=T86lLfOBUG4HX/q1zp6rT3trOXWgjJkCxfl8/mOafGg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ep3bWn24DhCBALZNCp3IBdC7YNV8UrJUeE96ReEDnvPgNXB+oCH7M7A4yXMh/+pvT
         ygaV/ugW9uOAZyKgdxKYccVTXk/uPFlARUrEXrQSRAknTO+efdMcvmK3ZfW+7YFidZ
         dxRMofE5tj6ptBdIJYj+N+YdekgkIs6+mHvW4FyQ=
Received: by mail-wr1-f42.google.com with SMTP id a108-v6so2233wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:09:11 -0700 (PDT)
X-Gm-Message-State: APzg51BO3EWxmyAsCIhOIirKBr6Z0WBgwXQB9do1DfGGHlprfiKaenMm
        nUBhItjwSVxEY/0aeWPElEMlVNu1qh0AwFKa+VrAlw==
X-Google-Smtp-Source: ANB0VdYr46jAuDFWhnHiGGCgOv/cTi8jGvMwwr6gaYpgz8Ev5EvWFMNeqE3BbJSOju9rm4PKa/mIpKPtzVektj/iKg8=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr9344038wrf.46.1535396950074;
 Mon, 27 Aug 2018 12:09:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 12:08:49 -0700 (PDT)
In-Reply-To: <20180827185631.163506-6-jannh@google.com>
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-6-jannh@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 12:08:49 -0700
X-Gmail-Original-Message-ID: <CALCETrXSfLVcGGPM5=XJ8hxaN_sO2faS7iu8JzJdeYDaWc_rPg@mail.gmail.com>
Message-ID: <CALCETrXSfLVcGGPM5=XJ8hxaN_sO2faS7iu8JzJdeYDaWc_rPg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86: plumb error code and fault address through to
 fault handlers
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
> This is preparation for looking at trap number and fault address in the
> handlers for uaccess errors.
> This patch should not change any behavior.

Confused.  $SUBJECT says you're plumbing the error code through, and
you are sort of doing it:

> -int fixup_exception(struct pt_regs *regs, int trapnr)
> +int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
> +                   unsigned long fault_addr)
>  {

It's available here...

>         const struct exception_table_entry *e;
>         ex_handler_t handler;
> @@ -202,7 +212,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr)
>                 return 0;
>
>         handler = ex_fixup_handler(e);
> -       return handler(e, regs, trapnr);
> +       return handler(e, regs, trapnr, fault_addr);

... but you don't pass it into the handlers.  Is this intentional?
