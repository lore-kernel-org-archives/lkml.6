Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F45C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCC3216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC3216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeI1UVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:21:25 -0400
Received: from foss.arm.com ([217.140.101.70]:50820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeI1UVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:21:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701A5ED1;
        Fri, 28 Sep 2018 06:57:30 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D868C3F5B7;
        Fri, 28 Sep 2018 06:57:24 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:57:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, robdclark@gmail.com,
        linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v16 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Message-ID: <20180928135718.GA1599@brain-police>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Thu, Aug 30, 2018 at 08:15:36PM +0530, Vivek Gautam wrote:
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using
> device links between smmu and client devices. The device link
> framework keeps the two devices in correct order for power-cycling
> across runtime PM or across system-wide PM.
> 
> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [7],
> the device links created between arm-smmu and its clients will be
> automatically purged when arm-smmu driver unbinds from its device.
> 
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.
> Otherwise, the clocks are turned to be always on in .probe until .remove.
> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
> 
> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
> 
> Previous version of this patch series is @ [1].
> 
> Build tested the series based on 4.19-rc1.

I'm going to send my pull request to Joerg early next week (probably
Monday), but I'm not keen to include this whilst it has outstanding comments
from Ulf. Your errata workaround patch is in a similar situation, with
outstanding comments from Robin.

Will
