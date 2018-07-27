Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE85FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79E20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAoTVqnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F79E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeG0Iln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:41:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47003 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeG0Iln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:41:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so2701157pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvqMEOX3abAY6bbS1k6sfnl8oyIOMEcePeAC8eVeMIk=;
        b=dAoTVqnN5Aedyv7u2CgMcnTFRL4wPxjRhUza6v1sTClYg0j0xxMU04gzqD888p6yfd
         NtcE2nUTE7ANH5lftvfwfYO1lDuTii0ELKWeJPYj2lSTv3BSFPuehMCamyaDfliCYutS
         zbPCIkm1gPiJPcPTIsepRfP4uIxWL4mzPFTAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NvqMEOX3abAY6bbS1k6sfnl8oyIOMEcePeAC8eVeMIk=;
        b=fU/trnCI0sfLlIxnYWfg72kZ02dvMj4rNXlhmeGtb7fqvwaGE3FhvO+oCa+Geut1vP
         xCRTQz5T8TxplQ8z1d+bJuXXy6QO1xi0TQloUThirKdjYT5W3OLAbMLYRBx28f7lZycX
         IrJ6uRmxBh8UI+nv1IwEucUjjGYXC4EFg2ql67TtIKTk3SxA79FCV+rwmzkvzhhZgy+6
         gStAW28t9zkyY4u76IwHoNhVeTccaR2LV0ROyOz5SsLOi+hxprIbhQNGYECFk9wqUQoM
         GoFLyDR0M4isMEnFPIbvGvF1hFHjKiDjcwAEke7EZl+xH1J/O6D36h8twXWtGwhxYlEK
         1Dbg==
X-Gm-Message-State: AOUpUlHg5k3grF1kDag1m4B9u6i8G/fi0r6v/5L2AD1i0H4YD0un0BQu
        TA6UpSbtgP+CRvv3SPiZcdtENQ==
X-Google-Smtp-Source: AAOMgpd5OnMShhTiZKr/VjA48msVgacFpNXhaASH5oyHHYCVbMniMUiIz0G+wM+r8RcVoT9kuHcb6w==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr5385806pfg.69.1532676069704;
        Fri, 27 Jul 2018 00:21:09 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id s85-v6sm6283328pfa.116.2018.07.27.00.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 00:21:09 -0700 (PDT)
Date:   Fri, 27 Jul 2018 16:22:43 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 13/16] arm64: kexec_file: invoke the kernel without
 purgatory
Message-ID: <20180727072242.GH11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-14-takahiro.akashi@linaro.org>
 <b9257c90-a538-fb82-b9de-574d68d06fbd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9257c90-a538-fb82-b9de-574d68d06fbd@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:36:07PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > On arm64, purgatory would do almost nothing. So just invoke secondary
> > kernel directly by jumping into its entry code.
> > 
> > While, in this case, cpu_soft_restart() must be called with dtb address
> > in the fifth argument, the behavior still stays compatible with kexec_load
> > case as long as the argument is null.
> 
> This patch conflicts with commit 76f4e2da45b4 ("arm64: kexec: always reset to
> EL2 if present") in the arm64 tree.

I haven't noticed Mark's patch.

I'm going to have to refresh my memory regarding why I introduced
el2_switch when I implemented kdump.
According to my current memory, however, I added
kvm_arch_hardware_enable/disable(), and associated functions, to gracefully
shutdown EL2 in case of kexec. Since we have no chance to call reset
function (via notifier) at kdump, I believed that el2_switch was necessary
for better chance of successful kdump.

Thanks,
-Takahiro AKASHI

> Thanks,
> 
> James
> 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index f76ea92dff91..830a5063e09d 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -205,10 +205,18 @@ void machine_kexec(struct kimage *kimage)
> >  	 * uses physical addressing to relocate the new image to its final
> >  	 * position and transfers control to the image entry point when the
> >  	 * relocation is complete.
> > +	 * In kexec case, kimage->start points to purgatory assuming that
> > +	 * kernel entry and dtb address are embedded in purgatory by
> > +	 * userspace (kexec-tools).
> > +	 * In kexec_file case, the kernel starts directly without purgatory.
> >  	 */
> > -
> >  	cpu_soft_restart(kimage != kexec_crash_image,
> > -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> > +		reboot_code_buffer_phys, kimage->head, kimage->start,
> > +#ifdef CONFIG_KEXEC_FILE
> > +						kimage->arch.dtb_mem);
> > +#else
> > +						0);
> > +#endif
> >  
> >  	BUG(); /* Should never get here. */
> >  }
