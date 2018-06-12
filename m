Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06BA8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F8208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="p0e5uDa+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3MvycQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933069AbeFLKjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:39:54 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39969 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeFLKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:39:50 -0400
Received: by mail-ot0-f195.google.com with SMTP id w9-v6so21954746otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=buX668ubvpmJekevypntnaFeICyiuMIeR7zZStVYbbc=;
        b=p0e5uDa+Gdmb3KcUMyaF+PG6TYc9z/g1GjLJ8FtgPA5FYzY8znltxW0Ekpa6sPAMr4
         48xKNBEmGHeFmqu4+Vhgui/sDbYlfvdPQx8anKPCNRnVwLpseYvoOe7qSdCcbOrxC4C5
         U2KtCLI4rKtQ61b4HhPY2sxTJIlHc5BH4rwK30NiT5+u9i7y+0pcvgQxX+r/Ud+F2p6Y
         pHSJYpxFO/VvJKuW4fiVTLRelfZWbMTw3VDUaIga06pNJrPLDM0QzUfUcJB9rWKF6aCP
         /jT3P+kHCgLDfJ/eM+osNcduQJSaXSawcdGByhJ7vYDZY7tuFhCiM1fM7WVwlqD+slrx
         YzSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=buX668ubvpmJekevypntnaFeICyiuMIeR7zZStVYbbc=;
        b=e3MvycQr0A6+h4bp8e2bvSIaCXDd0YZe6gCftKWZ2h/1JCAfRnXun7C3JUfprHh8yN
         edZPuKmaFrhp/MJCTagTtBFMfKcdeDqHUuLMkrLyppkMwuTFJnm9zSkuVje7t1MlPw+r
         68cAkQueWH9vyFckrY6Q9a3saA0j9o53dD7is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=buX668ubvpmJekevypntnaFeICyiuMIeR7zZStVYbbc=;
        b=WwKlCPhJd8Ba3/yaHaov5qBA2vj1Wf9HzyNk9xfxml/D2zJnHaGjkBsdewGZaOWN/M
         UVfBJ9n12tspHwLOvaTOlUh1bDxSNPWxuiaObBKuAcyd62vf3vTidAjFBIxEpl/jWOBN
         cuf5tFUSgkIEJNjBEPnkdJRpjdxpGx7O8JORkcY9Hc0/YISZCI8qyMjqMC0v8Ibc0lQl
         f44KMmN8F7UMSLtS/BsO0xaIBAxj+QZWVnGBdxl4CfHmMaec04JZ3XSp7/3jlQkB/6R0
         zaDlvL0DA+wn3kTpUg421hwwo9+nQQfYeY4wr9YJbUZxsYrrmuB/t3b7Rjjq7gTK+P0a
         7ycw==
X-Gm-Message-State: APt69E36LKPJABMUf4G5eBRLChKffcsKucod5m4N1nEJOU18DX0RuSGY
        H9PZvy09b9e9IYuOIgw6lE7zDB7tLppFnH8aNwqzsVDX
X-Google-Smtp-Source: ADUXVKK4h3uYHsNyKOkQH3XLC34EbziRoyvagqPlHfM7iTmK5zKlJ/wZgMatcdCMEDrM+uYMgHsqvo24oKJcG4u0asg=
X-Received: by 2002:a9d:241:: with SMTP id 59-v6mr2075194otb.71.1528799989960;
 Tue, 12 Jun 2018 03:39:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 03:39:49
 -0700 (PDT)
In-Reply-To: <20180604150319.GC510@tuxbook-pro>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <7a0f33cff94f41110bdbff14d28d36074fae2a7d.1527937396.git.amit.kucheria@linaro.org>
 <20180604150319.GC510@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 12 Jun 2018 13:39:49 +0300
X-Google-Sender-Auth: Dk34AUMngaaDQ20aSKgWRhtTRVQ
Message-ID: <CAHLCerPOp7_60JF-jJ+wZR9jq-z_wypheE=g_GV7Nn=M2OCP5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: tsens: Add support for SDM845 platform
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 6:03 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sat 02 Jun 04:11 PDT 2018, Amit Kucheria wrote:
>> diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
> [..]
>> +#define TRDY_OFFSET     0xe4
>> +#define TRDY_READY_BIT  BIT(1)
>
> This is bit 0.

Oops, fixed.

>> +
>> +#define STATUS_OFFSET        0xa0
>> +#define LAST_TEMP_MASK       0xfff
>> +#define STATUS_VALID_BIT     BIT(21)
>> +#define CODE_SIGN_BIT                BIT(11)
>> +
>> +static int get_temp_sdm845(struct tsens_device *tmdev, int id, int *temp)
>> +{
>> +     struct tsens_sensor *s = &tmdev->sensor[id];
>> +     u32 code;
>> +     unsigned int sensor_addr;
>> +     int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>> +
>> +     ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
>> +     if (ret)
>> +             return ret;
>> +     if (code & TRDY_READY_BIT)
>> +             return -ENODATA;
>
> This section is the only difference from 8996, but this register is
> identical to 8996 and 8998. So I think you should add this to
> tsens-8996.c and we can use that for 8996, 8998 and sdm845.
>
> Perhaps we should name it tsens-v2, as that seems to be the common
> denominator for these, according to the documentation.

Thanks for confirming that the block is identical^Wsimilar across
8996, 8998, sdm845 (and possible others). I suspected as much but
didn't check in a lot of detail.

I expected the 845 to gain more features over time, hence the reason
for a separate file and a custom get_temp(). Now, I'll fold all of
them into a common tsens-v2 function.

We'll also need to change how we regmap the 8998 and sdm845 tsens
registers because the offsets are not the same and hence not handled
corrently by tsens-common.c/init_common().
