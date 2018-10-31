Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5804EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B6520821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B6520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJaP2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:28:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbeJaP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:28:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9V6KHjI037779
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:31:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nf3paxwma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:31:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 31 Oct 2018 06:31:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 06:31:52 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9V6Vpv965142844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 06:31:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6342952063;
        Wed, 31 Oct 2018 06:31:51 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.41.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 02A6D52052;
        Wed, 31 Oct 2018 06:31:50 +0000 (GMT)
Date:   Wed, 31 Oct 2018 07:31:49 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
In-Reply-To: <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
        <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
        <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18103106-0008-0000-0000-00000288D04B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103106-0009-0000-0000-000021F2EFD8
Message-Id: <20181031073149.55ddc085@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 14:18:33 +0800
Li Wang <liwang@redhat.com> wrote:

> On Tue, Oct 16, 2018 at 12:42 AM, Martin Schwidefsky <schwidefsky@de.ibm.com
> > wrote:  
> 
> > In case a fork or a clone system fails in copy_process and the error
> > handling does the mmput() at the bad_fork_cleanup_mm label, the
> > following warning messages will appear on the console:
> >
> >   BUG: non-zero pgtables_bytes on freeing mm: 16384
> >
> > The reason for that is the tricks we play with mm_inc_nr_puds() and
> > mm_inc_nr_pmds() in init_new_context().
> >
> > A normal 64-bit process has 3 levels of page table, the p4d level and
> > the pud level are folded. On process termination the free_pud_range()
> > function in mm/memory.c will subtract 16KB from pgtable_bytes with a
> > mm_dec_nr_puds() call, but there actually is not really a pud table.
> >
> > One issue with this is the fact that pgtable_bytes is usually off
> > by a few kilobytes, but the more severe problem is that for a failed
> > fork or clone the free_pgtables() function is not called. In this case
> > there is no mm_dec_nr_puds() or mm_dec_nr_pmds() that go together with
> > the mm_inc_nr_puds() and mm_inc_nr_pmds in init_new_context().
> > The pgtable_bytes will be off by 16384 or 32768 bytes and we get the
> > BUG message. The message itself is purely cosmetic, but annoying.
> >
> > To fix this override the mm_pmd_folded, mm_pud_folded and mm_p4d_folded
> > function to check for the true size of the address space.
> >  
> 
> I can confirm that it works to the problem, the warning message is gone
> after applying this patch on s390x. And I also done ltp syscalls/cve test
> for the patch set on x86_64 arch, there has no new regression.
> 
> Tested-by: Li Wang <liwang@redhat.com>

Thanks for testing. Unfortunately Heiko reported another issue yesterday
with the patch applied. This time the other way around:

BUG: non-zero pgtables_bytes on freeing mm: -16384

I am trying to understand how this can happen. For now I would like to
keep the patch on hold in case they need another change.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

