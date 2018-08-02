Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A70EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C214208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C214208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeHBGlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:41:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbeHBGlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:41:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w724ls2R083070
        for <linux-kernel@vger.kernel.org>; Thu, 2 Aug 2018 00:51:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kku7x836m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 00:51:55 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Thu, 2 Aug 2018 05:51:53 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 05:51:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w724pnsp37486658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Aug 2018 04:51:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAB74203F;
        Thu,  2 Aug 2018 07:52:00 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A50642041;
        Thu,  2 Aug 2018 07:51:59 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.79.222.241])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Aug 2018 07:51:58 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/3] New device-tree format  and Opal based idle save-restore
Date:   Thu,  2 Aug 2018 10:21:29 +0530
X-Mailer: git-send-email 2.18.0.rc2.85.g1fb9df7
X-TM-AS-GCONF: 00
x-cbid: 18080204-0020-0000-0000-000002AFBD46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080204-0021-0000-0000-000020FBE6DF
Message-Id: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808020051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
New device tree format adds a compatible flag, so that only kernel
which has the capability to handle the version of stop state will enable
it.

Older kernel will still see stop0 and stop0_lite in older format and we
will depricate it after some time.

1) Idea is to bump up the version string in firmware if we find a bug or
regression in stop states. A fix will be provided in linux which would
now know about the bumped up version of stop states, where as kernel
without fixes would ignore the states.

2) Slowly deprecate cpuidle/cpuhotplug threshold which is hard-coded
into cpuidle-powernv driver. Instead use compatible strings to indicate
if idle state is suitable for cpuidle and hotplug.

New idle state device tree format :
       power-mgt {
            ...
         ibm,enabled-stop-levels = <0xec000000>;
         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
         ibm,idle-states {
                     stop4 {
                         flags = <0x207000>;
                         compatible = "ibm,state-v1",
				      "cpuidle",
				      "opal-supported";
                         psscr-mask = <0x0 0x3003ff>;
                         handle = <0x102>;
                         latency-ns = <0x186a0>;
                         residency-ns = <0x989680>;
                         psscr = <0x0 0x300374>;
                  };
                    ...
                    stop11 {
                     ...
                         compatible = "ibm,state-v1",
				      "cpuoffline",
				      "opal-supported";
                         ...
                  };
             };

Skiboot patch-set for device-tree is posted here :
https://patchwork.ozlabs.org/project/skiboot/list/?series=58934

High-level parsing algorithm :

Say Known version string = "ibm,state-v1"

for each stop state node in device tree:
	if (compatible has known version string)
		kernel takes care of stop-transitions
	else if (compatible has "opal-supported")
		OPAL takes care of stop-transitions
	else
		Skip All deeper states

When a state does not have both version support and opal support,
Its possible to exit from a shallower state. Hence skipping all
deeper states.

How does it work ?
-------------------

Consider a case that stop4 has a bug. We take the following steps to
mitigate the problem.

1) Change compatible string for stop4 in OPAL to "ibm-state-v2" and
remove "opal-supported". ship the new firmware.
The kernel ignores stop4 and all deeper states. But we will still have
shallower states. Prevents from completely disabling stop states.

2) Implement workaround in OPAL and add "opal-supported". Ship new firmware
The kernel uses opal for stop-transtion , which has workaround implemented.
We get stop4 and deeper states working without kernel changes and backports.
(and considerably less time)

3) Implement workaround in kernel and add "ibm-state-v2" as known versions
The kernel will now be able to handle stop4 and deeper states.

Also includes Abhishek's RFC which was posted there :
 https://patchwork.ozlabs.org/patch/947568/

This patch-set is on top of mpe-next



Abhishek Goel (1):
  cpuidle/powernv: Conditionally save-restore sprs using opal

Akshay Adiga (2):
  cpuidle/powernv: Add support for states with ibm,cpuidle-state-v1
  powernv/cpuidle: Pass pointers instead of values to stop loop

 arch/powerpc/include/asm/cpuidle.h            |  12 +
 arch/powerpc/include/asm/opal-api.h           |   4 +-
 arch/powerpc/include/asm/opal.h               |   3 +
 arch/powerpc/include/asm/paca.h               |   5 +-
 arch/powerpc/include/asm/processor.h          |   9 +-
 arch/powerpc/kernel/asm-offsets.c             |   3 +
 arch/powerpc/kernel/idle_book3s.S             |  55 ++++-
 arch/powerpc/platforms/powernv/idle.c         | 214 +++++++++++++++---
 .../powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/xmon/xmon.c                      |  14 +-
 drivers/cpuidle/cpuidle-powernv.c             |  66 +++---
 11 files changed, 304 insertions(+), 83 deletions(-)

-- 
2.18.0.rc2.85.g1fb9df7

