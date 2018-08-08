Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5528C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A02170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XTpWUxGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595A02170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHHJFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:05:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60559 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533710846; x=1565246846;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FpxQH/OYAaUlpNJTt4nGXW12eE4Jmmh7sk8flcywfPk=;
  b=XTpWUxGeTCFe1LGQsGjJCqxKx94ISX9D+JjFWBrXFhHCxAdfblZMGutI
   OZAZ/+THkPbfqgsROg0IjVTZLb0xkrpb4SJT7jjewgmqRQH4QqdJwa6ZV
   MK6zGo+InjNYmd9LUz6id8PJJ1ukEYF2xuuXjg1jp4QipE8f1zU/RKJMq
   p684aolC1ckZ3XP2mZe6D3wemmewJxOcJ1K1cXHcxlMgmY7VLSCACudsd
   TvVoTOWIRX6V55YcRhZ+8wPYACj+LNLQcEHrrfH7burzROsk6dijVeY28
   LNY86gCy1xEWJPHqFApA2OTPisaKjzMQKfpj8x7gzgJT64iTmdQrxS7st
   A==;
X-IronPort-AV: E=Sophos;i="5.51,456,1526313600"; 
   d="scan'208";a="184347156"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2018 14:47:25 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Aug 2018 23:34:54 -0700
Received: from ch8yk72.ad.shared (HELO [10.86.56.196]) ([10.86.56.196])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Aug 2018 23:47:16 -0700
Subject: Re: [PATCH 09/11] RISC-V: Support per-hart timebase-frequency
To:     Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <mhng-d315d8a6-c4db-4ec8-927b-fc9f1d8e7872@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <b4ddcb20-6109-22ac-4691-c2c012ea112a@wdc.com>
Date:   Tue, 7 Aug 2018 23:47:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-d315d8a6-c4db-4ec8-927b-fc9f1d8e7872@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/18 1:34 PM, Palmer Dabbelt wrote:
> On Fri, 03 Aug 2018 05:33:57 PDT (-0700), Christoph Hellwig wrote:
>> On Thu, Aug 02, 2018 at 03:19:49PM -0700, Atish Patra wrote:
>>> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>>>> From: Palmer Dabbelt <palmer@sifive.com>
>>>>
>>>> Follow the updated DT specs and read the timebase-frequency from the
>>>> CPU 0 node.
>>>>
>>>
>>> However, the DT in the HighFive Unleashed has the entry at the wrong place.
>>>
>>> Even the example in github also at wrong place.
>>> https://github.com/riscv/riscv-device-tree-doc/pull/8/commits/2461d481329c55005fcbe684f0d6bdb3b7f0a432
>>>
>>> DT should be consistent between Documentation and the one in the hardware.
>>> I can fix them in bbl & submit a bbl patch. But I am not sure if that's an
>>> acceptable way to do it.
>>
>> I'll need to have comments from Palmer and/or someone else at SiFive
>> here.  Personally I really don't care where we document the timebase,
>> as this patch supports both locations anywhere.  For now I'll just update
>> the commit log to state that more explicitly.
> 
> You're welcome to submit a BBL patch to make this all match, but from my
> understanding of the device tree spec putting timebase-frequency in either
> place should be legal so it's not a critical fix.  That said, it's better to
> have them match than not match.
> 

ok. I will add it my TODO list as a low priority task. Following DT 
entries can be fixed for now.

1. timebase-frequency
2. next-level-cache

Regards,
Atish
