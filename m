Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F71C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oOA6omwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DA120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeIKGcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:32:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28782 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536629766; x=1568165766;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t8WzOVrur58FnJP3QkWrZgQaYaMd2pfBAcp/YCH0S0c=;
  b=oOA6omwxPfWb+RUcPfm2l/Af/JGwU2d9p+Q/g9p2TYQ6LFGTjnYlsDwL
   LxLQBU0tPiGC4CM7VZv8pRBQooS3ZTqv4gCP+tjuJOiw3ja+3Txqhlr1v
   nkINZtgbAY8G39Q3PnRYvXKwy3+J2DuZFwFMs0uf3LoEcx3ikh5oSxI7q
   rb9Rne/P6Jlp52xPBxlPx0VUyBN8O9Ce3MkfDQ0xlBPErptP1p3MTJ6aT
   TqsrnXC8zC6eijdW/3eHBmHmrAA7HtRrqG2akKNgyhY+uufn+r+vZriEw
   tGFu6TM0NH1rPRPtqZXqhjl2kFuUnlS7QgY9Lcha43rkul7HccLpQVl51
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,358,1531756800"; 
   d="scan'208";a="187006326"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2018 09:36:06 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Sep 2018 18:22:21 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2018 18:35:46 -0700
Subject: Re: [PATCH v3 11/12] RISC-V: Use Linux logical cpu number instead of
 hartid
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
 <1536221135-182613-12-git-send-email-atish.patra@wdc.com>
 <20180910112909.GJ12979@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <517a8d3f-afb4-faa9-2acf-458d1a23bd21@wdc.com>
Date:   Mon, 10 Sep 2018 18:35:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910112909.GJ12979@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 4:29 AM, Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 01:05:34AM -0700, Atish Patra wrote:
>> Setup the cpu_logical_map during boot. Moreover, every SBI call
>> and PLIC context are based on the physical hartid. Use the logical
>> cpu to hartid mapping to pass correct hartid to respective functions.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Reviewed-by  : Anup Patel <anup@brainfault.org>
> 
> Same whitespace issue here.
> 
> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Fixed. Thanks for the review.

Regards,
Atish
