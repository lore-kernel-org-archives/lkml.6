Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3BC20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3BC20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeGLOoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:44:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732302AbeGLOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:44:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CEOSs1081327
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:34:13 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k65etu0kh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:34:13 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 12 Jul 2018 08:34:12 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 08:34:08 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CEY5iP5898588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 07:34:05 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64A23C6055;
        Thu, 12 Jul 2018 08:34:05 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BCEC6059;
        Thu, 12 Jul 2018 08:34:01 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.152.224.124])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 08:34:01 -0600 (MDT)
Subject: Re: [PATCH v6 09/21] s390: vfio-ap: structure for storing mdev matrix
To:     Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <8a708a2e-3961-bd0c-9354-705070ada83d@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 12 Jul 2018 16:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <8a708a2e-3961-bd0c-9354-705070ada83d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071214-0004-0000-0000-000014625997
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009357; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060296; UDB=6.00544245; IPR=6.00838215;
 MB=3.00022117; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 14:34:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071214-0005-0000-0000-0000881002CD
Message-Id: <9338b672-d907-3ca2-9afa-974a2caf4bb1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 04:26 PM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces a new structure for storing the AP matrix configured
>> for the mediated matrix device via its sysfs attributes files.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     |   12 ++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   24 ++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 4e61e33..bf7ed9f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -20,6 +20,17 @@
>>   DEFINE_SPINLOCK(mdev_list_lock);
>>   LIST_HEAD(mdev_list);
>>
>> +static void vfio_ap_matrix_init(struct ap_matrix *matrix)
>> +{
>> +    /* Test if PQAP(QCI) instruction is available */
>> +    if (test_facility(12))
>> +        ap_qci(&matrix->info);
>> +
>> +    matrix->apm_max = matrix->info.apxa ? matrix->info.Na : 63;
>> +    matrix->aqm_max = matrix->info.apxa ? matrix->info.Nd : 15;
>> +    matrix->adm_max = matrix->info.apxa ? matrix->info.Nd : 15;
>> +}
>> +
>>   static int vfio_ap_mdev_create(struct kobject *kobj, struct 
>> mdev_device *mdev)
>>   {
>>       struct ap_matrix_dev *matrix_dev =
>> @@ -31,6 +42,7 @@ static int vfio_ap_mdev_create(struct kobject 
>> *kobj, struct mdev_device *mdev)
>>           return -ENOMEM;
>>
>>       matrix_mdev->name = dev_name(mdev_dev(mdev));
>> +    vfio_ap_matrix_init(&matrix_mdev->matrix);
>>       mdev_set_drvdata(mdev, matrix_mdev);
>>
>>       if (atomic_dec_if_positive(&matrix_dev->available_instances) < 
>> 0) {
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 3de1275..ae771f5 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -29,9 +29,33 @@ struct ap_matrix_dev {
>>       atomic_t available_instances;
>>   };
>>
>> +/**
>> + * The AP matrix is comprised of three bit masks identifying the 
>> adapters,
>> + * queues (domains) and control domains that belong to an AP matrix. 
>> The bits i
>> + * each mask, from least significant to most significant bit, 
>> correspond to IDs
>> + * 0 to 255. When a bit is set, the corresponding ID belongs to the 
>> matrix.
>> + *
>> + * @apm identifies the AP adapters in the matrix
>> + * @apm_max: max adapter number in @apm
>> + * @aqm identifies the AP queues (domains) in the matrix
>> + * @aqm_max: max domain number in @aqm
>> + * @adm identifies the AP control domains in the matrix
>> + * @adm_max: max domain number in @adm
>> + */
>> +struct ap_matrix {
>> +    unsigned long apm_max;
>> +    DECLARE_BITMAP(apm, 256);
>> +    unsigned long aqm_max;
>> +    DECLARE_BITMAP(aqm, 256);
>> +    unsigned long adm_max;
>> +    DECLARE_BITMAP(adm, 256);
>> +    struct ap_config_info info;
>
> Why do we maintain (and populate by doing a QCI) the info member on a
> per mdev device basis?

That is a mistake, I am going to move it to struct ap_matrix_dev and
execute the QCI instruction when the matrix device is registered
with mdev during driver initialization.

>
>
>> +};
>> +
>>   struct ap_matrix_mdev {
>>       const char *name;
>>       struct list_head list;
>> +    struct ap_matrix matrix;
>>   };
>>
>>   static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
>>
>

