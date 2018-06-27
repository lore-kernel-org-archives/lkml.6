Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C060C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A2225BCC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A2225BCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966120AbeF0Vl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:41:26 -0400
Received: from ozlabs.org ([203.11.71.1]:49583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965789AbeF0VlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:41:25 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41GGZC26Lyz9s1R; Thu, 28 Jun 2018 07:41:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 22db552b50fa11d8c1d171de908a1f9ef62172b7
In-Reply-To: <20180619140229.3615110-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mathieu Malaterre <malat@debian.org>,
        Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, linux-m68k@lists.linux-m68k.org,
        Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [1/3,v2] powerpc: mac: fix rtc read/write functions
Message-Id: <41GGZC26Lyz9s1R@ozlabs.org>
Date:   Thu, 28 Jun 2018 07:41:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 14:02:27 UTC, Arnd Bergmann wrote:
> As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
> in negative times to be read from the RTC. The problem is that during the
> conversion from a byte array to a time64_t, the 'unsigned char' variable
> holding the top byte gets turned into a negative signed 32-bit integer
> before being assigned to the 64-bit variable for any times after 1972.
> 
> This changes the logic to cast to an unsigned 32-bit number first for
> the Macintosh time and then convert that to the Unix time, which then gives
> us a time in the documented 1904..2040 year range. I decided not to use
> the longer 1970..2106 range that other drivers use, for consistency with
> the literal interpretation of the register, but that could be easily
> changed if we decide we want to support any Mac after 2040.
> 
> Just to be on the safe side, I'm also adding a WARN_ON that will trigger
> if either the year 2040 has come and is observed by this driver, or we
> run into an RTC that got set back to a pre-1970 date for some reason
> (the two are indistinguishable).
> 
> For the RTC write functions, Andreas found another problem: both
> pmu_request() and cuda_request() are varargs functions, so changing
> the type of the arguments passed into them from 32 bit to 64 bit
> breaks the API for the set_rtc_time functions. This changes it
> back to 32 bits.
> 
> The same code exists in arch/m68k/ and is patched in an identical way now
> in a separate patch.
> 
> Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/22db552b50fa11d8c1d171de908a1f

cheers
