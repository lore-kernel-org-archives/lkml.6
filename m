Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CA5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F520663
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SIeZE/G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfBLMNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:13:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLMNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:13:54 -0500
Received: from zn.tnic (p200300EC2BCF3C00E17E3E33645BAC72.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3c00:e17e:3e33:645b:ac72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96E4C1EC0104;
        Tue, 12 Feb 2019 13:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549973632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nn/1DHqBgMQ7XQ36X7KvIHrMtqWIvvyiI2CUcxTw5mY=;
        b=SIeZE/G+Dj62SYM/raPx4+wFeg72L6xOWQh5u/r4ICJ4lKWELHYQBhfPwcPKXpAgpZgsDn
        37xwbSu4UEA+VO7B7vCZWEC37Px3z66V68YSoEwr/D+FXetmSP1ef7t134hW9AmJrhgjQg
        y2raDAQHGhjESvNU8AzDWFxNiWVhLs4=
Date:   Tue, 12 Feb 2019 13:13:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190212121347.GD30028@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
 <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:51:08PM +0100, Jiri Slaby wrote:
> And what if the LOCAL macros prepend .L automatically? The references
> would need to be via macro or by manually adding .L. I mean:
> 
> SYM_CODE_START_LOCAL(function)
>   ret
> SYM_CODE_END(function)
> 
> And then used as:
> call .Lfunction
> or
> call SYM_LOCAL(function)
> 
> Is that too ugly?

I'd prefer SYM_LOCAL because not everyone is aware of the fact that the
GNU toolchain makes .L-prepended symbols local.

However:

"Local Symbol Names

A local symbol is any symbol beginning with certain local label
prefixes. By default, the local label prefix is `.L' for ELF systems or
`L' for traditional a.out systems, but each target may have its own set
of local label prefixes. On the HPPA local symbols begin with `L$'."

Now if you make those macros arch-independent, you need to have the
correct local symbol definition for those arches and targets(!) which
differ.

If you don't macroize the local symbols stuff, OTOH, then that's one
less problem you have.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
