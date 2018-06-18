Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D014DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mCHZUHgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8001B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeFRNyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:54:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:20504 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbeFRNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:54:22 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5IDrwq1002183;
        Mon, 18 Jun 2018 22:53:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5IDrwq1002183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529330038;
        bh=NRDJDvY/e6MvQ5m+Pdmm7CUdGR++gHjO7t+14n/56KQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mCHZUHgvoFkkVjtLY2lytREOEuIxDqORihpfgxJBEjUQJeUJXR0V5AfcJUQnZqPwL
         FaCgtXBlfxou4UQcphdBu5ltJyoeew/quvAtE4GoYumNsgJuAzpiQF5Q1CGnkyJngV
         n95rBng9riX99nbDYo2NObEXWSzAKexUsEPjT0TwuejLMwnpx0R9K92WGQQOOrjPJq
         ovUzV8qqTTPXGdn1fdYGqpdDhtpGSVc6p2zsVJm2CCOJqEq26y8C2xd1lwRYD6zwwz
         eF82qS41X37aC/0RKnVzx3VpHOdzhrb86g/nRFqi9JamTbJaeFM4osiSVMpRfDFEpq
         FuoWsCGuQaYqw==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id 128-v6so9555670vkf.8;
        Mon, 18 Jun 2018 06:53:58 -0700 (PDT)
X-Gm-Message-State: APt69E3PM2C2uK5wvMoLVGkBibzBD88/QAdXwwHxS//JwEmv33MESxMg
        A2tIVW13kTL+TbBWHgjbi7biFbVoz69uWjOPdiw=
X-Google-Smtp-Source: ADUXVKIiuyQy5ll+/YY5qMBehcnBV0KmGRUmdOwOki2j4UnypOIVU2X6a5kaeXvEv8VVIkeGpohF0uybpDCkmxgJlTA=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr7154593vkj.160.1529330037618;
 Mon, 18 Jun 2018 06:53:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 06:53:17
 -0700 (PDT)
In-Reply-To: <34780659.LX1KsSZy9L@blindfold>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
 <1529025532-22087-4-git-send-email-yamada.masahiro@socionext.com> <34780659.LX1KsSZy9L@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Jun 2018 22:53:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8QTP6nMuR9j5-+Yxg5yzP2Dyq-rKGN-MaYg8xgr-3Ng@mail.gmail.com>
Message-ID: <CAK7LNAR8QTP6nMuR9j5-+Yxg5yzP2Dyq-rKGN-MaYg8xgr-3Ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mtd: rawnand: denali: optimize timing parameters
 for data interface
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,


2018-06-18 16:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Am Freitag, 15. Juni 2018, 03:18:52 CEST schrieb Masahiro Yamada:
>> This commit improves the ->setup_data_interface() hook.
>>
>> The denali_setup_data_interface() needs the frequency of clk_x
>> and the ratio of clk_x / clk.
>>
>> The latter is currently hardcoded in the driver, like this:
>>
>>   #define DENALI_CLK_X_MULT       6
>>
>> The IP datasheet requires that clk_x / clk be 4, 5, or 6.  I just
>> chose 6 because it is the most defensive value, but it is not optimal.
>> By getting the clock rate of both "clk" and "clk_x", the driver can
>> compute the timing values more precisely.
>
> What datasheet do you have, is it public?

No.  Not available in public.

I got the datasheet
because Socionext (formerly, Panasonic) bought this IP.


> Mine clearly states that the factor is 4.
> "The frequency of nand_x_clk is four times the frequency of nand_clk."

I checked
"Denali NAND Flash Memory Controller User's Guide"
released by Denali.

I also get access to a newer version
"Cadence Design IP - NAND Flash Memory Controller User's Guide"
because Cadence acquired Denali.


My datasheet says:
"clk_x - Cadence NAND Flash Memory Controller bus
interface clock. This runs at a configured
multiple of clk as is phase aligned. Configured
multiple can be between 4-6 times."



Various parts of this IP are configurable.
Is yours talking about this IP,
or about a particular configuration for SOCFPGA?



>> To not break the existing platforms, the fallback value, 50 MHz is
>> provided.  It is true for all upstreamed platforms.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Reviewed-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
