Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F79C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE1B206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE1B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406264AbeKWDvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:51:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392238AbeKWDvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:51:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAMH9ECm144231
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:11:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nwxjx5b1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:11:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 22 Nov 2018 17:11:20 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Nov 2018 17:11:17 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAMHBFj8524684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 17:11:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D340742045;
        Thu, 22 Nov 2018 17:11:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615D442041;
        Thu, 22 Nov 2018 17:11:15 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Nov 2018 17:11:15 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v2 0/3] s390: vfio: ap: Using GISA for AP Interrupt
Date:   Thu, 22 Nov 2018 18:11:12 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18112217-0020-0000-0000-000002EC3710
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112217-0021-0000-0000-0000213B763B
Message-Id: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811220153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series handles AP Interrupt using the GISA facility.
The patch series is based above the GISA+GIB patch series
sent by Michael Mueller.

- We define a new VFIO ioctl to ask the vfio_ap driver to register
  a interruption for the guest.
- We define the assembler code to register a GISA based interruption
  for the guest.
- We register to the GIB Alert mechanism and suppress the GISA
  (firmware) based interrupts from the list of software handled
  interrupts.

This patch series has been tested with success on z13 and z14
with adjunct processors CEX5[ACP] and CEX6C.

To use, you, of course, need the QEMU patches, which will be sent
separately.
Take care of the incompatbility in the ioctl parameters.

Pierre Morel (3):
  vfio: ap: Add AP Queue Interruption Control facility
  vfio: ap: ioctl definitions for AP Queue Interrupt Control
  vfio: ap: AP Queue Interrupt Control VFIO ioctl calls

 arch/s390/tools/gen_facilities.c  |   1 +
 drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h         |  25 +++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.7.4

The goal of the first serie was merely to provide the possibility
to test GISA, and was quite a mess.
This serie is reworked with a simplier interface and almost
the half of LOCs.

Changelog:
(Thanks to Tony:)
- Use explicitely ISC as ioctl parameters
- Use ISC parameter in IRQ disable
- No more changes to the ap_matrix_mdev structure (was isc and map)
- suppress redondant functions
- use standard vfio_ap prefix for functions
- in ioctl use one line to call dedicated ioctl function
(Thanks to Conny:)
- no more complicated structure to int conversions
- Use explicitely apqn as ioctl parameters
 


