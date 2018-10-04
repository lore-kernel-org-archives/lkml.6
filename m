Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0602098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0602098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJED5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:57:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:30929 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJED5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:57:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 14:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="238574673"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.132]) ([10.122.105.132])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2018 13:58:22 -0700
From:   Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
Reply-To: thor.thayer@linux.intel.com
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
 <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
 <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
Message-ID: <793d47b7-cb56-9017-2030-e248921ccab4@linux.intel.com>
Date:   Thu, 4 Oct 2018 16:00:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 10/04/2018 01:49 PM, Vivek Gautam wrote:
> Hi Thor,
> 
> 
> On 10/4/2018 3:58 AM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add a clock to the SMMU structure. In the device tree case,
>> check for a clock node and enable the clock if found.
>>
>> This patch is dependent upon the following patches that add
>> a device tree bulk clock function.
>> "[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
>> https://patchwork.kernel.org/patch/10583133/
>> "[V6, 2/4] clk: add new APIs to operation on all available
>> clocks"
>> https://patchwork.kernel.org/patch/10583131/
>> "[V6, 3/4] clk: add managed version of clk_bulk_get_all"
>> https://patchwork.kernel.org/patch/10583139/
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> The clock part is already handled by one of the patch in the
> runtime pm series of arm-smmu [1]. This patch should not be needed.
> 
> [1] https://patchwork.kernel.org/patch/10581899/
> 
> [...]
> 
> Regards
> Vivek
> 

Thanks. FYI, I had problems applying [v16,2/5] on [1] but was able to 
apply [v17,2/5] cleanly.

The bigger issue is that with your patchset I need to create a new 
structure for my variation of the ARM SMMUv2 due to the 
of_device_get_match_data() call in arm_smmu_device_dt_probe(). I want to 
use the default arm_mmu500 but it doesn't have a clock specified and I 
end up with num_clks of 0.

Creating a new smmu_match_data structure for each variant feels wrong 
because I have the clock data specified in my device tree. The 
of_clk_bulk_get() call handles this nicely but that patchset isn't 
getting much attention.

I'll investigate adding the of_clk_bulk_get() call on top of your 
patches. This may simplify your patches too since the additional 
structures in [v16,5/5] wouldn't be needed.

Thanks,

Thor

[1] git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git - next
