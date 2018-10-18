Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A5ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F9E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJRN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:56:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31512 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727328AbeJRN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:56:25 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46307789"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2018 13:57:00 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 840084B69E01;
        Thu, 18 Oct 2018 13:57:00 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 18 Oct 2018 13:57:07 +0800
Date:   Thu, 18 Oct 2018 13:56:23 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 7/8] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20181018055622.GF12871@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-8-fanc.fnst@cn.fujitsu.com>
 <20181018042320.GE1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018042320.GE1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 840084B69E01.A9234
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:23:20PM +0800, Baoquan He wrote:
>On 10/17/18 at 06:20pm, Chao Fan wrote:
>> If CONFIG_MEMORY_HOTREMOVE enabled, walk through the acpi srat memory
>> tables and store those immovable memory regions so that kaslr can get
>> where to choose for randomization.
>
>This patch only adds invocation of get_immovable_mem() inside
>mem_avoid_init(). It's not doing what you said in patch log. Can it be
>merged with other patch, e.g patch 6 or 8?

Yes, in old version, this patch will do more job.
Later I move more functions to acpitb.c, just this left.
So I can move it to 8/8.

Thanks,
Chao Fan

>
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 9ed9709d9947..0c3567bc231c 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -417,6 +417,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>>  	/* Mark the memmap regions we need to avoid */
>>  	handle_mem_options();
>>  
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +	/* Mark the immovable regions we need to choose */
>> +	get_immovable_mem();
>> +#endif
>> +
>>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>>  	/* Make sure video RAM can be used. */
>>  	add_identity_map(0, PMD_SIZE);
>> -- 
>> 2.17.2
>> 
>> 
>> 
>
>


