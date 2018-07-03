Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82094C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F811223C9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F811223C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeGCBeJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:34:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35978 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753130AbeGCBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:34:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="41763783"
Received: from localhost (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jul 2018 09:34:06 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B49EF4B44369;
        Tue,  3 Jul 2018 09:34:01 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 3 Jul 2018 09:34:06 +0800
Date:   Tue, 3 Jul 2018 09:32:35 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <lcapitulino@redhat.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/4] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory.
Message-ID: <20180703013235.GA7297@localhost.localdomain>
References: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
 <20180702121855.GA2195@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180702121855.GA2195@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: B49EF4B44369.AB347
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 08:18:55PM +0800, Baoquan He wrote:
>Hi Chao,
>
>On 06/12/18 at 04:10pm, Chao Fan wrote:
>> *** Issues need be discussed
>> There are several issues I am not quite sure, please help review and
>> give suggestions:
>> 
>> 1) In PATCH 1, I copy the structures and functions from ACPI head file,
>>    so that ACPI head file will never been used here. I am not sure
>>    whether it's good to include ACPI head file or use the method in
>>    PATCH 1. If people think we can use ACPI head files directely, I
>>    will remove the PATCH 1.
>
>Usaully we try to reuse code even though they are located in different
>life space. I think it applies to this SRAT handling. Copying ACPI codes

Yes, you are right. But as you said, they are in different life space,
so I don't have a better method to dig the SRAT table.
If anyone have a good way or suggestion, please tell me.

Thanks,
Chao Fan

>to kernel decompressing looks messy. Is there better way to reuse ACPI
>code and read SRAT table, then get what we need in a simple way?
>
>Thanks
>Baoquan
>> 
>> ***Test results:
>>  - I did a very simple test, and it can get the memory information in
>>    bios and efi KVM guest machine, and put it by early printk. But no
>>    more tests, so it's with RFC tag.
>> 
>> Any comments will be welcome.
>> 
>> 
>> Chao Fan (4):
>>   x86/boot: Add acpitb.h to help parse acpi tables
>>   x86/boot: Add acpitb.c to parse acpi tables
>>   x86/boot/KASLR: Walk srat tables to filter immovable memory
>>   x86/boot/KASLR: Limit kaslr to choosing the immovable memory
>> 
>>  arch/x86/boot/compressed/Makefile |   1 +
>>  arch/x86/boot/compressed/acpitb.c | 245 ++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/acpitb.h | 175 +++++++++++++++++++++
>>  arch/x86/boot/compressed/kaslr.c  | 120 +++++++++++++--
>>  4 files changed, 530 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.c
>>  create mode 100644 arch/x86/boot/compressed/acpitb.h
>> 
>> -- 
>> 2.17.0
>> 
>> 
>> 
>
>


