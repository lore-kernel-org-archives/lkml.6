Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4014BC04EBF
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB60420817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWVNlAl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeKRMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 07:11:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46158 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKRMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 07:11:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so15600047wrt.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zPgiB4ZOvTiWdqOrVGyEfRXhrFcPDUGAYcWl3VDpWY=;
        b=kWVNlAl97GmGesj7oeLCs/1M/TeClSjR8uUDvwyu1vYVClHdTsrjUkG3I8jRtb+j7C
         RpT+H3glT+K3BbRxaXIcmvaoTQhNZRYvb0wTDmIW74MbtA5b3CKouMi2F2WahIvxdrf/
         aX4WEPSky8BipZjOPopUxXdLBfhPoC4dj79Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zPgiB4ZOvTiWdqOrVGyEfRXhrFcPDUGAYcWl3VDpWY=;
        b=LipcNVIk/94V6OMkzrDo4Zqq1A1QTeZqWwRnOi48mvulxiAweLPRadoFMO+Udy6qPP
         hHDK1SNE4VrJU6UZbxaqmmLB6h53DUMObHMHxWjHDT2Ke65uZ1a8RrNtoLEvu8vu/x+c
         mS2tJVv/pgTWUnFruISGqrAAUCmy1N2BpEv7f95cSjo+mOue5uARU1bkNHMY29n1zqRd
         zSkiQ566nKIv1qLWHG2p3wNl1bPNs78AFZuHFmmUA7a5Guc3ZOx6QZM+sVfeluonYTP3
         hilJFegm830IVDuPg5Pk3iFl18JMa7OX1XXQ5X+CQpbjAkFpbHRxjjB9BDmlm5oeU1J1
         tJOw==
X-Gm-Message-State: AGRZ1gJeuKsI6CIrU7Z5AIcxIue7Dcs/2Y9tSJLe296Ju28rEQLEo1n2
        v+3cAIWA3NaRTN8lxWr7M0mcgw==
X-Google-Smtp-Source: AJdET5c0fmutaq7nF1F1OIhysv1hLBBapjpRODp9pCoqB8C+f6vN/1lZtx52wLHNxTtDVQj5a8y1lQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr13231909wrr.74.1542505958266;
        Sat, 17 Nov 2018 17:52:38 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l3sm12434697wru.36.2018.11.17.17.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:52:37 -0800 (PST)
Subject: Re: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
 <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
 <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
 <DB3PR0402MB39161E47E47937FDB8046B6EF5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <d811ef14-ec53-3422-b747-7df0c1ce360d@linaro.org>
 <DB3PR0402MB3916F404D1225F1A00808197F5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <27bef861-5e1e-78af-4eaa-daa6530b7277@linaro.org>
Date:   Sun, 18 Nov 2018 02:52:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916F404D1225F1A00808197F5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anson,

On 06/11/2018 10:12, Anson Huang wrote:

[ ... ]

>>>> Please convert to timer-of API.
>>>
>>> This patch mainly to fix the potential resource leak issue, for
>>> converting to timer-of API, should I add another patch for it? Since
>>> it is a different subject.
>>
>> Actually I was unclear. The patch is duplicating the kfree in the error path,
>> usually a rollback routine should be provided.
>>
>> So instead of creating this rollback path, you can directly use the timer-of
>> which contains the error check and rollback.
> 
> I understand the timer-of can save some code in timer driver, but current GPT
> driver is kind of complicated in order to support so many i.MX platforms with
> different GPT design, change it to timer-of will need some effort and I think we
> can do it later. If the duplicating kfree in error path confuses you, I can change
> it to rollback path you said. Below are 2 options in my mind:
> 
> 1. add kfree to rollback path;
> 2. skip this patch, just apply 1/2 patch, and let me find some time to change GPT
> driver using timer-of. 
> 
> Which one do you prefer? Thanks.

I'm fine with option 2.

Thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

