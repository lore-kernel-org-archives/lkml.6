Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC2FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C6720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l9rsSDcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C6720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJYWQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:16:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60138 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJYWQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nsK3ARigFKu+JIIpi/iMqtsIK7bWt2pAGr1cZYAOjkc=; b=l9rsSDcK8XipQxMLpE7IH7U30
        UNX4QIidSSF3I/n50u7pkGgI8V1eI+14t21dwnl2UGEFEcLwb1tC78bpj+dx/bdbNseuaoZ4BgT4u
        0NtnLMpbl2fkQYNE2tCF6kj4TZRgI32JArZ+0CK3H2H9LDEmNT/fVzpq6gXwHLnmXePRA=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:51753)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFfvR-0007uO-MK; Thu, 25 Oct 2018 14:43:50 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFfvO-00079P-0c; Thu, 25 Oct 2018 14:43:46 +0100
Date:   Thu, 25 Oct 2018 14:43:44 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
Message-ID: <20181025134344.GZ30658@n2100.armlinux.org.uk>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
 <20181025120006.GY30658@n2100.armlinux.org.uk>
 <CABdQkv_cC4ixEFr91zyg-S21O5_7U8FV7=g7ZMRqGcQyhrwzaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdQkv_cC4ixEFr91zyg-S21O5_7U8FV7=g7ZMRqGcQyhrwzaQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:37:59AM -0300, Rafael David Tinoco wrote:
> Is it okay to propose using only MAX_PHYSMEM_BITS for zsmalloc (like
> it was before commit 02390b87) instead, and make sure *at least* ARM
> 32/64 and x86/x64, for now, have it defined outside sparsemem headers
> as well ?

It looks to me like this has been broken on ARM for quite some time,
predating that commit.  The original was:

#ifndef MAX_PHYSMEM_BITS
#ifdef CONFIG_HIGHMEM64G
#define MAX_PHYSMEM_BITS 36
#else /* !CONFIG_HIGHMEM64G */
#define MAX_PHYSMEM_BITS BITS_PER_LONG
#endif
#endif
#define _PFN_BITS              (MAX_PHYSMEM_BITS - PAGE_SHIFT)

On ARM, CONFIG_HIGHMEM64G is never defined (it's an x86 private symbol)
which means that the above sets MAX_PHYSMEM_BITS to 32 on non-sparsemem
ARM LPAE platforms.  So commit 02390b87 hasn't really changed anything
as far as ARM LPAE is concerned - and this looks to be a bug that goes
all the way back to when zsmalloc.c was moved out of staging in 2014.

Digging further back, it seems this brokenness was introduced with:

commit 6e00ec00b1a76a199b8c0acae401757b795daf57
Author: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date:   Mon Mar 5 11:33:22 2012 -0600

    staging: zsmalloc: calculate MAX_PHYSMEM_BITS if not defined

    This patch provides a way to determine or "set a
    reasonable value for" MAX_PHYSMEM_BITS in the case that
    it is not defined (i.e. !SPARSEMEM)

    Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
    Acked-by: Nitin Gupta <ngupta@vflare.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

which, at the time, realised the problem with SPARSEMEM, but decided
that in the absense of SPARSEMEM, that MAX_PHYSMEM_BITS shall be
BITS_PER_LONG which seems absurd (see below.)

> This way I can WARN_ONCE(), instead of BUG(), when specific
> arch does not define it - enforcing behavior - showing BITS_PER_LONG
> is being used instead of MAX_PHYSMEM_BITS (warning, at least once, for
> the possibility of an overflow, like the issue showed in here).

Assuming that the maximum number of physical memory bits are
BITS_PER_LONG in the absense of MAX_POSSIBLE_PHYSMEM_BITS is a nonsense
- we have had the potential for PAE systems for a long time, and to
introduce new code that makes this assumption was plainly wrong.

We know when there's the potential for PAE, and thus more than
BITS_PER_LONG bits of physical memory address, through
CONFIG_PHYS_ADDR_T_64BIT.  So if we have the situation where
MAX_POSSIBLE_PHYSMEM_BITS (or the older case of MAX_PHYSMEM_BITS) not
being defined, but CONFIG_PHYS_ADDR_T_64BIT set, we should've been
erroring or something based on not knowing how many physical memory
bits are possible - it would be more than BITS_PER_LONG but less
than some unknown number of bits.

This is why I think any fallback here to BITS_PER_LONG is wrong.

What I suggested is to not fall back to BITS_PER_LONG in any case, but
always define MAX_PHYSMEM_BITS.  However, I now see that won't work for
x86 because MAX_PHYSMEM_BITS is not a constant anymore.

So I suggest everything that uses zsmalloc.c should instead define
MAX_POSSIBLE_PHYSMEM_BITS.

Note that there should _also_ be some protection in zsmalloc.c against
MAX_POSSIBLE_PHYSMEM_BITS being too large:

#define OBJ_INDEX_BITS  (BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
#define OBJ_TAG_BITS 1
#define _PFN_BITS               (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)

which means there's an implicit limitation on _PFN_BITS being less than
BITS_PER_LONG - OBJ_TAG_BITS (where, if it's equal to this, and hence
OBJ_INDEX_BITS will be zero.)  This imples that MAX_POSSIBLE_PHYSMEM_BITS
must be smaller than BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS, or
43 bits on a 32 bit system.  If you want to guarantee a minimum number
of objects, then that limitation needs to be reduced further.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
