Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EFA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMJg59lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EFA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGQUpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeGQUpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:45:39 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3232077B;
        Tue, 17 Jul 2018 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531858283;
        bh=zKangRooFhFponScmm40X4My+M9UfbwHkhuX8RqnllQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TMJg59lg+s6HSNodsPL2WlEcAguqmDZ9gnX3lGw+Jhd+5PA3f+0KW2YbVbY3VN0nt
         baUH4EV6JeY4JHey3aftsfsJFfaY6Oh36W2GsudQ18Bcukn7IVxlmf0W6TvJq9CmnR
         1UzsLs/BDBNPhoGCPtpPL0dScjMOqf6AjMwh3QJI=
Received: by mail-wr1-f45.google.com with SMTP id q10-v6so2430129wrd.4;
        Tue, 17 Jul 2018 13:11:23 -0700 (PDT)
X-Gm-Message-State: AOUpUlFWq2yRpaXJKFW85sHAGdmyxdzrQTlZB+0AwaUb3Aet3NaPWuFa
        X9k6vSfOvIJABx2xopNOGEDJ8gLigba+JiCdiAk=
X-Google-Smtp-Source: AAOMgpe9fuKe6R0+kib7hcHHQsRQSzI68EB8G+hI+Nix0fJqJZqZDyIgSiW2UG5URw17gLuURWnwCRYUmHwubL6nkvw=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr2480043wrr.227.1531858282151;
 Tue, 17 Jul 2018 13:11:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:11:21
 -0700 (PDT)
In-Reply-To: <CANAwSgTrsOv_cg470tze2vLLNAPEV1oApTEKep6gK8mPzWMiQg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-2-git-send-email-linux.amoon@gmail.com> <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
 <CANAwSgTrsOv_cg470tze2vLLNAPEV1oApTEKep6gK8mPzWMiQg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 22:11:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdMEp1r_K3Qa_iztfvKg61BEn4TejtoDwpq_Yf1CnyRAg@mail.gmail.com>
Message-ID: <CAJKOXPdMEp1r_K3Qa_iztfvKg61BEn4TejtoDwpq_Yf1CnyRAg@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: exynos: cleanup of clk err check for exynos_tmu_work
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 22:08, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On 17 July 2018 at 17:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> cleanup err check in exynos_tmu_work as clk internal
>>> framework will perform if clk is enable/disable
>>> so drop the double check of IS_ERR and other such references.
>>
>> I do not understand the statement. Clock framework will perform if clk
>> is enable/disable? How clock can be "enable" or "disable"? You mean
>> gate clock? you mean clock pointer is an ERR pointer?
>>
>
> if (!IS_ERR(data->clk_sec))
> check if the pointer is valid or not
> this check is again performed in
> clk_enable.

This should be then written in commit msg.

>>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>  drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
>>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>>> index 0164c9e..2dbde97 100644
>>> --- a/drivers/thermal/samsung/exynos_tmu.c
>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>> @@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>
>>>         mutex_lock(&data->lock);
>>>         clk_enable(data->clk);
>>> -       if (!IS_ERR(data->clk_sec))
>>> -               clk_enable(data->clk_sec);
>>> +       clk_enable(data->clk_sec);
>>>
>>>         status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>>>         if (!status) {
>>> @@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>  err:
>>>         clk_disable(data->clk);
>>>         mutex_unlock(&data->lock);
>>> -       if (!IS_ERR(data->clk_sec))
>>> -               clk_disable(data->clk_sec);
>>> +       clk_disable(data->clk_sec);
>>>  out:
>>>         return ret;
>>>  }
>>> @@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
>>>         struct exynos_tmu_data *data = container_of(work,
>>>                         struct exynos_tmu_data, irq_work);
>>>
>>> -       if (!IS_ERR(data->clk_sec))
>>> -               clk_enable(data->clk_sec);
>>> -       if (!IS_ERR(data->clk_sec))
>>> -               clk_disable(data->clk_sec);
>>> -
>>>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>>>
>>>         mutex_lock(&data->lock);
>>>         clk_enable(data->clk);
>>> +       clk_enable(data->clk_sec);
>>
>> You are changing here the logic completely. Before the "enable" was
>> followed immediately by "disable". Now you are moving disable
>> somewhere else... All this looks suspicious...
>
> I chose to move enable/disable of clk_sec this under the mutex lock for safe
> which dose the same sequence with different order.
>
> Second approach:
> We should get rid of clk_enable/disable in exynos_tmu_work
> as this looks unnecessary for toggle clk's on every update.

I already sent a cleanup for this:
https://patchwork.kernel.org/patch/10529971/

Best regards,
Krzysztof
