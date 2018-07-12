Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D928C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2E208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D2E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeGLM4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:56:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbeGLM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:56:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CCj3M2060412
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 08:47:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k65vn4wgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 08:47:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 12 Jul 2018 13:47:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 13:47:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CClIPv38535216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 12:47:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E67EA4040;
        Thu, 12 Jul 2018 15:47:40 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DFC1A4051;
        Thu, 12 Jul 2018 15:47:39 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 15:47:39 +0100 (BST)
Subject: Re: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open
 callback
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Thu, 12 Jul 2018 14:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071212-0012-0000-0000-00000289751D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071212-0013-0000-0000-000020BB1D06
Message-Id: <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     |  128 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>   2 files changed, 130 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index bc7398d..58be495 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -11,6 +11,10 @@
>   #include <linux/device.h>
>   #include <linux/list.h>
>   #include <linux/ctype.h>
> +#include <linux/bitops.h>
> +#include <linux/kvm_host.h>
> +#include <linux/module.h>
> +#include <asm/kvm.h>
>   
>   #include "vfio_ap_private.h"
>   
> @@ -748,12 +752,136 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>   	NULL
>   };
>   
> +/**
> + * Verify that the AP instructions are available on the guest and are to be
> + * interpreted by the firmware. The former is indicated via the
> + * KVM_S390_VM_CPU_FEAT_AP CPU model feature and the latter by apie crypto
> + * flag.
> + */
> +static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
> +{
> +	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat) &&
> +	    kvm->arch.crypto.apie)
> +		return 0;
> +
> +	pr_err("%s: interpretation of AP instructions not available",
> +	       VFIO_AP_MODULE_NAME);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
> +		matrix_mdev = container_of(nb, struct ap_matrix_mdev,
> +					   group_notifier);
> +		matrix_mdev->kvm = data;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +

[..]

> +
> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_dev *matrix_dev =
> +		to_ap_matrix_dev(mdev_parent_dev(mdev));
> +	unsigned long events;
> +	int ret;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
> +					     &matrix_mdev->matrix);
> +	if (ret)
> +		goto out_err;
> +
> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
> +
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				     &events, &matrix_mdev->group_notifier);
> +	if (ret)
> +		goto out_err;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);

At this point you assume that your vfio_ap_mdev_group_notifier callback
was called with VFIO_GROUP_NOTIFY_SET_KVM and that you do have
matrix_mdev->kvm set up properly.

Based on how callbacks usually work this seems rather strange. It's
probably cleaner to set up he cyrcb (including all the validation
that needs to be done immediately before) in the callback
(vfio_ap_mdev_group_notifier).

If that is not viable I think we need a comment here explaining why is this
OK (at least).

Regards,
Halil

> +	if (ret)
> +		goto out_kvm_err;
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev);
> +	if (ret)
> +		goto out_kvm_err;
> +
> +	return 0;
> +
> +out_kvm_err:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				 &matrix_mdev->group_notifier);
> +	matrix_mdev->kvm = NULL;
> +out_err:
> +	module_put(THIS_MODULE);
> +
> +	return ret;
> +}
> +
> 

[..]

