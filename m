Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49CA20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49CA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeFTNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:52:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752798AbeFTNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:52:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KDnPLX086889
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:51:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqp7tdygr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:51:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 14:51:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 14:51:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KDppcE34996362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 13:51:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD63552049;
        Wed, 20 Jun 2018 13:41:08 +0100 (BST)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7BBF852041;
        Wed, 20 Jun 2018 13:41:08 +0100 (BST)
From:   Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
To:     stefanha@redhat.com
Cc:     davem@davemloft.net, jhansen@vmware.com, cavery@redhat.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 1/1] VSOCK: fix loopback on big-endian systems
Date:   Wed, 20 Jun 2018 15:51:51 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18062013-4275-0000-0000-0000028FE566
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062013-4276-0000-0000-000037972E8B
Message-Id: <1529502711-8028-1-git-send-email-imbrenda@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=556 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dst_cid and src_cid are 64 bits, therefore 64 bit accessors should be
used, and in fact in virtio_transport_common.c only 64 bit accessors are
used. Using 32 bit accessors for 64 bit values breaks big endian systems.

This patch fixes a wrong use of le32_to_cpu in virtio_transport_send_pkt.

Fixes: b9116823189e85ccf384 ("VSOCK: add loopback to virtio_transport")

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8e03bd3..5d3cce9 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -201,7 +201,7 @@ virtio_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 		return -ENODEV;
 	}
 
-	if (le32_to_cpu(pkt->hdr.dst_cid) == vsock->guest_cid)
+	if (le64_to_cpu(pkt->hdr.dst_cid) == vsock->guest_cid)
 		return virtio_transport_send_pkt_loopback(vsock, pkt);
 
 	if (pkt->reply)
-- 
2.7.4

