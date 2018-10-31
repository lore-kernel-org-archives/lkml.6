Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FECC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C989720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C989720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbeKADMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:12:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730128AbeKADMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:12:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VIAcEe005020
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nff6975wa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 31 Oct 2018 18:13:08 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 18:13:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VID3Nd57344114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 18:13:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F09A11C054;
        Wed, 31 Oct 2018 18:13:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3022811C050;
        Wed, 31 Oct 2018 18:13:03 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.73])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 18:13:03 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
Date:   Wed, 31 Oct 2018 19:12:54 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103118-0012-0000-0000-000002C1360B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103118-0013-0000-0000-000020F5635D
Message-Id: <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the implementation of the VFIO ioctl calls to handle
the AQIC interception and use GISA to handle interrupts.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 272ef427dcc0..f68102163bf4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	return copy_to_user((void __user *)arg, &info, minsz);
 }
 
+static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
+			   struct vfio_ap_aqic *parm)
+{
+	struct aqic_gisa aqic_gisa = reg2aqic(0);
+	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
+	struct ap_status ap_status = reg2status(0);
+	unsigned long p;
+	int ret = -1;
+	int apqn;
+	uint32_t gd;
+
+	apqn = (int)(parm->cmd & 0xffff);
+
+	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
+	if (gd & 0x01)
+		aqic_gisa.f = 1;
+	aqic_gisa.gisc = matrix_mdev->gisc;
+	aqic_gisa.isc = GAL_ISC;
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisao = gisa->next_alert >> 4;
+
+	p = (unsigned long) page_address(matrix_mdev->map->page);
+	p += (matrix_mdev->map->guest_addr & 0x0fff);
+
+	ret = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), p);
+	parm->status = ret;
+
+	ap_status = reg2status(ret);
+	return (ap_status.rc) ? -EIO : 0;
+}
+
+static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
+			   struct vfio_ap_aqic *parm)
+{
+	struct aqic_gisa aqic_gisa = reg2aqic(0);
+	struct ap_status ap_status = reg2status(0);
+	int apqn;
+	int retval;
+	uint32_t gd;
+
+	apqn = (int)(parm->cmd & 0xffff);
+
+	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
+	if (gd & 0x01)
+		aqic_gisa.f = 1;
+	aqic_gisa.ir = 0;
+
+	retval = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), 0);
+	parm->status = retval;
+
+	ap_status = reg2status(retval);
+	return (ap_status.rc) ? -EIO : 0;
+}
+
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 				    unsigned int cmd, unsigned long arg)
 {
 	int ret;
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct s390_io_adapter *adapter;
+	struct vfio_ap_aqic parm;
+	struct s390_map_info *map;
+	int apqn, found = 0;
 
 	switch (cmd) {
+	case VFIO_AP_SET_IRQ:
+		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+			return -EFAULT;
+		apqn = (int)(parm.cmd & 0xffff);
+		parm.status &= 0x00000000ffffffffUL;
+		matrix_mdev->gisc = parm.status & 0x07;
+		/* find the adapter */
+		adapter = matrix_mdev->kvm->arch.adapters[parm.adapter_id];
+		if (!adapter)
+			return -ENOENT;
+		down_write(&adapter->maps_lock);
+		list_for_each_entry(map, &adapter->maps, list) {
+			if (map->guest_addr == parm.nib) {
+				found = 1;
+				break;
+			}
+		}
+		up_write(&adapter->maps_lock);
+
+		if (!found)
+			return -EINVAL;
+
+		matrix_mdev->map = map;
+		ret = ap_ioctl_setirq(matrix_mdev, &parm);
+		parm.status &= 0x00000000ffffffffUL;
+		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+			return -EFAULT;
+
+		break;
+	case VFIO_AP_CLEAR_IRQ:
+		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+			return -EFAULT;
+		ret = ap_ioctl_clrirq(matrix_mdev, &parm);
+		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+			return -EFAULT;
+		break;
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
-- 
2.17.0

