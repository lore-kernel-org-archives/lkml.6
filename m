Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE779ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730BE21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730BE21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbeIXSSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:18:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729919AbeIXSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:18:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OCEYKG099385
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:16:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mpydqs0me-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:16:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 24 Sep 2018 13:16:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 13:16:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OCGiD033554598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 12:16:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E13DAE056;
        Mon, 24 Sep 2018 15:15:46 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F8CAE04D;
        Mon, 24 Sep 2018 15:15:45 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.150])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 15:15:44 +0100 (BST)
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924133611.01fef50e.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pasic@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 24 Sep 2018 14:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924133611.01fef50e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092412-0012-0000-0000-000002ADD4C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092412-0013-0000-0000-000020E1E3CB
Message-Id: <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 01:36 PM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:43:03 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Let's call PAPQ(ZAPQ) to zeroize a queue for each queue configured
>> for a mediated matrix device when it is released.
>>
>> Zeroizing a queue resets the queue, clears all pending
>> messages for the queue entries and disables adapter interruptions
>> associated with the queue.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  drivers/s390/crypto/vfio_ap_ops.c |   44 +++++++++++++++++++++++++++++++++++++
>>  1 files changed, 44 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index f8b276a..48b1b78 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -829,6 +829,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>  	return NOTIFY_OK;
>>  }
>>  
>> +static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>> +				    unsigned int retry)
>> +{
>> +	struct ap_queue_status status;
>> +
>> +	do {
>> +		status = ap_zapq(AP_MKQID(apid, apqi));
>> +		switch (status.response_code) {
>> +		case AP_RESPONSE_NORMAL:
>> +			return 0;
>> +		case AP_RESPONSE_RESET_IN_PROGRESS:
>> +		case AP_RESPONSE_BUSY:
>> +			msleep(20);
>> +			break;
>> +		default:
>> +			/* things are really broken, give up */
>> +			return -EIO;
>> +		}
>> +	} while (retry--);
>> +
>> +	return -EBUSY;
> 
> So, this function may either return 0, -EIO (things are really broken),
> or -EBUSY (still busy after multiple tries)...
> 
>> +}
>> +
>> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>> +{
>> +	int ret;
>> +	int rc = 0;
>> +	unsigned long apid, apqi;
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>> +			     matrix_mdev->matrix.apm_max + 1) {
>> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>> +				     matrix_mdev->matrix.aqm_max + 1) {
>> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> +			if (ret)
>> +				rc = ret;
> 
> ...and here, we return the last error of any of the resets. Two
> questions:
> 
> - Does it make sense to continue if we get -EIO? IOW, does "really
>   broken" only refer to a certain tuple and other tuples still can/need
>   to be reset?

I think it does make sense to continue, because IMHO "things are really
broken" is an overstatement (I mean the APQN invalid case). One could
argue would skipping the current card (adapter) be justified or not.

IMHO the current code is good enough for the first shot, and we can think
about fine-tuning it later.

> - Is the return code useful in any way, as we don't know which tuple it
>   refers to?
> 

Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
is mostly fine given what the architecture say if we are satisfied with just
reset. And the cases behind -EIO might actually be OK too in the same sense.
My guess is, that based on the return value client code can tell if we have
zeroize for all queues or basically just reset (like rapq). We could log that
to some debug facility or whatever -- I guess, but at the moment we don't care.

In the end I think the code is good enough as is, and if we want we can
improve on it later.

Regards,
Halil


>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>  {
>>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> @@ -859,6 +902,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>  	if (matrix_mdev->kvm)
>>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>  
>> +	vfio_ap_mdev_reset_queues(mdev);
>>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>  				 &matrix_mdev->group_notifier);
>>  	matrix_mdev->kvm = NULL;
> 

