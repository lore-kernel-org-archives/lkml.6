Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD7820817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD7820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKIA2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:28:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeKIA2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:28:31 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E4E47B166B2FB;
        Thu,  8 Nov 2018 14:52:35 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 8 Nov
 2018 14:52:29 +0000
Subject: Re: [PATCH v4 2/6] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-3-roberto.sassu@huawei.com>
 <20181108140208.GC8922@linux.intel.com>
 <20181108140318.GD8922@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <624865ac-a410-00f0-43b7-5ee5bc324b1f@huawei.com>
Date:   Thu, 8 Nov 2018 15:52:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108140318.GD8922@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 3:03 PM, Jarkko Sakkinen wrote:
> On Thu, Nov 08, 2018 at 04:02:08PM +0200, Jarkko Sakkinen wrote:
>> On Tue, Nov 06, 2018 at 04:01:55PM +0100, Roberto Sassu wrote:
>>> tcg_efi_specid_event and tcg_pcr_event2 declaration contains static arrays
>>> for a list of hash algorithms used for event logs and event log digests.
>>> However, according to TCG EFI Protocol Specification, these arrays have
>>> variable sizes and are not suitable for parsing events with type casting.
>>>
>>> Since declaring static arrays with hard-coded sizes does not help to parse
>>> data after these arrays, this patch removes the declaration of
>>> TPM2_ACTIVE_PCR_BANKS and sets the size of the arrays above to zero.
>>>
>>> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware
>>> event log")
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>   include/linux/tpm_eventlog.h | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
>>> index 20d9da77fc11..3d5d162f09cc 100644
>>> --- a/include/linux/tpm_eventlog.h
>>> +++ b/include/linux/tpm_eventlog.h
>>> @@ -8,7 +8,6 @@
>>>   #define TCG_EVENT_NAME_LEN_MAX	255
>>>   #define MAX_TEXT_EVENT		1000	/* Max event string length */
>>>   #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
>>> -#define TPM2_ACTIVE_PCR_BANKS	3
>>>   
>>>   #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
>>>   #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
>>> @@ -90,7 +89,7 @@ struct tcg_efi_specid_event {
>>>   	u8 spec_errata;
>>>   	u8 uintnsize;
>>>   	u32 num_algs;
>>> -	struct tcg_efi_specid_event_algs digest_sizes[TPM2_ACTIVE_PCR_BANKS];
>>> +	struct tcg_efi_specid_event_algs digest_sizes[0];
>>>   	u8 vendor_info_size;
>>>   	u8 vendor_info[0];
>>>   } __packed;
>>> @@ -117,7 +116,7 @@ struct tcg_pcr_event2 {
>>>   	u32 pcr_idx;
>>>   	u32 event_type;
>>>   	u32 count;
>>> -	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
>>> +	struct tpm2_digest digests[0];
>>>   	struct tcg_event_field event;
>>
>> Last two fields make sense at least without comment as they overlap.
> 
> i.e. would be semantically equal to
> 
> union {
> 	struct tpm2_digest digests[0];
> 	struct tcg_event_field event;
> };

I didn't understand. Should I add the union?

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
