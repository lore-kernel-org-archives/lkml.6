Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FEEC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E8920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eMAUKi32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E8920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeIKGbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:31:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61239 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536629705; x=1568165705;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=waF1HyBAH6Mk535gQBIXxmVaigK6DDvR3biGKMiZ2gg=;
  b=eMAUKi327YSvLs1dr69qWvMmK7sgTPwQ3qW3ncPLLnCUuTPjRAA8G1SU
   BAs1bzHVnpi/QTRbaQAX/MUxZJFdsoWif00VGzZi9ERqQZsmNUNki28tN
   LWONPr5jP+mQ7s/yuAx8T/fPoPwCjJUBWHUxmiOs8N4Ma2uyAQeulzfBg
   qNnfWQIjR4VMU6WN6bFcO4EvRDJ90r9Shi3hBo/4Ifg4G+rOzVUULJhnO
   m2LYo2JlLCgqrCb6u5gf7Un+Mr01OXZvX+BUvKXnVu7G5PswglWRIQ3WW
   vuU3eMioSaARpalYXO7nb/oJoCu7Eg4Sty2rLrux71VTEeG2t/7CBhk93
   A==;
X-IronPort-AV: E=Sophos;i="5.53,358,1531756800"; 
   d="scan'208";a="91082084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2018 09:35:05 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Sep 2018 18:21:29 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2018 18:35:03 -0700
Subject: Re: [PATCH v3 02/12] RISC-V: Filter ISA and MMU values in cpuinfo
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-3-git-send-email-atish.patra@wdc.com>
 <20180910112418.GB12979@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <4633e2a9-868c-40bb-a6b3-366842c93f0a@wdc.com>
Date:   Mon, 10 Sep 2018 18:35:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910112418.GB12979@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 4:24 AM, Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 01:05:25AM -0700, Atish Patra wrote:
>> +#elif defined(CONFIG_64BIT)
>> +	if ((strcmp(mmu_type, "riscv,sv39") != 0)
>> +	    && (strcmp(mmu_type, "riscv,sv48") != 0))
>> +		return;
> 
> This should be:
> 
> 	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
> 	    strcmp(mmu_type, "riscv,sv48") != 0)
> 		return;
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Fixed.

Regards,
Atish
