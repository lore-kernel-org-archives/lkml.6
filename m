Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943F92081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491434;
	bh=h+XzGKcY765gMTqyVPOnShXTl/WRhYXmIfcJYSI4BjU=;
	h=From:Date:Subject:To:List-ID:From;
	b=C3z47jwvWFrMRLFvk5Aj3phpM0F/VO26xcIIMTfCm8O7UxQaeo8BkfPAGQ6WwjRFI
	 HhoZmF15qasgzeaRRCLz6I4hYQrm8PGY7mpy7W7PJktzykMha71MWihNG92WnN0xRR
	 kW8DR3ZX7dbHWgxDz9QljHF0w5gDGKplTEMw/W7I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943F92081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeLKBXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:23:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbeLKBXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:23:53 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0A32146D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544491432;
        bh=h+XzGKcY765gMTqyVPOnShXTl/WRhYXmIfcJYSI4BjU=;
        h=From:Date:Subject:To:From;
        b=NCa31ih7NNj13BLUs+ykXpoVLKUyxkOcLI3q/2DBznfKYRWVNFn71BFveT//6X+r7
         VYp9x+uRt7iX+kJx4WQl6fsr56FihLU+/B9KdZef6EN/OlUktk/sqLnQ3Be1SeJXj6
         gwLKL2RzgDPXzSJFFEEUwKpFFWW+bcBsJNjMaVuI=
Received: by mail-wm1-f46.google.com with SMTP id q26so495228wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:23:51 -0800 (PST)
X-Gm-Message-State: AA+aEWb7p69oWGGxRDMRonC528PQkbzRPs2DwRpF2pMS5xk9mWEg08qh
        m6muUxo0pqWcwfCMgdLT7BT8ciJiaPUvg5+eerL7Rw==
X-Google-Smtp-Source: AFSGD/UzrLGq4rHShWyLlrcUB90AgZlJAieEILp7phscfMKb8KA0KcHH2yrKMljYQUJD1W2EU5IoN3gjqXbx0yLH298=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr537345wmc.74.1544491430259;
 Mon, 10 Dec 2018 17:23:50 -0800 (PST)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Dec 2018 17:23:39 -0800
X-Gmail-Original-Message-ID: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
Message-ID: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
Subject: Can we drop upstream Linux x32 support?
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

I'm seriously considering sending a patch to remove x32 support from
upstream Linux.  Here are some problems with it:

1. It's not entirely clear that it has users.  As far as I know, it's
supported on Gentoo and Debian, and the Debian popcon graph for x32
has been falling off dramatically.  I don't think that any enterprise
distro has ever supported x32.

2. The way that system calls work is very strange.  Most syscalls on
x32 enter through their *native* (i.e. not COMPAT_SYSCALL_DEFINE)
entry point, and this is intentional.  For example, adjtimex() uses
the native entry, not the compat entry, because x32's struct timex
matches the x86_64 layout.  But a handful of syscalls have separate
entry points -- these are the syscalls starting at 512.  These enter
through the COMPAT_SYSCALL_DEFINE entry points.

The x32 syscalls that are *not* in the 512 range violate all semblance
of kernel syscall convention.  In the syscall handlers,
in_compat_syscall() returns true, but the COMPAT_SYSCALL_DEFINE entry
is not invoked.   This is nutty and risks breaking things when people
refactor their syscall implementations.  And no one tests these
things.  Similarly, if someone calls any of the syscalls below 512 but
sets bit 31 in RAX, then the native entry will be called with
in_compat_set().

Conversely, if you call a syscall in the 512 range with bit 31
*clear*, then the compat entry is set with in_compat_syscall()
*clear*.  This is also nutty.

Finally, the kernel has a weird distinction between CONFIG_X86_X32_ABI
and and CONFIG_X86_X32, which I suspect results in incorrect builds if
the host doesn't have an x32 toolchain installed.

I propose that we make CONFIG_X86_X32 depend on BROKEN for a release
or two and then remove all the code if no one complains.  If anyone
wants to re-add it, IMO they're welcome to do so, but they need to do
it in a way that is maintainable.

--Andy
