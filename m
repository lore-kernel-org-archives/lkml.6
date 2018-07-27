Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7096AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1C2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z+qL/q7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC1C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbeG0THg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:07:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23748 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbeG0THg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532713479; x=1564249479;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=o+XhC5hTUW8QSlbmNq+/Q0xh5YstXqE4KUh4i+xLo64=;
  b=Z+qL/q7PoIvCll+LxU7HQhw253mtWHlm8XLMpRgqdN5ftuI4RjiSXzEy
   XP44IrR8XsWIts7HTL4HH2bTVECFSAzfPJtIBtfgwqTe7IKJl3qKUPCJ8
   eEpvGRf1M44ySKrh8DPRW0Sh1z4VwisYLHQrf+u8Q+YzHfFBVC/5f7TO3
   6voUQNOnTP2MR+6lqoT7IWFtiokSt7VGdqh7DukEKu7llQId6irsgmgcd
   s1/A5ZC1Hu70V6V2qUSuH1a8Ihu+JRK6MeVbVq/3ETOZ0Hf4vf0VIMMIM
   /JAEsld/QyTdV17iqwauexj/VqLAsEi9vRLX2wynvdtqqP3VNUh1837uD
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,410,1526313600"; 
   d="scan'208";a="188897726"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2018 01:44:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jul 2018 10:33:12 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jul 2018 10:44:39 -0700
Subject: Re: [PATCH 9/9] clocksource: new RISC-V SBI timer driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-10-hch@lst.de>
 <972dacda-75d6-83cd-45e0-c7526a4e02ba@wdc.com>
 <20180727144148.GA29626@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f0a5a2e0-7f08-13cd-1758-f53494c1e391@wdc.com>
Date:   Fri, 27 Jul 2018 10:44:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727144148.GA29626@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 7:38 AM, Christoph Hellwig wrote:
> On Thu, Jul 26, 2018 at 11:51:56AM -0700, Atish Patra wrote:
>> Should we follow the same prefix for these functions?
>> either timer_riscv* or riscv_timer* ?
>>
>> Apologies for overlooking this in my timer patch as wel
> 
> riscv_timer_* sounds saner to me, I can update that.
> 

Thanks.
>>> +	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
>>> +
>>
>> The comment about the purpose of clearing the interrupt in the original
>> patch is removed here. If that's intentional, it's fine.
>>
>> I thought having that comment helps understanding the distinction between
>> clearing the timer interrupt in SBI call & here.
> 
> Yes, that was intentional.  But given that I don't even understand why
> not using an ABI for architectural interrupt source enable/disable maybe
> I'm confused and should revisit that decision.
> 

I tried adding a new SBI call to disable the interrupts. However, I 
realized that it is not recommended to change the SBI unless absolutely 
required.

Here is the PR & following discussion.
https://github.com/riscv/riscv-pk/pull/108

Regards,
Atish
