Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DB0ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103512146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103512146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeISDcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:32:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729736AbeISDcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:32:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ILrvR2118446
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 17:57:43 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mk9bc8r0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 17:57:43 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 18 Sep 2018 15:57:42 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Sep 2018 15:57:38 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ILvZHp52035634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 14:57:35 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84661C605D;
        Tue, 18 Sep 2018 15:57:35 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D770C6055;
        Tue, 18 Sep 2018 15:57:32 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Sep 2018 15:57:32 -0600 (MDT)
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <0ba9647d-76d8-1a6c-bed0-fadd0af496cc@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 18 Sep 2018 17:57:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <0ba9647d-76d8-1a6c-bed0-fadd0af496cc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091821-0004-0000-0000-0000148C5153
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009730; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090282; UDB=6.00563240; IPR=6.00870303;
 MB=3.00023372; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-18 21:57:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091821-0005-0000-0000-000088DB4F20
Message-Id: <bc642c76-09e2-586e-b512-55f1679beb0c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809180215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 01:00 PM, Halil Pasic wrote:
>
> On 09/12/2018 09:43 PM, Tony Krowiak wrote:
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
>> +{
>> +	struct ap_matrix_mdev *m;
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +
>> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>> +		if ((m != matrix_mdev) && (m->kvm == kvm)) {
>> +			mutex_unlock(&matrix_dev->lock);
>> +			return -EPERM;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&matrix_dev->lock);
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
>> +	if (!data) {
>> +		matrix_mdev->kvm = NULL;
>> +		return NOTIFY_OK;
>> +	}
>> +
>> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
> This could be racy. Two threads doing vfio_ap_mdev_group_notifier()
> can first get 0 here in a sense that there is no such kvm in the list,
> and then both set the very same kvm three lines below. Which would
> result in what we are trying to prevent.
>
> Also vfio_ap_mdev_open_once() does not seem like an appropriate name
> any more. If we were to do the matrix_mdev->kvm = kvm in there we could
> call it something like vfio_ap_mdev_set_kvm().

I'm moving the matrix-mdev->kvm = kvm inside the mutex lock in
vfio_ap_mdev_open_once() ... also renaming it to vfio_ap_mdev_set_kvm().

>
>> +	if (ret)
>> +		return NOTIFY_DONE;
>> +
>> +	matrix_mdev->kvm = data;
>> +
>> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	vfio_ap_mdev_copy_masks(matrix_mdev);
>> +
>> +	return NOTIFY_OK;
>> +}


