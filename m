Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B69AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C680217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iHt4QD/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfBZKq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:46:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfBZKq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:46:58 -0500
Received: from zn.tnic (p200300EC2BCDB2001DA4ECEFA9208567.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:1da4:ecef:a920:8567])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 105711EC023E;
        Tue, 26 Feb 2019 11:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551178017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UtRKe1UZfbyXC/+t4KcHfOTMhZy9W6j2yJlBltm8d1Y=;
        b=iHt4QD/j8+og9z4jXS29xHFtYGpZWd2WzxK24iCYXZv4fQoq2WCE17cQfxHSUMm1l5eShu
        o06T9ZyTpj5EobODyCUhuF0MVNJ/fzD8J5FdkPcj2l4zs1ZojY+hGSAB/SZ4haUb5jMYFO
        8xRVn+Dlgh16/+a47ulMu4qjo2Z3IQs=
Date:   Tue, 26 Feb 2019 11:46:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190226104653.GB14836@zn.tnic>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic>
 <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:08:42AM +0800, Pingfan Liu wrote:
> I follow Baoquan's opinion. Due to the randomness caused by KASLR, a
> user may be surprised to find crashkernel=x@y not working sometime.

And she/he will get told in dmesg that the allocation failed.

> If kernel can help them out of this corner automatically, then no
> need to bother them with the message to use alternative method
> crashkernel=M. Anyway it is a cheap method already used by other
> options like hugepages and memmap in handle_mem_options().
> If commitment, then do it without failure. Or just removing
> crashkernel=x@y option on x86.

I can't parse what you're trying to say here but let me repeat myself:
specifying a crashkernel region should not have an influence on KASLR
because this way you limit the kernel where it selects the offset. It
should be other other way around: KASLR offset should be selected and
*then* crashkernel region.

IOW, KASLR offset selection needs to have higher priority than
crashkernel region selection.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
