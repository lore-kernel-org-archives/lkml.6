Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00779C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9A208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCd4RgQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE9A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeHBBug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:50:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeHBBuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:50:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so226274pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89Z5raYRNYznVUlX4X8hMx66Voifzm1CyqwNjYYoDeU=;
        b=VCd4RgQvG6dfNVP0Q9SVuZCu+Iys54DXavbFE8KLDMng8BZdg5Gn37RusKBD7dOGtV
         tlRBoCwqvyBnGeNFrUpcICpka4U3uVpJch6HEpTIL9BoR2Rv0YhVxvX3ToUj8M+ZeqC6
         9FPhMC+ASE9alRCcbBhXxEqvE78KJMlfH3UzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=89Z5raYRNYznVUlX4X8hMx66Voifzm1CyqwNjYYoDeU=;
        b=aDdTYEvaa3xWj4egxhAVcxjUEGJ8bIywb/hvx30tfXkVIFHWjlgCmv9SytdMRG6Heb
         shmvy1LdSS8zTJ3eMQCmaE0wHe3GGHali+8VyAjJirNyXargK0Bt3Bkifc/73Nn36H/p
         jiIfVmoUozvtN/9svPVRsyGI9eQo4829zoG1Bg6J/XNmO0++6WRu1dkLi8CSPXF5u0uX
         bapr4gBEQVXIH1Z6/fQT1MP4zipeXitXCcuklXy1FX+2ZGR27zd2R11QcC+m3TtlZTNk
         g6G9L32DDdYMmiMN60ifKnYkFm4k4h6PdbhqxysIVgSUNQylVj6WrTAXb259DcKo2mBo
         q8XA==
X-Gm-Message-State: AOUpUlFEfHMOygjOG6IrvYk3XGe4hnmhOm5cBCNSJ4G831cjBLlAxgXn
        7MRDSIagzqmWyS/StWotDKOZJQ==
X-Google-Smtp-Source: AAOMgpfjq5ztS0NGWbDMO4tRJ7Ri7h2Xb2G0n6paKZ3txiJBvfvuy8FQhWwkPL99tO1+xqjT+WPP9Q==
X-Received: by 2002:a62:1449:: with SMTP id 70-v6mr476285pfu.222.1533168136388;
        Wed, 01 Aug 2018 17:02:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k64-v6sm287922pfc.160.2018.08.01.17.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 17:02:15 -0700 (PDT)
Date:   Thu, 2 Aug 2018 09:01:52 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Philipp Rudo <prudo@linux.ibm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180802000150.GN11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Philipp Rudo <prudo@linux.ibm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801102951.527cfc57@ThinkPad>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 01, 2018 at 10:29:51AM +0200, Philipp Rudo wrote:
> Hey Akashi,
> 
> I kept thinking about this patch and remembered why I didn't made the change
> you are suggesting now.

Hmm.

> The problem is when you only check for kbuf->mem you are excluding address 0,
> which might be a valid address to load the kernel to. On s390 this is actually
> done when the kernel is not loaded via a boot loader. For kexec_file however,
> we cut off the first few kB of the image and jump directly to 'startup'. So
> checking for !0 does not cause a problem here.

Yeah, as Dave(RedHat) described, all the current kexec-capable architectures,
except arm64, implicitly initialize kbuf.mem to zero with "kbuf = { ... }"
initializer. So surely my change would not break anything on the existing code.
On the other hand, I also see your concern here.

> Anyway, the long term safer solution would be something like
> 
> #define KEXEC_BUF_MEM_UNKNOWN (-1UL)
> 
> for architectures to tell common code to search a fitting mem hole.

This would require the existing code on every arch to be modified, which
I think should be avoided if possible. Instead,
we'd better define in linux/kexec.h:
  #ifndef KEXEC_BUF_MEM_UNKNOWN
  #define KEXEC_BUF_MEM_UNKNOWN 0
  #endif
and then check for kbuf in kexec_locate_mem_hole():
  if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
        return 0;
  ...

This way if some arch wants to treat *zero* as a valid address, it can
redefine this macro in arch/asm/kexec.h.

Thanks,
-Takahiro AKASHI

> 
> Back then I didn't do the change because I had the other workaround, which
> didn't require a common code change. But when you are touching the code now it
> is worth thinking about it.
> 
> Just wanted to let you know
> Philipp
> 
> 
> On Wed,  1 Aug 2018 16:58:07 +0900
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> 
> > Since s390 already knows where to locate buffers, calling
> > arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
> > indicates this while all other architectures sets it to 0 initially.
> > 
> > This change is a preparatory work for the next patch, where all the
> > variant memory walks, either on system resource or memblock, will be
> > put in one common place so that it will satisfy all the architectures'
> > need.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c | 10 ----------
> >  kernel/kexec_file.c                   |  4 ++++
> >  2 files changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> > index f413f57f8d20..32023b4f9dc0 100644
> > --- a/arch/s390/kernel/machine_kexec_file.c
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
> >  	return ret;
> >  }
> >  
> > -/*
> > - * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> > - * and provide kbuf->mem by hand.
> > - */
> > -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > -			int (*func)(struct resource *, void *))
> > -{
> > -	return 1;
> > -}
> > -
> >  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >  				     Elf_Shdr *section,
> >  				     const Elf_Shdr *relsec,
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 63c7ce1c0c3e..bf39df5e5bb9 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >  {
> >  	int ret;
> >  
> > +	/* Arch knows where to place */
> > +	if (kbuf->mem)
> > +		return 0;
> > +
> >  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> >  
> >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> 
