Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9904C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2320835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B2320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJJRJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:09:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeJJRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:09:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8BE80D;
        Wed, 10 Oct 2018 02:47:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC683F5BC;
        Wed, 10 Oct 2018 02:47:53 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:47:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 11/16] arm64: kexec_file: allow for loading
 Image-format kernel
Message-ID: <20181010094750.sy5byeaykatvvup6@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-12-takahiro.akashi@linaro.org>
 <20181009152759.x24xuiwb3zsg4jx7@lakrids.cambridge.arm.com>
 <20181010065235.GY32578@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010065235.GY32578@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:52:37PM +0900, AKASHI Takahiro wrote:
> Mark,
> 
> On Tue, Oct 09, 2018 at 04:28:00PM +0100, Mark Rutland wrote:
> > On Fri, Sep 28, 2018 at 03:48:36PM +0900, AKASHI Takahiro wrote:
> > > This patch provides kexec_file_ops for "Image"-format kernel. In this
> > > implementation, a binary is always loaded with a fixed offset identified
> > > in text_offset field of its header.
> > > 
> > > Regarding signature verification for trusted boot, this patch doesn't
> > > contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> > > in this series, but file-attribute-based verification is still a viable
> > > option by enabling IMA security subsystem.
> > > 
> > > You can sign(label) a to-be-kexec'ed kernel image on target file system
> > > with:
> > >     $ evmctl ima_sign --key /path/to/private_key.pem Image
> > > 
> > > On live system, you must have IMA enforced with, at least, the following
> > > security policy:
> > >     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> > > 
> > > See more details about IMA here:
> > >     https://sourceforge.net/p/linux-ima/wiki/Home/
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Reviewed-by: James Morse <james.morse@arm.com>
> > > ---
> > >  arch/arm64/include/asm/kexec.h         |  28 +++++++
> > >  arch/arm64/kernel/Makefile             |   2 +-
> > >  arch/arm64/kernel/kexec_image.c        | 108 +++++++++++++++++++++++++
> > >  arch/arm64/kernel/machine_kexec_file.c |   1 +
> > >  4 files changed, 138 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm64/kernel/kexec_image.c
> > > 
> > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > index 157b2897d911..5e673481b3a3 100644
> > > --- a/arch/arm64/include/asm/kexec.h
> > > +++ b/arch/arm64/include/asm/kexec.h
> > > @@ -101,6 +101,34 @@ struct kimage_arch {
> > >  	unsigned long dtb_mem;
> > >  };
> > >  
> > > +/**
> > > + * struct arm64_image_header - arm64 kernel image header
> > > + * See Documentation/arm64/booting.txt for details
> > > + *
> > > + * @mz_magic: DOS header magic number ('MZ', optional)
> > 
> > Please just call this code0. If CONFIG_EFI is disabled, it is not 'MZ'.
> 
> How about this?
> (This definition will go into a new header, asm/image.h.)
> 
> ---8<---
> /*
>  * struct arm64_image_header - arm64 kernel image header
>  * See Documentation/arm64/booting.txt for details
>  *
>  * @code0:		Executable code, or
>  *   @mz_header		  alternatively used for part of MZ header
>  * @code1:		Executable code
>  * @text_offset:	Image load offset
>  * @image_size:		Effective Image size
>  * @flags:		kernel flags
>  * @reserved:		reserved
>  * @magic:		Magic number
>  * @reserved5:		reserved, or
>  *   @pe_header:	  alternatively used for PE COFF offset
>  */
> 
> struct arm64_image_header {
> 	union {
> 		__le32 code0;
> 		struct {
> 			__le16 magic;
> 			__le16 pad;
> 		} mz_header;
> 	};
> 	__le32 code1;
> 	__le64 text_offset;
> 	__le64 image_size;
> 	__le64 flags;
> 	__le64 reserved[3];
> 	__le32 magic;
> 	union {
> 		__le32 reserved5;
> 		__le32 pe_header;
> 	};
> };

Do we care about the MZ header?

The definition of the Image header in Documentation/arm64/booting.txt is:

  u32 code0;                    /* Executable code */
  u32 code1;                    /* Executable code */
  u64 text_offset;              /* Image load offset, little endian */
  u64 image_size;               /* Effective Image size, little endian */
  u64 flags;                    /* kernel flags, little endian */
  u64 res2      = 0;            /* reserved */
  u64 res3      = 0;            /* reserved */
  u64 res4      = 0;            /* reserved */
  u32 magic     = 0x644d5241;   /* Magic number, little endian, "ARM\x64" */
  u32 res5;                     /* reserved (used for PE COFF offset) */

I'd prefer that we aligned our header definition with that, rather than
diverging from it.

If we need to look at the MZ magic to determine if the Image is a valid PE
binary, can't we just cast to the existing struct mz_hdr from <linux/pe.h> to
do that?

[...]

> > > +	/* Check cpu features */
> > > +	flags = le64_to_cpu(h->flags);
> > > +	value = head_flag_field(flags, HEAD_FLAG_BE);
> > > +	if (((value == HEAD_FLAG_BE) && !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ||
> > > +	    ((value != HEAD_FLAG_BE) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
> > > +		if (!system_supports_mixed_endian())
> > > +			return ERR_PTR(-EINVAL);
> > 
> > I think this can be simplified:
> > 
> > 	bool be_image = head_flag_field(flags, HEAD_FLAG_BE);
> > 	bool be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> > 
> > 	if ((be_image != be_kernel) && !system_supports_mixed_endian)
> > 	    		return ERR_PTR(-EINVAL);
> 
> Okay.
> 
> > ... though do we need to police this at all? It's arguably policy given
> > the new image has to be signed anyway), and there are other fields that
> > could fall into that category in future.
> 
> The aim here is to prevent any images from being loaded
> when there is no question that a new image will never be successfully
> kexec'ed since the core on a given SoC obviously doesn't support cpu
> features that are assumed and required by a image.
> 
> I believe that this check is a good and easy practice to avoid possible
> failures before execution.

My only concern is that this is arguably placing some policy in the
kernel, and I don't want to set the expectation that we'll do this for
other things in future, as that becomes a maintenance nightmare.

I'm not necessarily opposed to these specific checks, given they're
simple. Just wanted to make sure that we've thought about it.

Thanks,
Mark.
