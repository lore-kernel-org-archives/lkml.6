Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882022064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882022064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeIFR0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:26:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727678AbeIFR0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:26:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86Cmw9d043943
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 08:50:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb3t12dwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:50:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 13:50:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 13:50:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86Cojqr40632516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 12:50:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F7E4C044;
        Thu,  6 Sep 2018 15:50:39 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF954C050;
        Thu,  6 Sep 2018 15:50:38 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 15:50:38 +0100 (BST)
Date:   Thu, 6 Sep 2018 15:50:42 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 16/29] memblock: replace __alloc_bootmem_node with
 appropriate memblock_ API
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-17-git-send-email-rppt@linux.vnet.ibm.com>
 <20180906083841.GA14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906083841.GA14951@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090612-0020-0000-0000-000002C22E1C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090612-0021-0000-0000-0000210F6479
Message-Id: <20180906125041.GG27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:38:41AM +0200, Michal Hocko wrote:
> On Wed 05-09-18 18:59:31, Mike Rapoport wrote:
> > Use memblock_alloc_try_nid whenever goal (i.e. mininal address is
> > specified) and memblock_alloc_node otherwise.
> 
> I suspect you wanted to say (i.e. minimal address) is specified

Yep
 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> One note below
> 
> > ---
> >  arch/ia64/mm/discontig.c       |  6 ++++--
> >  arch/ia64/mm/init.c            |  2 +-
> >  arch/powerpc/kernel/setup_64.c |  6 ++++--
> >  arch/sparc/kernel/setup_64.c   | 10 ++++------
> >  arch/sparc/kernel/smp_64.c     |  4 ++--
> >  5 files changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> > index 1928d57..918dda9 100644
> > --- a/arch/ia64/mm/discontig.c
> > +++ b/arch/ia64/mm/discontig.c
> > @@ -451,8 +451,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
> >  	if (bestnode == -1)
> >  		bestnode = anynode;
> >  
> > -	ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
> > -		PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
> > +	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
> > +				     __pa(MAX_DMA_ADDRESS),
> > +				     BOOTMEM_ALLOC_ACCESSIBLE,
> > +				     bestnode);
> >  
> >  	return ptr;
> >  }
> > diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> > index ffcc358..2169ca5 100644
> > --- a/arch/ia64/mm/init.c
> > +++ b/arch/ia64/mm/init.c
> > @@ -459,7 +459,7 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
> >  		pte = pte_offset_kernel(pmd, address);
> >  
> >  		if (pte_none(*pte))
> > -			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node))) >> PAGE_SHIFT,
> > +			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
> >  					     PAGE_KERNEL));
> 
> This doesn't seem to belong to the patch, right?

Right, will fix.
 
> >  	}
> >  	return 0;
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

