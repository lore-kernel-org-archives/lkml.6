Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD84BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFE021479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfACWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:08:16 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53222 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfACWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:08:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C119B2A185;
        Thu,  3 Jan 2019 17:08:12 -0500 (EST)
Date:   Fri, 4 Jan 2019 09:08:13 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
In-Reply-To: <20190103080229.GB11147@infradead.org>
Message-ID: <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au> <20190103080229.GB11147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Christoph Hellwig wrote:

> > +
> > +const struct nvram_ops arch_nvram_ops = {
> > +	.read_byte      = nvram_read_byte,
> > +	.write_byte     = nvram_write_byte,
> > +	.get_size       = nvram_get_size,
> > +};
> > +EXPORT_SYMBOL(arch_nvram_ops);
> 
> I think something this internal should always be EXPORT_SYMBOL_GPL.
> 

By "internal" do you mean "not involving interests outside of the Linux 
Foundation"? TBH, I don't know who's affected.

Anyway, this patch series is mostly refactoring. So the policy it enforces 
towards the use of arch_nvram_ops just reflects the policy already in 
place:

$ git grep -w EXPORT_SYMBOL_GPL | grep nvram
$ git grep -w EXPORT_SYMBOL | grep nvram
...
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_read_byte);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_write_byte);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_get_size);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_sync);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_get_partition);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_xpram_read);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_xpram_write);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_read_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_read_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_write_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_write_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_check_checksum);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_check_checksum);
...
$ 

-- 
