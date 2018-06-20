Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F858C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF6C20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF6C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754904AbeFTTep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754557AbeFTTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:34:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KJSrsk037981
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:34:42 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqw3fg81r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:34:42 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 13:34:41 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 13:34:38 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KJYbZl1704304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 12:34:37 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FAABE058;
        Wed, 20 Jun 2018 13:34:37 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B03FBE053;
        Wed, 20 Jun 2018 13:34:37 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 13:34:36 -0600 (MDT)
Subject: Re: [PATCH 1/6] tpm: Introduce a kref for the tpm_chip
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
 <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
 <20180620183854.GC27445@ziepe.ca>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Wed, 20 Jun 2018 15:34:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620183854.GC27445@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18062019-0036-0000-0000-00000A0185E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049847; UDB=6.00537972; IPR=6.00828819;
 MB=3.00021764; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 19:34:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062019-0037-0000-0000-000047CF6A46
Message-Id: <0d37dbe0-d0f4-da13-ffa4-4f00d3542390@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 02:38 PM, Jason Gunthorpe wrote:
> On Wed, Jun 20, 2018 at 12:19:43PM -0400, Stefan Berger wrote:
>> Introduce a kref for the tpm_chip that we initialize when the tpm_chip has
>> been allocated and release before the tpm_chip is to be freed.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>   drivers/char/tpm/tpm-chip.c | 24 +++++++++++++++++++-----
>>   drivers/char/tpm/tpm.h      |  1 +
>>   2 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 0a62c19937b6..a933676194a4 100644
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -119,8 +119,24 @@ struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
>>   	return res;
>>   }
>>   
>> +static void tpm_chip_free(struct kref *kref)
>> +{
>> +	struct tpm_chip *chip = container_of(kref, struct tpm_chip, kref);
>> +
>> +	kfree(chip->log.bios_event_log);
>> +	kfree(chip->work_space.context_buf);
>> +	kfree(chip->work_space.session_buf);
>> +	kfree(chip);
>> +}
>> +
>> +static void tpm_chip_put(struct tpm_chip *chip)
>> +{
>> +	if (chip)
>> +		kref_put(&chip->kref, tpm_chip_free);
>> +}
>> +
>>   /**
>> - * tpm_dev_release() - free chip memory and the device number
>> + * tpm_dev_release() - free the device number and release reference to chip
>>    * @dev: the character device for the TPM chip
>>    *
>>    * This is used as the release function for the character device.
>> @@ -133,10 +149,7 @@ static void tpm_dev_release(struct device *dev)
>>   	idr_remove(&dev_nums_idr, chip->dev_num);
>>   	mutex_unlock(&idr_lock);
>>   
>> -	kfree(chip->log.bios_event_log);
>> -	kfree(chip->work_space.context_buf);
>> -	kfree(chip->work_space.session_buf);
>> -	kfree(chip);
>> +	tpm_chip_put(chip);
>>   }
>>   static void tpm_devs_release(struct device *dev)
>> @@ -195,6 +208,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>   
>>   	mutex_init(&chip->tpm_mutex);
>>   	init_rwsem(&chip->ops_sem);
>> +	kref_init(&chip->kref);
>>   
>>   	chip->ops = ops;
>>   
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 7f2d0f489e9c..098d7dcc04a4 100644
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -211,6 +211,7 @@ struct tpm_chip {
>>   	struct cdev cdev;
>>   	struct cdev cdevs;
>>   
>> +	struct kref kref;
> NAK, there is already a kref in struct device, that one must be used.

Right. Should make it simpler...


>
> Jason
>

