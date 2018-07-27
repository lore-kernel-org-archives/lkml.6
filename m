Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2DB20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKKT1L6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2DB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeG0G4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:56:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43158 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeG0G4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:56:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so2544504pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BTwNVIxSxeSJ961T1ybkAUG3jFiabkb5o7rQ2hOygw=;
        b=QKKT1L6P1PxgDLr5My0hlVDsUa0426+Hw2aVtJCNRbVjy0Uf/YmvFg5Os80+ZB9zo/
         f+y96vFQLqMGNs+hSWLww71f9k2dgpv12ecdbYwuhNewKYArUQ0Rzi0xk8M4tW1mNLmX
         nQ0cuXXROE5PFWWPRETRS9QvUFYRXuCy++xE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2BTwNVIxSxeSJ961T1ybkAUG3jFiabkb5o7rQ2hOygw=;
        b=cRG/aVqXkKMlclK4pwU9sK7M3Lo2YEPtAvlN2uXo8wxfsX7HOK+El9ccBfejNAHkgI
         6HwSa2ejV+rgns6qhhS9yz3B3wMiwQBtfQwu0lhisjw99VU9WBDQ2HD1+qZ3epaXs1yQ
         lGpTu15bHk9Y8VKbJCbWazB6DBqKey2ZA+QSGgoPDcP/sxRHWtzVkPRZV7f7o6vLIcgw
         6xhJn2uhOod1K3oC+KeiuXu4ttR3sMAd/06UG4kVwmT3vZpxUroAhEfm/19HQJbLLE1f
         g7574rAqpDujEMRobbiw8EEs+U70YFAPpQKeP7iyUCodOkdpNtQPcK9Iv+juiqjLZUAu
         nwEg==
X-Gm-Message-State: AOUpUlGZizoLDy5hBEzerg9OrDT+WnF6u91dyAI5dddFh35xdmKRzfkR
        JInwU2CzmW+Bnf5/gY255apjgA==
X-Google-Smtp-Source: AAOMgpeHLh3/hruCfO7F/B2KjezjjvhXzGsTWBi1teDaDRd2t2kf10oYzNNA7dxyRy0fOH1EMVyUsg==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr4711030pgw.132.1532669781233;
        Thu, 26 Jul 2018 22:36:21 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y27-v6sm9376649pff.181.2018.07.26.22.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 22:36:20 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:37:55 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 10/16] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180727053754.GF11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-11-takahiro.akashi@linaro.org>
 <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:34:55PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > load_other_segments() is expected to allocate and place all the necessary
> > memory segments other than kernel, including initrd and device-tree
> > blob (and elf core header for crash).
> > While most of the code was borrowed from kexec-tools' counterpart,
> > users may not be allowed to specify dtb explicitly, instead, the dtb
> > presented by the original boot loader is reused.
> > 
> > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > specific data allocated in load_other_segments().
> 
> Since v11 you've renamed struct kimage_arch's dtb_buf as dtb, but not changed
> the struct. This series doesn't build until patch 12 where you fix it. This will
> cause anyone trying to bisect through here a problem.

Right. My last-minute change introduced this screw-up.
I will double-check at v13.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index e17f0529a882..026f7e408f0c 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> 
> > +struct kimage_arch {
> > +	void *dtb_buf;
> > +	unsigned long dtb_mem;
> > +};
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..b28fbb0659c9 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb);
> > +	image->arch.dtb = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}
> 
