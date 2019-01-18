Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626D220823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Et070cH1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LNIV/M4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfARLxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:53:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfARLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:53:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78E846084F; Fri, 18 Jan 2019 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547812427;
        bh=5pVPmFdQ3w2BGxaeu0magkeFtuoC9f4C2CrM52TYAzI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Et070cH1hI1/9PRKE7GCYZCNczeDnwcISg6ZwqwFN+Z/qV/dRSJc/FiD6xk9oCOXb
         fMbVkhba6OeYDG06bzZPuzBF03RCwhYqXAEDSpfCtXgItjjJbeYjSfQkrCWLkTs0bl
         pPzCZqCBLNQVYZvfDzgpBtNxiacytE93YnCOGwmM=
Received: from [10.79.129.0] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A5146053B;
        Fri, 18 Jan 2019 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547812426;
        bh=5pVPmFdQ3w2BGxaeu0magkeFtuoC9f4C2CrM52TYAzI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LNIV/M4JkJiVdnvn42KYtyWY1fuNnOQckn0b4msCvaP70DskszhcNj5mAuLxVl3Is
         DnMgmIAZXIPaitUWdxWp6UAEIfhyZCUI2ZpjBelKTsAdTPioTKohDR+Yurzfr6nShR
         LH2vQyfWjMqe+44Z+xAiFuuyL7w+3T2n3MEetPJI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A5146053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
 <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
 <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
 <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <1ffe2b68-c87b-aa19-08af-b811063b3310@codeaurora.org>
Date:   Fri, 18 Jan 2019 17:23:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2019 4:50 PM, Pintu Agarwal wrote:
>>>> Could you please tell which QCOM SoC this board is based on?
>>>>
>>>
>>> Snapdragon 845 with kernel 4.9.x
>>> I want to know from which subsystem it is triggered:drivers/soc/qcom/
>>>
>>
>> Irqchip driver is "drivers/irqchip/irq-gic-v3.c". The kernel you are
>> using is msm-4.9 I suppose or some other kernel?
>>
> Yes, I am using customized version of msm-4.9 kernel based on Android.
> And yes the irqchip driver is: irq-gic-v3, which I can see from config.
> 
> But, what I wanted to know is, how to find out which driver module
> (hopefully under: /drivers/soc/qcom/) that register with this
> irq_chip, is getting triggered at the time of crash ?
> So, that I can implement irq_hold function for it, which is the cause of crash.
> 

Hmm, since this is a bootup crash, *initcall_debug* should help.
Add "initcall_debug ignore_loglevel" to kernel commandline and
check the last log before crash.

- Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
