Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B465C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJsMSP5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B3820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeHAKmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:42:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39410 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388831AbeHAKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:42:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so1068653wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xeWU1x8waxG1D8aup+BfI7/p0f2a/ukQ/2+lwyv3VRc=;
        b=NJsMSP5VUv9xDCTfNCSM9JyZxFwg94P9pKvjpqzsdT5P+vrs94dN8AnH5b9TPBf33D
         Q5RygTz3dPAgwYSPzC3iTJWtGkjAtVlUQktEkUFMViJcp/P+AIIrQUUzfn1nvRe2SDZo
         E9V3zx8pXwRVIac/9W6sq2ulEMub7kx8ob3Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xeWU1x8waxG1D8aup+BfI7/p0f2a/ukQ/2+lwyv3VRc=;
        b=Z2INlJDoDLnKZm8O9iMIow/4PlU/4MeIUk1uSrzmvEe3Ah+GvMrYM2U/sjqkwK5n8w
         WvloRiH0dGwsiS1njgRNMhxyZyw/NyzJu5l1YHmtPZ9M2YUoFbkHQxV7idWDegbcYpvL
         1ABtssio7Qyx/2AedJAXxpoleELj/GKq60HG8SFwEUnYs8z44QruiqpHn3WfARaukfXd
         hV68x/Q6n1v9/4B29GikgvUiKi2Sfk3yVfmLtvBl+/AaWYt5m+Fc3BhlkTpQNsRxCBjd
         srIzHUE7KZu0+APoMrrSe9aPcO+bNZfGlRGxnfyU9ArR6z0fmAVh0cWxIS61fl8agRxC
         ehlg==
X-Gm-Message-State: AOUpUlF5PFj5onGPiq+sJ3+Kacd2SCO+Nyoqw1BdPWlAJSgPsaXARyIb
        5N6KaE4683WntQspYSI3KAVW+g==
X-Google-Smtp-Source: AAOMgpeJhXF3Z5qDkFESQjK9xFN8CZSTHEWMvss48+8D+T11CPIgOW5rTONdgLv1vG8BfltkHR287Q==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189-v6mr2006321wmf.12.1533113848647;
        Wed, 01 Aug 2018 01:57:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm28567054wrn.83.2018.08.01.01.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:57:27 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
To:     Rob Herring <robh@kernel.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180731204536.GA7241@rob-hp-laptop>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
Date:   Wed, 1 Aug 2018 09:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180731204536.GA7241@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 31/07/18 21:45, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>> Multiple interrupts are muxed via these lines.
>> INTR1 consists of all possible interrupt sources like:
>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Makefile                |   2 +-
>>   drivers/mfd/wcd9335-core.c          |   9 ++
>>   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
> 
> I'm confused why these are defined here. The binding for the wc9335 is
> not an interrupt-controller.

I can move this defines to include/linux/mfd/wcd9335/wcd9335.h as there 
are no active users for this, but I  was hoping that these can be used 
in DT in future.

WCD9335 is an interrupt controller too. It muxes multiple interrupts via 
a gpio line interrupt.

I did mention this in the bindings.

+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+

> 
>>   include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>   5 files changed, 228 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mfd/wcd9335-irq.c
>>   create mode 100644 include/dt-bindings/mfd/wcd9335.h


Thanks,
srini
