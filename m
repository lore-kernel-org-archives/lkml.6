Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1002083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1002083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJRNtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:49:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4420 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727328AbeJRNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:49:15 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46307503"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2018 13:49:30 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0F6DC4B6ED95;
        Thu, 18 Oct 2018 13:49:31 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 18 Oct 2018 13:49:38 +0800
Date:   Thu, 18 Oct 2018 13:48:53 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 0/8] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181018054853.GC12871@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181018035958.GA1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018035958.GA1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0F6DC4B6ED95.AF03C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:59:58AM +0800, Baoquan He wrote:
>On 10/17/18 at 06:20pm, Chao Fan wrote:
>> In the earliest time, I tried to dig ACPI tabls to solve this problem.
>> But I didn't splite the code in 'compressed/' and ACPI code, so the patch
>> is hard to follow so refused by community.
>> Somebody suggest to add a kernel parameter to specify the
>> immovable memory so that limit kaslr in these regions. Then I make
>> a new patchset. After several versions, Ingo gave a suggestion:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
>> Follow Ingo's suggestion, imitate the ACPI code to parse the acpi
>> tables, so that the kaslr can get necessary memory information in
>> ACPI tables.
>> I think ACPI code is an independent part, so imitate the codes
>> and functions to 'compressed/' directory, so that kaslr won't
>> influence the initialization of ACPI.
>> 
>> PATCH 1/3 Add acpitb.c to provide functions to parse ACPI code.
>> PATCH 2/3 If CONFIG_MEMORY_HOTREMOVE enabled, walk all nodes and
>>           store the information of immovable memory regions.
>> PATCH 3/3 According to the immovable memory regions, filter the
>>           immovable regions which KASLR can choose.
>
>Chao, seems you didn't update above accordingly.

oops, sorry for that.

Thanks,
Chao Fan

>
>> 
>> v1->v2:
>>  -  Simplify some code.
>> Follow Baoquan He's suggestion:
>>  - Reuse the head file of acpi code.
>> 
>> v2->v3:
>>  - Test in more conditions, so remove the 'RFC' tag.
>>  - Change some comments.
>> 
>> v3->v4:
>> Follow Thomas Gleixner's suggetsion:
>>  - Put the whole efi related function into #define CONFIG_EFI and return
>>    false in the other stub.
>>  - Simplify two functions in head file.
>> 
>> v4->v5:
>> Follow Dou Liyang's suggestion:
>>  - Add more comments about some functions based on kernel code.
>>  - Change some typo in comments.
>>  - Clean useless variable.
>>  - Add check for the boundary of array.
>>  - Add check for 'movable_node' parameter
>> 
>> v5->v6:
>> Follow Baoquan He's suggestion:
>>  - Change some log.
>>  - Add the check for acpi_rsdp
>>  - Change some code logical to make code clear
>> 
>> v6->v7:
>> Follow Rafael's suggestion:
>>  - Add more comments and patch log.
>> Follow test robot's suggestion:
>>  - Add "static" tag for function
>> 
>> v7-v8:
>> Follow Kees Cook's suggestion:
>>  - Use mem_overlaps() to check memory region.
>>  - Use #ifdef in the definition of function.
>> 
>> v8-v9:
>> Follow Boris' suggetion:
>>  - Change code style.
>>  - Splite PATCH 1/3 to more path.
>>  - Introduce some new function
>>  - Use existing function to rework some code
>> Follow Masayoshi's suggetion:
>>  - Make code more readable
>> 
>> Any comments will be welcome.
>> 
>> 
>> Chao Fan (8):
>>   x86/boot: Introduce cmdline_find_option_arg()to detect if option=arg
>>     in cmdline
>>   x86/boot: Copy kstrtoull() to compressed period
>>   x86/boot: Add efi_get_rsdp_addr() to dig out RSDP from EFI table
>>   x86/boot: Add bios_get_rsdp_addr() to search RSDP in memory
>>   x86/boot: Add get_acpi_rsdp() to parse RSDP in cmdlien from kexec
>>   x86/boot: Dig out SRAT table from RSDP and find immovable memory
>>   x86/boot/KASLR: Walk srat tables to filter immovable memory
>>   x86/boot/KASLR: Limit kaslr to choosing the immovable memory
>> 
>>  arch/x86/boot/compressed/Makefile  |   4 +
>>  arch/x86/boot/compressed/acpitb.c  | 354 +++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/cmdline.c |  15 ++
>>  arch/x86/boot/compressed/kaslr.c   |  77 ++++++-
>>  arch/x86/boot/compressed/misc.c    |  88 +++++++
>>  arch/x86/boot/compressed/misc.h    |  15 ++
>>  6 files changed, 542 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.c
>> 
>> -- 
>> 2.17.2
>> 
>> 
>> 
>
>


