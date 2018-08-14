Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4508DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3B2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="odrVGq2i";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZyIGwR9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3B2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeHNPP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:15:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:15:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 22987600C1; Tue, 14 Aug 2018 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249710;
        bh=xbZuk57fciyHmldLGqo3ARt/0FbMq3SfC7Dbl34+obM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=odrVGq2irlp/+uHpPqsZCiAiXNktUlrSGWn59ywHoYx3xftlUQlqbhyzWDmEjRTon
         8VQ5MKo6EPNZwiNbqbXrYFLgMWUw4UI7IJ7fgPT2GDuRp6nwPxSoHeNB2oVfDxllOv
         XftZTZfFGuSPYDyT521Wy77EA2Z5NBB6ajxpcFp8=
Received: from [10.79.40.124] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E26AE600C1;
        Tue, 14 Aug 2018 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249709;
        bh=xbZuk57fciyHmldLGqo3ARt/0FbMq3SfC7Dbl34+obM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZyIGwR9/ufF2ylIuTm5FOSXYWE2+ga0bxXhTtKbIslo9fO74ltbVRL+CmIbAd6Ax2
         VtX1mQtMx//y5oM1x0M0X6OuOwGA1uwypjPGx/OacEIY+/yUHDTqJwl2GxGqkOOPel
         kk0E/akkvta6vQ5rU3ikcLlBNqD40qdUs0g3F3cs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E26AE600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500
 errata handling
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
        mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814105528.20592-5-vivek.gautam@codeaurora.org>
 <20180814114015.GG28664@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <459f9be6-fc8b-3a4b-269d-d3ff297fbdfc@codeaurora.org>
Date:   Tue, 14 Aug 2018 17:58:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814114015.GG28664@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2018 5:10 PM, Will Deacon wrote:
> On Tue, Aug 14, 2018 at 04:25:27PM +0530, Vivek Gautam wrote:
>> Cleanup to re-use some of the stuff
> Maybe we should factor a few of the other bits whilst we're here.

Sure, do you want me to refactor anything besides this change?

>
> Or just write a proper commit message ;)

My bad. I should have written a more descriptive commit message. :|
Will change this.

Best regards
Vivek

>
> Will

