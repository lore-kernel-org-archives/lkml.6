Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B561C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6002064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6002064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeKBCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:11:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:57818 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeKBCLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:11:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 10:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="scan'208";a="82682643"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2018 10:07:18 -0700
Subject: Re: lib/genalloc
To:     Stephen Bates <sbates@raithlin.com>,
        "danielmentz@google.com" <danielmentz@google.com>,
        "mathieu.desnoyers@efficios.co" <mathieu.desnoyers@efficios.co>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>
References: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
 <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <d127f28f-71fe-c175-c0e4-a368ff1d01a1@intel.com>
Date:   Thu, 1 Nov 2018 19:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/18 18:48, Stephen  Bates wrote:
>>    I use gen_pool_first_fit_align() as pool allocation algorithm allocating
>>    buffers with requested alignment. But if a chunk base address is not
>>    aligned to the requested alignment(from some reason), the returned
>>    address is not aligned too.
>     
> Alexey
> 
> Can you try using gen_pool_first_fit_order_align()? Will that give you the alignment you need?
> 
> Stephen
>     
> 
I think it will not help me. Let's assume that the chunk base address is
0x2F400000 and I want to allocate 16MB aligned buffer. I get back the
0x2F400000. I think it happens because of this string in the
gen_pool_alloc_algo():

addr = chunk->start_addr + ((unsigned long)start_bit << order);

and the gen_pool_first_fit_align() implementation that doesn't take into
account the "incorrect" chunk base alignment.

It might be easily fixed, by rounding the start address up (0x2F400000
-> 0x30000000) and start looking from this, aligned, address.

Thanks,
Alexey
