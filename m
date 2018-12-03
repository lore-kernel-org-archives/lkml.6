Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290CDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75AE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DvgKvPet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75AE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeLCRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:31:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5257 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLCRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543858279; x=1575394279;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8TCu3Sd7qsPWvRMySkaqsG2A5lI5wsjaimKIPdz9VJI=;
  b=DvgKvPetl1zEIwKFy5QDsmaWFp4JblqAHP9fG2nuWnSb5Y37lXcey/YN
   NVuFAlf/ZuHRELttupfyJgi6g52nUbOCF53faMINtmbGFNDRBOrf/BdZB
   ibv68mF2oujqxNUYqe5Pa58VdJ7RS+bMIZSG2sPqRX399n2l5z7mtkVPI
   xrZ69si7HQ8ycREMabT54PG7PW5ufPXGjCcB0KnD5sIOqFNzlmi001e9l
   9Utif0KJ5q2VmJsJyJAHE6qUSrXp6o962UWfz3EvwC26yOOw5vK7BXp27
   5cAERtCOKbZokreRy4R6f7EtbWNV+Z64Ikpu3tcytSP9VNhtsOOOToVfC
   g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100505956"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 01:31:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 03 Dec 2018 09:14:10 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 09:31:18 -0800
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to common
 code.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203171619.GE17883@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f71fd03d-e5a7-0e79-9273-367db2354777@wdc.com>
Date:   Mon, 3 Dec 2018 09:31:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203171619.GE17883@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 9:16 AM, Sudeep Holla wrote:
> On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>> their cpu topology. It's better to move the relevant code to
>> a common place instead of duplicate code.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/arm64/include/asm/topology.h |  22 ---
>>   arch/arm64/kernel/topology.c      | 303 +-------------------------------------
>>   drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
>>   include/linux/arch_topology.h     |  26 ++++
>>   include/linux/topology.h          |   1 +
>>   5 files changed, 325 insertions(+), 321 deletions(-)
>>
>  From a quick look and diffstat, it looks like a simple move. However
> I would like to throw this at 0-day bot to test various build configurations
> so that it's not breaking anything. I can push to a branch in my git
> @kernel.org but not sure on the build coverage. Anyways will update
> with any results on build and testing on my side ASAP.
> 
Thanks. It definitely need to rigorous build testing for different 
configurations.

What is the best practice to trigger expansive build tests?
linux-kernel@vger.kernel.org is in CC.

Regards,
Atish
> --
> Regards,
> Sudeep
> 

