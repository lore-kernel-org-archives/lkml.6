Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721E22080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721E22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJaRON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:14:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbeJaRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:14:13 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1D5F2325EA7D7;
        Wed, 31 Oct 2018 08:17:05 +0000 (GMT)
Received: from [10.204.65.163] (10.204.65.163) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 31 Oct
 2018 08:16:57 +0000
Subject: Re: [PATCH v3 5/5] tpm: ensure that output of PCR read contains the
 correct digest size
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
 <20181030154711.2782-6-roberto.sassu@huawei.com>
 <alpine.DEB.2.21.1810302151580.5058@jsakkine-mobl1>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <7adca046-ae80-7453-9fee-a802b46ceb86@huawei.com>
Date:   Wed, 31 Oct 2018 09:16:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810302151580.5058@jsakkine-mobl1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.163]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 8:52 PM, Jarkko Sakkinen wrote:
> On Tue, 30 Oct 2018, Roberto Sassu wrote:
>> This patch ensures that the digest size returned by the TPM during a PCR
>> read matches the size of the algorithm passed as argument to
>> tpm2_pcr_read(). The check is performed after information about the PCR
>> banks has been retrieved.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> What is the scenarion when this can happen (should be explained in
> the commit message)?

Without an HMAC session, the request/response payload can be modified.
This patch ensures that the digest size in the payload is equal to the
size of the algorithm specified by the caller.

Patch 3/5 only ensures that there is no buffer overflow when data is
copied to the tpm_digest structure passed by the caller.

Patch 5/5 uses the PCR bank information introduced in patch 4/5 to
ensure that the exact amount of data is copied from the response
payload. However, the patch may not help because an attacker can modify
the algorithm in the request payload so that the TPM returns a shorter
digest.

For me it is ok to remove this patch from the set. It was requested by
Mimi.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
