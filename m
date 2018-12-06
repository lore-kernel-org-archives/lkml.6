Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C2C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38DB20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38DB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLFR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:56:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeLFR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:56:48 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 18EBEF501A0BE;
        Thu,  6 Dec 2018 17:56:43 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Dec
 2018 17:56:33 +0000
Subject: Re: [PATCH v6 1/7] tpm: dynamically allocate the allocated_banks
 array
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-2-roberto.sassu@huawei.com>
 <20181204231848.GA1233@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9193bc05-8222-f0d6-9ad8-a2a7eaf1a34c@huawei.com>
Date:   Thu, 6 Dec 2018 18:56:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204231848.GA1233@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2018 12:18 AM, Jarkko Sakkinen wrote:
> On Tue, Dec 04, 2018 at 09:21:32AM +0100, Roberto Sassu wrote:
>> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
>> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
>> TPM2_Get_Capability(). One PCR bank with algorithm set to SHA1 is always
>> allocated for TPM 1.x.
> 
> ...
> 
>> +		for (j = 0; j < pcr_selection.size_of_select; j++)
>> +			if (pcr_selection.pcr_select[j])
>> +				break;
>> +
>> +		if (j < pcr_selection.size_of_select) {
>> +			chip->allocated_banks[nr_alloc_banks] = hash_alg;
>> +			nr_alloc_banks++;
>> +		}
>> +
> 
> Why was this needed? Can CAP_PCRS return completely unallocated banks?

This was discussed for patch v4 1/6:
---

Nayna wrote:

# /usr/local/bin/tssgetcapability -cap 5
2 PCR selections
     hash TPM_ALG_SHA1
     TPMS_PCR_SELECTION length 3
     ff ff ff
     hash TPM_ALG_SHA256
     TPMS_PCR_SELECTION length 3
     00 00 00

The pcr_select fields - "ff ff ff" and "00 00 00" - are bit masks for
the enabled PCRs. The SHA1 bank is enabled for all PCRs (0-23), while
the SHA256 bank is not enabled.
---

> Kind of out-of-context for the rest of the changes.
> 
> Should this be a bug fix of its own because it looks like as this is a
> bug fix for existing code, and not a new feature? Just asking because
> I don't yet fully understand this change.

If we store in tpm_chip the possible banks, IMA would calculate more
digests unnecessarily. But this problem does not happen without my patch
set, because tpm_pcr_extend() only accepts a SHA1 digest.


> Anyway, I believe that you can streamline this by:
> 
> /* Check that at least some of the PCRs have been allocated. This is
>   * required because CAP_PCRS ...
>   */
> if (memchr_inv(pcr_selection.pcr_select, 0, pcr_selection.size_of_select))
> 	nr_allocated_banks++;
> 
> [yeah, comment would be awesome about CAP_PCRS. Did not finish up the
> comment because I don't know the answer]
> 
> In addition, it would be consistent to call the local variable also
> nr_allocated_banks (not nr_alloc_banks).

Unfortunately, I exceed the limit of characters per line.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
