Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E71C214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+983fkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E71C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeHUQXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:23:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35008 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeHUQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:23:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so15805261wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UXGU65NAO8uB/E8fTetTCfgGMBgtnqRgd5NnQ6zvYwk=;
        b=D+983fkLOsfzDQ+6tN/MCfKvFt1t58DBC86fJdwGyXOgwfN2EiLxzyQGLA+ZBU9Icf
         +tBIl1RFKNJmPgUAAlN0Uozpt5cJwWV0dit7uuUixJ00RvDE8gg5vMg9VPQ3JBMwWpoP
         HR6kcTcilpl6oomweu9e+a6jsuxBq6fvlFzS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXGU65NAO8uB/E8fTetTCfgGMBgtnqRgd5NnQ6zvYwk=;
        b=bOl35+ogS6xcfQVaVSJP4VzVXMR3oT6MyT+UIikQ4FBDRSicUISwRQWA0juKXq8pwP
         OYc4YDoeP8Gs4mqsqRAHM8PJfYPDEBT93hgVMiDM9tcLKv4rc8pRGUl717ezeojjAfyM
         ylscBfJ+8FazmBZ0hpimsgYfR0zIpue3v9yc6WfVn9VLol0CxkKGtxeBGJfOkPdsAtDt
         NRyTXlPuUpYdxEqnH2GMgt46tqagtkdb+xkXW4njLp8xhe1KjsalmmnjOqLXMpvLAtu5
         pq29E/ctfvgj0k5aASGEaaFLRZrgmlCAUvSHz9kuQX0xV3esPPCUdLAXwpfEz9Glrx7d
         bHaw==
X-Gm-Message-State: APzg51BhrXrBDWdLIz2wWKZXdsV9dKUQNmz1ZkpL9kxfFBZ/uRRvoNmQ
        F7Y0oHmoxSebAzcdExxQ6VcruQ==
X-Google-Smtp-Source: ANB0VdZQ5tXPABANlf+ehcg5+IP2jMdFBHeykGQgeJYHKuCfip+2lj6LJGklankg07dy1Vendbo+SQ==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr8343674wrp.85.1534856626667;
        Tue, 21 Aug 2018 06:03:46 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id u127-v6sm3085788wmf.48.2018.08.21.06.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:03:45 -0700 (PDT)
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <afc4be51-56b1-6455-71e1-d2fddd622426@linaro.org>
Date:   Tue, 21 Aug 2018 14:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/18 08:02, Vivek Gautam wrote:
> Sricharan R (3):
>    iommu/arm-smmu: Add pm_runtime/sleep ops
>    iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
>    iommu/arm-smmu: Add the device_link between masters and smmu
> 
> Vivek Gautam (1):
>    iommu/arm-smmu: Add support for qcom,smmu-v2 variant
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
>   drivers/iommu/arm-smmu.c                           | 194 +++++++++++++++++++--
>   2 files changed, 225 insertions(+), 11 deletions(-)
MSM8896 audio and display on top of mainline totally depends on this 
patches, I have been testing various version this series on DB820c for 
both display and audio.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
