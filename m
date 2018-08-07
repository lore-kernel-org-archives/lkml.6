Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D08721899
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08721899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbeHGOp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:45:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53742 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeHGOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:45:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A7380D;
        Tue,  7 Aug 2018 05:31:51 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83BB53F5D0;
        Tue,  7 Aug 2018 05:31:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM
 framework
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
 <20180807085406.3863-2-marc.zyngier@arm.com> <2940317.dDZy1L4CDY@phil>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <94b6aab1-e8d3-6929-a2e6-2f06c564bc70@arm.com>
Date:   Tue, 7 Aug 2018 13:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2940317.dDZy1L4CDY@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 13:09, Heiko Stuebner wrote:
> Hi Marc,
> 
> Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
>> pm_runtime_get_if_in_use can fail: either PM has been disabled
>> altogether (-EINVAL), or the device hasn't been enabled yet (0).
>> Sadly, the Rockchip IOMMU driver tends to conflate the two things
>> by considering a non-zero return value as successful.
>>
>> This has the consequence of hiding other bugs, so let's handle this
>> case throughout the driver, with a WARN_ON_ONCE so that we can try
>> and work out what happened.
>>
>> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'm still not sure about the !CONFIG_PM case, as it was probably silently
> working in that case before

Do we agree that this is an orthogonal problem though?

> 
> But on the other hand we're also already running over it in other places
> like in the iommu-shutdown and I guess if someone _really_ disabled
> CONFIG_PM, a lot of additional stuff would fail anyway.
> 
> So should we wrap that in some #ifdef magic, just ignore it or simply
> select PM similar to what Tegra, Renesas and Vexpress seem to do?
> 
> I guess I like the 3rd option best ;-)

It probably doesn't hurt. At what level do you want it? As a dependency
to the IOMMU? or to the platform?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
