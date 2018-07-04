Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EDC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DCE2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DCE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeGDNYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753155AbeGDNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:24:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64DNXMF136298
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 09:24:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0uterkgy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:24:18 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 14:24:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 14:24:14 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64DODAW25428208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 13:24:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 626B6A4059;
        Wed,  4 Jul 2018 16:24:38 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12E3A404D;
        Wed,  4 Jul 2018 16:24:37 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 16:24:37 +0100 (BST)
Date:   Wed, 4 Jul 2018 16:24:11 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180704130500.GP22503@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704130500.GP22503@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070413-0028-0000-0000-000002D82357
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070413-0029-0000-0000-0000238FAAFF
Message-Id: <20180704132410.GH4352@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 03:05:00PM +0200, Michal Hocko wrote:
> On Tue 03-07-18 20:05:06, Mike Rapoport wrote:
> > Most functions in memblock already use phys_addr_t to represent a physical
> > address with __memblock_free_late() being an exception.
> > 
> > This patch replaces u64 with phys_addr_t in __memblock_free_late() and
> > switches several format strings from %llx to %pa to avoid casting from
> > phys_addr_t to u64.
> > 
> > CC: Michal Hocko <mhocko@kernel.org>
> > CC: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  mm/memblock.c | 46 +++++++++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 03d48d8..20ad8e9 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -330,7 +330,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> >  {
> >  	struct memblock_region *new_array, *old_array;
> >  	phys_addr_t old_alloc_size, new_alloc_size;
> > -	phys_addr_t old_size, new_size, addr;
> > +	phys_addr_t old_size, new_size, addr, new_end;
> >  	int use_slab = slab_is_available();
> >  	int *in_slab;
> >  
> > @@ -391,9 +391,9 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> >  		return -1;
> >  	}
> >  
> > -	memblock_dbg("memblock: %s is doubled to %ld at [%#010llx-%#010llx]",
> > -			type->name, type->max * 2, (u64)addr,
> > -			(u64)addr + new_size - 1);
> > +	new_end = addr + new_size - 1;
> > +	memblock_dbg("memblock: %s is doubled to %ld at [%pa-%pa]",
> > +			type->name, type->max * 2, &addr, &new_end);
> 
> I didn't get to check this carefully but this surely looks suspicious. I
> am pretty sure you wanted to print the value here rather than address of
> the local variable, right?

It's the semantics of %pa:

Physical address types phys_addr_t
----------------------------------

::

	%pa[p]	0x01234567 or 0x0123456789abcdef

For printing a phys_addr_t type (and its derivatives, such as
resource_size_t) which can vary based on build options, regardless of the
width of the CPU data path.

Passed by reference.


> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

