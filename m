Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243442075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T/I+3LVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243442075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJYUcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:32:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58968 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KqIGekJpw9cG2hQa6zjbOurEgyS91jisgXcI+lcalpg=; b=T/I+3LViEvCKCvYIECwd3GcVt
        WAA+DvXulhesOO3+ES0Z3OY/MPF3+FYbwQWM8JPW9PZPytpCkitOrNZg2K9rzbQDkXh43XEQ7nr5o
        25PRU6sSJ+pu5mWZCsQUwoGYswwjute3FPmuoT7tvBSm/xrOzMwsC0Ij+a26qqE75Q03U=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:35120)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFeJI-0007Ux-6f; Thu, 25 Oct 2018 13:00:20 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFeJ9-0006AZ-5d; Thu, 25 Oct 2018 13:00:12 +0100
Date:   Thu, 25 Oct 2018 13:00:06 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
Message-ID: <20181025120006.GY30658@n2100.armlinux.org.uk>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:27:44PM -0300, Rafael David Tinoco wrote:
> On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
> physical frame number might be so big that zsmalloc obj encoding (to
> location) will break IF architecture does not re-define
> MAX_PHYSMEM_BITS, causing:

I think there's a deeper problem here - a misunderstanding of what
MAX_PHYSMEM_BITS is.

MAX_PHYSMEM_BITS is a definition for sparsemem, and is only visible
when sparsemem is enabled.  When sparsemem is disabled, asm/sparsemem.h
is not included (and should not be included) which means there is no
MAX_PHYSMEM_BITS definition.

I don't think zsmalloc.c should be (ab)using MAX_PHYSMEM_BITS, and
your description above makes it sound like you expect it to always be
defined.

If we want to have a definition for this, we shouldn't be playing
fragile games like:

#ifndef MAX_POSSIBLE_PHYSMEM_BITS
#ifdef MAX_PHYSMEM_BITS
#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
#else
/*
 * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
 * be PAGE_SHIFT
 */
#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
#endif
#endif

but instead insist that MAX_PHYSMEM_BITS is defined _everywhere_.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
