Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FF20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="DUgOcCuy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvMtzLpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0FF20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeGLEsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:48:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38652 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeGLEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:48:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so53421616oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LuwwvvCLXDMhF4NZaYM7asiPcWdP7WW7fHNIGBVJ+oE=;
        b=DUgOcCuyAE9yRs4KlFlBh2bNF6lAgQS1nCLDULAkhC6dfSHJEAS1VxbMeSCF0uM//2
         xUNgLnnz1Qp1NBvB3SewGhor8sHhOe/c/tlBOfENvzwuv/zvLNo9Zx9DXe8VY+5cdamj
         O8CA7cMn74CSax7u5mtcpN8sKU0ZZ3l41ApNF9B+R81NgS13rSTu1vbuB7CFegFoTZ35
         7B6QzcbOOb3N5pafTUYeeV70ljiPgAX3nsL/gIrYcNEsGsZ0IXKmwtJMm5zjwldGpxfZ
         R3uU6APGR9qYEFBz1+jGh1wAM+hScpj5DpTDJD0s4yRiLeeKzCnnOuxcQkRMVwdue18D
         TOaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LuwwvvCLXDMhF4NZaYM7asiPcWdP7WW7fHNIGBVJ+oE=;
        b=dvMtzLpegSeBFi3gn2xX5+ceGFcbC1UYANquBUo0kksZowglTRGKWh+9vn4iglnALd
         TKGm2nSqB/OaG/0sf2E6cL9a4P8s0xe2izlg+0FPdIRLzShe5yf+EMBGwF2KjmSGGLzs
         BPWX1CkkWIr5VJq4UJ/PyenZjGYe+68JTY1g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LuwwvvCLXDMhF4NZaYM7asiPcWdP7WW7fHNIGBVJ+oE=;
        b=R1N71XuSN2je8EZwGzk8n5s4k7Wj0WnCcaWCrM058Ttq0gB4z1zLeyHOMund1iGRP0
         0NX0rNHrUd8w2Ury9c5kQUHKBcYjXV7y6vDDaKY2Ezo+ropDlQmTjB+MzBY8J5R4pOn6
         PzBignjXqryMVL6MuY8Kxl+KEG0dJ3g+Svo7fuc8Kxol7PHAiY6zImAopP4dGA3F8THU
         2f5ZtJ1IhHzAIYx7KE1BIW4wYZdO72+hPsy1xX0tnlcNS1bfq8iHpnEjUSm04iXDN8LR
         uYOa6xtBcyeNH5lB4mnEg3ifwR/0kE/aYpmxa1ugCf9m93J4G6CAIDTfq6dARi/yduNr
         usUA==
X-Gm-Message-State: AOUpUlFrNbm/BooWGft/8Foun4FjnrrWk42BoNSN+sWeqoX2kcaKiRDV
        hoH0HE5EH7v4gpzPucbT91wjZn658qhbzqppkTlCsA==
X-Google-Smtp-Source: AAOMgpd6V3Eyp7MNxmsFjm7xLmpZciDqDs3b/gIRnxN3Dpg6hZ4Ud1KJ+il8ulLtscNZ2ES3GL9RJO4+AmoHPIYEyJ4=
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr702376oih.6.1531370434891;
 Wed, 11 Jul 2018 21:40:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 21:40:34
 -0700 (PDT)
In-Reply-To: <CAD=FV=UGjf+qSfzYbQ1OEydEWJH2e8vhNiOPAytPH_rnkabq3Q@mail.gmail.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
 <CAD=FV=UGjf+qSfzYbQ1OEydEWJH2e8vhNiOPAytPH_rnkabq3Q@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Jul 2018 10:10:34 +0530
X-Google-Sender-Auth: eTlGEGEcylhInEaR2MnRR1ZEB0c
Message-ID: <CAHLCerNcoXuDi0MF5q8fzmegMZfGwAxSkv4czndVa0a-ov6ZVg@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] thermal: tsens: Add support to split up register
 address space into two
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:07 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
>> SoCs these were contiguous, leading to DTs mapping them as one register
>> address space of size 0x2000. In newer SoCs, these two banks are not
>> contiguous anymore.
>>
>> Fixing old DTs to split the address space into allows us to have cleaner
>> common code e.g. get_temp() that is shared across new and old platforms.
>
> This makes it sound like old DTs won't be supported anymore.  ...but
> the code says otherwise.  I'd just remove the above paragraph.

OK.

>
>> @@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
>>  int __init init_common(struct tsens_device *tmdev)
>>  {
>>         void __iomem *base;
>> +       struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>>
>> +       if (!op)
>> +               return -EINVAL;
>>         base = of_iomap(tmdev->dev->of_node, 0);
>>         if (!base)
>>                 return -EINVAL;
>>
>> +       if (op->num_resources > 1) {
>
> Maybe add a comment here that says that we don't actually map the SROT
> yet because you don't read anything from there?  I kept getting
> confused about how this patch could possibly work with no code to map
> SROT...

OK. The SROT comment got separated (patch 3) during patch refactoring.
Will add a comment.

>> +               tmdev->tm_offset = 0;
>> +       } else {
>> +               /* old DTs where SROT and TM were in a contiguous 2K block */
>> +               tmdev->tm_offset = 0x1000;
>
> This patch without patch #4 will break compatibility.  You should
> squash part of patch #4 into this one, specifically:
>
> -#define STATUS_OFFSET 0x10a0
> -#define LAST_TEMP_MASK 0xfff
> +#define STATUS_OFFSET 0xa0
> +#define LAST_TEMP_MASK 0xfff
>
> Without that you break bisect-ability and also confuse anyone trying
> to look at this patch.

Thanks. Will fix.
