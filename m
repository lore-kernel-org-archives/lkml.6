Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80281C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4994920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLFSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:00:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbeLFSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:00:22 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 93FD3F312D033;
        Thu,  6 Dec 2018 18:00:18 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Dec
 2018 18:00:14 +0000
Subject: Re: [PATCH v6 5/7] tpm: retrieve digest size of unknown algorithms
 with PCR read
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-6-roberto.sassu@huawei.com>
 <20181204235354.GD1233@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ac404fdd-b673-eb49-d6e7-4fc6de561ce1@huawei.com>
Date:   Thu, 6 Dec 2018 19:00:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204235354.GD1233@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2018 12:53 AM, Jarkko Sakkinen wrote:
> On Tue, Dec 04, 2018 at 09:21:36AM +0100, Roberto Sassu wrote:
>> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
>> +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
>> +
>> +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
>> +			continue;
>> +
>> +		bank->digest_size = hash_digest_size[crypto_algo];
>> +		bank->crypto_id = crypto_algo;
>> +		return 0;
>> +	}
>> +
>> +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
>> +}
> 
> This is a part that I don't get. Coud you just always call
> tpm2_pcr_read() instead of this complexity

First, we avoid operations that may increase the boot time. Second, the
loop is necessary to obtain the crypto subsystem identifier from a TPM
algorithm identifier.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
