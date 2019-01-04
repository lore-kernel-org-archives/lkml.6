Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BDBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F792087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfADWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:05:13 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43212 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfADWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:05:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3770929D56;
        Fri,  4 Jan 2019 17:05:09 -0500 (EST)
Date:   Sat, 5 Jan 2019 09:05:33 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
In-Reply-To: <20190104175639.GA6347@infradead.org>
Message-ID: <alpine.LNX.2.21.1901050855340.11@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au> <20190103080229.GB11147@infradead.org> <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
 <20190104175639.GA6347@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019, Christoph Hellwig wrote:

> On Fri, Jan 04, 2019 at 09:08:13AM +1100, Finn Thain wrote:
> > On Thu, 3 Jan 2019, Christoph Hellwig wrote:
> > 
> > > > +
> > > > +const struct nvram_ops arch_nvram_ops = {
> > > > +	.read_byte      = nvram_read_byte,
> > > > +	.write_byte     = nvram_write_byte,
> > > > +	.get_size       = nvram_get_size,
> > > > +};
> > > > +EXPORT_SYMBOL(arch_nvram_ops);
> > > 
> > > I think something this internal should always be EXPORT_SYMBOL_GPL.
> > > 
> > 
> > By "internal" do you mean "not involving interests outside of the Linux 
> > Foundation"? TBH, I don't know who's affected.
> 
> Linux Foundation doesn't matter.
> 
> But as far as I can see you export the struct from arch code
> for nvram.ko to use them and no one else, which is clearly internal.
> 

No, arch_nvram_ops is not "internal" in that sense. The struct is used 
whereever the nvram_* exports are presently used:

$ git grep -e "EXPORT_SYMBOL.*nvram" v4.20
...
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_read_byte);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_write_byte);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_get_size);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_sync);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_read_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_read_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_write_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_write_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_check_checksum);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_check_checksum);
...
$ git grep -wle "nvram_read_byte|nvram_write_byte|nvram_get_size|nvram_sync|__nvram_read_byte|__nvram_write_byte|__nvram_check_checksum"
arch/powerpc/include/asm/machdep.h
arch/powerpc/include/asm/nvram.h
arch/powerpc/kernel/setup_32.c
arch/powerpc/platforms/powermac/nvram.c
drivers/char/generic_nvram.c
drivers/char/nvram.c
drivers/platform/x86/thinkpad_acpi.c
drivers/scsi/atari_scsi.c
drivers/video/fbdev/controlfb.c
drivers/video/fbdev/imsttfb.c
drivers/video/fbdev/matrox/matroxfb_base.c
drivers/video/fbdev/platinumfb.c
drivers/video/fbdev/valkyriefb.c
include/linux/nvram.h
sound/ppc/awacs.c
$ 

-- 
