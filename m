Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4067ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404E2156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404E2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeIVFTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:19:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbeIVFTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:19:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LNNd9r032701
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:28:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mn87wkwtj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:28:27 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 21 Sep 2018 19:28:26 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 19:28:23 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LNSLdx46399574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 23:28:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86C0112061;
        Fri, 21 Sep 2018 19:27:48 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9770B112063;
        Fri, 21 Sep 2018 19:27:47 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 19:27:47 -0400 (EDT)
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
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
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 21 Sep 2018 19:28:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092123-2213-0000-0000-000002F32695
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009748; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091742; UDB=6.00564119; IPR=6.00871767;
 MB=3.00023443; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 23:28:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092123-2214-0000-0000-00005BA2E19D
Message-Id: <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 03:43 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |    1 +
>   drivers/s390/crypto/vfio_ap_ops.c     |  168 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |    5 +
>   3 files changed, 174 insertions(+), 0 deletions(-)
> 

(...)

> @@ -699,12 +730,149 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>   	NULL
>   };
>   
> +/**
> + * Verify that the AP instructions are available on the guest. This is indicated
> + * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
> + */
> +static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
> +{
> +	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +

(...)

> +
> +/**
> + * vfio_ap_mdev_open_once
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * Return 0 if no other mediated matrix device has been opened for the
> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
> + */
> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
> +				  struct kvm *kvm)
> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev->lock);
> +
> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> +		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> +			mutex_unlock(&matrix_dev->lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
> +		return NOTIFY_OK;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> +
> +	if (!data) {
> +		matrix_mdev->kvm = NULL;
> +		return NOTIFY_OK;
> +	}
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
> +	if (ret)
> +		return NOTIFY_DONE;
> +
> +	matrix_mdev->kvm = data;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;
> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long events;
> +	int ret;
> +
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
> +
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				     &events, &matrix_mdev->group_notifier);
> +	if (ret) {
> +		module_put(THIS_MODULE);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

(...)

The fixup! patch below modifies this patch (11/26) to illustrate how
David's recommendation will be implemented for v11 of the series. It
is one of three fixup! patches (the other two are in responses to
03/26 and 25/26) included to generate discussion in v10 rather than
waiting until v11 for comments.

-----------------------------------8<-----------------------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 20 Sep 2018 12:01:53 -0400
Subject: [FIXUP v10] fixup!: s390: vfio-ap: implement mediated device 
open callback

* Fix race condition in KVM notifier
* Remove test for KVM_S390_VM_CPU_FEAT_AP
---
  drivers/s390/crypto/vfio_ap_ops.c |   26 +++++++++++++++-----------
  1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
b/drivers/s390/crypto/vfio_ap_ops.c
index 8bc0cdd..573a5cc 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -731,12 +731,12 @@ static ssize_t matrix_show(struct device *dev, 
struct device_attribute *attr,
  };

  /**
- * Verify that the AP instructions are available on the guest. This is 
indicated
- * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
+ * Verify that the AP instructions are being interpreted by firmware 
for the
+ * guest. This is indicated by the kvm->arch.crypto.apie flag.
   */
  static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
  {
-	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
+	if (kvm->arch.crypto.apie)
  		return 0;

  	return -EOPNOTSUPP;
@@ -772,15 +772,19 @@ static void vfio_ap_mdev_copy_masks(struct 
ap_matrix_mdev *matrix_mdev)
  }

  /**
- * vfio_ap_mdev_open_once
+ * vfio_ap_mdev_set_kvm
   *
   * @matrix_mdev: a mediated matrix device
+ * @kvm: reference to KVM instance
   *
- * Return 0 if no other mediated matrix device has been opened for the
- * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
+ * Verifies no other mediated matrix device has a reference to @kvm and 
sets a
+ * reference to it in @matrix_mdev->kvm.
+ *
+ * Return 0 if no other mediated matrix device has a reference to @kvm;
+ * otherwise, returns -EPERM.
   */
-static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
-				  struct kvm *kvm)
+static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
+				struct kvm *kvm)
  {
  	struct ap_matrix_mdev *m;

@@ -793,6 +797,7 @@ static int vfio_ap_mdev_open_once(struct 
ap_matrix_mdev *matrix_mdev,
  		}
  	}

+	matrix_mdev->kvm = kvm;
  	mutex_unlock(&matrix_dev->lock);

  	return 0;
@@ -814,16 +819,15 @@ static int vfio_ap_mdev_group_notifier(struct 
notifier_block *nb,
  		return NOTIFY_OK;
  	}

-	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
  	if (ret)
  		return NOTIFY_DONE;

-	matrix_mdev->kvm = data;
-
  	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
  	if (ret)
  		return ret;

+
  	vfio_ap_mdev_copy_masks(matrix_mdev);

  	return NOTIFY_OK;
-- 
1.7.1

