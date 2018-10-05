Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA81C65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJFAri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:47:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727941AbeJFArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:47:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95HiQBV016637
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 13:47:51 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxaevp9jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:47:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 13:47:49 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 13:47:46 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95HljZN28704842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 17:47:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 941F9112061;
        Fri,  5 Oct 2018 13:47:08 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9960112063;
        Fri,  5 Oct 2018 13:47:05 -0400 (EDT)
Received: from [9.124.221.60] (unknown [9.124.221.60])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 13:47:05 -0400 (EDT)
Subject: Re: [PATCH v4 5/6] ima: add support for external setting of
 ima_appraise
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
 <20180926122210.14642-6-nayna@linux.vnet.ibm.com>
 <1538054412.3459.105.camel@linux.ibm.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Fri, 5 Oct 2018 23:14:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1538054412.3459.105.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100517-0064-0000-0000-0000035ABB7B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098325; UDB=6.00568080; IPR=6.00878365;
 MB=3.00023631; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 17:47:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100517-0065-0000-0000-00003AE1585C
Message-Id: <0c0c392b-e5c8-d875-4526-01ff6ff32a81@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2018 06:50 PM, Mimi Zohar wrote:
> Hi Nayna,
>
> On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:
>> The "ima_appraise" mode defaults to enforcing, unless configured to allow
>> the boot command line "ima_appraise" option. This patch explicitly sets the
>> "ima_appraise" mode for the arch specific policy setting.
> Eventually this patch might be needed if/when we need to differentiate
> between different secure boot modes.
>
> Only if CONFIG_IMA_APPRAISE_BOOTPARAM is enabled, can the IMA appraise
> mode be modified on the boot command line.  Instead of this patch, how
> about making the ability to change the IMA appraise mode also
> dependent on CONFIG_IMA_ARCH_POLICY not being enabled?

Yes, I did this change. I also included other feedback and posted as v5 
version.

Thanks Mimi for all the feedback.

Thanks & Regards,
     - Nayna


>
> Mimi
>
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> ---
>>   security/integrity/ima/ima.h          |  5 +++++
>>   security/integrity/ima/ima_appraise.c | 11 +++++++++--
>>   security/integrity/ima/ima_policy.c   |  5 ++++-
>>   3 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 588e4813370c..6e5fa7c42809 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -248,6 +248,7 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>>   				 int xattr_len);
>>   int ima_read_xattr(struct dentry *dentry,
>>   		   struct evm_ima_xattr_data **xattr_value);
>> +void set_ima_appraise(char *str);
>>   
>>   #else
>>   static inline int ima_appraise_measurement(enum ima_hooks func,
>> @@ -290,6 +291,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
>>   	return 0;
>>   }
>>   
>> +static inline void set_ima_appraise(char *str)
>> +{
>> +}
>> +
>>   #endif /* CONFIG_IMA_APPRAISE */
>>   
>>   /* LSM based policy rules require audit */
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index 8bd7a0733e51..e061613bcb87 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -18,15 +18,22 @@
>>   
>>   #include "ima.h"
>>   
>> -static int __init default_appraise_setup(char *str)
>> +void set_ima_appraise(char *str)
>>   {
>> -#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>>   	if (strncmp(str, "off", 3) == 0)
>>   		ima_appraise = 0;
>>   	else if (strncmp(str, "log", 3) == 0)
>>   		ima_appraise = IMA_APPRAISE_LOG;
>>   	else if (strncmp(str, "fix", 3) == 0)
>>   		ima_appraise = IMA_APPRAISE_FIX;
>> +	else if (strncmp(str, "enforce", 7) == 0)
>> +		ima_appraise = IMA_APPRAISE_ENFORCE;
>> +}
>> +
>> +static int __init default_appraise_setup(char *str)
>> +{
>> +#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>> +	set_ima_appraise(str);
>>   #endif
>>   	return 1;
>>   }
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 5fb4b0c123a3..410fee31b162 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -585,9 +585,12 @@ void __init ima_init_policy(void)
>>   	arch_entries = ima_init_arch_policy();
>>   	if (!arch_entries)
>>   		pr_info("No architecture policies found\n");
>> -	else
>> +	else {
>>   		add_rules(arch_policy_entry, arch_entries,
>>   			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
>> +		if (temp_ima_appraise)
>> +			set_ima_appraise("enforce");
>> +	}
>>   
>>   	/*
>>   	 * Insert the builtin "secure_boot" policy rules requiring file

