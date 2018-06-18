Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE327C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B41F20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B41F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754136AbeFRT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:56:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935743AbeFRT4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:56:24 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U0OhzL_MIVD2; Mon, 18 Jun 2018 21:56:22 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A32621EC00EE;
        Mon, 18 Jun 2018 21:56:22 +0200 (CEST)
Date:   Mon, 18 Jun 2018 21:56:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        hpa@zytor.com
Subject: Re: [PATCH] x86/microcode/intel: Ensure new microcode processor
 flags match with cpu's pf
Message-ID: <20180618195619.GH24921@zn.tnic>
References: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 08:16:51AM +0000, Zhenzhong Duan wrote:
> Intel spec says: 'The processor flags in the 48-byte header and the
> processor flags field associated with the extended processor signature
> structures may have multiple bits set.'
> 
> Make sure processor flags of the new microcode intersect with current
> cpu's. Comparing with old microcode's pf can't guarantee this.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 461e315..54f4014 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -371,12 +371,10 @@ static int microcode_sanity_check(void *mc, int print_err)
>  				goto next;
>  
>  		} else {
> -			struct microcode_header_intel *phdr = &patch->hdr;
> -
>  			if (!has_newer_microcode(data,
> -						 phdr->sig,
> -						 phdr->pf,
> -						 phdr->rev))
> +						 uci->cpu_sig.sig,
> +						 uci->cpu_sig.pf,
> +						 patch->hdr.rev))
>  				goto next;
>  		}
>  
> -- 

So I'm scratching my head over this and have no clue what you're trying
to achieve. Is this a fix for a bug you're seeing or what? You'd need to
be a lot more verbose when explaining what this patch is trying to do...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
