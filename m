Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16207C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA1E21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA1E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeGLQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:14:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbeGLQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:14:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CFwV6x104537
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:04:00 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k68ym3gus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:04:00 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 12 Jul 2018 10:03:59 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 10:03:54 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CG3pn01900914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 09:03:51 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217DEC6055;
        Thu, 12 Jul 2018 10:03:51 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6133C6059;
        Thu, 12 Jul 2018 10:03:47 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.152.224.124])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 10:03:47 -0600 (MDT)
Subject: Re: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open
 callback
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
 <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
 <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 12 Jul 2018 18:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071216-0004-0000-0000-000014626202
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009357; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060327; UDB=6.00544263; IPR=6.00838245;
 MB=3.00022118; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 16:03:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071216-0005-0000-0000-000088103D1B
Message-Id: <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 02:47 PM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> Implements the open callback on the mediated matrix device.
>> The function registers a group notifier to receive notification
>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>> the vfio_ap device driver will get access to the guest's
>> kvm structure. The open callback must ensure that only one
>> mediated device shall be opened per guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     |  128 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>>   2 files changed, 130 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index bc7398d..58be495 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -11,6 +11,10 @@
>>   #include <linux/device.h>
>>   #include <linux/list.h>
>>   #include <linux/ctype.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/module.h>
>> +#include <asm/kvm.h>
>>     #include "vfio_ap_private.h"
>>   @@ -748,12 +752,136 @@ static ssize_t matrix_show(struct device 
>> *dev, struct device_attribute *attr,
>>       NULL
>>   };
>>   +/**
>> + * Verify that the AP instructions are available on the guest and 
>> are to be
>> + * interpreted by the firmware. The former is indicated via the
>> + * KVM_S390_VM_CPU_FEAT_AP CPU model feature and the latter by apie 
>> crypto
>> + * flag.
>> + */
>> +static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>> +{
>> +    if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat) &&
>> +        kvm->arch.crypto.apie)
>> +        return 0;
>> +
>> +    pr_err("%s: interpretation of AP instructions not available",
>> +           VFIO_AP_MODULE_NAME);
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>> +                       unsigned long action, void *data)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
>> +        matrix_mdev = container_of(nb, struct ap_matrix_mdev,
>> +                       group_notifier);
>> +        matrix_mdev->kvm = data;
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>
> [..]
>
>> +
>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    struct ap_matrix_dev *matrix_dev =
>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>> +    unsigned long events;
>> +    int ret;
>> +
>> +    if (!try_module_get(THIS_MODULE))
>> +        return -ENODEV;
>> +
>> +    ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
>> +                         &matrix_mdev->matrix);
>> +    if (ret)
>> +        goto out_err;
>> +
>> +    matrix_mdev->group_notifier.notifier_call = 
>> vfio_ap_mdev_group_notifier;
>> +    events = VFIO_GROUP_NOTIFY_SET_KVM;
>> +
>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                     &events, &matrix_mdev->group_notifier);
>> +    if (ret)
>> +        goto out_err;
>> +
>> +    ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>
> At this point you assume that your vfio_ap_mdev_group_notifier callback
> was called with VFIO_GROUP_NOTIFY_SET_KVM and that you do have
> matrix_mdev->kvm set up properly.
>
> Based on how callbacks usually work this seems rather strange. It's
> probably cleaner to set up he cyrcb (including all the validation
> that needs to be done immediately before) in the callback
> (vfio_ap_mdev_group_notifier).
>
> If that is not viable I think we need a comment here explaining why is 
> this
> OK (at least).

This was originally in the callback and moved out, to the best of my 
recollection,
because the validation at that time was done on the CRYCB and if that 
validation
failed, there was no way to notify the client (QEMU) that configuration 
of the
guest's CRYCB failed from the notification callback. This works - at 
least as far
as I can tell from testing - because the registration of the notifier 
invokes the
notification callback if KVM has already been set and that appears to be 
the case.
You are correct, however; we probably shouldn't bank on that given that
I don't think we can guarantee that to be the case 100% of the time. 
Consequently,
I will move this back into the notification callback and since 
consistency checking
is now being done on the mdev devices instead of the CRYCB, we don't 
need KVM at open
time.

>
>
> Regards,
> Halil
>
>> +    if (ret)
>> +        goto out_kvm_err;
>> +
>> +    ret = vfio_ap_mdev_open_once(matrix_mdev);
>> +    if (ret)
>> +        goto out_kvm_err;
>> +
>> +    return 0;
>> +
>> +out_kvm_err:
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                 &matrix_mdev->group_notifier);
>> +    matrix_mdev->kvm = NULL;
>> +out_err:
>> +    module_put(THIS_MODULE);
>> +
>> +    return ret;
>> +}
>> +
>>
>
> [..]


