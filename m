Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A227CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7028920855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OlrKycMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfARCIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:08:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12945 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfARCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547777316; x=1579313316;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nUzTQsPZiSZq/mJIX/AY5MQuROuAFQ9ZS3mpZfR5e/k=;
  b=OlrKycMN85fm5KJny8ya+mNFRqwBW441covWwpXycsVuLlKbaxa+eOwd
   qwnKdeFlDuvNloxonHgrQydUgo7TZ4Xlw2o6eQlggCIXTdbyI07WHmrOF
   rYGMMG7Zr2GfOt6hODbSHGJpjRvzgWzvMsMVTco4X6zZ+tkEwN3Ys1LjC
   wGmKRA1xpnDi3Rpx5OVAeHTTJPGYUj91Zczc2nH16t/CFyA15RdRonvO0
   7iNkJBlNa5/SH+lI/h1zWng/D4QgTCX0SU5UyLaqNiVbdOumsJ8pnEGHX
   qDBVZiajVjI0TJ266QEoAdoqouzYhMoB6BvwKHhQ5bJR9RGY1ANEcNLGz
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="99142786"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 10:08:12 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jan 2019 17:47:52 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2019 18:08:12 -0800
Subject: Re: [PATCH v2 2/8] RISC-V: Move cpuid to hartid mapping to SMP.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-3-git-send-email-atish.patra@wdc.com>
 <20190115135229.GB28946@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <b7043bae-f95f-5c9a-000f-9ea630e7ba17@wdc.com>
Date:   Thu, 17 Jan 2019 18:08:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115135229.GB28946@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 5:52 AM, Christoph Hellwig wrote:
>> +	if (hartid == boot_cpu_hartid)
>> +		return 0;
>> +	else
>> +		return -1;
> 
> No need for an else after a return statement.
>

Correct. Will update it.

>> +}
>> +static inline unsigned long cpuid_to_hartid_map(int cpu)
>> +{
>> +
>> +	return boot_cpu_hartid;
> 
> spurious empty line above.
> 
Sorry for that. Will fix it.

Regards,
Atish
