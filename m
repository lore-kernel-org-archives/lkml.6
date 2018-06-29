Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BAFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB90216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB90216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937449AbeF2UqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:46:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935900AbeF2UqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:46:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TKiYXN086165
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:46:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwtatuwft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:46:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 21:46:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 21:46:09 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TKk8pK17367210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 20:46:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12D1AE053;
        Fri, 29 Jun 2018 21:45:58 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3475AE055;
        Fri, 29 Jun 2018 21:45:57 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.81])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 21:45:57 +0100 (BST)
Date:   Fri, 29 Jun 2018 23:46:05 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH/RFC] mm: do not drop unused pages when userfaultd is
 running
References: <20180628123916.96106-1-borntraeger@de.ibm.com>
 <a2602470-a2b8-adc5-5057-fc8f489ab949@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2602470-a2b8-adc5-5057-fc8f489ab949@de.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18062920-0008-0000-0000-0000024E028F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062920-0009-0000-0000-000021B40295
Message-Id: <20180629204604.GF4799@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 08:51:23AM +0200, Christian Borntraeger wrote:
> 
> 
> On 06/28/2018 02:39 PM, Christian Borntraeger wrote:
> > KVM guests on s390 can notify the host of unused pages. This can result
> > in pte_unused callbacks to be true for KVM guest memory.
> > 
> > If a page is unused (checked with pte_unused) we might drop this page
> > instead of paging it. This can have side-effects on userfaultd, when the
> > page in question was already migrated:
> > 
> > The next access of that page will trigger a fault and a user fault
> > instead of faulting in a new and empty zero page. As QEMU does not
> > expect a userfault on an already migrated page this migration will fail.
> > 
> > The most straightforward solution is to ignore the pte_unused hint if a
> > userfault context is active for this VMA.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  mm/rmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 6db729dc4c50..3f3a72aa99f2 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1481,7 +1481,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >  				set_pte_at(mm, address, pvmw.pte, pteval);
> >  			}
> >  
> > -		} else if (pte_unused(pteval)) {
> > +		} else if (pte_unused(pteval) && !vma->vm_userfaultfd_ctx.ctx) {
> 
> FWIW, this needs a fix for !CONFIG_USERFAULTFD.

There's userfaultfd_armed() in include/linux/userfaultfd_k.h. Just
s/!vma->vm_userfaultfd_ctx.ctx/!userfaultfd_armed(vma)

> Still: more opinions on the patch itself? 

If the only use case for pte_unused() hint is guest notification for host,
the patch seems Ok to me.

> >  			/*
> >  			 * The guest indicated that the page content is of no
> >  			 * interest anymore. Simply discard the pte, vmscan
> > 
> 

-- 
Sincerely yours,
Mike.

