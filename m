Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40731C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD9C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547800957;
	bh=/A19VUor74ICH0K0h/pulLr023SA07xwYLMGvSrqEU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxBUFaA8I5LtnnupcXNL48SEr/F3e99EZciwm+x65E7fQTNUsuniUErA9HwBpLdTS
	 qKTH74Grv8xGoltEnvYh7o+lIxN8Lzh2y6ovGYEQeLOwkm6iizmQTblUsMTVPdikns
	 aIuhzOQ1hGtU36JukzT4ZKm8eklYvkMYdoXWm4X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfARImf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfARIme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:42:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FADC20855;
        Fri, 18 Jan 2019 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547800953;
        bh=/A19VUor74ICH0K0h/pulLr023SA07xwYLMGvSrqEU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euYF565NKIFwTO8L7LafcO3f+dvk3VpVOqUE3KZqyrAGoL+mfBNN/NBfukJu2vppN
         jyZroW4VJ+NZVDY0kUiVXswgZ3QIA9IPTrccAzpph12M+/gvbY1jT7YCaLWREj4Dmc
         XiiHsU4i/YM2IIvKOJvbfh1trsEz6JqMornEb95A=
Date:   Fri, 18 Jan 2019 09:42:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 21/21] memblock: drop memblock_alloc_*_nopanic() variants
Message-ID: <20190118084230.GA8855@kroah.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-22-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547646261-32535-22-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:44:21PM +0200, Mike Rapoport wrote:
> As all the memblock allocation functions return NULL in case of error
> rather than panic(), the duplicates with _nopanic suffix can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arc/kernel/unwind.c       |  3 +--
>  arch/sh/mm/init.c              |  2 +-
>  arch/x86/kernel/setup_percpu.c | 10 +++++-----
>  arch/x86/mm/kasan_init_64.c    | 14 ++++++++------
>  drivers/firmware/memmap.c      |  2 +-
>  drivers/usb/early/xhci-dbc.c   |  2 +-
>  include/linux/memblock.h       | 35 -----------------------------------
>  kernel/dma/swiotlb.c           |  2 +-
>  kernel/printk/printk.c         | 17 +++++++----------
>  mm/memblock.c                  | 35 -----------------------------------
>  mm/page_alloc.c                | 10 +++++-----
>  mm/page_ext.c                  |  2 +-
>  mm/percpu.c                    | 11 ++++-------
>  mm/sparse.c                    |  6 ++----
>  14 files changed, 37 insertions(+), 114 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
