Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB129C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kjg3heJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B2D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeIJWMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:12:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33970 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeIJWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:12:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so18124726lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVLiwjP9SKl4jZxY2AkSujZSfyE/upl+/yiMB1QzDek=;
        b=Kjg3heJsDeBjKyJbb/2E8J2f+mi8P5trkxnLdx7Zm0BTewIMhEu2DlA4Hkq88qwQ56
         uE+zCW3UwvoZ2OlEmMT8JBHG3kOpqwVGy3hz9avfC7dN2zFMDL0pDzijxVTi4oocWf3x
         +Non2twI3Fv2e/Vwn4kRqwD2IhlpASD1gdJFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVLiwjP9SKl4jZxY2AkSujZSfyE/upl+/yiMB1QzDek=;
        b=n32SsFVQuTTPy3OHFtnkenNmzZeO1zis05UuQa6fFp0QWHhB20i+pLLEdvPXb2MLFb
         6QMoqJT1uCFlOWeSgTQcqM0Fm/FG2PmRcRZ0nUmAMzjVhQXVn8B42ob0eHLZYhc9aHaJ
         18GGlfHMDsGC1C69ioRgag5hMb4M0Vb9n0n50VWjytsyhp4HhXKjaeFRCZ219hYDVCXn
         iK6PE6PuYEOGOHuOAaZsioB+sYYOQGh2JliVc3wFBIDgPvN0IOIPdz5o0DUEKBYmlz7d
         cltBRm2V9ruTUBM89elE84hl4gs0YB7LaCVjCPUJHjwxXCq9Lz+hx/nGeft7/20IoO9k
         Tnvg==
X-Gm-Message-State: APzg51Anrfn9uPj5zzcvfXpLi9jioXEdPspWC3eiJUPLWCXCM6TeZn8M
        sYW50JhlZ0u+RUQHpq40edXJdCq25uiGmmIE1Zf2PQ==
X-Google-Smtp-Source: ANB0VdY8BQugFk7DjIihn9MQ5j0buIOk0eMcnu3AVKxaJmOKAM2c2FEimDSFqLIPq1Y7A2QXuwLcArwtdNDQAcovgLg=
X-Received: by 2002:a19:d38b:: with SMTP id k133-v6mr12949787lfg.43.1536599855689;
 Mon, 10 Sep 2018 10:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <1536142147-21323-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1536142147-21323-1-git-send-email-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 10 Sep 2018 11:17:24 -0600
Message-ID: <CANLsYkw092cYLUKOw9hc6SDMgw+rSHj2NTdx73m1zybLO7Z0Sg@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc: Refactor loops in etb dump
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 at 04:09, Leo Yan <leo.yan@linaro.org> wrote:
>
> In ETB dump function tmc_etb_dump_hw() it has nested loops.  The second
> level loop is to iterate index in the range [0 .. drvdata->memwidth);
> but the index isn't really used in the code, thus the second level
> loop is useless.
>
> This patch is to remove the second level loop; the refactor also reduces
> indentation and we can use 'break' to replace 'goto' tag.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 9c599c9..8b34161 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -34,23 +34,20 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>  {
>         char *bufp;
>         u32 read_data, lost;
> -       int i;
>
>         /* Check if the buffer wrapped around. */
>         lost = readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL;
>         bufp = drvdata->buf;
>         drvdata->len = 0;
>         while (1) {
> -               for (i = 0; i < drvdata->memwidth; i++) {
> -                       read_data = readl_relaxed(drvdata->base + TMC_RRD);
> -                       if (read_data == 0xFFFFFFFF)
> -                               goto done;
> -                       memcpy(bufp, &read_data, 4);
> -                       bufp += 4;
> -                       drvdata->len += 4;
> -               }
> +               read_data = readl_relaxed(drvdata->base + TMC_RRD);
> +               if (read_data == 0xFFFFFFFF)
> +                       break;
> +               memcpy(bufp, &read_data, 4);
> +               bufp += 4;
> +               drvdata->len += 4;

I implemented these loops in accordance with the reference manual,
which is advising to read one ETB memory word at a time.  But taking a
step back getting rid of the inner loop yields exactly the same
result.  So I'll go ahead and apply your patch.

Thanks,
Mathieu

>         }
> -done:
> +
>         if (lost)
>                 coresight_insert_barrier_packet(drvdata->buf);
>         return;
> --
> 2.7.4
>
