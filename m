Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F71D2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F71D2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHCEFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:05:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47917 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725736AbeHCEFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:05:02 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43011133"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2018 10:11:00 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 8A9114B6ADE7;
        Fri,  3 Aug 2018 10:10:57 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 3 Aug 2018 10:10:59 +0800
Date:   Fri, 3 Aug 2018 10:08:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Dou Liyang <douly.fnst@cn.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 2/4] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20180803020844.GF6723@localhost.localdomain>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-3-fanc.fnst@cn.fujitsu.com>
 <694e364b-f94d-662e-f30f-ac65fb920548@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <694e364b-f94d-662e-f30f-ac65fb920548@cn.fujitsu.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 8A9114B6ADE7.AC38E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:00:48AM +0800, Dou Liyang wrote:
>
>
>At 07/23/2018 05:29 PM, Chao Fan wrote:
>> Imitate the ACPI code to parse ACPI tables. Functions are simplified
>> cause some operations are not needed here.
>> And also, this method won't influence the initialization of ACPI.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>
>Hi Fan,
>
>I know you got the code from acpica subsystem and EFI code... and do
>many adaptation work for KASLR. It's awesome!
>
>I think you can add some other simple comments.
>
>  - what differences between your function and the function you based on
>    and why did you do that?
>
>... to make this more credible and easy to remember the details as time
>goes on.

That's a good idea, will add more comments.

>
>Also some concerns below.
>> ---
>[...]
>> +	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
>> +		efi_64 = false;
>> +	else {
>> +		debug_putstr("Wrong efi loader signature.\n");
>
>s/efi/EFI/, also need fix in the comments below.
>
>> +		return false;
>> +	}
>> +
>[...]
>> +		/*
>> +		 * Get rsdp from efi tables.
>> +		 * If we find acpi table, go on searching for acpi20 table.
>> +		 * If we didn't get acpi20 table then use acpi table.
>> +		 * If neither acpi table nor acpi20 table found,
>> +		 * return false.
>> +		 */
>> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)) && !acpi_20) {
>> +			*rsdp_addr = (acpi_physical_address)table;
>> +			acpi_20 = false;
>> +			find_rsdp = true;
>> +		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
>> +			*rsdp_addr = (acpi_physical_address)table;
>> +			acpi_20 = true;
>> +			return true;
>
>If we find the ACPI 2.0, we will return immediately, so the variable and
>logic of _acpi_20_ is redundant.

I will check the logical and fix the mistake.

Thanks,
Chao Fan

>
>Thanks,
>	dou


