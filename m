Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AE520658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AE520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJKUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:50:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbeJKUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:50:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BDFUQh140208
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:23:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n26av39w7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:23:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 14:23:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 14:22:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BDMtmC65077462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 13:22:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47ECC11C050;
        Thu, 11 Oct 2018 16:22:28 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4F3711C052;
        Thu, 11 Oct 2018 16:22:26 +0100 (BST)
Received: from aks.in.ibm.com (unknown [9.124.35.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 16:22:26 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     huntbag@linux.vnet.ibm.com, npiggin@gmail.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 0/3] New device-tree format  and Opal based idle save-restore
Date:   Thu, 11 Oct 2018 18:52:34 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18101113-0008-0000-0000-0000027E2462
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101113-0009-0000-0000-000021E76BE3
Message-Id: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110130
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
				      "opal-support";
			 type = "cpuidle";
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
				      "opal-support";
			 type = "cpuoffline";
                         ...
                  };
             };

High-level parsing algorithm :

Say Known version string = "ibm,state-v1"

for each stop state node in device tree:
	if (compatible has known version string)
		kernel takes care of stop-transitions
	else if (compatible has "opal-support")
		OPAL takes care of stop-transitions
	else
		Skip All deeper states

When a state does not have both version support and opal support,
Its possible to exit from a shallower state. Hence skipping all
deeper states.

OPAL support for idle states
----------------------------

With this patch series, all the states that loose hypervisor state
will be handled through opal_call.

Patch 3 adds support for Saving/restoring of SPRs and resync-timebase
in OPAL. Also all the decision making such as identifying first thread
in the core and taking locks before restoring, etc are implemented in
OPAL.

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

Changes from v1 :
 - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
   idle code in C"
	http://patchwork.ozlabs.org/patch/969596/
 - All the states that loses hypervisor states will be handled by OPAL
 - All the decision making such as identifying first thread in
   the core and taking locks before restoring in such cases have also been
   moved to OPAL


Abhishek Goel (1):
  cpuidle/powernv: save-restore sprs in opal

Akshay Adiga (2):
  cpuidle/powernv: Add support for states with ibm,cpuidle-state-v1
  powernv/cpuidle: Pass pointers instead of values to  stop loop

 arch/powerpc/include/asm/cpuidle.h            |   9 +
 arch/powerpc/include/asm/opal-api.h           |   4 +-
 arch/powerpc/include/asm/opal.h               |   3 +
 arch/powerpc/include/asm/processor.h          |   8 +-
 arch/powerpc/kernel/idle_book3s.S             |   6 +-
 arch/powerpc/platforms/powernv/idle.c         | 247 ++++++++++++++----
 .../powerpc/platforms/powernv/opal-wrappers.S |   2 +
 drivers/cpuidle/cpuidle-powernv.c             |  46 ++--
 8 files changed, 251 insertions(+), 74 deletions(-)

-- 
2.17.1

