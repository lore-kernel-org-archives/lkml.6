Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293102086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfA2RIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:08:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfA2RIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:08:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TGwnY7024327
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:08:45 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qat093eyp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:08:44 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 29 Jan 2019 17:08:44 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 17:08:39 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TH8cau11927726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 17:08:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D0B2BE051;
        Tue, 29 Jan 2019 17:08:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F477BE054;
        Tue, 29 Jan 2019 17:08:26 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.217.24])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jan 2019 17:08:24 +0000 (GMT)
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>
Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date:   Tue, 29 Jan 2019 15:08:12 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012917-0012-0000-0000-00001701BAEA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153539; UDB=6.00601409; IPR=6.00933905;
 MB=3.00025342; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 17:08:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012917-0013-0000-0000-000056010087
Message-Id: <87zhrj8kcp.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

With Christoph's rework of the DMA API that recently landed, the patch
below is the only change needed in virtio to make it work in a POWER
secure guest under the ultravisor.

The other change we need (making sure the device's dma_map_ops is NULL
so that the dma-direct/swiotlb code is used) can be made in
powerpc-specific code.

Of course, I also have patches (soon to be posted as RFC) which hook up
<linux/mem_encrypt.h> to the powerpc secure guest support code.

What do you think?

From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 24 Jan 2019 22:08:02 -0200
Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted

The host can't access the guest memory when it's encrypted, so using
regular memory pages for the ring isn't an option. Go through the DMA API.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 drivers/virtio/virtio_ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..321a27075380 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	 * not work without an even larger kludge.  Instead, enable
 	 * the DMA API if we're a Xen guest, which at least allows
 	 * all of the sensible Xen configurations to work correctly.
+	 *
+	 * Also, if guest memory is encrypted the host can't access
+	 * it directly. In this case, we'll need to use the DMA API.
 	 */
-	if (xen_domain())
+	if (xen_domain() || sev_active())
 		return true;

 	return false;

