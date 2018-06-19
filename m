Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8400DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F4F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F4F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966695AbeFSPll (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:41:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964999AbeFSPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:41:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JFdIV8029112
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:41:39 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jq389cban-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:41:38 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 19 Jun 2018 11:41:38 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 11:41:35 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JFfYkU7405988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 15:41:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76EBDAE064;
        Tue, 19 Jun 2018 11:41:35 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6637BAE05C;
        Tue, 19 Jun 2018 11:41:35 -0400 (EDT)
Received: from alifm-ThinkPad-T470p.pok.ibm.com (unknown [9.56.58.93])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jun 2018 11:41:35 -0400 (EDT)
From:   Farhan Ali <alifm@linux.ibm.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     qemu-devel@nongnu.org, herbert@gondor.apana.org.au,
        borntraeger@de.ibm.com, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v3 0/2] Detect & register virtio-crypto algos only if it can be supported by backend
Date:   Tue, 19 Jun 2018 11:41:32 -0400
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18061915-0068-0000-0000-0000030B3870
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009220; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049295; UDB=6.00537643; IPR=6.00828268;
 MB=3.00021740; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 15:41:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061915-0069-0000-0000-000044BD3609
Message-Id: <cover.1529422492.git.alifm@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=813 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently the Linux virtio-crypto driver registers the crypto
algorithm without verifying if the backend actually supports the
algorithm.

This kernel patch series adds support for registering algorithm
with Linux crypto layer, only if the algorithm is supported by
the backend device. This also makes the driver more compliant with
the virtio-crypto spec [1].

I would appreciate any feedback or comments on this.

Thank you
Farhan

Reference
---------
[1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html

ChangeLog
---------
v2 -> v3
    - Add Christian Borntrager's acks for the patches.

v1 -> v2
   - Modify comment as suggested by Arei (patch 1)
   - Modify error message as suggested by Arei (patch 2)

Farhan Ali (2):
  crypto/virtio-crypto: Read crypto services and algorithm masks
  crypto/virtio-crypto: Register an algo only if it's supported

 drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
 drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
 drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
 drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
 4 files changed, 202 insertions(+), 45 deletions(-)

-- 
2.7.4

