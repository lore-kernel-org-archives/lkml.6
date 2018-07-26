Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9BCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C3920671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YpMfs8r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C3920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbeG0A5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:57:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41201 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbeG0A5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532648325; x=1564184325;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4XAZAlPEVBbj5j7HHl+MxVn/Ww4nIY50tP9qZD4VifA=;
  b=YpMfs8r+L/2nE2MpOV3H9uQJCFX3LNERUC4Yxd827ZwEw5VHJ7wVNIG5
   4wirQM3too/lvhiKQkWBi6UWKuiuCeDtEOZnSiFh1wmWee0hACOV9MqB4
   etp3X4ypthM82eHzU2KoK/ifrkqaJ0tuSE7xqUi14PI8N5mP1BwYV6GKe
   pockqU3uikrJKlhO/MSz9wsIqLAzzyUs3fjfPMJ9kgMWy0Y6UafriEugf
   V6j+ETNxNxwEmlzw0sJXpCLpTrAm2Zmhzt3CkH3U0J35XE517LScxP/yf
   0yo/HdqbWss/+nmxUyr+a4Bc20XZjTiBUmYMGq15G6LoN/PgZyBdY43Dw
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,407,1526313600"; 
   d="scan'208";a="85923717"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2018 07:38:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jul 2018 16:26:48 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jul 2018 16:38:43 -0700
Subject: Re: RFC: simplified RISC-V interrupt and clocksource handling
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <dc346650-0b48-3c2b-9190-b87ea6987e37@wdc.com>
Date:   Thu, 26 Jul 2018 16:38:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/18 7:37 AM, Christoph Hellwig wrote:
> This series tries adds support for interrupt handling and timers
> for the RISC-V architecture.
> 
> The basic per-hart interrupt handling implemented by the scause
> and sie CSRs is extremely simple and implemented directly in
> arch/riscv/kernel/irq.c.  In addition there is a irqchip driver
> for the PLIC external interrupt controller, which is called through
> the set_handle_irq API, and a clocksource driver that gets its
> timer interrupt directly from the low-level interrupt handling.
> 
> Compared to previous iterations this version does not try to use an
> irqchip driver for the low-level interrupt handling.  This saves
> a couple indirect calls and an additional read of the scause CSR
> in the hot path, makes the code much simpler and last but not least
> avoid the dependency on a device tree for a mandatory architectural
> feature.
> 
I agree that this code is much simpler than HLIC code.
Few doubts though

1. As per my understanding, timer interrupt now can't be registered as a 
Linux IRQ now. Thus, /proc/interrupts will not be automatically 
populated for timer interrupt stats. Am I wrong in my assumption?

2. The future version of local interrupt controller known as Core Level 
Interrupt Controller aka CLIC. Do we have to change the current design
again for CLIC in future?

Here are the docs:
https://github.com/sifive/clic-spec/blob/master/clic.adoc

Regards,
Atish
> A git tree is available here (contains a few more patches before
> the ones in this series)
> 
>      git://git.infradead.org/users/hch/riscv.git riscv-irq-simple
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple
> 

