Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 189E8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC519208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC519208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933605AbeFLH47 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:56:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933549AbeFLH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:56:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sTh8117254
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj8f2mrfw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:56:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:52 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7upQ321233690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BD0DAE058;
        Tue, 12 Jun 2018 08:45:42 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CB65AE051;
        Tue, 12 Jun 2018 08:45:42 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:42 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state machine
Date:   Tue, 12 Jun 2018 09:56:42 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18061207-0028-0000-0000-000002CFD87F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0029-0000-0000-00002386F322
Message-Id: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=645 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of the patch serie is to secure the state machine by:
- centralizing all state changes inside the state machine wrapper
- make the state change atomic using mutexes
- refactor the initialization to avoid using a subchannel without a guest


This series introduces new states and events and suppressed
others.
Here the list of states and events used in this serie:
- VFIO_CCW_STATE_NOT_OPER    : when the Sub-Channel is KO
- VFIO_CCW_STATE_STANDBY     : when it is offline
- VFIO_CCW_STATE_IDLE        : when it is ready for I/O
- VFIO_CCW_STATE_BUSY        : when it is busy doing I/O
- VFIO_CCW_STATE_QUIESCING(N): when it is busy going offline

- VFIO_CCW_EVENT_INIT            : the channel setup (admin)
- VFIO_CCW_EVENT_NOT_OPER        : something really wrong happened
- VFIO_CCW_EVENT_IO_REQ          : Starting a SSCH request (UAPI)
- VFIO_CCW_EVENT_INTERRUPT(N)    : Receiving an interrupt (callback)
- VFIO_CCW_EVENT_SCHIB_CHANGED(N): Receiving a channel event (callback)

The user's ABI do not change.



Pierre Morel (8):
  vfio: ccw: Moving state change out of IRQ context
  vfio: ccw: Transform FSM functions to return state
  vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
  vfio: ccw: Only accept SSCH as an IO request
  vfio: ccw: Suppress unused event parameter
  vfio: ccw: Make FSM functions atomic
  vfio: ccw: Introduce the INIT event
  vfio: ccw: Suppressing the BOXED state

 drivers/s390/cio/vfio_ccw_drv.c     |  71 ++++++-----------
 drivers/s390/cio/vfio_ccw_fsm.c     | 147 +++++++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_ops.c     |  41 +++++-----
 drivers/s390/cio/vfio_ccw_private.h |  12 ++-
 4 files changed, 137 insertions(+), 134 deletions(-)

-- 
2.7.4

Changelog:

From v2 to v3:
- Concentrate more on securing the FSM:
 - abandonned ONLINE/OFFLINE events
 - abandonned make user wait on busy
 - abandonned switch case on command to keep old
   way of testing the START_SSCH bit in write syscall

From v1 to v2:
- rebased on current Linux branch
- change the name of VFIO_CCW_EVENT_SCH_EVENT to
  VFIO_CCW_EVENT_SCHIB_CHANGED
- refactoring the initialization (mdev create/open
  and driver probe)
- return -EAGAIN to let the low level retry the
  sending of events
- make wait_for_completion interruptible


