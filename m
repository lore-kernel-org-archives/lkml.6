Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864CEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45F2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfA2Jwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:52:35 -0500
Received: from ozlabs.org ([203.11.71.1]:35429 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfA2Jwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:52:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43phcK6Xzfz9s9h;
        Tue, 29 Jan 2019 20:52:17 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
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
        xen-devel@lists.xenproject.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 02/21] powerpc: use memblock functions returning virtual address
In-Reply-To: <1548057848-15136-3-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com> <1548057848-15136-3-git-send-email-rppt@linux.ibm.com>
Date:   Tue, 29 Jan 2019 20:52:17 +1100
Message-ID: <871s4vssdq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@linux.ibm.com> writes:

> From: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Since only the virtual address of allocated blocks is used,
> lets use functions returning directly virtual address.
>
> Those functions have the advantage of also zeroing the block.
>
> [ MR:
>  - updated error message in alloc_stack() to be more verbose
>  - convereted several additional call sites ]
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c |  3 +--
>  arch/powerpc/kernel/irq.c         |  5 -----
>  arch/powerpc/kernel/paca.c        |  6 +++++-
>  arch/powerpc/kernel/prom.c        |  5 ++++-
>  arch/powerpc/kernel/setup_32.c    | 26 ++++++++++++++++----------
>  5 files changed, 26 insertions(+), 19 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
