Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02006C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A8208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FejRTz2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51A8208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeFUPOF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:14:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53197 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbeFUPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:14:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so5819880wmb.2;
        Thu, 21 Jun 2018 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1dnGEY2d+eFry97V6/ISRPoglkGlaa0m94mcIpCfzs=;
        b=FejRTz2X7sK5ZIP+ngdL5N+Oz9l6oj/W27NSNe7mc2bOS06gI1Ih9+dST08r43qd6y
         RVyRNhfDDcPEXFbu9O+jrVCyF5NuckGoYx+3wlDBn9Y3jMqIHlvlLBGDnrxy9N4B6Ucq
         vbUSFIs+QL4+8RNUak0s/m/IVeWNu4uUaFhBctooZVmAOFMIdU/KzBVoZD8h2W3mSYeN
         b4oZvJwYAa0Kw5CXHD7iIiJoNAPEK8b5/tlAKHmYd8CPO9ugHY6wHXiaXMUaTo9Q/G98
         Rzza9EbkQsem3urBkZ+eINw/Mk5TzPxnkYaddhP0WOtuIF/IkOe4igmhpqzG/CAGkxN+
         hfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1dnGEY2d+eFry97V6/ISRPoglkGlaa0m94mcIpCfzs=;
        b=VRI9LBg/fWoIKtyMpsE4ieio1KI2fBlVzKKMFvBuuMkTEFrClvGOQIfDSrKHjMRIc2
         vMrT8LhXL5lhvCUSqhKWxF33Nkt7fg9MRWZaU5RCj4V5LgG4AVAInNkT9gFO/malvquP
         Wg9sI+cX+drPhRDJYccduHWyG4x81nBoTVB9O1JBM9EmrlN7fwVgtC9M1O1Bg7yKJhjF
         3muZ9DkaKnIWafFmzQRUnfgSWC/i2D9tEPMRzEeugos3JTVp4HB5IzdYZKiby9GDtLVp
         jDsWG/q8CYzFnHlrCfvPWfwwWzWR0tqeSK4XPVfMwucoh3KC7Yf5uO/e88QCaWuRqQL+
         lDCA==
X-Gm-Message-State: APt69E3Gnxf0sAdVfsWpN+13Z88bBOpyZrQn/1U45qq5gApOvZv/sJgv
        TNcykv668Q4f7XV5n7sUYIs=
X-Google-Smtp-Source: ADUXVKKP2LdSIyQJx4YA2+267T0fux2YJHs99BZGv7zDAisdrCBmN50q0rvKtaQqeNX4DDiZWpEmYw==
X-Received: by 2002:a1c:e546:: with SMTP id c67-v6mr5328420wmh.108.1529594042139;
        Thu, 21 Jun 2018 08:14:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n23-v6sm4102199wmh.6.2018.06.21.08.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:14:01 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:13:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:efi/core] efi/x86: Ignore unrealistically large option ROMs
Message-ID: <20180621151359.GA26017@gmail.com>
References: <20180504060003.19618-16-ard.biesheuvel@linaro.org>
 <tip-1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f@git.kernel.org>
 <CAKv+Gu94+dK1WM__thFup9AmPrEqJ-7Ojynnx4hO9picanwhcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu94+dK1WM__thFup9AmPrEqJ-7Ojynnx4hO9picanwhcQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 14 May 2018 at 09:50, tip-bot for Hans de Goede <tipbot@zytor.com> wrote:
> > Commit-ID:  1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f
> > Gitweb:     https://git.kernel.org/tip/1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f
> > Author:     Hans de Goede <hdegoede@redhat.com>
> > AuthorDate: Fri, 4 May 2018 08:00:01 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 14 May 2018 08:57:49 +0200
> >
> > efi/x86: Ignore unrealistically large option ROMs
> >
> > setup_efi_pci() tries to save a copy of each PCI option ROM as this may
> > be necessary for the device driver for the PCI device to have access too.
> >
> > On some systems the efi_pci_io_protocol's romimage and romsize fields
> > contain invalid data, which looks a bit like pointers pointing back into
> > other EFI code or data. Interpreting these pointers as romsize leads to
> > a very large value and if we then try to alloc this amount of memory to
> > save a copy the alloc call fails.
> >
> > This leads to a "Failed to alloc mem for rom" error being printed on the
> > EFI console for each PCI device.
> >
> > This commit avoids the printing of these errors, by checking romsize before
> > doing the alloc and if it is larger then the EFI spec limit of 16 MiB
> > silently ignore the ROM fields instead of trying to alloc mem and fail.
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > [ardb: deduplicate 32/64 bit changes, use SZ_16M symbolic constant]
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> This looks odd now: I sent this out as
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> [ardb: deduplicate 32/64 bit changes, use SZ_16M symbolic constant]
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> which clearly conveys that Hans tested the updated version of the patch.
> 
> In general, I don't think there is a need to reorder signoffs unless
> there is anything wrong with them, no?

Indeed - this is a script bug that I failed to notice.

Thanks,

	Ingo
