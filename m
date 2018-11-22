Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C751C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF5D20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF5D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406316AbeKWDvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:51:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404641AbeKWDvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:51:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAMH9DdK023943
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:11:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nwxtamra8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:11:26 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 22 Nov 2018 17:11:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Nov 2018 17:11:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAMHBKCt56492100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 17:11:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F74642045;
        Thu, 22 Nov 2018 17:11:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F361D4203F;
        Thu, 22 Nov 2018 17:11:19 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Nov 2018 17:11:19 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
Date:   Thu, 22 Nov 2018 18:11:15 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112217-0028-0000-0000-0000031EF78E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112217-0029-0000-0000-000023DB0552
Message-Id: <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=977 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811220153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the implementation of the VFIO ioctl calls to handle
the AQIC interception and use GISA to handle interrupts.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 272ef42..f6e942f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -895,12 +895,121 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	return copy_to_user((void __user *)arg, &info, minsz);
 }
 
+static unsigned long vfio_ap_get_nib(struct kvm *kvm, struct vfio_ap_aqic *parm)
+{
+	struct s390_io_adapter *adapter;
+	struct s390_map_info *map;
+	unsigned long nib;
+	int found = 0;
+
+	/* find the adapter */
+	if (parm->adapter_id > MAX_S390_IO_ADAPTERS)
+		return 0;
+
+	adapter = kvm->arch.adapters[parm->adapter_id];
+	if (!adapter)
+		return 0;
+
+	down_write(&adapter->maps_lock);
+	list_for_each_entry(map, &adapter->maps, list) {
+		if (map->guest_addr == parm->nib) {
+			found = 1;
+			break;
+		}
+	}
+	up_write(&adapter->maps_lock);
+
+	if (!found)
+		return 0;
+
+	nib = (unsigned long) page_address(map->page);
+	nib += (map->guest_addr & 0x0fff);
+
+	return nib;
+}
+
+static int vfio_ap_ioctl_setirq(struct mdev_device *mdev, unsigned long arg)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_aqic parm;
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct kvm *kvm = matrix_mdev->kvm;
+	struct kvm_s390_gisa *gisa = kvm->arch.gisa;
+	struct ap_queue_status ap_status;
+	unsigned long nib;
+
+	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+		return -EFAULT;
+
+	if (parm.isc > MAX_ISC)
+		return -EINVAL;
+
+	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
+		aqic_gisa.gf = 1;
+
+	nib = vfio_ap_get_nib(kvm, &parm);
+	if (!nib)
+		return -ENODEV;
+
+	aqic_gisa.gisc = parm.isc;
+	aqic_gisa.isc = kvm_s390_gisc_register(kvm, parm.isc);
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisa = gisa->next_alert >> 4;
+
+	ap_status = ap_aqic(parm.apqn, aqic_gisa, (void *)nib);
+	parm.status = *(uint32_t *)(&ap_status);
+
+	if (copy_to_user((void __user *)arg, &parm, sizeof(parm))) {
+		kvm_s390_gisc_unregister(kvm, parm.isc);
+		return -EFAULT;
+	}
+
+	if (ap_status.response_code) {
+		kvm_s390_gisc_unregister(kvm, parm.isc);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int vfio_ap_ioctl_clrirq(struct mdev_device *mdev, unsigned long arg)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_aqic parm;
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status ap_status;
+	struct kvm *kvm = matrix_mdev->kvm;
+
+	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+		return -EFAULT;
+
+	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
+		aqic_gisa.gf = 1;
+	aqic_gisa.ir = 0;
+
+	ap_status = ap_aqic(parm.apqn, aqic_gisa, NULL);
+	parm.status = *(uint32_t *)(&ap_status);
+
+	kvm_s390_gisc_unregister(kvm, parm.isc);
+
+	if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+		return -EFAULT;
+
+	return (ap_status.response_code) ? -EIO : 0;
+}
+
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 				    unsigned int cmd, unsigned long arg)
 {
 	int ret;
 
 	switch (cmd) {
+	case VFIO_AP_SET_IRQ:
+		ret = vfio_ap_ioctl_setirq(mdev, arg);
+		break;
+	case VFIO_AP_CLEAR_IRQ:
+		ret = vfio_ap_ioctl_clrirq(mdev, arg);
+		break;
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
@@ -911,7 +1020,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-
 	return ret;
 }
 
-- 
2.7.4

