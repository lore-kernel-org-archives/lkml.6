Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F759C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58925205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pBMVaHbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58925205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeLKA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:26:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59582 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLKA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544488125; x=1576024125;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Yu/UGOFjGVp/CZUqSFRBTuTeDAXC3xQlnIWp9srtFm0=;
  b=pBMVaHbzGxVF8NYjOeYmOQP17s3m+hIqJfSC/clhR1vP65RmBA+4N1Kk
   FLEk7FqzSfjJO7teNbI1hPOJ/qI9J3yIKjAgIyo/PZ9xC8ASDfpJ4TXA1
   qaKCIJFUREa/kRvZfeMqlDzLHqKChm7u7BJ+xzyFbNpp9cD0MlxAvZTjb
   dSG5k90HrGiJLuHbbEhQqkihW+9tP7HJY6H5f4QUA17bYKtLBJgSu8Hv4
   YveaIuyy5rwoJiTbTRMBd8iPrLsqzKr+k2BkLhWx4bBBiP2jxzkZhX9oX
   x0E2bZ6t8X6LajokGNDyPOidx7mDuf6NpfNRNtMhEBkw+1eKddTMgZ8A+
   A==;
X-IronPort-AV: E=Sophos;i="5.56,340,1539619200"; 
   d="scan'208";a="194162147"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2018 08:28:44 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Dec 2018 16:09:26 -0800
Received: from colley-l-lt.ad.shared (HELO [10.86.57.118]) ([10.86.57.118])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Dec 2018 16:26:49 -0800
Subject: Re: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Ingo Molnar <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <d72a87f4-8dc1-2ec7-b602-0135c5e4c3a7@codeaurora.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <131ba08d-a31f-601d-eb40-9d2e8007d948@wdc.com>
Date:   Mon, 10 Dec 2018 16:26:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d72a87f4-8dc1-2ec7-b602-0135c5e4c3a7@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 9:53 AM, Jeffrey Hugo wrote:
> On 11/29/2018 4:28 PM, Atish Patra wrote:
>> The cpu-map DT entry in ARM64 can describe the CPU topology in
>> much better way compared to other existing approaches. RISC-V can
>> easily adopt this binding to represent it's own CPU topology.
>> Thus, both cpu-map DT binding and topology parsing code can be
>> moved to a common location so that RISC-V or any other
>> architecture can leverage that.
>>
>> The relevant discussion regarding unifying cpu topology can be
>> found in [1].
>>
>> arch_topology seems to be a perfect place to move the common
>> code. I have not introduced any functional changes in the moved
>> code. The only downside in this approach is that the capacity
>> code will be executed for RISC-V as well. But, it will exit
>> immediately after not able to find the appropriate DT node. If
>> the overhead is considered too much, we can always compile out
>> capacity related functions under a different config for the
>> architectures that do not support them.
>>
>> The patches have been tested for RISC-V and compile tested for
>> ARM64 & x86.
>>
>> The socket change[2] is also now part of this series.
>>
>> [1] https://lkml.org/lkml/2018/11/6/19
>> [2] https://lkml.org/lkml/2018/11/7/918
>>
>> QEMU changes for RISC-V topology are available at
>>
>> https://github.com/atishp04/riscv-qemu/tree/cpu_topo
>>
>> Apologies for the previous patch series with incorrect title and
>> was sent only to kernel mailing list due to a bug in my config.
>> Please ignore that.
>>
>> Atish Patra (3):
>> dt-binding: cpu-topology: Move cpu-map to a common binding.
>> cpu-topology: Move cpu topology code to common code.
>> RISC-V: Parse cpu topology during boot.
>>
>> Sudeep Holla (1):
>> Documentation: DT: arm: add support for sockets defining package
>> boundaries
>>
>> .../{arm/topology.txt => cpu/cpu-topology.txt}     | 133 +++++++--
>> arch/arm64/include/asm/topology.h                  |  22 --
>> arch/arm64/kernel/topology.c                       | 303 +--------------------
>> arch/riscv/Kconfig                                 |   1 +
>> arch/riscv/kernel/smpboot.c                        |   3 +
>> drivers/base/arch_topology.c                       | 294 ++++++++++++++++++++
>> include/linux/arch_topology.h                      |  26 ++
>> include/linux/topology.h                           |   1 +
>> 8 files changed, 435 insertions(+), 348 deletions(-)
>> rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
>>
>> --
>> 2.7.4
>>
> 
> Seems to test fine on QDF2400.
> 
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>


Thanks for verifying the patches.

> I did see that git am complained about patch #2 -
> 
> patch:103: space before tab in indent.
>                           };
> patch:114: space before tab in indent.
>           };
> warning: 2 lines add whitespace errors.
> 
> 

Thanks for pointing it out. For some reason, cherry-pick did not 
complain about these. I will fix them.

Regards,
Atish
