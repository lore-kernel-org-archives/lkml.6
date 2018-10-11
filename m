Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF122C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2pmyUhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B6D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJKTyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJKTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:54:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id e4-v6so9488895wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NoTHzn9OrrkVLMHg4qKhiCcO7C8Qkc2Mo1FWCZwuSVU=;
        b=O2pmyUhBI5a+Tdco6RO+i1xCgQbsoiDewILJ2try+zsW3NzH2CAoqnfxYXiOmaH0hj
         cogAdnNcZJiysgbw17pDpM9G8nP7WIaJhziz+JmmyXM7VGTdYokDEddx5GBiMIZjpdwF
         r3ITqzMs5i3gTGkLXFAh35osxB7NS3KExMOzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NoTHzn9OrrkVLMHg4qKhiCcO7C8Qkc2Mo1FWCZwuSVU=;
        b=bkjCOE6v4Ci17dttVS3M5C3+BFrz9QH6XWJukiu5Y8iEvPX7sqh6kBS6nYcvpiO0Xi
         crj6p3AEqxsz+5aFB/If2nX2I87f3AElVppYdxj/ILDQGnthyEVP0aIcKQufeL707rzq
         iHnn/myQwgLFbHQ3V4zCdUqbQHyRHU2paKV1sgg0tG/6dEhMqrEg9v3lC51OveByxWoD
         VjmEminuXtCa0Kwrgfvy2pjM8KxYvZEIB+iylIqtCWChhhDDG8VpdAGbqBe8S1RWlSkd
         mQq+BURNkT7wkRRtkM25xW0TqMf8sRmJ8sXo9PfQpcWTG/HkWepohyMeLPGOajCq1aSa
         UneA==
X-Gm-Message-State: ABuFfoji3qxaAnZF+DjRGw8jI4OKezmQjsq71TiJezjj+IZmpblswAgC
        PRtGBWFCGj+YJ0kbpMHpUlk2rcP4MSo=
X-Google-Smtp-Source: ACcGV63mrNU41pCvSyJkd7IT9V4lOloYlwyJYuAttCffdfym4NUswvnbmR5Krjb6mGLq8i4ahH1pTg==
X-Received: by 2002:adf:8b5e:: with SMTP id v30-v6mr1282402wra.282.1539260820392;
        Thu, 11 Oct 2018 05:27:00 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id u191-v6sm21921659wmd.31.2018.10.11.05.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 05:26:59 -0700 (PDT)
Subject: Re: [PATCH] iommu: arm-smmu: handle client iommu translation fault
 handlers
To:     Will Deacon <will.deacon@arm.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
 <20181010170837.GC16512@arm.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
Date:   Thu, 11 Oct 2018 15:26:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010170837.GC16512@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 10/10/2018 08:08 PM, Will Deacon wrote:
> On Wed, Oct 10, 2018 at 05:44:07PM +0300, Stanimir Varbanov wrote:
>> Call iommu client translation fault handler(s).
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 066f4c8daf4e..02a8aab0cc59 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>  			    fsr, iova, fsynr, cfg->cbndx);
>>  
>>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>> +
>> +	report_iommu_fault(domain, smmu->dev, iova, 0);
> 
> Who's using this? Generally, the callback here isn't so useful because it's

The idea was to use it from video driver to dump few multimedia
interconnect registers which will give us some more info about the fault.

> called in irq context. We also don't enable stalling since 3714ce1d6655.
> 
> We previously had fairly detailed discussions on the list with Rob Clark
> about alternative ways to design this, but I don't remember where it ended
> up.

It will be useful if you point me to the discussion. Thanks!

-- 
regards,
Stan
