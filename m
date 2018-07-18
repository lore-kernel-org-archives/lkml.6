Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE12ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C46F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C46F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGRO12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:27:28 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38956 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbeGRO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:27:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CF07423F11;
        Wed, 18 Jul 2018 09:49:21 -0400 (EDT)
Date:   Wed, 18 Jul 2018 23:49:20 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
In-Reply-To: <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de> <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com> <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
 <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Arnd Bergmann wrote:

> Hmm, apparently I forgot to update via_read_time(), that one
> is indeed bogus and now inconsistent with the other functions.
> 
> The change in via_write_time() seems at least consistent wtih what we do 
> elsewhere, and using __u32 makes this code more portable. (yes, I 
> realize that 64-bit powermac doesn't use the VIA RTC, but it feels 
> better to write code portably anyway).
> 

As for portability, I think you just contradicted yourself. But I take 
your point about consistency. So I won't object to adopting __u32.

> I'd suggest we do it like below to make it consistent with the
> rest again, using the 1904..2040 range of dates and no warning
> for invalid dates.
> 
> If you agree, I'll send that as a proper patch.
> 

Geert may instead wish to fixup or revert the patch he has committed 
already...

>        Arnd
> 
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index bf8df47a6d09..8335509969f1 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -255,12 +255,13 @@ static void via_write_pram(int offset, __u8 data)
>   * is basically any machine with Mac II-style ADB.
>   */
> 
> -static long via_read_time(void)
> +static time64_t via_read_time(void)
>  {
>         union {
>                 __u8 cdata[4];
> -               long idata;
> +               __u32 idata;
>         } result, last_result;
> +       time64_t ret;

ret isn't used.

>         int count = 1;
> 
>         via_pram_command(0x81, &last_result.cdata[3]);
> @@ -279,12 +280,8 @@ static long via_read_time(void)
>                 via_pram_command(0x89, &result.cdata[1]);
>                 via_pram_command(0x8D, &result.cdata[0]);
> 
> -               if (result.idata == last_result.idata) {
> -                       if (result.idata < RTC_OFFSET)
> -                               result.idata += 0x100000000ull;
> -
> -                       return result.idata - RTC_OFFSET;
> -               }
> +               if (result.idata == last_result.idata)
> +                       return (time64_t(result.idata) - RTC_OFFSET);
> 

Did you mean to write,

			return (time64_t)result.idata - RTC_OFFSET;

?

-- 
