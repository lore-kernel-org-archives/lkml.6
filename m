Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18186C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6B6208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6B6208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935769AbeFMUi6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:38:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935381AbeFMUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:38:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DKXwXG006198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:38:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk9rn1qab-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:38:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Wed, 13 Jun 2018 16:38:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 16:38:51 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DKcoXQ8716716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 20:38:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB666AC05E;
        Wed, 13 Jun 2018 16:40:11 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1D31AC05B;
        Wed, 13 Jun 2018 16:40:11 -0400 (EDT)
Received: from alifm-ThinkPad-T470p.pok.ibm.com (unknown [9.56.58.93])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Jun 2018 16:40:11 -0400 (EDT)
From:   Farhan Ali <alifm@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v2 0/2] Detect & register virtio-crypto algos only if it can be supported by backend
Date:   Wed, 13 Jun 2018 16:38:47 -0400
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18061320-2213-0000-0000-000002B94251
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009185; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046514; UDB=6.00535974; IPR=6.00825490;
 MB=3.00021630; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 20:38:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061320-2214-0000-0000-00005A78DD1D
Message-Id: <cover.1528921468.git.alifm@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130218
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

