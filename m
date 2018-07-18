Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29602ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19F22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19F22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbeGRMjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:39:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36700 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeGRMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:39:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6A1B027572;
        Wed, 18 Jul 2018 08:02:13 -0400 (EDT)
Date:   Wed, 18 Jul 2018 22:02:15 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
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
In-Reply-To: <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de> <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Geert Uytterhoeven wrote:

> 
> Thanks for your patch!
> 
> Applied and queued for v4.19, with the WARN_ON() dropped.
> 

The patch you've committed to your for-v4.19 branch has this hunk:

@@ -269,8 +275,12 @@ static long via_read_time(void)
                via_pram_command(0x89, &result.cdata[1]);
                via_pram_command(0x8D, &result.cdata[0]);
 
-               if (result.idata == last_result.idata)
+               if (result.idata == last_result.idata) {
+                       if (result.idata < RTC_OFFSET)
+                               result.idata += 0x100000000ull;
+
                        return result.idata - RTC_OFFSET;
+               }
 
                if (++count > 10)
                        break;

That looks bogus to me, since result.idata is a long.

Also, the following hunk seems a bit pointless (?)

@@ -291,11 +301,11 @@ static long via_read_time(void)
  * is basically any machine with Mac II-style ADB.
  */
 
-static void via_write_time(long time)
+static void via_write_time(time64_t time)
 {
        union {
                __u8 cdata[4];
-               long idata;
+               __u32 idata;
        } data;
        __u8 temp;
 

But if data.idata needs to be changed to __u32 here, why not change the 
same struct member in via_read_time() also?

-- 
