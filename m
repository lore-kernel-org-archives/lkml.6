Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B04C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BAE20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dwTAHoYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfAMOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 09:37:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfAMOh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 09:37:28 -0500
Received: from zn.tnic (p200300EC2BE08000EDE322DDA64824A6.dip0.t-ipconnect.de [IPv6:2003:ec:2be0:8000:ede3:22dd:a648:24a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDE981EC027A;
        Sun, 13 Jan 2019 15:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547390246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tl7qcAZ8FNvp4oWx6utLsw1//jsL8nUvAjTmv+F2lD8=;
        b=dwTAHoYDMaSYk2JNGi1ewBYra5ghgAdhf2+xEVZvhgud5CjQi2TJcCLDk1Ij4J/+d/KdY/
        yUY80GT7z8u8XbBIsyAEPC8KIAyOI8rQwByS+rguhF15y1fjcQav0Urzi6r3GZfGpksHh6
        Z/XNytubmRBtPs4+3gBR1cJi7eYBH+Q=
Date:   Sun, 13 Jan 2019 15:37:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] x86/kvm: Enable MCE injection in the guest
Message-ID: <20190113143719.GA25673@zn.tnic>
References: <20181114181507.6037-1-bp@alien8.de>
 <64d0e75f-f292-7e63-dd66-4e05d4afed5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64d0e75f-f292-7e63-dd66-4e05d4afed5b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:41:21PM +0100, Paolo Bonzini wrote:
> On 14/11/18 19:15, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Hi all,
> > 
> > here's a rediff ontop of -rc2. No changes, only added Yazen's Tested-by.
> > 
> > Please queue,
> > thx.
> > 
> > Changelog:
> > ==========
> > 
> > v2:
> > 
> > here's v2, dropping patch 3 and incorporating hopefully all of Radim's
> > feedback.
> > 
> > v1:
> > 
> > there's this mce-inject.ko module in the kernel which allows for
> > injecting real MCEs and thus test the MCE handling code.
> > 
> > It is doubly useful to be able to inject same MCEs in a guest so that
> > testing of the MCE handling code can happen even easier/faster. In order
> > to be able to do that on an AMD guest, we need to emulate some bits
> > and pieces like the HWCR[McStatusWrEn] bit which allows writes to the
> > MCi_STATUS registers without a #GP.
> > 
> > The below does that and with it I'm able to properly inject MCEs in said
> > guest.
> > 
> > --
> > 
> > Borislav Petkov (2):
> >   kvm/x86: Move MSR_K7_HWCR to svm.c
> >   x86/kvm: Implement MSR_HWCR support
> > 
> >  arch/x86/kvm/svm.c | 20 ++++++++++++++++++++
> >  arch/x86/kvm/x86.c | 46 +++++++++++++++++++++++++++++++---------------
> >  2 files changed, 51 insertions(+), 15 deletions(-)
> > 
> 
> Queued, thanks.

Where?

I don't see them in rc1...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
