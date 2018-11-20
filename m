Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20635C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84262080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxfVaiJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84262080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeKTKtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeKTKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:49:19 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CE2213A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542673382;
        bh=/rykdRXYDlUm3+7nv/S7Qv7cIJcWgF/dxNU1v/10oVc=;
        h=From:Date:Subject:To:From;
        b=XxfVaiJOXg0mobND4dvNzizHN728Lnt/B2XMA99DPQpfYKGokMWalPvVGsdVrJb70
         q6yl8n0dV5dHlLF/fnl7w6e761atpNjWPJaFNoisYqN0M1AOSAbU7ORGB68YbgUoxj
         HYEeghdvAmGp6lz0kN6f0QVI5WJZfspMZC9wbbWE=
Received: by mail-wr1-f42.google.com with SMTP id e3-v6so119721wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:23:02 -0800 (PST)
X-Gm-Message-State: AA+aEWZGw7A5dp+a1/KvoSf7aW/OZ7ilfVImQXll0d944zNhiMPNmoKn
        XfvY/BKUmjJxrwtawMoqpK9KApxmfrvYLcSN9FAjPg==
X-Google-Smtp-Source: AFSGD/Uu5L2OFHzCS5XzasDHlsEC6Q4yVgJvGpeHlSrnNFpb8S0iZ/GVmp+A6V8m51hDSQm+hrYuQu/M2XCoXgW66/8=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr6974144wrw.330.1542673380946;
 Mon, 19 Nov 2018 16:23:00 -0800 (PST)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 16:22:49 -0800
X-Gmail-Original-Message-ID: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
Message-ID: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
Subject: Cleaning up numbering for new x86 syscalls?
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

We currently have some giant turds in the way that syscalls are
numbered.  We have the x86_32 table, which is totally sane other than
some legacy multiplexers.  Then we have the x86_64 table, which is,
um, demented:

 - The numbers don't match x86_32.  I have no idea why.

 - We use bit 30, which triggers in_x32_syscall().  It should have
been bit 31, bit I digress.

 - We have this weird set of extra x32 syscalls that start at 512.
Who wants to bet whether we have no bugs if someone does syscall with,
say, nr == 512 (i.e. not 512 | BIT(30)) or nr == (16 | BIT(30))?  The
latter would be non-compat ioctl with in_x32_syscall() set and hence
in_compat_syscall() set.

 - Bloody restart_syscall() has a different number on x86_64 and
x64_32, which is a big mess.

I propose we consider some subset of the following:

1. Introduce restart_syscall_2().  Make its number be 1024.  Maybe
someday we could start using it instead of restart_syscall().  The
only issue I can see is programs that allow restart_syscall() using
seccomp but don't allow the new variant.

2. Introduce an outright ban on new syscalls with nr < 1024.

3. Introduce an outright ban on the addition of new __x32_compat
syscalls.  If new compat hacks are needed, they can use
in_compat_syscall(), thank you very much.

4. Modify the wrappers of the __x32_compat entries so that they will
return -ENOSYS if in_x32_syscall() returns false.

5. Adjust the scripts so that we only have to wire up new syscalls
once.  They'll have a nr above 1024, and they'll have the same nr on
all x86 variants.

Thoughts?
