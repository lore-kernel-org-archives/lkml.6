Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90107C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557EE20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d74AQk+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557EE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJXUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:22:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=noYNixtyW6+tNSA5DMMgXeStNZuyJHQIA6ZSbn3aZnw=; b=d74AQk+mGnhZt5jphC1m0Ij0B
        nkDHBVDu4HnXFEih4EG2ZaIsKZlK6ImhbKlHFrjABiY7MKuD/TiLs7ABml1gpbuwR7KpC+kFOB49s
        3SItegqGnwV71Di8PuVLHMzoUhzN85iuwwZk+9as+POkXKZPv/n8Wqwl7PnZNq64ukHP/EkfTLc4/
        PNRwUgP3+2bF6HxIJkxXducKCIzHAZLJ3vPpNwh2IiYOYpG5Jf03EjhvG4i4ptObOPK+ZZ5zXyAvs
        SXGvfPDw1iEmBoYbZiUzm28+hy2VlmxzURw/uh1clBVhlburJ3fkv7Kdd8Dh2Z5kYjlHHf62alnaA
        WZM2Hin2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFHkN-0005Bt-Kc; Wed, 24 Oct 2018 11:54:47 +0000
Date:   Wed, 24 Oct 2018 04:54:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181024115447.GE25444@bombadil.infradead.org>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
 <20181023163157.41441-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023163157.41441-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 07:31:56PM +0300, Kirill A. Shutemov wrote:
> -ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
> +ffff888000000000 - ffff887fffffffff (=39 bits) LDT remap for PTI

I'm a little bit cross-eyed at this point, but I think the above '888'
should be '880'.

> @@ -14,7 +15,6 @@ ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
>  ... unused hole ...
>  				    vaddr_end for KASLR
>  fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
> -fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI

... and the line above this one should be adjusted to finish at
fffffeffffffffff (also it's now 40 bits).  Or should there be something
else here?

>  ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
>  ... unused hole ...
>  ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
> @@ -30,8 +30,8 @@ Virtual memory map with 5 level page tables:
>  0000000000000000 - 00ffffffffffffff (=56 bits) user space, different per mm
>  hole caused by [56:63] sign extension
>  ff00000000000000 - ff0fffffffffffff (=52 bits) guard hole, reserved for hypervisor
> -ff10000000000000 - ff8fffffffffffff (=55 bits) direct mapping of all phys. memory
> -ff90000000000000 - ff9fffffffffffff (=52 bits) LDT remap for PTI
> +ff10000000000000 - ff10ffffffffffff (=48 bits) LDT remap for PTI
> +ff11000000000000 - ff90ffffffffffff (=55 bits) direct mapping of all phys. memory

What's at ff910..0 to ff9f..f ?

Is there any way we can generate this part of this file to prevent human
error from creeping in over time?  ;-)

