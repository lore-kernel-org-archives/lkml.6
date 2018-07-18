Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74130ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BEA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqUoM6fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BEA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeGRGbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:31:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46113 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeGRGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:31:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so1656238pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZA49VF8RtFWzsUAM6RxWt0DzRIHqG8N4WFPq0liA3I=;
        b=aqUoM6fzudY8KldeSAWvEPh6bs4w9PaVFDgO+Yu8Tvp3a6In1koO9JVC3r21cqCbqt
         qfNlQ8sxx4FE9lqdifrg4T0xrRI3rH726HSZTdlIKeQWauD6T+QNuSxtNiNCKcYLNxyi
         eNrhkJtz4d1RzwNflh/uHC2OOvUv23f6HvIbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HZA49VF8RtFWzsUAM6RxWt0DzRIHqG8N4WFPq0liA3I=;
        b=Vzx3sHhiah4eEmQGQF6F+mpbhH5Ew2GLylqb1SNJ01OTYqYNQuyFqLYs4nLjc0W8m8
         vGogQAby6Q8HhxF9ekjiE6MgT4zSvybezGwIaECUiUk+oYwzAEina2o2uijbQWWt66kf
         HONk9eCEi1artWeDTiiZIPgxrMgNM7x52YOXMDOMUv7A7KP5acA4u1OcUMhPdt+HmDDt
         ROc3raFRiwYLXsD8aAVQngGDDlSWAhAdto4BqCRAWt3Bo2Rtoix6Fn2uUpJO7dcRIVQG
         q2ueJcwN3s7CVlcKt3CqPY6LU0vnYdObNlAj1MGHHZgsEU3nr+BIEbt8YxnnFoNpVLOQ
         GmtQ==
X-Gm-Message-State: AOUpUlHu+t3NrLv2Tdn9cepKIrIoZTxBigdhD7iu3qg6BeIdDNUxvGF8
        gJY67/3jNJz+UtniPxOhDkBZEg==
X-Google-Smtp-Source: AAOMgpek47U9Aw2OMLul6AqS4b3zqsrUieaCvKfyvYdmu62fp1MWIy+cq8Fa5YdTgQ4cq1eCWGAB7g==
X-Received: by 2002:a63:1a20:: with SMTP id a32-v6mr4435045pga.446.1531893341890;
        Tue, 17 Jul 2018 22:55:41 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g85-v6sm7512647pfk.39.2018.07.17.22.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 22:55:41 -0700 (PDT)
Date:   Wed, 18 Jul 2018 14:56:57 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 09/15] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180718055656.GG11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-10-takahiro.akashi@linaro.org>
 <c5199d62-16f3-a0f2-fdf5-7dcbf6a02cd6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5199d62-16f3-a0f2-fdf5-7dcbf6a02cd6@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, Jul 17, 2018 at 05:57:06PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 11/07/18 08:41, AKASHI Takahiro wrote:
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
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..ca00681c25c6 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb_buf);
> > +	image->arch.dtb_buf = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}
> 
> A nit from sparse:
> | warning: symbol 'arch_kimage_file_post_load_cleanup' was not declared
> 
> Can we add a definition for this to a header file somewhere. asm/kexec.h is
> probably the best bet.

Sparse! Ok, I will fix it.

> > +static int setup_dtb(struct kimage *image,
> > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len,
> > +		char **dtb_buf, size_t *dtb_buf_len)
> > +{
> 
> > +	/* add initrd-* */
> > +	if (initrd_load_addr) {
> > +		value = cpu_to_fdt64(initrd_load_addr);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> > +							value);
> 
> fdt_setprop_u64() already does the endian conversion.
> 
> From scripts/dtc/libfdt/libfdt.h, its implemented as:
> | 	fdt64_t tmp = cpu_to_fdt64(val);
> | 	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
> 
> (I think you were using setprop directly in an older version)

Indeed.

> This leads to:
> | ------------[ cut here ]------------
> | initrd not fully accessible via the linear mapping -- please check your
> | bootloader ...
> | WARNING: CPU: 0 PID: 0 at ../arch/arm64/mm/init.c:429
> | arm64_memblock_init+0x150/0x3d8
> | Modules linked in:
> | CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc5-00015-g95b5c843d0da #10150
> | Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
> | pstate: 60000085 (nZCv daIf -PAN -UAO)
> | pc : arm64_memblock_init+0x150/0x3d8
> | lr : arm64_memblock_init+0x150/0x3d8
> 
> | Call trace:
> | arm64_memblock_init+0x150/0x3d8
> | setup_arch+0x1c0/0x510
> | start_kernel+0x80/0x418
> | random: get_random_bytes called from print_oops_end_marker+0x4c/0x68 with
> | crng_init=0
> | ---[ end trace 0000000000000000 ]---
> 
> 
> Which is caused by the values being miles outside ram due to the extra byte
> swapping:

So it is in little endian.

> | morse@frikadeller:~$ sudo dtc -I dtb -O dts /sys/firmware/fdt  | grep initrd
> |                 linux,initrd-end = <0x900b6c05 0x80000000>;
> |                 linux,initrd-start = <0x906a04 0x80000000>;
> 
> 
> With the two extra cpu_to_fdt64() calls removed:
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

-Takahiro AKASHI

> 
> Thanks,
> 
> James
