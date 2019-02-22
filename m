Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E608C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A92086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfBVJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:10 -0500
Received: from ozlabs.org ([203.11.71.1]:47437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfBVJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:48:05 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RNM72H2z9sDX; Fri, 22 Feb 2019 20:48:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cabe8138b23c92e851b92c6a20ffb13598ff34d4
X-Patchwork-Hint: ignore
In-Reply-To: <9afb42b9d78abe00fe049e1736a180b1facdfd86.1550490186.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: dump as a single line areas mapping a single physical page.
Message-Id: <445RNM72H2z9sDX@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:48:03 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 12:25:20 UTC, Christophe Leroy wrote:
> When using KASAN, there are parts of the shadow area where all
> pages are mapped to the kasan_early_shadow_page. It is pointless
> to dump one line for each of those pages (in the example below there
> are 7168 entries pointing to the same physical page).
> 
> ~# cat /sys/kernel/debug/kernel_page_tables
>  ...
> ---[ kasan shadow mem start ]---
> 0xf7c00000-0xf8bfffff 0x06fac000       16M        rw       present           dirty  accessed
> 0xf8c00000-0xf8c03fff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c04000-0xf8c07fff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c08000-0xf8c0bfff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c0c000-0xf8c0ffff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c10000-0xf8c13fff 0x00cd0000       16K        r        present           dirty  accessed
>  ... 7168 identical lines
> 0xffbfc000-0xffbfffff 0x00cd0000       16K        r        present           dirty  accessed
> ---[ kasan shadow mem end ]---
>  ...
> 
> This patch modifies linux table dump to dump as a single line areas
> where all addresses points to the same physical page. That physical
> address is put inside [] to show that all virt pages points to the
> same phys page.
> 
> ~# cat /sys/kernel/debug/kernel_page_tables
>  ...
> ---[ kasan shadow mem start ]---
> 0xf7c00000-0xf8bfffff  0x06fac000        16M        rw       present           dirty  accessed
> 0xf8c00000-0xffbfffff [0x00cd0000]       16K        r        present           dirty  accessed
> ---[ kasan shadow mem end ]---
>  ...
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cabe8138b23c92e851b92c6a20ffb135

cheers
