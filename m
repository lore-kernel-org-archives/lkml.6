Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373CBC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C4920831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXmLqSAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeKTTWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:22:33 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33451 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:22:33 -0500
Received: by mail-wr1-f42.google.com with SMTP id u9-v6so1056683wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YiKsH2SBRwXR72JBpKIZpb0ghcQkW9elVqNf5LWnQT0=;
        b=hXmLqSAWDMex4iTP3Mer0QRAX49i9/A7QUwDkE+1poZEcOrwciJzIPwE9uob6C9ikN
         /DVM9iett35HJAj4udLLpJY0Dwzs+Cp6t6tfXbHEYuC0VN868ypMyJU7m9Qww6dme+Fp
         ITkPKQvkclzPsK7qzAErvewuDpa2dESkAS4fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YiKsH2SBRwXR72JBpKIZpb0ghcQkW9elVqNf5LWnQT0=;
        b=jKkojvw+YSS7f2B3KYmPoraFm0iGKr3Vus9CxcFE6pgJYlywky7/Sj2ftl1kirLrqm
         lcxx1K6refkU6K4X3zypwWBkf8Nl7f4cADJnso6k6PeXuVuYsRcaikKOTPfxgyfuBsSX
         1yQhCW2WJUwQO/LZKKlR1iMbqwR2ZXkLv5H/6FysEsbv0SMpBu8xrG9quYcJLQg97q9v
         hVlBjcOW+q4lVCcW9u0AbbbSKj0MCO8sCfWDQE2NWPOddLXtAuksbZFm0gEbJ7y0z0TH
         x6YMVUTaW+hdEMGz9frBShXWSo6Ak5sR/m4Q6Ky5d0qBAhruMwF/Js7EAIDLfEUpdEkx
         tTVg==
X-Gm-Message-State: AA+aEWZczKojD7lGmot55Npuw8HHy4FHxCPmJrU3SCRq+BK0VYKSK0EX
        tHwyTV1cgDn7XR298FkLx4t8Bg==
X-Google-Smtp-Source: AFSGD/VJwIdKJdQCwN67JNgT+ozSKe1cS/CCWCFNYxTsBGjT3ilsSOwBHIEd1TZGHd6+2QezEdHVKw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr1181837wrx.149.1542704071194;
        Tue, 20 Nov 2018 00:54:31 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id z8sm23242622wrr.52.2018.11.20.00.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 00:54:30 -0800 (PST)
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
 <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
Date:   Tue, 20 Nov 2018 09:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 09:47, Anson Huang wrote:
> Hi, Daniel
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: 2018年11月20日 16:45
>> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
>> edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
>>
>> On 24/10/2018 08:39, Anson Huang wrote:
>>> The thermal driver is a standalone driver for monitoring SoC
>>> temperature by enabling thermal sensor, so it can be enabled even when
>>> CONFIG_CPU_FREQ is NOT set. So remove the dependency with
>> CPU_THERMAL.
>>>
>>> Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
>>> driver to make thermal driver probe successfully when CONFIG_CPU_FREQ
>>> is NOT set.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>
>> Why not simply kill this legacy code ?
> 
> Because killing legacy code will have old dtb compatible issue, old dtb
> will NOT have cpufreq cooling function.

Yeah, I imagine that is the reason why you want to keep the legacy code
but do you really care about old DTB based boards? Are they still
updated with newer *upstream vanilla* kernels?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

