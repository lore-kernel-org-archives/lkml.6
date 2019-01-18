Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E006C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609120883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DnbrIuWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfARCNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:13:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43885 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfARCNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547777585; x=1579313585;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rFlBZNV3NI+o5bHSlNipI8QY+dI7Tht/TtUsVJmoWlI=;
  b=DnbrIuWyfMJzbZWcgD1ZYW3tsA6q04i8JzHvd603FkmL4vFRfNcgX8f2
   Cxrm7MSmcziTAjPu+sPKXObG3kTN18Vrx4hPn6GKz+e4Kmp4D6NmVZaqW
   7QfsJPuTEBd7UXqfpfmGCj1kC4xbXKCTaaz5gF3uJtV2NY4dR5OWHFtWW
   UcwA+hF6guQMNTU4X27pmC75UJ+wSrCo1ny/vDg29bIAc2MEPqo1ARgb5
   UD35+BX/K8m7BayLHRRLspLGDz4SbA8gpbISix2UcP3oFuPaAo65NVKTM
   dPDX0FEbVl1Bv7SgvFlSbds/eHYJz5Z/zd57XA7egZNueXSOxyW2gMMVh
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="204082826"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 10:13:05 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jan 2019 17:52:45 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2019 18:13:06 -0800
Subject: Re: [PATCH v2 8/8] RISC-V: Assign hwcap only according to current
 cpu.
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
 <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
 <20190115135639.GH28946@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <356b919c-c025-8993-e5ef-2b010bed0b56@wdc.com>
Date:   Thu, 17 Jan 2019 18:13:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115135639.GH28946@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 5:56 AM, Christoph Hellwig wrote:
> On Tue, Jan 08, 2019 at 01:38:38AM -0800, Atish Patra wrote:
>> Currently, we set hwcap based on first valid cpu from
>> DT. This may not be correct always as that CPU might not
>> be current booting cpu.
>>
>> Set hwcap based on the current cpu instead of first
>> valid CPU from DT.
> 
> This is generally the right thing to do.  But can the kernel even cope
> with different hwcaps per hart?

I don't think so.
   I know arm land and I think x86 as well
> don't, so we might want to add a sanity check that they match or reduce
> them to the common subset.
> 

I will add a sanity check that they match and throw a warning if they 
don't.

Regards,
Atish
