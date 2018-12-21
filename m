Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD5218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeLUHnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:43:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:19118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbeLUHnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:43:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 23:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,380,1539673200"; 
   d="scan'208";a="111150904"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2018 23:43:05 -0800
Subject: Re: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
 <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
 <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
 <BN7PR12MB2836A1467A21CAE50125727AC2BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d0d38418-ddd4-b9ab-2951-10207540856b@intel.com>
Date:   Fri, 21 Dec 2018 09:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BN7PR12MB2836A1467A21CAE50125727AC2BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/18 11:01 PM, Sowjanya Komatineni wrote:
> Hi Adrian,
> 
> Thank you for the feedback.
> 
>> This doesn't seem to relate to the host controller implementation.  
>> "The device" means the eMMC.
> 
> Yes, setting block size of 512B before enabling command queue is a device specific 
> requirement not host specific. So thought to update in cqhci driver to follow this 
> device specific sequence requirement. This also serves tegra sdhci host strictly
> following this device specific requirement.

Not sure what you mean.  The eMMC block size is set by CMD16.  In fact CMD16
is not used because 512B is the default so it never needs to be changed.

> 
>> We don't want to disable and re-enable in the request function,
>> so that change is not good for controllers that don't have your problem.
>> Another thing to consider is that the block size register may not need to be changed
>> - for example when cqhci is halted to allow a manual discard, the block size register is
>> not updated, so I would expect its value to be unchanged.
> 
> Once block size is set prior to enabling CQE, it stays same till command queue is 
> disabled and I don’t think it needs reconfiguration.
> 
>> There are ways you can solve this in your driver.  
>> You could look at using SDHCI I/O accessors, and/or implement your own ->enable() 
>> instead of calling sdhci_cqe_enable() directly.  Would that be feasible?
> 
> Sure, will provide updated patch that takes care of this inside tegra sdhci host once you 
> confirm that we don’t plan to fix this device specific sequence requirement in cqhci driver.
> 
> -Sowjanya
>  
> 

