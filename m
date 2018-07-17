Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7239ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4165220877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4165220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeGQBdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:33:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38472 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729968AbeGQBdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:33:24 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42301729"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jul 2018 09:03:26 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id BD3B04B5CC0C;
        Tue, 17 Jul 2018 09:03:24 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 17 Jul 2018 09:03:24 +0800
Date:   Tue, 17 Jul 2018 09:01:33 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH v2 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180717010132.GA6816@localhost.localdomain>
References: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
 <20180716085538.31939-4-fanc.fnst@cn.fujitsu.com>
 <20180716114447.GA7650@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180716114447.GA7650@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: BD3B04B5CC0C.AE70D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:44:47PM +0200, Ingo Molnar wrote:
>
>* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
>> If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
>> tables, store the immovable memory regions, so that kaslr can get
>> the information abouth where can be selected or not.
>> If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 531c9876f573..0ec5aab915db 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -31,6 +31,7 @@
>>  
>>  #include "misc.h"
>>  #include "error.h"
>> +#include "acpitb.h"
>>  #include "../string.h"
>>  
>>  #include <generated/compile.h>
>> @@ -104,6 +105,14 @@ static bool memmap_too_large;
>>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>>  unsigned long long mem_limit = ULLONG_MAX;
>>  
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/* Store the movable memory */
>> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
>> +
>> +/* Store the num of movable mem regions */
>> +static int num_immovable_mem;
>> +#endif
>
>So comment says 'movable', but variables are named 'immovable'??

Sorry for the typo, will change it immidiately.

Thanks,
Chao Fan

>
>Thanks,
>
>	Ingo
>
>


