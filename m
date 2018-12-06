Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3FC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A65F20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A65F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLFSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:38:39 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbeLFSij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:38:39 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9A066FCF10B52;
        Thu,  6 Dec 2018 18:38:35 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Dec
 2018 18:38:30 +0000
Subject: Re: [PATCH v6 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-8-roberto.sassu@huawei.com>
 <20181205001417.GF1233@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9d6e47d9-3b88-86f6-1b60-6652dfe8dc00@huawei.com>
Date:   Thu, 6 Dec 2018 19:38:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205001417.GF1233@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2018 1:14 AM, Jarkko Sakkinen wrote:
> On Tue, Dec 04, 2018 at 09:21:38AM +0100, Roberto Sassu wrote:
>> The new tpm_bank_list structure has been preferred to the tpm_digest
>> structure, to let the caller specify the size of the digest (which may be
>> unknown to the TPM driver).
> 
> Why is that? Didn't previous commit query these?

Since the TPM driver pads/truncates the first digest passed by the
caller to extend PCRs for which no digest was provided, it must know
which amount of data it can use. It is possible that the algorithm of
the first digest is unknown for the TPM driver, if the caller of
tpm_pcr_extend() didn't check chip->allocated_banks.

By requiring that the caller passes also the digest size, this problem
does not arise. It seems reasonable to me to pass this information, as
the caller calculated the digest and it should know the digest size.

Roberto


>> +struct tpm_bank_list {
>> +	u16 alg_id;
>> +	u16 extend_size;
>> +	const u8 *extend_array;
>> +};
> 
> Naming is not good here. If this only for extending shouldn't that
> be in the structs name?
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
