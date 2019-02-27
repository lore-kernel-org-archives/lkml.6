Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D73C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890972183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfB0Oz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:55:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40220 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfB0Oz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:55:58 -0500
Received: by mail-it1-f195.google.com with SMTP id l139so8128226ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnjpDmXT2EqnZlf06IOTHITcaZjhV0SF0UqYv79HErg=;
        b=nELISoggVhOIm102oiLegKmaxFM5PV6Q3JhjZjzQZTZPsxpAeqdVixh02vdK7QXAPN
         UEN5d8Pg66lu+lQYsMRODFdj8qC0bSjvNY1aTNJZ8+jb9AP4GPOLg0RCwhgxUf9NRDt8
         zGp3M316IAA+RGfkBtq7OoRhDFkFOX8bacR0UK+nmsWzOOyTDhnMMN6fhqnISGi2jQGT
         Z+oQt4QkBiLTtuIifW8kzNrxU6KMy5xSj82KO91Cr6CheakDN6uRoW8QPZfSIBd42njX
         tMeumfF+N6okVpsHCOskK0brhcQYwgp9rDcVhbICyzgg2IJTHIwR9fo+FgdiqQA3poTW
         qMTQ==
X-Gm-Message-State: AHQUAuaHDipeNtjTI/twDUKsm2OKlOcRFXqDSoTjDwgYndcKS3oy1Ukx
        gOzKFZm//qrgoyEHpL66uu5gD7BYD5CbRLV557s9zg==
X-Google-Smtp-Source: AHgI3IZt//O2Qg0ywe1CRFoqDbWQK+yB8InnWJ3GF3op+zI1rtVeU6g7MbPgjf0QS8M79gT5yMc+/v3k4AbEmxLZYrY=
X-Received: by 2002:a24:789:: with SMTP id f131mr1831381itf.19.1551279357427;
 Wed, 27 Feb 2019 06:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20190226155615.16724-1-kasong@redhat.com> <20190227120141.GN32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227120141.GN32494@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 27 Feb 2019 22:55:46 +0800
Message-ID: <CACPcB9c86eT=kXcXkBkUjZnifk5bZ71SogfW2tyNudrVmWbnDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86, hyperv: fix kernel panic when kexec on HyperV VM
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 8:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 26, 2019 at 11:56:15PM +0800, Kairui Song wrote:
> >  arch/x86/hyperv/hv_init.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 7abb09e2eeb8..92291c18d716 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -406,6 +406,10 @@ void hyperv_cleanup(void)
> >       /* Reset our OS id */
> >       wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> >
> > +     /* Cleanup page reference before reset the page */
> > +     hv_hypercall_pg = NULL;
> > +     wmb();
>
> What do we need that SFENCE for? Any why does it lack a comment?

Hi, that's for ensuring the hv_hypercall_pg is reset to NULL before
the following wrmsr call. The wrmsr call will make the pointer address
invalid.
I can add some comment in V2 if this is OK.


--
Best Regards,
Kairui Song
