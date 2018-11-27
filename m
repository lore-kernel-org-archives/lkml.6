Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21367208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21367208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeK1B33 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:29:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbeK1B32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:29:28 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAREU5eL131760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:31:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p15q15j0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:31:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 27 Nov 2018 14:31:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 14:31:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAREVFhX62980338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 14:31:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B1F42042;
        Tue, 27 Nov 2018 14:31:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E0A74203F;
        Tue, 27 Nov 2018 14:31:15 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 14:31:15 +0000 (GMT)
Date:   Tue, 27 Nov 2018 15:31:14 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Wang <liwang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
In-Reply-To: <20181127073411.GA3625@osiris>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
        <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
        <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
        <20181031073149.55ddc085@mschwideX1>
        <20181031100944.GA3546@osiris>
        <20181031103623.6ykzsjdenrpeth7x@kshutemo-mobl1>
        <20181127073411.GA3625@osiris>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18112714-0028-0000-0000-000003223E25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112714-0029-0000-0000-000023DE470F
Message-Id: <20181127153114.0a6193d3@mschwideX1>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 08:34:12 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Wed, Oct 31, 2018 at 01:36:23PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 31, 2018 at 11:09:44AM +0100, Heiko Carstens wrote:  
> > > On Wed, Oct 31, 2018 at 07:31:49AM +0100, Martin Schwidefsky wrote:  
> > > > Thanks for testing. Unfortunately Heiko reported another issue yesterday
> > > > with the patch applied. This time the other way around:
> > > > 
> > > > BUG: non-zero pgtables_bytes on freeing mm: -16384
> > > > 
> > > > I am trying to understand how this can happen. For now I would like to
> > > > keep the patch on hold in case they need another change.  
> > > 
> > > FWIW, Kirill: is there a reason why this "BUG:" output is done with
> > > pr_alert() and not with VM_BUG_ON() or one of the WARN*() variants?
> > > 
> > > That would to get more information with DEBUG_VM and / or
> > > panic_on_warn=1 set. At least for automated testing it would be nice
> > > to have such triggers.  
> > 
> > Stack trace is not helpful there. It will always show the exit path which
> > is useless.  
> 
> So, even with the updated version of these patches I can flood dmesg
> and the console with
> 
> BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> messages with this complex reproducer on s390:
> 
> echo "void main(void) {}" | gcc -m31 -xc -o compat - && ./compat

Forgot a hunk in the fix.. I claim not enough coffee :-/
Patch is queued and I will send a please pull by the end of the week.
--
From c0499f2aa853939984ecaf0d393012486e56c7ce Mon Sep 17 00:00:00 2001
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 27 Nov 2018 14:04:04 +0100
Subject: [PATCH] s390/mm: correct pgtable_bytes on page table downgrade

The downgrade of a page table from 3 levels to 2 levels for a 31-bit compat
process removes a pmd table which has to be counted against pgtable_bytes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/pgalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 814f26520aa2..6791562779ee 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -131,6 +131,7 @@ void crst_table_downgrade(struct mm_struct *mm)
 	}
 
 	pgd = mm->pgd;
+	mm_dec_nr_pmds(mm);
 	mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
 	mm->context.asce_limit = _REGION3_SIZE;
 	mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-- 
2.16.4
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

