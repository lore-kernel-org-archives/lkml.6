Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79222C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40651218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149006;
	bh=tvfSfixV9M/zFUAZ25eiE9ftJmocefhGyeG7bJ1p+wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ckMnl0X+i/Uoz4hPBZ/ia3WUMIvC/G6DP8IBwxPvHitA0R6p28xZcJzy/ISark6fP
	 1DfM5h68n0WWlzycRY0mnFCCL6V/Xc/r8T23qA9xKtGTItnhouSMka/LLVkxqXHgUC
	 cS/za9bR4FvO0BBGRAbpbUZPUGm4EpjXz5jG0SU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfAVJXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfAVJXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:23:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8847218D4;
        Tue, 22 Jan 2019 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149002;
        bh=tvfSfixV9M/zFUAZ25eiE9ftJmocefhGyeG7bJ1p+wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiR3edAXBVFUN7hzroBaOdWPtGHJ4PvajGPuamdx3G45qsVh4pQCSBGYHxHhWCvGG
         UcxdFStjA+N+NgMGE/+jFBsRbGP+55MuNl0zqtSVFzpqWRf+oOcWl4sK+Qh8NEzL9d
         5uAQ8uVHQZ3QkihfTDVeHr2RmnOHtQsEHcXatTxU=
Date:   Tue, 22 Jan 2019 10:22:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 00/22] Re-use nvram module
Message-ID: <20190122092234.GA15813@kroah.com>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> The "generic" NVRAM module, drivers/char/generic_nvram.c, implements a
> /dev/nvram misc device. This module is used only by 32-bit PowerPC
> platforms.
> 
> The RTC "CMOS" NVRAM module, drivers/char/nvram.c, also implements a
> /dev/nvram misc device. This module is now used only by x86 and m68k
> thanks to commit 3ba9faedc180 ("char: nvram: disable on ARM").
> 
> The "generic" module cannot be used by x86 or m68k platforms because it
> cannot co-exist with the "CMOS" module. One reason for that is the
> CONFIG_GENERIC_NVRAM kludge in drivers/char/Makefile. Another reason is
> that automatically loading the appropriate module would be impossible
> because only one module can provide the char-major-10-144 alias.
> 
> A multi-platform kernel binary needs a single, generic module. With this
> patch series, drivers/char/nvram.c becomes more generic and some of the
> arch-specific code gets moved under arch/. The nvram module is then
> usable by all m68k, powerpc and x86 platforms.
> 
> This allows for removal of drivers/char/generic_nvram.c as well as a
> duplicate in arch/powerpc/kernel/nvram_64.c. By reducing the number of
> /dev/nvram char misc device implementations, the number of bugs and
> inconsistencies is also reduced.
> 
> This approach reduces inconsistencies between PPC32 and PPC64 and also
> between PPC_PMAC and MAC. A uniform API has benefits for userspace.
> 
> For example, some error codes for some ioctl calls become consistent
> across PowerPC platforms. The uniform API can potentially benefit any
> bootloader that works across the various platforms having XPRAM
> (e.g. Emile).
> 
> This patch series was tested on Atari, Mac, PowerMac (both 32-bit and
> 64-bit) and ThinkPad hardware. AFAIK, it has not yet been tested on
> pSeries or CHRP.
> 
> I think there are two possible merge strategies for this patch series.
> The char misc maintainer could take the entire series. Alternatively,
> the m68k maintainer could take patches 1 thru 16 (though some of these
> have nothing to do with m68k) and after those patches reach mainline
> the powerpc maintainer could take 17 thru 22.

I just took the whole series, thanks for doing this, looks good.

greg k-h
