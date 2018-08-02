Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDDC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1D208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TL9iiEdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA1D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeHBC6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:58:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2042 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbeHBC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533172185; x=1564708185;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AtCiDbQqiJV6h8y6PE0sPv0D/QVuEFu/r1gXu28beLU=;
  b=TL9iiEdbubLuvB/ieWRdmARKO2OKIEv/J15Y1zBTlSVM01ZpHoWCG0lO
   yrPQzD2m0vZqFIBTlSXwxUNCWt+D58lD1JGwSd3OzCqzHZ9xRPfH+GyNd
   zjzwZNyEz2zUHfJcGL+UQowTJHlwoTT55g/EWCY/5GUc0GR0/ald4gU3B
   YkfHK8qNYJbKRSKyzU5XHiNXcsSmpKJh+oa280ekd/WEAZyjtBRSJ8Lg7
   g5tiI8F/BTJmJHz15PwIe/pCAmqgdlQzLxzW4AcYD5M3BhHOU8iHEebNa
   R9F/IUFC9QnbcFQx4HTRMqgH5p69rRn2iwmB083mqahOdlng47xzU4t8h
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="89523221"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 09:09:44 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Aug 2018 17:58:07 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2018 18:09:44 -0700
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-8-hch@lst.de>
 <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
 <dc69d688-f765-74cc-3234-563fecff6002@wdc.com> <20180731165712.GA2521@lst.de>
 <dcb17e67-9f83-0ff5-a2c6-a6dd1b4d9c0d@wdc.com>
 <20180801121656.GA25806@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <1b380e3c-e137-ebe9-4528-852062d2192e@wdc.com>
Date:   Wed, 1 Aug 2018 18:09:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801121656.GA25806@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 5:12 AM, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 05:38:01PM -0700, Atish Patra wrote:
>> crash details are at
>> https://paste.debian.net/1036078/
> 
> Is this running without kallsyms?  It seems to lack useful symbols
> and a backtrace unfortunately.
> 
Yes. I checked the config. All KALLSYMS options and STACKTRACE are enabled

CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y

CONFIG_STACKTRACE_SUPPORT=y
CONFIG_STACKTRACE=y

Not sure if I missed something.

Regards,
Atish
