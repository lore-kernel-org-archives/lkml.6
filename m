Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B8321779
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmhweQwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B8321779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeHDXka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbeHDXka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:40:30 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897C321854
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533418706;
        bh=UgbtdEUDMwTAfPp0oHVk4r5WX30LlpoPgFC2Bdrs9j8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JmhweQwP5SH5dBW6831qTFSGAE5SgryNM2JxMrrt9wSyv0/c28q8GaU/rDT/+e+7m
         c70WLOD56yRZZbUffvGS9ogrc/CZf/SASkSh3G2/IN5mb8zO8SGklOCaXC+yQAqmSc
         x0DDOWf5uVQplPt3sCiULACv+yzi0wsBpyPwJHqQ=
Received: by mail-wm0-f48.google.com with SMTP id t25-v6so10114417wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 14:38:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlHtBdApLiIVTiyw2OzH6iHXmRbEvfjbzRP/+/25BGITHgerZJMw
        b9FsGTG6EmNELacuC606Xvg6k8Llg2m5ppYuYWTDNQ==
X-Google-Smtp-Source: AAOMgpeJEbzpMBd/jnyjJtvLmLyHxpdrGvx7gnTtlQEVzLZtHXlKjjnBJU0/WfG2mbtSXT9edHeSa4sQo7JRLAQr3FU=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr7488513wmd.46.1533418704915;
 Sat, 04 Aug 2018 14:38:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 14:38:04 -0700 (PDT)
In-Reply-To: <20180802225831.5F6A2BFC@viggo.jf.intel.com>
References: <20180802225823.4711C55B@viggo.jf.intel.com> <20180802225831.5F6A2BFC@viggo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 4 Aug 2018 14:38:04 -0700
X-Gmail-Original-Message-ID: <CALCETrV3O8WexN_zvksYWersyLu1K9GCiYJoLCB2-Jsxq9MGGQ@mail.gmail.com>
Message-ID: <CALCETrV3O8WexN_zvksYWersyLu1K9GCiYJoLCB2-Jsxq9MGGQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86/mm/init: remove freed kernel image areas from
 alias mapping
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 3:58 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> The kernel image is mapped into two places in the virtual address
> space (addresses without KASLR, of course):
>
>         1. The kernel direct map (0xffff880000000000)
>         2. The "high kernel map" (0xffffffff81000000)
>
> We actually execute out of #2.  If we get the address of a kernel
> symbol, it points to #2, but almost all physical-to-virtual
> translations point to #1.
>
> Parts of the "high kernel map" alias are mapped in the userspace
> page tables with the Global bit for performance reasons.  The
> parts that we map to userspace do not (er, should not) have
> secrets.
>
> This is fine, except that some areas in the kernel image that
> are adjacent to the non-secret-containing areas are unused holes.
> We free these holes back into the normal page allocator and
> reuse them as normal kernel memory.  The memory will, of course,
> get *used* via the normal map, but the alias mapping is kept.
>
> This otherwise unused alias mapping of the holes will, by default
> keep the Global bit, be mapped out to userspace, and be
> vulnerable to Meltdown.
>
> Remove the alias mapping of these pages entirely.  This is likely
> to fracture the 2M page mapping the kernel image near these areas,
> but this should affect a minority of the area.
>
> The pageattr code changes *all* aliases mapping the physical pages
> that it operates on (by default).  We only want to modify a single
> alias, so we need to tweak its behavior.
>
> This unmapping behavior is currently dependent on PTI being in
> place.  Going forward, we should at least consider doing this for
> all configurations.  Having an extra read-write alias for memory
> is not exactly ideal for debugging things like random memory
> corruption and this does undercut features like DEBUG_PAGEALLOC
> or future work like eXclusive Page Frame Ownership (XPFO).
>

I like this patch, and I tend to think we should (eventually) enable
it regardless of PTI.  Cleaning up the memory map is generally a good
thing.

Also, just to make sure I fully understand: the kernel text is aliased
in both the direct map and the high map, right?  This means that we
should be able to make the high kernel mapping have proper RO
permissions very early without breaking text_poke() at the minor cost
of needing to force a serializing instruction at the end of each big
block of text pokes.  I think this would be worthwhile, although I
suspect we'll uncover *tons* of bugs in the process.
