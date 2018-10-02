Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FCD20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiMPmHXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FCD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJBOkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:40:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46250 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJBOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:40:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so450036plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LjATinbNFYaw4O40ri70vmxBtULhEUAFg57yGeBSQo=;
        b=LiMPmHXfUCw+OIIQb2q3IbBOBxpP/pSkFG42ilMNWtTyphgnLpAKyWFl/ig0W1bf5v
         wYq1EVo3yFLGUI4Up98Nl+wKbr8W4KxEav7aB3VkbxkZy+7ZXE5WeHSQQck2LTCDlQqb
         p+MxsB59KVggB2ig+DXEF6Xs0Xu0KVg18qOHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5LjATinbNFYaw4O40ri70vmxBtULhEUAFg57yGeBSQo=;
        b=Q8NndvoKSO0yK5I+67Fg0Y/l3qcyqMr2SEzXX9DRMgsNjNNhVgIAzA68SFgOFnV3jl
         INDCkscnlMHWPdL4X1YzfwmNZybkdwRFhePaobhhftJ2fl9UvrUKUIwrCDxL6yHXgVb4
         qL2+jrxoLZNQHdldHVW2eh6lT21efi5MuAVkB60Pa8Iq8Q4ySaekZDLVjXJwNrY0ALaN
         QhdHEkkvyDsQ3usSx7lVVu9pSzFgjzhrqzX3gzXpUGFSWSKGRPPHa+zOHjoLnEhrkd29
         ocpMuQ/3E/4Fl4AZdjoAPvqmPhNyd9WySqFHL8plmqxmzGACm+JRPoOOSv8kQAe9xu5k
         ObEw==
X-Gm-Message-State: ABuFfogOXeQN2rlYY6cZAtEGL53p7MNlQ7Ys9eo2L+quWl5BCEeiiich
        OFSB03nWHtnEXalg0WAbGQ0kyg==
X-Google-Smtp-Source: ACcGV62WsKIlb78I0C6/t9Mru47vTVFc0Ld1pLfVrPrC1a/nQRYqts0+PBIkx7/5Za/HxITGOrdhgQ==
X-Received: by 2002:a65:498b:: with SMTP id r11-v6mr13758070pgs.153.1538467094180;
        Tue, 02 Oct 2018 00:58:14 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f1-v6sm22242864pgc.4.2018.10.02.00.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:58:13 -0700 (PDT)
Date:   Tue, 2 Oct 2018 16:59:40 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 07/16] arm64: add image head flag definitions
Message-ID: <20181002075939.GG32578@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, prudo@linux.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
 <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Oct 01, 2018 at 01:52:26PM +0100, Mark Rutland wrote:
> On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> > Those image head's flags will be used later by kexec_file loader.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Acked-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
> >  arch/arm64/kernel/head.S      |  2 +-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> > index 355e552a9175..0bab7eed3012 100644
> > --- a/arch/arm64/include/asm/boot.h
> > +++ b/arch/arm64/include/asm/boot.h
> > @@ -5,6 +5,21 @@
> >  
> >  #include <asm/sizes.h>
> >  
> > +#define ARM64_MAGIC		"ARM\x64"
> > +
> > +#define HEAD_FLAG_BE_SHIFT		0
> > +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> > +#define HEAD_FLAG_BE_MASK		0x1
> > +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> > +
> > +#define HEAD_FLAG_BE			1
> 
> These already exist in some form in arch/arm64/kernel/image.h; can we
> please factor those out rather than duplicating them?

Sure.

> I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
> and removed the old definitions.

I want to make sure two things;

1. Do you assume all the existing __HEAD_FLAG_xyz's NOT be renamed
   (say, to HEAD_FLAG_xyz)?

2. Do you mind removing this check in image.h?
   (we also need to manage 'CONFIG_EFI' part of image.h.)

>       #ifndef LINKER_SCRIPT
>       #error This file should only be included in vmlinux.lds.S
>       #endif


Thanks,
-Takahiro Akashi

> > +#define HEAD_FLAG_PAGE_SIZE_4K		1
> > +#define HEAD_FLAG_PAGE_SIZE_16K		2
> > +#define HEAD_FLAG_PAGE_SIZE_64K		3
> 
> I appreciate these are new, since we didn't previously need definitions.
> 
> Thanks,
> Mark.
> 
> > +
> > +#define head_flag_field(flags, field) \
> > +		(((flags) >> field##_SHIFT) & field##_MASK)
> > +
> >  /*
> >   * arm64 requires the DTB to be 8 byte aligned and
> >   * not exceed 2MB in size.
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index b0853069702f..8cbac6232ed1 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -91,7 +91,7 @@ _head:
> >  	.quad	0				// reserved
> >  	.quad	0				// reserved
> >  	.quad	0				// reserved
> > -	.ascii	"ARM\x64"			// Magic number
> > +	.ascii	ARM64_MAGIC			// Magic number
> >  #ifdef CONFIG_EFI
> >  	.long	pe_header - _head		// Offset to the PE header.
> >  
> > -- 
> > 2.19.0
> > 
