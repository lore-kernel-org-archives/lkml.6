Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70451C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2866B21723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2866B21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbeHCDy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:54:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31733 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731925AbeHCDy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:54:56 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43010361"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2018 10:00:50 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id C791E4B6ADE8;
        Fri,  3 Aug 2018 10:00:50 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 3 Aug 2018 10:00:54 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 2/4] x86/boot: Add acpitb.c to parse acpi tables
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-3-fanc.fnst@cn.fujitsu.com>
Message-ID: <694e364b-f94d-662e-f30f-ac65fb920548@cn.fujitsu.com>
Date:   Fri, 3 Aug 2018 10:00:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180723092908.32656-3-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C791E4B6ADE8.AD1D7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 07/23/2018 05:29 PM, Chao Fan wrote:
> Imitate the ACPI code to parse ACPI tables. Functions are simplified
> cause some operations are not needed here.
> And also, this method won't influence the initialization of ACPI.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>

Hi Fan,

I know you got the code from acpica subsystem and EFI code... and do
many adaptation work for KASLR. It's awesome!

I think you can add some other simple comments.

   - what differences between your function and the function you based on
     and why did you do that?

... to make this more credible and easy to remember the details as time
goes on.

Also some concerns below.
> ---
[...]
> +	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
> +		efi_64 = false;
> +	else {
> +		debug_putstr("Wrong efi loader signature.\n");

s/efi/EFI/, also need fix in the comments below.

> +		return false;
> +	}
> +
[...]
> +		/*
> +		 * Get rsdp from efi tables.
> +		 * If we find acpi table, go on searching for acpi20 table.
> +		 * If we didn't get acpi20 table then use acpi table.
> +		 * If neither acpi table nor acpi20 table found,
> +		 * return false.
> +		 */
> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)) && !acpi_20) {
> +			*rsdp_addr = (acpi_physical_address)table;
> +			acpi_20 = false;
> +			find_rsdp = true;
> +		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
> +			*rsdp_addr = (acpi_physical_address)table;
> +			acpi_20 = true;
> +			return true;

If we find the ACPI 2.0, we will return immediately, so the variable and
logic of _acpi_20_ is redundant.

Thanks,
	dou


