Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9810C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368532151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TFd56VNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368532151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHXSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:40:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53972 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:40:39 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7OF5PVn027586
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 00:05:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7OF5PVn027586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535123126;
        bh=1pd3VOjIuDn35dmsnNq2OI98P4DfaePX1IHyAnN7Lyc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TFd56VNLtX2Qe/MO2y+IdVpanpIF8GXYYmQM37CSdulUyWEdkhhmqZ10lxHC3GLiI
         1IVrq+Wj0Xdb+9eTLalZzQrwdt1u/0Z5juxIgXTP+L4mywAPtg7RoAj+eeZ3PoGhUV
         y+sRoQEioJREsEpLhUTtBj+3VwQPWSj6n7Mnk6tutT0luvPjFHxHMG4o3AcuhYnU+i
         dueUpw/GUaxHNf7T+/Lx1h2gXVui5xzouNKCYRfsd5qkUkQlQSUDi1fhbKhrA8OIFg
         MiriBfRGRWI0zhEVmx+UBen6Jenp3NhKHlUlmVcEG0HZCs9DMoOWXlHZe4wQ9ZzesU
         uVB1XjD9Q28wg==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id s6-v6so3329798vks.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:05:25 -0700 (PDT)
X-Gm-Message-State: APzg51BUUA7XX0XiFJ7sMF3+DCIVTblIPI8wDR7s13soV7fbUZMuYtGL
        lZHnDgeO8wEj/RPOrDQ0Gs4i6Sc/NKEADounPs4=
X-Google-Smtp-Source: ANB0VdbW8dqmH6sI82PQ9ObBbt0raMV2kLkyyyH7ERUOqVBlrCEm+VbKcvfE3ImcB8n74oi3xS1wtWW42ogZWzumW2Y=
X-Received: by 2002:a1f:491:: with SMTP id 139-v6mr1215326vke.55.1535123124258;
 Fri, 24 Aug 2018 08:05:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 08:04:43
 -0700 (PDT)
In-Reply-To: <20180824145519.330133a4@bbrezillon>
References: <1534839799-14112-1-git-send-email-yamada.masahiro@socionext.com> <20180824145519.330133a4@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 25 Aug 2018 00:04:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwqkhSkGK6vpFTvxd_ppdMpQzMY-C4ZJgaVMuzEA_b3w@mail.gmail.com>
Message-ID: <CAK7LNAQwqkhSkGK6vpFTvxd_ppdMpQzMY-C4ZJgaVMuzEA_b3w@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: do not pass zero maxchips to nand_scan()
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

2018-08-24 21:55 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> Hi Masahiro,
>
> On Tue, 21 Aug 2018 17:23:19 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> Commit 49aa76b16676 ("mtd: rawnand: do not execute nand_scan_ident()
>> if maxchips is zero") gave a new meaning for calling nand_scan_ident()
>> with maxchips=0.
>>
>> It is a special usage for some drivers such as docg4, but in fact
>> the Denali driver may pass maxchips=0 to nand_scan() when the driver
>> is enabled but no NAND chip is found on the board for some reasons.
>>
>> If nand_scan_with_ids() is called with maxchips=0, nand_scan_ident()
>> is skipped, i.e. nand_set_defaults() is skipped.  Therefore, the
>> driver must have set chip->controller beforehand.  Otherwise,
>> nand_attach() causes NULL pointer dereference.
>>
>> In fact, the Denali controller knows the number of connected chips
>> before calling nand_scan_ident(); if DEVICE_RESET fails, there is no
>> chip in that chip select.  Then, denali_reset_banks() sets the maxchips
>> to the number of detected chips.  If no chip is found, it is zero.
>>
>> The reason of this trick was, as commit f486287d2372 ("mtd: nand:
>> denali: fix bank reset function to detect the number of chips")
>> explained, nand_scan_ident() issued Set Features (0xEF) command
>> to all CS lines, some of which may not be connected with a chip.
>> Then, the driver would wait until R/B# response, which never happens.
>>
>> This problem was solved by commit 107b7d6a7ad4 ("mtd: rawnand: avoid
>> setting again the timings to mode 0 after a reset").  In the current
>> code, nand_setup_data_interface() is called from nand_scan_tail(),
>> which is after the chip detection is done.
>>
>> Remove the code that is causing NULL pointer dereference.  Now, the
>> maxchips passed to nand_scan() is the maximum number of chip selects
>> supported by the IP (typically 4 or 8).  Leave all the chip detection
>> process to nand_scan_ident().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/mtd/nand/raw/denali.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
>> index ca18612..3e4b8e1 100644
>> --- a/drivers/mtd/nand/raw/denali.c
>> +++ b/drivers/mtd/nand/raw/denali.c
>> @@ -1086,7 +1086,6 @@ static void denali_reset_banks(struct denali_nand_info *denali)
>>       }
>>
>>       dev_dbg(denali->dev, "%d chips connected\n", i);
>> -     denali->max_banks = i;
>
> Shouldn't we instead avoid calling nand_scan() when
> denali->max_banks=0? I mean, what's the point of calling this function
> if you know for sure it will fail.


Right.  If no chip is found, it should error out with -ENODEV or something.



> Last question: do we still need this denali_reset_banks()? If it's only
> about resetting the chip to detect how many are actually present,
> that's already done by nand_scan().

I thought this too.

Please give me time to answer this question.
I need to check the datasheet and test on my boards.

If I can remove denali_reset_banks() entirely,
it would be the best.

Thanks.



>>  }
>>
>>  static void denali_hw_init(struct denali_nand_info *denali)
>



-- 
Best Regards
Masahiro Yamada
