Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856FC208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G+I98Tei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856FC208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeHWUIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:08:16 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42132 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHWUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:08:15 -0400
Received: by mail-lf1-f43.google.com with SMTP id z11-v6so4531147lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjaRiPtoYR1TUV2xS3nIQikfWGj8T6ZtGvRjPOVZdQc=;
        b=G+I98TeiFo9+G+KTLzOEMEg0Bzku6CnZvhr+Q/7LXbEU7+FUXVbR+uMjBhSilGmdYl
         /TWPrjlUz9XmIdTR/xBVIs0CKHM9FLaOpW4Pan0BunubSahr8W89/65e9tIOEpdgxvVj
         7xvYiLy+3E170Hfk7jdOmf8DefpMBOTgBQofU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjaRiPtoYR1TUV2xS3nIQikfWGj8T6ZtGvRjPOVZdQc=;
        b=c1gJV4KIttyzT1oZziG9BQoE5rZ0dC2p2zEA+gjh7a9wqEZDyQPMtLCrh6KOlNchRI
         UYQoFkTPSnlYN2cR8kDGuqw7D86DuntNEz3vQbpAdGxv43Ne7xsG/AkiLTwtiDNLm2UO
         tXZOpTY/MhfWvlJp/bZ2Oa2BBLn72ElhKbWxC4GahcPxJgmvbcsv0mCuXyPiOG7uDYL3
         vaq8Ptsho1MAz3EHHwIv99gjHKLyESDE+N7sxmsnlk2zueIMyWbS4ApSx+rjabrq4EEW
         B0ZPzg1JZNnm0sYVjEJpXqRBZ5sXiIab0GppTd+AxVo+MKS8II3lylx+KlxKw/8dmkZ3
         IxkQ==
X-Gm-Message-State: AOUpUlGkD/zCJcHoTB7S6A0C847PML0WkJzr2LQCR95+KccgTrIG9e39
        J/mACkOyVcTAnDU8RhLQNzTwTcnjna0jugVHdFYYUpfeBE8=
X-Google-Smtp-Source: AA+uWPwcLTx2EuOMH4Q2XAvJxjvsWFr9ABdEWBgblTCXSt77vhYEBTefZMjIqlQJpsIcjN+5sJ2pVGCFSV0oPrCMMkQ=
X-Received: by 2002:a19:cb93:: with SMTP id b141-v6mr20136415lfg.119.1535042262779;
 Thu, 23 Aug 2018 09:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com> <20180823061253.GA8803@kroah.com>
In-Reply-To: <20180823061253.GA8803@kroah.com>
From:   Roland Dreier <roland@purestorage.com>
Date:   Thu, 23 Aug 2018 09:37:28 -0700
Message-ID: <CAL1RGDUxkWm+tSdLmptSZZ55mdWCR6i1GevMUx_K-a2BX74xdQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt@codeblueprint.co.uk, ben.hutchings@codethink.co.uk
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        bp@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        ard.biesheuvel@linaro.org, bp@alien8.de, brgerst@gmail.com,
        davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is bad enough that 4.4.148 and all newer 4.4.y crash early in
> > boot on some EFI systems that I have.
>
> Ugh, not good.
>
> > For now I am re-applying the "ensure cpa->pfn only contains page frame
> > numbers" patch, ported on top of 4.4.151.
>
> I can try to add it back and see what blows up, want me to attempt that?

Not sure what to say... the current state is obviously broken.  If you
look at what 02ff2769edbc is doing, it's clear that we're now shifting
cpa->pfn by PAGE_SHIFT where we weren't before, so we're putting bogus
values in the page table.  And this is enough that my server system
booting with EFI crashes early in boot efi_enter_virtual_mode() with
the symptom that NX is improperly set on some pages (booting with
"noexec=off" fixes things, although obviously I don't want to run that
way).  FWIW I can confirm that reverting the single patch 02ff2769edbc
fixes things, as does the cpa->pfn fix I mentioned above.

It's hard for me to make a call on applying "ensure cpa->pfn only
contains page frame numbers" without knowing the problems it caused
before.  The patch looks fine to me and I definitely need it, but
maybe it exposes some other bug elsewhere?  Maybe Ben or Matt remember
more above why this was reverted in 4.4.106?  Otherwise I'd say yeah,
we should re-apply it, since I don't think we want to revert
02ff2769edbc.

 - R.
