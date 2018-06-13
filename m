Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E3A5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4C920891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gM8YtPUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4C920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbeFMIVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:21:07 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33572 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeFMIVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:21:05 -0400
Received: by mail-wr0-f174.google.com with SMTP id k16-v6so1747049wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGCrvefxUofsiBLchmj4CccRLc8nRcMnTrOtK77nqJo=;
        b=gM8YtPUA+BGn26D8WUOytJ7I8tkXxw2GWzm52wmO0mG4cKhCj5LEVpvvN0acVKe9fo
         Ds0vrDXL+yhfxQQGnw5jbU2cg5YU1V+3kO3BhMBPSz5y40v6XY+7l0E5I2OHVd8BFJIk
         TRflELlzSE33Zk8kZ7IdQ35Kx8zx9wnDQbI0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGCrvefxUofsiBLchmj4CccRLc8nRcMnTrOtK77nqJo=;
        b=fI3ewNEyLIikEdeGu1HXK2Ik5W6B9rMoHF9IidEVha5B3mayYcWwHE9/U8GTu7i1Fv
         FFRTujabio6VxZn+FZeYIPwtRXl3uaBP6Aci0NuUtWN6ks7bEOeXu64WgNEy+a/hoZi6
         /dMD2R9fCXVdfGjZtUQLn9rtdpsFqEx7K5i/8GiwN/3BB6+QR+8le1iSqFeKVUydHRgg
         WvkFVUS9+3YlfR6/GlO/D7GLhCKI7Y2rQTutGeAgy0C5/sUkDSd9QNEAcxK5L1phcMMw
         mJZk+Kis1gz88doz601juYnbaGv5Uvlgc9aXpuBWSZdyT24mhjlgeMoZUZ93+yIZcCio
         JnvA==
X-Gm-Message-State: APt69E0g7bDgyWPOVIoeb9IAYu+EVPD81l5in5QN1jzQkAIe0v5dw5gO
        fWbYMgxUTl/Jhlph7CS8G+xsfQ==
X-Google-Smtp-Source: ADUXVKLvaBsA5v0+L1YSivgi/E93v5UMgjtM38Z7PBW4bRneQ6cBgYRa+L0J+txb1t+9rT/zqSnIVw==
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr3059393wra.221.1528878063718;
        Wed, 13 Jun 2018 01:21:03 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b16-v6sm2984463wrm.15.2018.06.13.01.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 01:21:03 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured
 register.
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org, sboyd@kernel.org
References: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
 <86d0ww7ymc.wl-marc.zyngier@arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c4fafe97-fbf4-1037-394c-94c65fff3e21@linaro.org>
Date:   Wed, 13 Jun 2018 09:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <86d0ww7ymc.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/18 17:34, Marc Zyngier wrote:
> I suggest you find out how the GIC has been integrated on this
> platform. If you take a fault on accessing this register, this very
> much looks like an integration bug, and it should be quirked as such.
Thanks for the suggestion, This is a bug in the firmware which is 
restricting access to this register. We have been working around this 
bug for more than 2 years due to this. Now this platform support is in 
mainline and We/I have no hope that this will be fixed in near future 
atleast for this platform.

I will try to come up with a Quirk specific for this SoC.

thanks,
srini
