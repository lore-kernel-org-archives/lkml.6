Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDB62098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wx79Dcp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDB62098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeHWEPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:15:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45964 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWEPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:15:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id u83-v6so2781955lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SL7J54XRlzmYNMr9lpFFkZX1OIMMzBGSjzTjkR8LXAA=;
        b=Wx79Dcp7dfwGxrBZeBu+RdEN21bcWopZMQ1boT677dK8XkV8MAcj9Ixc6MasgHRlU0
         +52OGO3RJV6clp26F2L2waHdO2EaZZ3xqC1GdnXoHeaEKTekB1faov07eDB2w/bG+dhN
         RAem+sFdzLGdC76F0vhBvWz6oQN+lydC7l+Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SL7J54XRlzmYNMr9lpFFkZX1OIMMzBGSjzTjkR8LXAA=;
        b=dD6KSzEXAgMEZBgkfqotosOfo29QRU8udAJCrzbKQjMe609bqY8mA6XW7L5FQEFJ99
         BvtcFJdgFzOkZpUivKCzh6cqudaAJlMQ1xuEEx0I1GhGt818oAlVcaIi/fIm1AH+MwQF
         Lzj/LIyKAlw7HRAgi0Fcy0NBBcUMiMzqAqE9hXcLIaONCXrJMUV4/+NxwzVVtq1AoY/g
         0FeQvexv8u2fLovGm90JOFolZTtStGzYB8kRRTouSV9ofMU4ZItqf2lBNExSclXpo50n
         y7NebMxT3i2X3TtJDWrB+yNfr+8H3VT8QZJ73P6DxuzyNrwWhCH8FO76Ui4mqEvMOwiB
         F/pw==
X-Gm-Message-State: AOUpUlH2bufvvZJhhhiIT3JlcHHEVnT6ItNFssI7nvuJUKsG/bjGTkHk
        AZryJm3+e/2isTAHOu9chwoy4mTVKhnzakmI7yJTPA==
X-Google-Smtp-Source: AA+uWPw3imzYSfYylRRRI7oEG2//SWwQkoDm/L+mST3/6/9uCkHCS2cYHALttfIOgngI7vMcjD4yA95LDEn17IRTl4Q=
X-Received: by 2002:a2e:9d45:: with SMTP id y5-v6mr40745788ljj.136.1534985324306;
 Wed, 22 Aug 2018 17:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
In-Reply-To: <20171215092311.347628971@linuxfoundation.org>
From:   Roland Dreier <roland@purestorage.com>
Date:   Wed, 22 Aug 2018 17:48:32 -0700
Message-ID: <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        ben.hutchings@codethink.co.uk, matt@codeblueprint.co.uk,
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

On Fri, Dec 15, 2017 at 2:20 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
> commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.
>
> Turns there was too many other issues with this patch to make it viable
> for the stable tree.

This was sort of a long time ago, but does anyone remember why this
needed to be reverted from 4.4?

The reason I ask is that without this, commit 02ff2769edbc /
"x86/mm/pat: Make set_memory_np() L1TF safe" in 4.4.148 is broken.
That patch has

-               set_pud(pud, __pud(cpa->pfn | _PAGE_PSE |
-                                  massage_pgprot(pud_pgprot)));
+               set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+                                  canon_pgprot(pud_pgprot))));

(and similarly for pmds) but pfn_pud() is operating on page frame
numbers and __pud(cpa->pfn... in the old code is operating on physical
addresses.

This is bad enough that 4.4.148 and all newer 4.4.y crash early in
boot on some EFI systems that I have.

For now I am re-applying the "ensure cpa->pfn only contains page frame
numbers" patch, ported on top of 4.4.151.

 - R.
