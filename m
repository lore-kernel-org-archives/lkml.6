Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3621906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NiH4XFZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404529AbeLUT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:29:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390204AbeLUT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:29:35 -0500
Received: from zn.tnic (p200300EC2BD18000058FF39CF3603A95.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:58f:f39c:f360:3a95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B6101EC05EB;
        Fri, 21 Dec 2018 20:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545420574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JBtL0Vn/mS61dloUbe+mQ9k1BsRRf3IQ6GTGFoXrbgA=;
        b=NiH4XFZubhfo7YEp4TwwKGwfIqOuSd9BWEGSO5if7DtTVSBpX+h9Vxh+nqC4/gYV4rR6SJ
        TNchoqePVUQPku11SK6G6v7X9KMifwIkmQe6Eii2j7CyKRao7SmRTicoMaut64mhha5XRC
        7coa17GYi0wDnM3vVeQ25tSWlFxgX28=
Date:   Fri, 21 Dec 2018 20:29:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        matt@codeblueprint.co.uk
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Message-ID: <20181221192928.GM1325@zn.tnic>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
 <20181221171308.GJ1325@zn.tnic>
 <CAKv+Gu91YsuK2QmWStPe84v8L7XD9x4cduTYgUjj3TPRfQckfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu91YsuK2QmWStPe84v8L7XD9x4cduTYgUjj3TPRfQckfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 06:26:23PM +0100, Ard Biesheuvel wrote:
> On Fri, 21 Dec 2018 at 18:13, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Dec 21, 2018 at 06:02:29PM +0100, Ard Biesheuvel wrote:
> > > As far as I can tell, the SGI x86 UV platforms still rely on this, so
> > > we're stuck with it for the foreseeable future.
> >
> > What happened with the old apple laptops which couldn't handle high
> > virtual mappings and needed 1:1? We don't care anymore?
> >
> 
> If that is the case (I wouldn't know) then yes, there is a second
> reason why we need to keep this code.

Fleming knows details and he's on CC, lemme "pull" him up into To: :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
