Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECCBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DA02145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DA02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeK3Pww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:52:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeK3Pww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2912E31256D9;
        Fri, 30 Nov 2018 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41EEA19940;
        Fri, 30 Nov 2018 04:44:39 +0000 (UTC)
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tony.luck@intel.com,
        fenghua.yu@intel.com, bhe@redhat.com
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <5bda3bfe-8ab2-3c3e-fc4d-6322d372e9ae@redhat.com>
Date:   Fri, 30 Nov 2018 12:44:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 30 Nov 2018 04:44:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月30日 11:41, Dave Young 写道:
> On 11/29/18 at 04:09pm, Lianbo Jiang wrote:
>> When doing kexec_file_load, the first kernel needs to pass the e820
>> reserved ranges to the second kernel. But kernel can not exactly
>> match the e820 reserved ranges when walking through the iomem resources
>> with the descriptor 'IORES_DESC_NONE', because several e820 types(
>> e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
>> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
>> may pass these four types to the kdump kernel, that is not desired result.
>>
>> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
>> for the iomem resources search interfaces. It is helpful to exactly
>> match the reserved resource ranges when walking through iomem resources.
>>
>> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
>> these code originally related to the descriptor 'IORES_DESC_NONE' need to
>> be updated. Otherwise, it will be easily confused and also cause some
>> errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
>> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
>> changed.
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
> 
> This was suggested by Boris instead :) 
> 

Sorry for this, i forgot to change it.
And i will correct this in next version.

Thanks.

>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/ia64/kernel/efi.c |  4 ++++
>>  arch/x86/kernel/e820.c |  2 +-
>>  arch/x86/mm/ioremap.c  | 13 ++++++++++++-
>>  include/linux/ioport.h |  1 +
>>  kernel/resource.c      |  6 +++---
>>  5 files changed, 21 insertions(+), 5 deletions(-)
>>
>>
> [snip]
> 
> Thanks
> Dave
> 
