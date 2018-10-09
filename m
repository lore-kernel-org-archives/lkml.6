Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61873C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9F421479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9F421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIWVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:21:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIWVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:21:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F74980D;
        Tue,  9 Oct 2018 08:04:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C34C3F5B7;
        Tue,  9 Oct 2018 08:04:07 -0700 (PDT)
Date:   Tue, 9 Oct 2018 16:04:05 +0100
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
Subject: Re: [PATCH v15 07/16] arm64: add image head flag definitions
Message-ID: <20181009150404.cqpkmi2wumututwa@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
 <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
 <20181002075939.GG32578@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002075939.GG32578@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:59:40PM +0900, AKASHI Takahiro wrote:
> Hi Mark,
> 
> On Mon, Oct 01, 2018 at 01:52:26PM +0100, Mark Rutland wrote:
> > On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> > > Those image head's flags will be used later by kexec_file loader.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Acked-by: James Morse <james.morse@arm.com>
> > > ---
> > >  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
> > >  arch/arm64/kernel/head.S      |  2 +-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> > > index 355e552a9175..0bab7eed3012 100644
> > > --- a/arch/arm64/include/asm/boot.h
> > > +++ b/arch/arm64/include/asm/boot.h
> > > @@ -5,6 +5,21 @@
> > >  
> > >  #include <asm/sizes.h>
> > >  
> > > +#define ARM64_MAGIC		"ARM\x64"
> > > +
> > > +#define HEAD_FLAG_BE_SHIFT		0
> > > +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> > > +#define HEAD_FLAG_BE_MASK		0x1
> > > +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> > > +
> > > +#define HEAD_FLAG_BE			1
> > 
> > These already exist in some form in arch/arm64/kernel/image.h; can we
> > please factor those out rather than duplicating them?
> 
> Sure.
> 
> > I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
> > and removed the old definitions.
> 
> I want to make sure two things;
> 
> 1. Do you assume all the existing __HEAD_FLAG_xyz's NOT be renamed
>    (say, to HEAD_FLAG_xyz)?

I'm perfectly happy for them to be renamed, I just don't want duplicate
definitions.

Let's rename them to ARM64_IMAGE_FLAG_<foo>, and place them in a new
header, arch/arm64/include/asm/image.h, which arch/arm64/kernel/image.h
can include and make use of.

> 
> 2. Do you mind removing this check in image.h?
>    (we also need to manage 'CONFIG_EFI' part of image.h.)

What exactly do we need from that? AFAICT that's all linker script
stuff that shouldn't matter for kexec.

Thanks,
Mark.
