Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B67C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F14720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIYHSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:18:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20985 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726059AbeIYHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:18:18 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="45300333"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Sep 2018 09:13:19 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 087EF4B6AE13;
        Tue, 25 Sep 2018 09:13:21 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 25 Sep 2018 09:13:26 +0800
Date:   Tue, 25 Sep 2018 09:12:46 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Kees Cook <keescook@chromium.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20180925011246.GB12561@localhost.localdomain>
References: <20180913104629.5179-1-fanc.fnst@cn.fujitsu.com>
 <20180913104629.5179-2-fanc.fnst@cn.fujitsu.com>
 <CAGXu5j+LxEpoKAkEo8GQa-f729_Ebavgtnv+DA9bxf9XEz2QPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGXu5j+LxEpoKAkEo8GQa-f729_Ebavgtnv+DA9bxf9XEz2QPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 087EF4B6AE13.AB386
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:45:12AM -0700, Kees Cook wrote:
>On Thu, Sep 13, 2018 at 3:46 AM, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> There is a bug that kaslr may randomly chooses some positions
>> which are located in movable memory regions. This will break memory
>> hotplug feature and make the movable memory chosen by KASLR can't be
>> removed. So dig SRAT table from ACPI tables to get memory information.
>>
>> Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
>> tables. Since some operations are not needed here, functions are
>> simplified. Functions will be used to dig only SRAT tables to get
>> information of memory, so that KASLR can the memory in immovable node.
>>
>> And also, these functions won't influence the initialization of
>> ACPI after start_kernel().
>>
>> Since use physical address directely, so acpi_os_map_memory()
>> and acpi_os_unmap_memory() are not needed.
>>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/Makefile |   4 +
>>  arch/x86/boot/compressed/acpitb.c | 401 ++++++++++++++++++++++++++++++
>
>Does this logic live anywhere else in the kernel already? (i.e. could
>other code be reused?)

Live in uncompressec period, but not completely same.
The map between physical address and virtual address is not needed here.
So I thins it's hard to reuse, that's why I made this new file.

Thanks,
Chao Fan

>
>-Kees
>
>-- 
>Kees Cook
>Pixel Security
>
>


