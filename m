Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DCFC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B322172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="afkptQZW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="afkptQZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B322172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeHNPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:11:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeHNPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:11:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0F6860D98; Tue, 14 Aug 2018 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249498;
        bh=+Hj724E7ljRFHT53uSntaYQKlAYMv2pEpRc/2dWrVng=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=afkptQZWJ7ysh1Zg8O2ulOKWZy8r7DW6obkk9JmxcIdPsYYFkhJsdISWCa3bEWDlJ
         CsPvrMVJ4KWdCe0k9iyJiULvWJhG35bWpts++wGXFIr0ZphlGQWTZSKVubndOGudza
         bZH0E1MJdgENa0DDrSCk+sn4/YU4vnaysvybeSVY=
Received: from [10.79.40.124] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D407D60D88;
        Tue, 14 Aug 2018 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249498;
        bh=+Hj724E7ljRFHT53uSntaYQKlAYMv2pEpRc/2dWrVng=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=afkptQZWJ7ysh1Zg8O2ulOKWZy8r7DW6obkk9JmxcIdPsYYFkhJsdISWCa3bEWDlJ
         CsPvrMVJ4KWdCe0k9iyJiULvWJhG35bWpts++wGXFIr0ZphlGQWTZSKVubndOGudza
         bZH0E1MJdgENa0DDrSCk+sn4/YU4vnaysvybeSVY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D407D60D88
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
        mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
Date:   Tue, 14 Aug 2018 17:54:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814114009.GF28664@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


On 8/14/2018 5:10 PM, Will Deacon wrote:
> Hi Vivek,
>
> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
>> errata [1] because of which the TCU cache look ups are stalled during
>> invalidation cycle. This is mitigated by serializing all the invalidation
>> requests coming to the smmu.
> How does this implementation differ from the one supported by qcom_iommu.c?
> I notice you're adding firmware hooks here, which we avoided by having the
> extra driver. Please help me understand which devices exist, how they
> differ, and which drivers are intended to support them!

IIRC, the qcom_iommu driver was intended to support the static context 
bank - SID
mapping, and is very specific to the smmu-v2 version present on msm8916 soc.
However, this is the qcom's mmu-500 implementation specific errata. 
qcom_iommu
will not be able to support mmu-500 configurations.
Rob Clark can add more.
Let you know what you suggest.

>
> Also -- you didn't CC all the maintainers for the firmware bits, so adding
> Andy here for that, and Rob for the previous question.

I added Andy to the series, would you want me to add Rob H also?

Best regards
Vivek

>
> Thanks,
>
> Will

