Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D8C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B734214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B734214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLFPyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:54:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:54:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E356480D;
        Thu,  6 Dec 2018 07:54:03 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B18F43F59C;
        Thu,  6 Dec 2018 07:54:03 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C9A9C1AE0BD1; Thu,  6 Dec 2018 15:54:24 +0000 (GMT)
Date:   Thu, 6 Dec 2018 15:54:24 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181206155424.GA4422@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviewing this.

On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Added function, fdt_setprop_reg(), will be used later to handle
> > kexec-specific property in arm64's kexec_file implementation.
> > It will possibly be merged into libfdt in the future.
> 
> You generally can't modify libfdt files. Any changes will be blown
> away with the next dtc sync (there's one in -next now). Though here
> you are creating a new location with fdt code. lib/ is just a shim to
> the actual libfdt code. Don't put any implementation there. You can
> add this to drivers/of/fdt_address.c for the short term, but it still
> needs to go upstream.
> 
> Otherwise, the implementation looks fine to me.

I agree, but I don't think there's a real need for us to hack
drivers/of/fdt_address.c in the meantime -- let's just target upstream
and not carry this in the kernel.

Akashi -- for now, I'll drop the kdump parts of this series which rely
on this helper. The majority of the series is actually independent and
can go in as-is.

I've pushed out a kexec branch to the arm64 tree for you to take a look
at:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec

Thanks,

Will
