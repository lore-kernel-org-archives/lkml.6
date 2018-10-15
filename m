Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07B12064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07B12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJPA25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:28:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbeJPA25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:28:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FGdcX3089905
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:42:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4w0pn5cb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:42:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 15 Oct 2018 17:42:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 17:42:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FGgpZY4784618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 16:42:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1D8742045;
        Mon, 15 Oct 2018 19:42:24 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A4994203F;
        Mon, 15 Oct 2018 19:42:24 +0100 (BST)
Received: from mschwideX1.emea.ibm.com (unknown [9.145.33.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Oct 2018 19:42:23 +0100 (BST)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH 0/3] pgtable bytes mis-accounting v2
Date:   Mon, 15 Oct 2018 18:42:36 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18101516-0012-0000-0000-000002B75873
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101516-0013-0000-0000-000020EBC9DA
Message-Id: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

the first test patch to fix the pgtable_bytes mis-accounting on s390
still had a few problems. For one it didn't work for x86 ..

Changes v1 -> v2:

 - Split the patch into three parts, one patch to add the mm_pxd_folded
   helpers, one patch to use to the helpers in mm_[dec|inc]_nr_[pmds|puds]
   and finally the fix for s390.

 - Drop the use of __is_defined, it does not work with the
   __PAGETABLE_PxD_FOLDED defines

 - Do not change the basic #ifdef'ery in mm.h, just add the calls
   to mm_pxd_folded to the pgtable_bytes accounting functions. This
   fixes the compile error on alpha (and potentially on other archs).

Martin Schwidefsky (3):
  mm: introduce mm_[p4d|pud|pmd]_folded
  mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
  s390/mm: fix mis-accounting of pgtable_bytes

 arch/s390/include/asm/mmu_context.h |  5 ----
 arch/s390/include/asm/pgalloc.h     |  6 ++---
 arch/s390/include/asm/pgtable.h     | 18 ++++++++++++++
 arch/s390/include/asm/tlb.h         |  6 ++---
 include/linux/mm.h                  | 48 +++++++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 11 deletions(-)

-- 
2.16.4

