Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F93C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA52246A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA52246A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbeGCKaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:30:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754665AbeGCKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:30:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63AOK8s133054
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 06:30:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k07348wf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:30:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 11:30:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:30:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63ATxJ745809902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 10:29:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C0311C052;
        Tue,  3 Jul 2018 13:30:24 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC7811C04A;
        Tue,  3 Jul 2018 13:30:22 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.209])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jul 2018 13:30:22 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 03 Jul 2018 13:29:56 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Date:   Tue,  3 Jul 2018 13:29:52 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18070310-0012-0000-0000-000002863D44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070310-0013-0000-0000-000020B7B8F5
Message-Id: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=678 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030120
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
 arch/m68k/mm/mcfmmu.c           | 11 +++++++----
 arch/m68k/mm/motorola.c         | 35 +++++++++++------------------------
 arch/m68k/sun3/config.c         |  4 ----
 9 files changed, 36 insertions(+), 62 deletions(-)

-- 
2.7.4

