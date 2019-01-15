Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AB820651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfAOKbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:31:07 -0500
Received: from ozlabs.org ([203.11.71.1]:35775 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfAOKbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:31:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43f67Y0DwVz9s9G;
        Tue, 15 Jan 2019 21:31:03 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, benh@kernel.crashing.org,
        paulus@samba.org, aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] powerpc: PCI does not require PowerNV
In-Reply-To: <20190115004745.9996-1-Jason@zx2c4.com>
References: <20190115004745.9996-1-Jason@zx2c4.com>
Date:   Tue, 15 Jan 2019 21:31:02 +1100
Message-ID: <87d0oyyzyx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for the patch.

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
> did not conditionalize it inside of the PCI pSeries driver. This meant
> that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
> in:
>
> powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
> pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'
>
> This commit therefore wraps that line in an ifdef, so that PCI works
> without PowerNV.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")

I think this should actually be:

  Fixes: 3be2df00e299 ("powerpc/pseries/npu: Enable platform support")

Because that's the commit that added the call to pnv_npu2_init() in the
pseries code. Prior to that it was only called from powernv code.

I'll update the change log to reflect that, unless you disagree.

cheers

> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 7725825d887d..37a77e57893e 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -264,7 +264,9 @@ void __init pSeries_final_fixup(void)
>  			if (!of_device_is_compatible(nvdn->parent,
>  						"ibm,power9-npu"))
>  				continue;
> +#ifdef CONFIG_PPC_POWERNV
>  			WARN_ON_ONCE(pnv_npu2_init(hose));
> +#endif
>  			break;
>  		}
>  	}
> -- 
> 2.20.1
