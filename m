Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E0DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3F72098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYZ3Buoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3F72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJEPOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:14:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJEPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:14:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id a2-v6so5513793wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MydrcLmYI+e6vf9bA2L3VH26SsTIuH68lBVVz3LfEFo=;
        b=gYZ3BuoiGq0ziAaWFzSdxrSapn5CK8pMq6i1sp+Hz/ltpvfKGYk/mCIr+0SMlkHEfn
         ISHWbK6nuyTWXLndvRCoQxJcn//ngzVKewnLJyqo2lHTC5xevrKX0XrwhTzM05oQO3N6
         rhn8B3/aDtDAmb2+TfLWyBY355hR9JmnHloSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MydrcLmYI+e6vf9bA2L3VH26SsTIuH68lBVVz3LfEFo=;
        b=Ctxbak25aoO1q89IsiYLsZAma5DYWGg0/5CpyIP7rlAdmELprYdkB+9QEPwHLlEFZU
         n2ytGuMFG/vPG5GUNLk0l+Cxopvm7vYvVR8KeIan3QB20vi1KvIVSUBEWPnJcepTmJ+l
         TDF/bjYzj+y2xPF5LbvfGddhuE/CPZIlaDKDtv2vaAv27Yj+V4C9L9v50cxv2S+7OAS5
         8uP5RfXIu6ulLLtOnZuygY1CUrmWOKcntyuKRn5LdKagmcmtuE/TIFVKULPfaiUbuDMx
         qPoz+Iz1wIfQyQtwmrMAvvtEqSiJYp7nPe+qa2QUyKTG05Oc2OeOl+16o6aLSwnzG6No
         5QOQ==
X-Gm-Message-State: ABuFfoj/FmCRJwmZsYrxE0jLT2kUI7NzR1vSzL+dCiyQE6LGnNpODk4y
        9xkXGb8xgDX9tgmMEs5Y6/b2xQ==
X-Google-Smtp-Source: ACcGV62K1ZTK1pFMLLkHRBgGD7l4XsCCAPniFWY4qGn5uRZxbLmEulGeQg1Qz2eiVt+7p7X17UwEIw==
X-Received: by 2002:a5d:4791:: with SMTP id w17-v6mr7923089wrq.319.1538727388488;
        Fri, 05 Oct 2018 01:16:28 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm6416913wrs.69.2018.10.05.01.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:16:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()
To:     Vinod <vkoul@kernel.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-2-srinivas.kandagatla@linaro.org>
 <20181005003112.GG2372@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6ac9b82e-9f92-d06a-724e-b460d24433ae@linaro.org>
Date:   Fri, 5 Oct 2018 09:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181005003112.GG2372@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review!

On 05/10/18 01:31, Vinod wrote:
> On 26-09-18, 11:23, Srinivas Kandagatla wrote:
>> This patch adds support to set runtime dma buffer on compressed stream.
> The change is fine as is, but I feel we need to document the motivation
> in the changelog. The core changes need a bit more explanation on why we
> should add this..

Sure, I will add more information into the change log in next version.

--srini

> 
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   include/sound/compress_driver.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
>> index ea8c93bbb0e0..0cdc3999ecfa 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -23,6 +23,7 @@ struct snd_compr_ops;
>>    * struct snd_compr_runtime: runtime stream description
>>    * @state: stream state
>>    * @ops: pointer to DSP callbacks
