Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F89C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4492146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jFyJHtWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4492146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeK3Ifu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:35:50 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46386 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeK3Ift (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:35:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id t13so1389652ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfRtaPAGLSKj7E0VQz83F2G7yyR84/9dPeB/jw6eg5M=;
        b=jFyJHtWUt/TGeBW1BaDEmYgRqnb/3U/6dg9SkC9+Xgib6EzMhaD4bGn3ZOCtcLOWgT
         +RPXqUaJb2akDKH3JaFczgGjtGFBP9UEMxyJKL++eaK2kVn3MbjblxAa44xyS33nlu5x
         0YGXQeiS1SIX51frQyjIzWBzL7v+fMQuCPDoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfRtaPAGLSKj7E0VQz83F2G7yyR84/9dPeB/jw6eg5M=;
        b=So4dUUq0JEOzRhw874tZoqQMDyprxKzWH/pndeesPrJ6HsKaVFwuSpbza7mLl/tT6d
         YrLq3KLNJupKJVn9trv0s15O0t+qGMRqOpNQhV/pondDpVW2PeJnGsgOXbU0M9Sp8c6H
         eJddjbUZlj0qIGVanhno47UpaEPyUWynfsyWmLVn0s7XP809otISYXrYfDLnmOI5glXu
         GYm2gwxXwAOtPnVo3Fam6a3MaGvry3X5YNG3j2P+H5aQZJG4qZ1cTp1gj7zWOaKkDEKD
         xJ0wyYJnlUB0htJLbXGnNV0th98S3CaUbqXRCs7R9u4t24diXuTveusuOLDDAGjPNd6D
         L0/g==
X-Gm-Message-State: AA+aEWZDUs+sjgsOmH2H7G87CYEom2yexKe9lBpj6JFfcjPDAEFNiTN7
        WXwzOuH++RUSdOXFONTKyRoZPe6zs4Q=
X-Google-Smtp-Source: AFSGD/UmI6vGNTa7zfw7D5e+XJtPZ+weB5PBN8PgDzVTFwesroq6v8TKhyJicWLJr8qGgKDPzKHtaw==
X-Received: by 2002:a81:af58:: with SMTP id x24mr3260207ywj.362.1543526941056;
        Thu, 29 Nov 2018 13:29:01 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id v191sm847512ywc.102.2018.11.29.13.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:29:00 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id g75so1414715ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:28:59 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr3306151ywo.168.1543526939594;
 Thu, 29 Nov 2018 13:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20181119154334.18265-1-tiny.windzz@gmail.com> <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
 <CAGXu5jJuHQOi3C7_xH7Fo2H-=EmzKkwAPWmWPOUNb0WWMTLnJQ@mail.gmail.com> <dd78fa9f-f27c-1579-1bc3-0b63acf54672@intel.com>
In-Reply-To: <dd78fa9f-f27c-1579-1bc3-0b63acf54672@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 13:28:48 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLk7tQDXWdvvYFeVoqmFwQp4yF6vv+AfTjJqXoaGFx8OA@mail.gmail.com>
Message-ID: <CAGXu5jLk7tQDXWdvvYFeVoqmFwQp4yF6vv+AfTjJqXoaGFx8OA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     Dave Hansen <dave.hansen@intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:45 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/27/18 2:50 PM, Kees Cook wrote:
> > On Mon, Nov 19, 2018 at 9:06 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> >> On 11/19/18 7:43 AM, Yangtao Li wrote:
> >>> -static const struct file_operations ptdump_curusr_fops = {
> >>> -     .owner          = THIS_MODULE,
> >>> -     .open           = ptdump_open_curusr,
> >>> -     .read           = seq_read,
> >>> -     .llseek         = seq_lseek,
> >>> -     .release        = single_release,
> >>> -};
> >>> +DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
> >>
> >> FWIW, I rather dislike this conversion and the DEFINE_SHOW_ATTRIBUTE()
> >> approach in general.  It makes it basically impossible to go from
> >> ptdump_curusr to ptdump_open_curusr without opening up the macro and
> >> reverse-engineering it.
> >>
> >> My test is that for these macros to be sane, I need to be able to find
> >> "ptdump_open_curusr" by grepping for "ptdump_curusr".  This fails the test.
> >
> > Er, "ptdump_curusr" matches the generated name "ptdump_curusr_show",
> > is that what you mean?
>
> Ahh, I also missed some of the renames to make this OK, like:
>
> > -static int ptdump_show_efi(struct seq_file *m, void *v)
> > +static int ptdump_efi_show(struct seq_file *m, void *v)
>
> I thought there was some macro magic going on that screwed the names up.
>
> This looks fine to me.
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Cool, thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

Ingo, can you toss this in -tip please?

-- 
Kees Cook
