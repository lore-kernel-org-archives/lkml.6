Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4010BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B6B248B3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B6B248B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933444AbeFVUpy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:45:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932918AbeFVUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:45:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKchB4107366
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:45:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js4ef8dp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:45:52 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 16:45:51 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 16:45:48 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MKjlLw17170776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 20:45:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32D5A112063;
        Fri, 22 Jun 2018 16:45:44 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 201D9112061;
        Fri, 22 Jun 2018 16:45:44 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 16:45:44 -0400 (EDT)
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
 <20180622204319.GE19151@ziepe.ca>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Fri, 22 Jun 2018 16:45:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622204319.GE19151@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18062220-0060-0000-0000-0000028151F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009242; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050831; UDB=6.00538563; IPR=6.00829801;
 MB=3.00021811; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 20:45:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062220-0061-0000-0000-0000458ADB47
Message-Id: <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 04:43 PM, Jason Gunthorpe wrote:
> On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
>> Implement tpm_chip_find() for other subsystems to find a TPM chip and
>> get a reference to that chip.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>   drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
>>   include/linux/tpm.h         |  5 +++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 4e83695af068..2520555b1e17 100644
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
>>   EXPORT_SYMBOL_GPL(tpm_put_ops);
>>   
>>   /**
>> + * tpm_chip_find() - find a TPM chip and get a reference to it
>> + */
>> +struct tpm_chip *tpm_chip_find(void)
> I feel like this should be called 'tpm_default_chip()'
>
>> +{
>> +	struct tpm_chip *chip, *res = NULL;
>> +	int chip_num = 0;
>> +	int chip_prev;
>> +
>> +	mutex_lock(&idr_lock);
>> +
>> +	do {
>> +		chip_prev = chip_num;
>> +		chip = idr_get_next(&dev_nums_idr, &chip_num);
>> +		if (chip) {
>> +			get_device(&chip->dev);
>> +			res = chip;
>> +			break;
>> +		}
>> +	} while (chip_prev != chip_num);
>> +
>> +	mutex_unlock(&idr_lock);
> And what was tpm_chip_find_get should just call this function..
And then after that each time tpm_get_ops() ?
>
> Jason
>

