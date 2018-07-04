Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5F20834
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A5F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933197AbeGDG21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:28:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932500AbeGDG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:28:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w646O3cR047586
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 02:28:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0qjqu78n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:28:25 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 07:28:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 07:28:21 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w646SKZY39387182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 06:28:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD51A4C052;
        Wed,  4 Jul 2018 09:28:45 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39E674C044;
        Wed,  4 Jul 2018 09:28:44 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 09:28:44 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 04 Jul 2018 09:28:18 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Date:   Wed,  4 Jul 2018 09:28:13 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18070406-4275-0000-0000-00000294F555
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070406-4276-0000-0000-0000379C772D
Message-Id: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=725 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches switch m68k boot time memory allocators from bootmem to
memblock + no_bootmem.

The first two patches update __ffs() and __va() definitions to be inline
with other arches and asm-generic. This is required to avoid compilation
warnings in mm/memblock.c and mm/nobootmem.c.

The third patch performs the actual switch of the boot time mm. Its
changelog has detailed description of the changes.

I've tested the !MMU version with qemu-system-m68k -M mcf5208evb
and the MMU version with q800 using qemu from [1].

I've also build tested allyesconfig and *_defconfig.

[1] https://github.com/vivier/qemu-m68k.git

v2:
* fix reservation of the kernel text/data/bss for ColdFire MMU

Mike Rapoport (3):
  m68k/bitops: convert __ffs to match generic declaration
  m68k/page_no.h: force __va argument to be unsigned long
  m68k: switch to MEMBLOCK + NO_BOOTMEM

 arch/m68k/Kconfig               |  3 +++
 arch/m68k/include/asm/bitops.h  |  8 ++++++--
 arch/m68k/include/asm/page_no.h |  2 +-
 arch/m68k/kernel/setup_mm.c     | 14 ++++----------
 arch/m68k/kernel/setup_no.c     | 20 ++++----------------
 arch/m68k/mm/init.c             |  1 -
 arch/m68k/mm/mcfmmu.c           | 13 +++++++------
 arch/m68k/mm/motorola.c         | 35 +++++++++++------------------------
 arch/m68k/sun3/config.c         |  4 ----
 9 files changed, 36 insertions(+), 64 deletions(-)

-- 
2.7.4

