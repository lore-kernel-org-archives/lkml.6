Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E984C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78F120883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Si2K8LpL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDXccAmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78F120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeGZLeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:34:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42143 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbeGZLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:34:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so1985084oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4E1p3TM9bdttR79YBBfgcm5sWZnATxNp3jMrdJpqdzI=;
        b=Si2K8LpLHyMQ5mFlyae70zqsWwdsVNOhn0Mh58MkWrLz5jXe2Y7RkcH+Ymbvq0zI6x
         Yfc1akmS2ei9VPe8/Djgc1P8YWv+F2AHqhkhJx1PhoI1KyQCBXyVxU69H24feM0vmKez
         uFGaK4nju5ADdvZ5q9LfPuc/QeZpNQdMK5ZM7y9awr+W3kMBhqfQpE1nAh7cMxO7KrEt
         5b7TChUTmpWmmtEWrM44lLF/+8gkVy45dvYU2RsT+2SC5cU3AkTD15f2cVfd8v9G5G/Z
         nD2bh0F1y4EiJ+c0/Z+p/O7yWqzmIuarDIJXdVLMVmCCCserF0moZQQG47VujpHptJ4y
         XjtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4E1p3TM9bdttR79YBBfgcm5sWZnATxNp3jMrdJpqdzI=;
        b=GDXccAmEhLiITXl1b/VMuv3T2sxqYdxIDqcTMuLWjRaR9ud8aEAlMeVmbNL1Y74HyI
         tl32rzU/xhRAS9vhJLeElOX/H+XZaW3m3N2xvaCcBtCjkC9klUMgKhpPKU9gWJSg54MJ
         Rl+7wd1gE8ZHN5N/Ch6kVokcM0aTUcuOGw5Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4E1p3TM9bdttR79YBBfgcm5sWZnATxNp3jMrdJpqdzI=;
        b=ef6esj+RSFLihxEGQZtjv2z53wmELoFlb27XudqbLi5QqwLSNyCB+tpQLSvL5/8yQ9
         z4z5STWBM0mT+hzeesRCId1vtFvBeOkyirNQXFP5wf8Fi7TL32RrR1BxkN673D0A7h0X
         re8D/C7l1QwAM0BvrFhNfwi0nLLDzzYG656g7cJGhB/5GNklmq0On5ii98/eBLItkPMJ
         zQqkXFUh+xsWKzijwBCd6stPV0a3c3CQ8+3lxSzhCUtm7H+xiKqzpC3Rhjqb8QPSPrUq
         oheBqlocsEVQ9+OQDx11Bt5++0a5HNnVGQ7HypqwxAvzXs16s8QuSQg+7bgNa4YKz5fY
         nL8w==
X-Gm-Message-State: AOUpUlGaDlpV7nNa6GA0BFP7bJuQvNR1zuqTdG7NfPX70FLTTZKLHHG+
        pf7UFfPfizap5yA0kJUKXvJznS4vLKPLC+L2FAzZJA==
X-Google-Smtp-Source: AAOMgpcPRJjh5KCEKfoiIQdA6IYFWEWJS5JFu6xqelplJpLDGCatuMhBLZRiBQ2P4nP33viKZLqhkpM5tBIVfym1a+w=
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr1158083oig.287.1532600274853;
 Thu, 26 Jul 2018 03:17:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 03:17:54
 -0700 (PDT)
In-Reply-To: <20180725234936.GT129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
 <20180725234936.GT129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 26 Jul 2018 15:47:54 +0530
X-Google-Sender-Auth: kiBhv976Ycssnq42WZluUOLWtCI
Message-ID: <CAHLCerO2CyqzLi2MM_58nRGyigSZk4k56EwxqU=zg9Xak5rbzw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] thermal: tsens: Fix negative temperature reporting
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 5:19 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Wed, Jul 18, 2018 at 12:55:03PM +0530, Amit Kucheria wrote:
>> The current code will always return 0xffffffff in case of negative
>> temperatures due to a bug in how the binary sign extension is being done.
>>
>> Use sign_extend32() instead.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 908e3dc..46abc21 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -5,19 +5,20 @@
>>   */
>>
>>  #include <linux/regmap.h>
>> +#include <linux/bitops.h>
>>  #include "tsens.h"
>>
>>  #define STATUS_OFFSET                0xa0
>>  #define LAST_TEMP_MASK               0xfff
>>  #define STATUS_VALID_BIT     BIT(21)
>> -#define CODE_SIGN_BIT                BIT(11)
>>
>>  static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>>  {
>>       struct tsens_sensor *s = &tmdev->sensor[id];
>>       u32 code;
>>       unsigned int status_reg;
>> -     int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>> +     u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
>> +     int ret;
>>
>>       status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
>>       ret = regmap_read(tmdev->map, status_reg, &code);
>> @@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>>       else if (last_temp2 == last_temp3)
>>               last_temp = last_temp3;
>>  done:
>> -     /* Code sign bit is the sign extension for a negative value */
>> -     if (last_temp & CODE_SIGN_BIT)
>> -             last_temp |= ~CODE_SIGN_BIT;
>> -
>> -     /* Temperatures are in deciCelicius */
>> -     *temp = last_temp * 100;
>> +     /* Convert temperatures to milliCelicius */
>
> nits:
>
> s/temperatures/temperature/
> s/milliCelicius/milliCelsius/

Embarrassing to have two typos in a single sentence. :-)

>> +     *temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
>>
>>       return 0;
>>  }
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for the review.
