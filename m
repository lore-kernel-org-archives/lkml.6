Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0994EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6533223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6533223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeKMUbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:31:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42943 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeKMUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:31:25 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so6934286vsd.9;
        Tue, 13 Nov 2018 02:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5SzxIa9mPp45Qc/kBULxPInKEza8q2OTrgnemDCaHw=;
        b=nk1r0enAaoSEgnsE4KpL4UpIlSwoUe5v/1C6hO8XPpe6MriKOOcUk+BICxzgAz0Hxg
         aIUWpwKt7ANTm8ntOpygCbsFofwxOhF9qJpsDG7Bn4UhVsFDnHnseq+HE9x9lTV1dwY6
         TdYHp1+kYaMaj1qAJb50qhKxRMxRUjDi7o89UIeaSkdV9U4rxYG8//wnR81/aRkY6+Dj
         Bwouh9jp2a5NxPx+Ylqipg8EbRWRIPToUPfoSA3Vxqabp1Nc90kxsuWPeFBj8onjIrAF
         iGQw1GmqZ9BPInNN50DOJm6dmxGX+ZVcZqUZLi2Dt8FdER7xDm/C0ggMN9cOSYUCSPnB
         ribw==
X-Gm-Message-State: AGRZ1gIuPaYc+Q+Yu7attAD/SCCrVY+rcltynCjnND+6TvipRfVvDnI1
        XBlG8Ht6IMex//xoTFB9m7BjkRFLPdkBC/pwlSw=
X-Google-Smtp-Source: AJdET5f15sPP7B0jZX+k/geTCPoIF6a1LWDhKvq6G3QwWNmS+7iDwCQWTZvlOR+hJlgwclFWuaUcIKHfmcs5ARTUpwU=
X-Received: by 2002:a67:3885:: with SMTP id n5mr1800358vsi.96.1542105235134;
 Tue, 13 Nov 2018 02:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20181113102228.820214-1-lkundrak@v3.sk> <20181113102228.820214-3-lkundrak@v3.sk>
In-Reply-To: <20181113102228.820214-3-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 11:33:43 +0100
Message-ID: <CAMuHMdU0_CnXGzWNkb4q1dm1yoVOkG=Hhr0BnS3dYdjd-7A-+Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] spi: Deal with slaves that return from
 transfer_one() unfinished
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
