Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626A920842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626A920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeIXTY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:24:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbeIXTY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:24:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ODKfSU146954
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 09:22:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mpx7gxung-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 09:22:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 24 Sep 2018 14:22:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 14:22:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ODMB6h65929340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 13:22:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 199C611C064;
        Mon, 24 Sep 2018 16:21:53 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B8F211C04C;
        Mon, 24 Sep 2018 16:21:52 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 16:21:52 +0100 (BST)
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924133611.01fef50e.cohuck@redhat.com>
 <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Mon, 24 Sep 2018 15:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092413-0016-0000-0000-00000209DAAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092413-0017-0000-0000-00003260EDCA
Message-Id: <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.2018 14:16, Halil Pasic wrote:
>
> On 09/24/2018 01:36 PM, Cornelia Huck wrote:
>> On Wed, 12 Sep 2018 15:43:03 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Let's call PAPQ(ZAPQ) to zeroize a queue for each queue configured
>>> for a mediated matrix device when it is released.
>>>
>>> Zeroizing a queue resets the queue, clears all pending
>>> messages for the queue entries and disables adapter interruptions
>>> associated with the queue.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  drivers/s390/crypto/vfio_ap_ops.c |   44 +++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 44 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index f8b276a..48b1b78 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -829,6 +829,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>  	return NOTIFY_OK;
>>>  }
>>>  
>>> +static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>>> +				    unsigned int retry)
>>> +{
>>> +	struct ap_queue_status status;
>>> +
>>> +	do {
>>> +		status = ap_zapq(AP_MKQID(apid, apqi));
>>> +		switch (status.response_code) {
>>> +		case AP_RESPONSE_NORMAL:
>>> +			return 0;
>>> +		case AP_RESPONSE_RESET_IN_PROGRESS:
>>> +		case AP_RESPONSE_BUSY:
>>> +			msleep(20);
>>> +			break;
>>> +		default:
>>> +			/* things are really broken, give up */
>>> +			return -EIO;
>>> +		}
>>> +	} while (retry--);
>>> +
>>> +	return -EBUSY;
>> So, this function may either return 0, -EIO (things are really broken),
>> or -EBUSY (still busy after multiple tries)...
>>
>>> +}
>>> +
>>> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>> +{
>>> +	int ret;
>>> +	int rc = 0;
>>> +	unsigned long apid, apqi;
>>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +
>>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>> +			     matrix_mdev->matrix.apm_max + 1) {
>>> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>> +				     matrix_mdev->matrix.aqm_max + 1) {
>>> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>> +			if (ret)
>>> +				rc = ret;
>> ...and here, we return the last error of any of the resets. Two
>> questions:
>>
>> - Does it make sense to continue if we get -EIO? IOW, does "really
>>   broken" only refer to a certain tuple and other tuples still can/need
>>   to be reset?
> I think it does make sense to continue, because IMHO "things are really
> broken" is an overstatement (I mean the APQN invalid case). One could
> argue would skipping the current card (adapter) be justified or not.
>
> IMHO the current code is good enough for the first shot, and we can think
> about fine-tuning it later.
Absolutely. The -EIO case is reached for example when the APQN
is 'deconfigured' which means the crypto adapter is logically unplugged.
So the -EIO case should NOT lead to some fatal actions like panic()
or cause a KVM guest to shut down or so.
>> - Is the return code useful in any way, as we don't know which tuple it
>>   refers to?
>>
> Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
> is mostly fine given what the architecture say if we are satisfied with just
> reset. And the cases behind -EIO might actually be OK too in the same sense.
> My guess is, that based on the return value client code can tell if we have
> zeroize for all queues or basically just reset (like rapq). We could log that
> to some debug facility or whatever -- I guess, but at the moment we don't care.
>
> In the end I think the code is good enough as is, and if we want we can
> improve on it later.
>
> Regards,
> Halil
>
>
>>> +		}
>>> +	}
>>> +
>>> +	return rc;
>>> +}
>>> +
>>>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>  {
>>>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> @@ -859,6 +902,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>  	if (matrix_mdev->kvm)
>>>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>  
>>> +	vfio_ap_mdev_reset_queues(mdev);
>>>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>  				 &matrix_mdev->group_notifier);
>>>  	matrix_mdev->kvm = NULL;

