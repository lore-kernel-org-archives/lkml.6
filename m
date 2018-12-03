Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE50C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F38A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLCHgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:36:18 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38078 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeLCHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:36:17 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so6896485vsa.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 23:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/Tcax7EnITvjeEoC/VRKi7pBLEs8Ms3pTi33Q8Lx6s=;
        b=YzluN6Ioe6u+FFsC4JiMKQ6KkVOw+h2OM8WSKAPHzixd35/EZsp499x8CpINy5ohSs
         5rqaV4b8kLv20cfaPpdMtu1RlEq6hFUhRwFPqIjC2WR0/kUIJ5pHEgZvLgmrC1fNZ+eS
         Dr6SDau4oSk/mzCBLQsyiHJcN9LLo5O6l2vhkKDk5UBrBPqF+W6K48g7CwKsOqpFww7R
         gG/8MYKbXBKW5x9uCMIyr5ofGLMk9V8JH8fVpfD7Wb9lT8x29Poho+a8ko/VF8nf93qs
         HlK0H2CviD0czu2igA9swdO9tLLluyKWXEeA7qUD64m9IH1MylHjbfH35siFN8JEazY4
         k8PA==
X-Gm-Message-State: AA+aEWYuQeYSOYVx2jWaHJabFCex3VYNhbCf6pTkURLwTLH+5DPEwnM4
        s9vDDxKG+yyc7BboFnonc1w6n5DEF/3cVdjT50c=
X-Google-Smtp-Source: AFSGD/VgubTrKrqRiYvc5MRC7XuAJK8ItYO7lgjPYy3ui3Vc615vhrXNsO4DX6xzdTE9706zUC4kmAIo+e31zofBtwY=
X-Received: by 2002:a67:d119:: with SMTP id u25mr5889191vsi.63.1543822575283;
 Sun, 02 Dec 2018 23:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20181120001128.GA11300@altlinux.org> <20181120001524.GF11387@altlinux.org>
 <CAMuHMdV+-Lw-mx8OAifrFP--XhbiHr8hAZ56rsG=9Ayu9BeXtw@mail.gmail.com> <20181203002436.GA9487@altlinux.org>
In-Reply-To: <20181203002436.GA9487@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Dec 2018 08:36:03 +0100
Message-ID: <CAMuHMdX5nR03E46u_p5+cDNYLYZzT3+ZwC0t8Wfu540BFbP5aQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] m68k: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>, lineprinter@altlinux.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Dec 3, 2018 at 1:24 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Sun, Dec 02, 2018 at 11:29:10AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Nov 20, 2018 at 1:15 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > syscall_get_arch() is required to be implemented on all architectures
> > > in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> > > request.
> > >
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > What's your plan w.r.t. the upstreaming strategy?
> > Do you plan to get this series in as a whole, or through individual architecture
> > maintainers?
>
> Given that the last patch in this series adds an argument
> to syscall_get_arch(), my plan is to get this series in
> as a whole along with PTRACE_GET_SYSCALL_INFO series.

Cool, thanks!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
