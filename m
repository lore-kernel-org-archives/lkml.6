Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C3CC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60E20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfAUPyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:54:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37744 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAUPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:54:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so24014788qtt.4;
        Mon, 21 Jan 2019 07:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BolUHUemdSZNYDTaUCTkJTDa+hu/AMvXO0Ph+5Tguds=;
        b=nS+rQk60Pq3WTGnlnXrqoLS0+adnBxu+vaPyTDGw31/e1kQLgdZXehQwEdlhJTeQVa
         xdboAjvUexCZuLr5t7sah5rP/yJ0tAbjlTMZHdYf7ijAe+q6J8PY1UeC4z6kmsKmW1SE
         GMDFcvmyRvRQI1fhTuCtf1GUY+ek9zqP4wZsxW+07JjI2VOT1hl9srgY57Fie1nlrMfo
         ZGzdVPojp976Yd9qhRJ083YGNhW6lfaepETKxJpwLOyaBVQI1JZF96x74ZnxGOZKgBkP
         O7aCWJUGLy/BWYgL+MRXh42P26gZ3uUVyA29CLgjbDrcQIO2/B2UCjyT8+vo6J/fL2eV
         Jjcg==
X-Gm-Message-State: AJcUukf3EAoiaWy4+UB/OebO2kdmt8ArxlVmQyRNOuy6wlSUZysAifwF
        9pq1YuLiO3LN8TXEn2vvKgmCKbz37mYuL92SBVw=
X-Google-Smtp-Source: ALg8bN4xhZ8yHvW/KbKdBj9RO2PeHmyu5vnU6SbfaaKJj41epoElZRzRk0KzYbg3nXv6YWZzWm/df9KJulT854RZ60g=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr26877541qtr.319.1548086050519;
 Mon, 21 Jan 2019 07:54:10 -0800 (PST)
MIME-Version: 1.0
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org> <20190119235650.GC26876@brain-police>
In-Reply-To: <20190119235650.GC26876@brain-police>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 16:53:54 +0100
Message-ID: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
To:     Will Deacon <will.deacon@arm.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > This will be an automated scripts to provide easy support
> > for add/modify/delete the system call entry by add in
> > respective *.tbl file.
> >
> > System call table generation support for asm-generic is
> > provide for arm64 architecture which will use the common
> > scripts resides in scripts directory and use syscall.tbl
> > syscall_arm32.tbl files as inputs. This implementation
> > will replace asm-generic/unistd.h.
> >
> > This patch depends on:
> >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
>
> I'm having a hard time understanding what the benefit of this series is,
> given that we only support EABI compat tasks. When adding a new compat
> system call, you can't just blindly hook it up without checking whether it
> needs a wrapper to deal with any type conversion etc, so really we're just
> replacing one table with another as far as I can tell. What am I missing?

The point that is missing in the description above is that all unistd.h
and syscall.S files are now being generated from a .tbl file, across
all architectures. This was already done on arm32, x86 and s390
before 4.20, but is now done on all architectures that don't use
the uapi/asm-generic/unistd.h header, and the arm32 compat version for
arm64.

The newly added file has the same format as all other tables, and
will be easier to synchronize with the arm32 version, which has
almost the same contents (arm32 has oabi support, arm64 has
compat support).

> I also really don't think we should be generating the 32-bit UAPI headers
> from the 64-bit compat system call support (if that's what you're trying to
> do -- make headers_check fails with your patches applied). arch/arm/ is the
> canonical place for the 32-bit UAPI, and we're just implementing that.

I think you just misread what Firoz was trying to say here: The
arm64 uapi/asm/unistd.h file is now being generated from the
generic syscall.tbl file, while the compat asm/unistd32.h file is not
part of the UAPI. In both cases though, the data from the old files
is being replaced with data in the more compact and (hopefully)
more readable format.


    Arnd
