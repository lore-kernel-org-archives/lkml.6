Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01147C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5121502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C5121502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeHOVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbeHOVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:14:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FIJttX119270
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 14:21:38 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kvpysx08x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 14:21:38 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 15 Aug 2018 12:21:37 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Aug 2018 12:21:34 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7FILVEe5702014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Aug 2018 11:21:31 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22EE4136051;
        Wed, 15 Aug 2018 12:21:31 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6433F136055;
        Wed, 15 Aug 2018 12:21:28 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.175.5])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Aug 2018 12:21:28 -0600 (MDT)
Subject: Re: [PATCH v9 15/22] s390: vfio-ap: implement mediated device open
 callback
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815180814.5985e3f0.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 15 Aug 2018 14:21:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180815180814.5985e3f0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081518-0036-0000-0000-00000A236849
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009550; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073974; UDB=6.00553417; IPR=6.00853933;
 MB=3.00022737; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-15 18:21:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081518-0037-0000-0000-00004897FDEE
Message-Id: <2ba3a6d9-37ef-c614-3525-5f6f3d2c1c2d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 12:08 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:12 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Implements the open callback on the mediated matrix device.
>> The function registers a group notifier to receive notification
>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>> the vfio_ap device driver will get access to the guest's
>> kvm structure. The open callback must ensure that only one
>> mediated device shall be opened per guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     |  174 ++++++++++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>>   2 files changed, 175 insertions(+), 1 deletions(-)
>> @@ -602,7 +633,6 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   DEVICE_ATTR_RO(matrix);
>>   
>> -
> Nit: whitespace change

A nit, but somebody else will point it out too, so I will fix it.

>
>>   static struct attribute *vfio_ap_mdev_attrs[] = {
>>   	&dev_attr_assign_adapter.attr,
>>   	&dev_attr_unassign_adapter.attr,
> (...)
>
>> +/**
>> + * vfio_ap_mdev_open_once
>> + *
>> + * @matrix_mdev: a mediated matrix device
>> + *
>> + * Return 0 if no other mediated matrix device has been opened for the
>> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
>> + */
>> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
>> +				  struct kvm *kvm)
> You're passing kvm in here, but do not use it.

I'll fix it.

>
>> +{
>> +	struct ap_matrix_mdev *m;
>> +
>> +	mutex_lock(&matrix_dev.lock);
>> +
>> +	list_for_each_entry(m, &matrix_dev.mdev_list, list) {
>> +		if ((m != matrix_mdev) && (m->kvm == matrix_mdev->kvm)) {
> If you used it here instead of matrix_mdev->kvm...

I believe that was the case in a previous patch, but for some reason the 
code
was changed. I'll rework this so it uses the kvm param instead.

>
>> +			mutex_unlock(&matrix_dev.lock);
>> +			return -EPERM;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>> +				       unsigned long action, void *data)
>> +{
>> +	int ret;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>> +		return NOTIFY_OK;
>> +
>> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>> +
>> +	matrix_mdev->kvm = data;
>> +	if (data == NULL)
>> +		return NOTIFY_OK;
>> +
>> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
> ...you could move this up to before overwriting matrix_mdev->kvm and
> bailing out when the check failed, which makes more sense to me.

That makes more sense to me too. Don't set matrix_mdev->kvm until we
know it is okay to do so.

>
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>> +	if (ret)
>> +		return ret;
> It probably makes more sense to return NOTIFY_DONE in the error case
> (NOTIFY_BAD does not sound like a good idea as it would stop processing
> the notifier chain).

Will do.

>
>> +
>> +	vfio_ap_mdev_copy_masks(matrix_mdev);
>> +
>> +	return NOTIFY_OK;
>> +}
> Otherwise, looks sane.

Good!!!

>

