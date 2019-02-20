Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6FC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311BF2195D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DpzX2uJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBTQHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:07:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTQHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:07:13 -0500
Received: from zn.tnic (p200300EC2BCB85008CB41DEE22243FB8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:8500:8cb4:1dee:2224:3fb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8BA21EC0375;
        Wed, 20 Feb 2019 17:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550678832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FuWrqm3gYIKjPp/OIyk2H5wvXxskQnamgQncl/lDD4g=;
        b=DpzX2uJTFznTEjpd31L8k3uyQMoAFpgLU8lA/Ya7UBoOQFWC3YY0qJMXIrWh/pC9+7Ao3v
        xNXOsGv4+u6RVMGexsvnSWvr0Gy7c4a+HqE/yjbSxMrnMBiumPNvRFdjGCMHIEn+E9kH2A
        F76Uq/Q0Uqj7Fuhk1zu9rh3uVNQkHlg=
Date:   Wed, 20 Feb 2019 17:07:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 14/20] mm: Make hibernate handle unmapped pages
Message-ID: <20190220160703.GD3447@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-15-rick.p.edgecombe@intel.com>
 <20190219110400.GA19514@zn.tnic>
 <07ea2a4a9f1771f7bad82ad8fe5ee9483b79d115.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07ea2a4a9f1771f7bad82ad8fe5ee9483b79d115.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:28:55PM +0000, Edgecombe, Rick P wrote:
> These are from logs hibernate generates. The concern was that hibernate could be
> slightly slower because of the checking of whether the pages are mapped. The
> bandwidth number can be used to compare, 819.02->813.32 MB/s. Some randomness
> must have resulted in different amounts of memory used between tests. I can just
> remove the log lines and include the bandwidth numbers.

Nah, I'm just trying to get an idea of the slowdown it would cause. I'm
thinking these pages are, as you call them "special" so they should not
be a huge chunk of all the system's pages, even if it is a machine with
a lot of memory so I guess it ain't that bad. We should keep an eye on
it though... :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
