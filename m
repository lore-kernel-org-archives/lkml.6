Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECABD20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpnrMcHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECABD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeGIJlN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:41:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54044 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754403AbeGIJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:41:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so20485004wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8FVNiSc0Nh8PKVhxrGrFcPkKrD4nQ4sKZf/ukhbfXO8=;
        b=XpnrMcHjbXvsK9Zx5zxeepd6ZLtdlqLNXZrAe/w1Bc9PYblnlzJBXJ3lEksrsEbJcF
         94SjpNWbXWyRtSLUyiTiArPPO2K9OOmD3AI/9NaJm9NF5rzI0GkgUeaJ0XWHFunXLcks
         qCim3gkzzGtMQ22OSghwuqGyuRxJQYvc9qF7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8FVNiSc0Nh8PKVhxrGrFcPkKrD4nQ4sKZf/ukhbfXO8=;
        b=LJKegSYrfwF8QwnrpKvAhEMOoWQ61M2lIel9U6TAZHLnzF2GRtR7UllP5nUectTINg
         wVgZwtLfK9VVC3fzFtFgP0reXaYKVznn2n3LUl4QVIyH21UXJA01qPHGfVZQ5+kNBP0l
         JvDzSxVf8I1wwBGWbYkX9R8w2q0Ki+CrIhrcbWQ+UyoRMn1fF08DS43D+tSDHVuQan9r
         hHRZ+eN0qrW37GUuoadhGnGomJkUs6fGpuwGDtg8Sz4fWsG7HhWREU55rAMx9DQqBm6E
         VpVdvrDVbl8CYH3s5bLDpgHZWwza5A/hjcMkgExKXFumQhmm8+uoZ9nf2spUu0BzzWzu
         xV+g==
X-Gm-Message-State: APt69E3gReJIIYFUuZQAEaXKjMHJDl7eyO7kpkPutbFhNTMQ1rl5G4W/
        DWYTO7qSIho0znQNCO92+289dcWwemc=
X-Google-Smtp-Source: AAOMgpfhbWb0ZmCe7vczyFaG4pwoOT8N2law+75HhvapmtYc3X3Pzjw0sC1MfLGSBrTl9wkCrrqC6Q==
X-Received: by 2002:a1c:1509:: with SMTP id 9-v6mr11062906wmv.142.1531129270212;
        Mon, 09 Jul 2018 02:41:10 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm29222719wru.66.2018.07.09.02.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 02:41:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmem: Add Spreadtrum SC27XX efuse support
To:     Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, freeman.liu@spreadtrum.com,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
 <d49c27421b2166dc5d535fb448e6cc11475a2a79.1529908086.git.baolin.wang@linaro.org>
 <CAMz4kuLWAT0aXy=xNPaeBDdixZCxUoE+joWsLMXb6MrmRiBr1Q@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <068e3671-2624-7e16-7387-185e688cb6ed@linaro.org>
Date:   Mon, 9 Jul 2018 10:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLWAT0aXy=xNPaeBDdixZCxUoE+joWsLMXb6MrmRiBr1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 10:26, Baolin Wang wrote:
> Hi Srinivas,
> 
> On 25 June 2018 at 14:31, Baolin Wang<baolin.wang@linaro.org>  wrote:
>> From: Freeman Liu<freeman.liu@spreadtrum.com>
>>
>> This patch add the efuse driver which is embeded in Spreadtrum SC27XX
>> series PMICs. The sc27xx efuse contains 32 blocks and each block's
>> data width is 16 bits.
>>
>> Signed-off-by: Freeman Liu<freeman.liu@spreadtrum.com>
>> Signed-off-by: Baolin Wang<baolin.wang@linaro.org>
>> ---
>> Changes since v1:
>>   - Fix one typo.
>> ---
> Do you have any comments for this patch set? Thanks.
Thanks for your patience!

These patches look good!, Normally I tend to send nvmem patches to Greg 
K.H just before rc5! I will queue them by end of this week!

Thanks
Srini
> 
