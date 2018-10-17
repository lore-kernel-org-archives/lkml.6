Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E1BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046A821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A821526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJQXI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:08:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbeJQXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:08:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HF9UhU135835
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:12:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n64rrrr50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:12:10 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 17 Oct 2018 11:10:34 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 11:10:30 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HFAT4C2162964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 15:10:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FB87AC065;
        Wed, 17 Oct 2018 15:10:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06515AC075;
        Wed, 17 Oct 2018 15:10:26 +0000 (GMT)
Received: from [9.79.213.117] (unknown [9.79.213.117])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 15:10:25 +0000 (GMT)
Subject: Re: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation to
 tpm1-cmd.c
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
 <20181017064613.19746-4-tomas.winkler@intel.com>
 <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F4691@hasmsx109.ger.corp.intel.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Wed, 17 Oct 2018 20:37:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9F4691@hasmsx109.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101715-0052-0000-0000-0000034522E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009892; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104018; UDB=6.00571503; IPR=6.00884070;
 MB=3.00023795; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 15:10:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101715-0053-0000-0000-00005E723821
Message-Id: <650c00b1-d53e-27e8-3e1f-94e34c2ae2e9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 05:54 PM, Winkler, Tomas wrote:
>>
>>>    	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
>>> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
>>> -					     tpm_calc_ordinal_duration(chip,
>>> -								       ordinal),
>>> -					     &priv->read_queue);
>>> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
>>
>> This version of the patch didn't address my previous comment - "The original
>> code in the nuvoton driver does not differentiate between TPM 1.2 and TPM
>> 2.0 as it does in tpm_tis_core.c.
>> Before making any changes, I would first fix it, so that it could easily be
>> backported. Only then do the refactoring."
> This patch doesn't change the original behavior, just change the name of the function,  so there is no regression.
> I would suggest there is another bug in those drivers/devices that is orthogonal to this refactoring and should not block this from merging.

The problem is that you are inadvertently fixing a bug without realizing 
it - [Patch 04/20]. Bug fixes should be addressed independently
of this change, so that they can be backported properly.

> According to what you say  it can call just tpm_calc_oridnal_duration() instead of tpm1_calc_ordinal_duration(chip, ordinal),
> but I prefer that someone that has those devices will do that change on top of this series as  I cannot test it.

The problem is:

1. This patch calls tpm1_calc_ordinal_duration for both the TPM 1.2 and 
TPM 2.0.
2. In the next patch, it adds a new function tpm_calc_ordinal_duration 
as a wrapper for both the TPM 1.2 and TPM 2.0. After this change when it 
calls tpm_calc_ordinal_duration(),
it now calls different functions for TPM 1.2 and TPM 2.0. This is a 
change in behavior.

Thanks & Regards,
    - Nayna

> Thanks
> Tomas
>

