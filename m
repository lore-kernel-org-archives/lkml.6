Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7597CECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1407920C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IYaXVfwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1407920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeIRHxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:53:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52846 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIRHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537237404; x=1568773404;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ko73oEIYQ0SQVgw+OZMjPWghg7nBrzhiDJWDZ86DSpw=;
  b=IYaXVfwNghiZ6A0iMf9zr3r2Zj0zvbGky24e0nBK9JS1fp675uv5OXjH
   ttCfggOpjbDNXeZxL4zl7I+WgjWEJsDGuzfki2t1c61NecaZCU7GKzuer
   afvvUtEnr71PMjOvAUBWES7li3VkbvA/xyoAH1PICN2GCd5nSjZT+jlu5
   F+YVgbgDEeTFM5kNDqjQPxlES2fj+TSoqF1reoNcbkqNzhwW8q3MKeWp+
   4ezm5uvbzUkEGdydFvgNH/YLSXP7HIrCOWYcEyyA0OpOrywWpR9JL6sHb
   h1fra7OS93PPvtMNLcZJigCJ6mqrvaUcLhCVX/Ijkyq5kR9lCBf/S4/Io
   w==;
X-IronPort-AV: E=Sophos;i="5.53,387,1531756800"; 
   d="scan'208";a="187544702"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2018 10:23:24 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Sep 2018 19:09:14 -0700
Received: from d4bdf12.ad.shared (HELO [10.86.55.130]) ([10.86.55.130])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2018 19:23:03 -0700
Subject: Re: [RFC 2/3] RISC-V:Support per-hart timebase-frequency
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-3-git-send-email-atish.patra@wdc.com>
 <20180917142308.GB15588@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <4d7c1d3d-df0b-df7c-aabd-8ce9fd9dc623@wdc.com>
Date:   Mon, 17 Sep 2018 19:23:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917142308.GB15588@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/18 7:23 AM, Christoph Hellwig wrote:
> On Fri, Sep 14, 2018 at 02:54:55PM -0700, Atish Patra wrote:
>> Follow the updated DT specs and read the timebase-frequency
>> from the boot cpu. Keep the old DT reading as well for backward
>> compatibility. This patch is rework of old patch from Palmer.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> This setup looks a bit odd because it keeps blindly overwriting
> riscv_timebase for every cpu found.  Shouldn't we at least check that
> they all match for now as the rest of the port assumes that?
> 

It will be only updated for boot cpu as it is done after this check.

if (cpuid != smp_processor_id())
  		return 0;

Regards,
Atish
