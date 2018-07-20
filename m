Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC37ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F9D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F9D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeGTKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:24:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32640 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727243AbeGTKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:24:42 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42477030"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Jul 2018 17:37:13 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 48E964B625E5;
        Fri, 20 Jul 2018 17:37:12 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 20 Jul 2018 17:37:11 +0800
Date:   Fri, 20 Jul 2018 17:35:24 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <mingo@redhat.com>, <bhe@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <lcapitulino@redhat.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Message-ID: <20180720093524.GB6739@localhost.localdomain>
References: <20180717100409.10547-1-fanc.fnst@cn.fujitsu.com>
 <20180717100409.10547-2-fanc.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1807191717330.1693@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807191717330.1693@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 48E964B625E5.A9DBD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:19:43PM +0200, Thomas Gleixner wrote:
>On Tue, 17 Jul 2018, Chao Fan wrote:
>
>> In order to parse ACPI tables, reuse the head file linux/acpi.h,
>> so that the files in 'compressed' directory can read ACPI table
>> by including this head file.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.h | 50 +++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.h
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
>> new file mode 100644
>> index 000000000000..fd2bba23f447
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpitb.h
>> @@ -0,0 +1,50 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <linux/acpi.h>
>> +
>> +#define ACPI_MAX_TABLES                128
>> +
>> +/* Function to get ACPI SRAT table pointer. */
>> +struct acpi_table_header *get_acpi_srat_table(void);
>> +
>> +#ifdef ACPI_BIG_ENDIAN
>> +
>> +#define ACPI_MOVE_64_TO_64(d, s) \
>> +{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7]; \
>> +((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6]; \
>> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5]; \
>> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4]; \
>> +((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3]; \
>> +((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2]; \
>> +((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1]; \
>> +((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>
>Whats wrong with be64_to_cpu() ?

Hi tglx,

Thanks for your review.
ACPI_MOVE_64_TO_64 and ACPI_MOVE_16_TO_32 are copied from arch/x86/boot/compressed/acpitb.h
cause I though copying the old code is reliable.
I will delete these two definitions and only using le64_to_cpu and
le16_to_cpu may be enough(since ACPI table is in little endian).
And also add more comments in next version.

Thanks,
Chao Fan

>
>> +
>> +#define ACPI_MOVE_16_TO_32(d, s) \
>> +{(*(u32 *)(void *)(d)) = 0; \
>> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1]; \
>> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
>
>Huch? 
>
>> +
>> +#else
>> +#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
>> +
>> +#define ACPI_MOVE_64_TO_64(d, s) \
>> +{*(u64 *)(void *)(d) = *(u64 *)(void *)(s); }
>> +
>> +#define ACPI_MOVE_16_TO_32(d, s) \
>> +{*(u32 *)(void *)(d) = *(u16 *)(void *)(s); }
>> +
>> +#else
>> +#define ACPI_MOVE_64_TO_64(d, s) \
>> +{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0]; \
>> +((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; \
>> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2]; \
>> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; \
>> +((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4]; \
>> +((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5]; \
>> +((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6]; \
>> +((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
>
>And why doees this have to be done bytewise? Some comments would be
>helpful.
>
>Thanks,
>
>	tglx
>
>


