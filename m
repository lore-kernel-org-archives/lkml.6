Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AADC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76612075D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549926013;
	bh=RdARy0D2d2IImaaPeK+pm12Sk+zLe4PWvJ4Rp1UMq8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=obUw8hgSPidWi/OqiNf+hJxPoRydBIxWvHD5txUnBG933tbGi/ASEKg2MPv/Chscp
	 D7U0qWozycwW4YnDenj8jpiisGV3554xEIGH6L5YGIkLT1HxcodGc5ul5z97ce2hrO
	 iYqA+S9OfqqPU7s2qYrTDcZZTcXOPPFNmwR1WLIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfBKXAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfBKXAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:00:12 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C992083B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549926011;
        bh=RdARy0D2d2IImaaPeK+pm12Sk+zLe4PWvJ4Rp1UMq8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1U/t75gPlPzV0GunWAAj580UQ0M8IQO7b/0ocVXPNelID0RVlkdhMj4hsKGasjksD
         EVjIa8/xD1Gua910hLYZzaNPVVqqmjn0XIr7KSRz+zjA74djGWCRG2PhI6a6hymlpQ
         09sU7CdhUpL1YU0IzM5ExJ2bmf1i/5n92jcXqhYA=
Received: by mail-wm1-f52.google.com with SMTP id q21so958942wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:00:11 -0800 (PST)
X-Gm-Message-State: AHQUAubAbxtQK5grsZsyPpptr835FbwPGuwF7nhqONoDBH2PEpdkVrk/
        X+b1lzQ8Hxet/Ysv+KmdnDWDdOUlIJaFYXMCdIgPIw==
X-Google-Smtp-Source: AHgI3IY9/CMTozIoxXmaMd4k3IPzExCkXpyQ6EENDNglBFNRGElm4CwGZ5tQ0Jfoffwkks/clk12CUflqqHCBROQbIk=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr377508wmh.83.1549926009812;
 Mon, 11 Feb 2019 15:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-14-rick.p.edgecombe@intel.com> <20190211190925.GQ19618@zn.tnic>
In-Reply-To: <20190211190925.GQ19618@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Feb 2019 14:59:55 -0800
X-Gmail-Original-Message-ID: <CALCETrX2AOTTZOQafZgOFxiQsFgdYHVaLonXTqTa3RUs5MPVUQ@mail.gmail.com>
Message-ID: <CALCETrX2AOTTZOQafZgOFxiQsFgdYHVaLonXTqTa3RUs5MPVUQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/20] Add set_alias_ function and x86 implementation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 28, 2019 at 04:34:15PM -0800, Rick Edgecombe wrote:
> > This adds two new functions set_alias_default_noflush and
>
> s/This adds/Add/
>
> > set_alias_nv_noflush for setting the alias mapping for the page to its
>
> Please end function names with parentheses, below too.
>
> > default valid permissions and to an invalid state that cannot be cached in
> > a TLB, respectively. These functions to not flush the TLB.
>
> s/to/do/
>
> Also, pls put that description as comments over the functions in the
> code. Otherwise that "nv" as part of the name doesn't really explain
> what it does.
>
> Actually, you could just as well call the function
>
> set_alias_invalid_noflush()
>
> All the other words are written in full, no need to have "nv" there.

Why are you calling this an "alias"?  You're modifying the direct map.
Your patches are thinking of the direct map as an alias of the vmap
mapping, but that does seem a bit backwards.  How about
set_direct_map_invalid_noflush(), etc?

--Andy
