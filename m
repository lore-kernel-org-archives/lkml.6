Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6412170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS3qLWUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6412170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHUOEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:04:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46976 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeHUOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:04:10 -0400
Received: by mail-io0-f195.google.com with SMTP id y12-v6so5261801ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dg59mDSI9aAGS28tik0yHQG4BYg8g1Mbs0L7PJIGt0Q=;
        b=RS3qLWUEiGssosl/BuwvdwiUefnWikFclwWFHNPw1n0fppIMEmNkKuEFrofSvnWmKK
         s2BznqGvV2JZ+V5prqXAn/TZcdZPxp2YgDRsxkZ2MUFM4c4Gf635uh4x3tBD1o94bFxr
         oSkt55XT1SGZrw2CzVwzTJadb94lUcmnaNf7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dg59mDSI9aAGS28tik0yHQG4BYg8g1Mbs0L7PJIGt0Q=;
        b=QJUHBRsD7NXXD6bOwLu18aWE8FrGLJucdXnEwssbNbCy5ic8ZICyurgHsyXmNthAll
         1QD54BBePkecC2TWBxY2zfWKO90WIS0NwqbmDe2r8KLVyhEdUuZjBG/WvBCpxXAMW902
         JX0w9hWeLC6/AR5ex1/F02kiu2rBrGWUTuVdErfRpmuSAt7JHp9ws854p+4+dxpJyKeH
         qYWICM8iSFPC3qHl/XztgRNgYfhc/7nmUlLJK4bBZ//pw0eE9MOEBx93ZRP8lzyGdQrB
         ub2iCWNoNH/DbNagaJN1bCW8UwSV9DdOnnGU5d1/epNfapX2DH+tO8awlJsvCwTcYgHm
         +FIw==
X-Gm-Message-State: APzg51DNLm2gTtC3UwhHyPKpHVud3+dMRLS6DUbNg/r+OJDo+8KP0q3g
        NYvGde1P+TqqdR/lg3nNT+CMJVWsICBu57VywQf84Q==
X-Google-Smtp-Source: ANB0Vdaf3yOGWSqmHIRQyuyNkQPR2hvk3QKz6ko00NP5+XefdnoAYoGDWAtCAY3Vsvy6akVpSP8K9d02Vemn17U7fy0=
X-Received: by 2002:a6b:2cc1:: with SMTP id s184-v6mr15986213ios.23.1534848271871;
 Tue, 21 Aug 2018 03:44:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3541:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 03:44:31
 -0700 (PDT)
In-Reply-To: <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 21 Aug 2018 16:14:31 +0530
Message-ID: <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 August 2018 at 15:17, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> (+CC Rob, DT, LKML)
>
> I forgot to CC this to DT community...
>
>
> 2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
>> Pro4, and sLD8 SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>> new file mode 100644
>> index 0000000..a9e969e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>> @@ -0,0 +1,28 @@
>> +UniPhier Media IO DMA controller
>> +
>> +This works as an external DMA engine for SD/eMMC controllers etc.
>> +found in UniPhier LD4, Pro4, sLD8 SoCs.
>> +
>> +Required properties:
>> +- compatible: should be "socionext,uniphier-mio-dmac".
>> +- reg: offset and length of the register set for the device.
>> +- interrupts: a list of interrupt specifiers associated with the DMA channels.
>> +- clocks: a single clock specifier
>> +- #dma-cells: should be <1>. The single cell represents the channel number.
>> +- dma-channels: specify the number of the DMA channels. This should match to
>> +  the number of tuples in the interrupts property.
>> +
Can we not infer the number of channels from interrupt tuples? After
all the driver assumes they are same.
