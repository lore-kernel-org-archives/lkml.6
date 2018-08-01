Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE77EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80D2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsxtuiRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C80D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbeHAUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:10:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37082 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbeHAUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:10:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so11226320pgq.4;
        Wed, 01 Aug 2018 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWf0VW5aUhoa979lhJ0aysKT+iQ4faN+4WDPZzsCyls=;
        b=TsxtuiRvSn8R7WMN/bSedaYzEzmb5WON3qqa+UhZStffixRL4HG5Ttq1PsZRmTCJUN
         LZdPw1DoUIi06eut0s2zBfWRhJ0q68sUNGheyeyBoRqQFoI95pEvaqBzbZqhf0/9s+Zo
         3+gGU/caGh72Af0ZwRn6c5BQVVdIUQJfcFs/VCI8tshV/usVw9jzxiJOAtau7lFhpZyM
         iK5EEauSHkvcMeXPKv20ZAFt74tydYmJb2L0BCfLKZOcRs2SkYNSSe7vEG1NrKc6zFuE
         afSaFpjG7ZIB5tAbWKH6Kj5Bf2Iooz1X5tJPp9oM5RaXOnh6u2CLl01wIZkRm1MBFF+F
         1yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWf0VW5aUhoa979lhJ0aysKT+iQ4faN+4WDPZzsCyls=;
        b=f8cjis4O0hrD42LKEEnryS48wmq0x0bK3usgZTu6SAf2zLnVpnWvt4qceUlVrccq9k
         JcycCETxbbJYyFyG+UFjOX0BhVt7XVikZbPy6I4FPv1CtIrFf1avoJhWyquNImPjlnpV
         Fu+MtrVh+iSrzYVO1iJ9JZ/ML0khQ0qnqsJT2trIVHOkJnpluO1US8eCA94qiNN9h5jB
         f3UwbFNLxHkTFDbDoVGB/bez1CFjUg7VZkJFFI/bI0i0HGLcebFl8oqlOfYaG6s9wG1m
         ru3GPUNBsu/23JR7QB9emUomPfIi/2XsG3uLXYjL0UudYOES2Us2z4pTAkqmaNxqVwgY
         xfrQ==
X-Gm-Message-State: AOUpUlHyR/MfLF2SoprrW5vWCrE7bDJsVF/v6cHUbhvKvzVP7Od8SRfQ
        sxdZW4BHdUgmmUVYjzs2egA=
X-Google-Smtp-Source: AAOMgpew/69pY4AkWmuZmvKYicFez3Z2wNKffJtOG8pEsKFN0si1jGvEgrCpVmOunktHA7n4jAD90g==
X-Received: by 2002:a63:a347:: with SMTP id v7-v6mr24967706pgn.182.1533147808447;
        Wed, 01 Aug 2018 11:23:28 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h29-v6sm3766766pgh.37.2018.08.01.11.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:23:27 -0700 (PDT)
Date:   Wed, 1 Aug 2018 11:23:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Stefan Agner <stefan@agner.ch>, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
Message-ID: <20180801182326.GA20550@roeck-us.net>
References: <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
 <f67628ad-4cae-96cd-d0c4-3b2f7d12a822@roeck-us.net>
 <4ce17098-850f-3bb0-b977-8d7932e74e06@arm.com>
 <20180731154353.GA29601@roeck-us.net>
 <10c2ca4d-d587-2705-2802-b6df3dc72fd4@arm.com>
 <20180731173859.GA17007@roeck-us.net>
 <9f32010e-3bcb-2153-dac3-996e9d1b1e9b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f32010e-3bcb-2153-dac3-996e9d1b1e9b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:33:30PM +0100, Robin Murphy wrote:
> On 31/07/18 18:38, Guenter Roeck wrote:
> >On Tue, Jul 31, 2018 at 04:58:41PM +0100, Robin Murphy wrote:
> >>On 31/07/18 16:43, Guenter Roeck wrote:
> >>>On Tue, Jul 31, 2018 at 03:09:34PM +0100, Robin Murphy wrote:
> >>>>>Please note that sparc images still generate the warning (next-20180731).
> >>>>
> >>>>Ugh, OK, any ideas what sparc does to create these platform devices that
> >>>>isn't of_platform_device_create_pdata() and has somehow grown an implicit
> >>>>dependency on of_dma_configure() since 4.12? I'm looking, but nothing jumps
> >>>>out...
> >>>>
> >>>
> >>>I suspect it might be of_device_register(), called from
> >>>	arch/sparc/kernel/of_device_64.c:scan_one_device()
> >>>	arch/sparc/kernel/of_device_32.c:scan_one_device()
> >>
> >>Right, that's as far as I got as well, so I'm struggling to see how these
> >>things ever got DMA masks set before the of_dma_configure() call moved out
> >>of of_platform_device_create_pdata(), or why it wasn't a problem prior to
> >>the generic dma_ops rework if they didn't :/
> >>
> >Ah, ok. No idea, sorry. All I know is that the messages were first seen
> >with next-20180727.
> 
> OK, I spent this afternoon wrangling toolchains and QEMU to boot an
> instrumented 4.11 kernel, and the answer is that the warnings are arguably
> correct. These masks have indeed never been set where they should have been,
> but then the sbus_dma_ops don't reference them anyway.
> 
> The coherent mask WARN_ON *should* have started appearing in 4.16 with
> 205e1b7f51e4("dma-mapping: warn when there is no coherent_dma_mask"), but
> happened to be hidden by the inadvertent side-effect of the prior
> dma_configure() change. Since there's seemingly no actual regression of
> functionality, I'm inclined to leave this in the hands of whoever cares
> about sparc32.
> 

You mean there is now a warning stating that coherent_dma_mask is not set,
but coherent_dma_mask isn't used by sparc32 in the first place ?

Guenter
