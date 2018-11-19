Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F724C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450092145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fJ1uiewg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450092145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeKTELR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:11:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55865 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbeKTELQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542649607; x=1574185607;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zS1A7Tv4Czs1FEpfMs3Ntne1PZcf7XNMjDhuanEGfQs=;
  b=fJ1uiewgVmUb91fW+3Sartg12wSf2wZtzSMI8OP8UbIXTOVgNyHAjCRp
   pRY6hT8rZGY1N2XG9QaSkyOv3h2zBnJLBsTls9jb483t94nH4GiiQXb3X
   GHFa74ThuufJNfXHdb6GGFWWSOHo3fiG+wCMhSs8wkZM2Rif2Hqw+IDGR
   +eb4PwXLOKmD99gnGRUIEs+JowXww/gNDbg8L7Srl+ORDcs1vrfgihSOw
   nF2Vt4XsZJzjcmCTKctdjHnMFO4nxKf4CPgVutiPbFkClLCKyCUVSLjRp
   LQKBEEKkpl/bVmvG6I9yOGhYvDDBKx2pbI/97a5t6YPrCaZB4cArPPOSt
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="99423757"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 01:46:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 09:30:02 -0800
Received: from cnf003109.ad.shared (HELO [10.86.54.248]) ([10.86.54.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 09:46:45 -0800
Subject: Re: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "juri.lelli@arm.com" <juri.lelli@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <40f24d50-eb1b-cef6-81e2-1bc9930bcbf5@wdc.com>
Date:   Mon, 19 Nov 2018 09:46:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 10:31 AM, Jeffrey Hugo wrote:
> On 11/8/2018 6:50 PM, Atish Patra wrote:
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
>> to code. The only downside in this approach is that the capacity
>> code will be executed for RISC-V as well. But, it will exit
>> immediately after not able to find the appropriate DT node. If
>> the overhead is considered too much, we can always compile out
>> capacity related functions under a different config for the
>> architectures that do not support them.
>>
>> The patches have been tested for RISC-V and compile tested for
>> ARM64.
>>
>> The socket changes[2] can be merged on top of this series or vice
>> versa.
>>
>> [1] https://lkml.org/lkml/2018/11/6/19
>> [2] https://lkml.org/lkml/2018/11/7/918
>>
>> Atish Patra (3):
>>     dt-binding: cpu-topology: Move cpu-map to a common binding.
>>     cpu-topology: Move cpu topology code to common code.
>>     RISC-V: Parse cpu topology during boot.
>>
>>    Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
>>    .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
>>    arch/arm64/include/asm/topology.h                  |  23 +-
>>    arch/arm64/kernel/topology.c                       | 305 +-----------
>>    arch/riscv/Kconfig                                 |   1 +
>>    arch/riscv/kernel/smpboot.c                        |   6 +-
>>    drivers/base/arch_topology.c                       | 303 ++++++++++++
>>    include/linux/arch_topology.h                      |  23 +
>>    include/linux/topology.h                           |   1 +
>>    9 files changed, 864 insertions(+), 799 deletions(-)
>>    delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
>>    create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt
>>
> 
> I was interested in testing these on QDF2400, an ARM64 platform, since
> this series touches core ARM64 code and I'd hate to see a regression.
> However, I can't figure out what baseline to use to apply these.
> Different patches cause different conflicts of a variety of baselines I
> attempted.
> 
> What are these intended to apply to?
> 
I had rebased them on top of 4.20-rc1.

> Also, you might want to run them through checkpatch next time.  There
> are several whitespace errors.
> 
Sorry I missed couple of them.
Thanks for trying to test the patches. I will send a next version as Rob 
suggested. Please test that.


Regards,
Atish
