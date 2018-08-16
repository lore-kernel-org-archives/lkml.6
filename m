Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A032C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82F32147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82F32147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeHQALc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:11:32 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:42444 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeHQALc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:11:32 -0400
Received: by mail-qt0-f175.google.com with SMTP id z8-v6so6472307qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rdic9wbU2bcbev5+zWhc5YGti3xVIxNp8/IQdJskXs=;
        b=Q+1elaI/VmB8grT7+Opdv5A8yRrm4cY6RCawbaRVQUfo7IRziBM9t+Td+GO59Ucm5d
         f6ph/QEz47nWpTgi36twQ67kbfTy1zyxViCZr3Eo385RCUKAxzHjJ1RP2gxpzu5Vn+GL
         aX97eZ/+GmoLMKi9GH5nHon+G+3U+ocl4Xkg99x0Djqw4UfG3CmhhcY/9d1L5I7nyOhr
         g36qRRSRnlOIuFElquEOGZN4r0Ba9xs8t7AB4XBlV2D5VDy0ldqbNZt4obSXTlB7DVu2
         mHaDiyMRtpmlL4BlWD0BJiClMk884YeOvJL65iEOoZPTjbmIKsmhrrE5TTGE+2usRPeE
         7ldA==
X-Gm-Message-State: AOUpUlGih+OOh6vcjvqWOy0pFadbECYQHFsmzhEi8O19aWz1XNfE71V7
        Ec5FrNwmd2uKthR2tnFe8sC+ncK1+njuZtCmdek=
X-Google-Smtp-Source: AA+uWPxxLGYvynR2GJHUHip3BqENWDkgnsmmSk2JNQSelxcKFa4CEY6qt8maYWvHplXastiRiyXgDYgjvA8lh3LHh1A=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr28512157qvc.180.1534453850236;
 Thu, 16 Aug 2018 14:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180816204506.GA21144@agluck-desk>
In-Reply-To: <20180816204506.GA21144@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Aug 2018 23:10:33 +0200
Message-ID: <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
Subject: Re: how to fix acpi_pci_root_remap_iospace?
To:     Tony Luck <tony.luck@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jchandra@broadcom.com, Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:45 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Bjorn,
>
> Back in commit:
>
>   0a70abb38062 ("PCI/ACPI: Support I/O resources when parsing host bridge resources")
>
> we added acpi_pci_root_remap_iospace().  On ia64 this was a no-op because ia64
> didn't define PCI_IOBASE, so the entire body of the function was skipped.
>
> But in the current merge window commit:
>
>   0bbf47eab469 ("ia64: use asm-generic/io.h")
>
> ended up defining PCI_IOBASE for us, and now we die horribly
> in early boot with:
>
>   kernel BUG at lib/ioremap.c:72!

Ah, that explains it. I'm sorry for causing you trouble here, and glad
you figured out the cause.

> Is PCI_IOBASE the right thing to check for to decide whether
> acpi_pci_root_remap_iospace() needs to do anything?
>
> The ugly fix would be:

Another way would be to add

 #include <asm-generic/io.h>
+#undef PCI_IOBASE

in your asm/io.h. This is about as ugly as the your version, but
it would be local to ia64 ;-)

      Arnd
