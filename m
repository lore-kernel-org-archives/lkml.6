Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF9C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3020660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C3020660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeK1Xmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:42:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728373AbeK1Xmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:42:50 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASCdeU1002679
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1s9vw8rq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 28 Nov 2018 12:41:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 12:41:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASCf7S58782082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 12:41:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 706504C044;
        Wed, 28 Nov 2018 12:41:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347764C040;
        Wed, 28 Nov 2018 12:41:07 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 12:41:07 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 0/6] vfio: ccw: VFIO CCW cleanup part1
Date:   Wed, 28 Nov 2018 13:41:01 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18112812-0012-0000-0000-000002D17960
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112812-0013-0000-0000-00002106BE1C
Message-Id: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of the patches of this serie is to clarify the code
of state/event handling.

- First patch (already acked/applied) makes sure that every structures are initialized
  before the mediated device is registered.
  (Only here to apply the serie on the main tree).

- vfio: ccw: Rework subchannel state on setup
  makes sure that the device can not be used before a guest is
  ready to drive it.

- vfio: ccw: Rework subchannel state on removing
  could be squash with the previous: same kind of rewriting
  but for the removing/release callbacks.

- vfio: ccw: Rework subchannel state on sch_event
  sch_event handling seems quite poor to me.
  Anyway, I do not understand why we hould have state change there.

- vfio: ccw: Documenting state transitions

- vfio: ccw: serialize the write system calls
  Quite independent of the previous patches, this makes sure
  that the entry in the driver is serialized.

Pierre Morel (6):
  vfio: ccw: Register mediated device once all structures are
    initialized
  vfio: ccw: Rework subchannel state on setup
  vfio: ccw: Rework subchannel state on removing
  vfio: ccw: Rework subchannel state on sch_event
  vfio: ccw: Documenting state transitions
  vfio: ccw: serialize the write system calls

 Documentation/s390/vfio-ccw.txt     | 45 +++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++
 drivers/s390/cio/vfio_ccw_drv.c     | 30 ++++-------------
 drivers/s390/cio/vfio_ccw_ops.c     | 65 ++++++++++++++++++++++++-------------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 5 files changed, 105 insertions(+), 47 deletions(-)

-- 
2.7.4

Changelog:

from v2:
- adaptation after Conny's hlt/clr patches
- integration of Conny's comments
- reworking of the state changes to make it clearer
- added documentation
- added serialization

from v1:
- change commit message
- add reviewed-by from Eric (Really this time)

from v0:
- isolate these two patches from the previous serie
- Added Reviewed-by Eric
- Ortographic correction

