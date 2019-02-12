Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55CA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfBLOlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:41:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbfBLOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:41:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CEd74n034280
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:41:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkyk3sske-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:41:01 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 12 Feb 2019 14:40:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 14:40:56 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CEetRV51707922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 14:40:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14FDA5205A;
        Tue, 12 Feb 2019 14:40:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.59.139])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 83CC752051;
        Tue, 12 Feb 2019 14:40:54 +0000 (GMT)
Date:   Tue, 12 Feb 2019 16:40:52 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: use memblock_alloc() instead of custom
 get_memblock()
References: <1549979990-6642-1-git-send-email-rppt@linux.ibm.com>
 <20190212141418.GM12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212141418.GM12668@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021214-0016-0000-0000-000002558FC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021214-0017-0000-0000-000032AFB1EE
Message-Id: <20190212144052.GB20902@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:14:18AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 12, 2019 at 03:59:50PM +0200, Mike Rapoport wrote:
> > -static void * __init get_memblock(unsigned long size)
> > -{
> > -	static phys_addr_t search_addr __initdata;
> > -	phys_addr_t phys;
> > -
> > -	if (!search_addr)
> > -		search_addr = PAGE_ALIGN(__pa((unsigned long) &_end));
> > -	search_addr = ALIGN(search_addr, size);
> > -	while (!memblock_is_region_memory(search_addr, size) ||
> > -		memblock_is_region_reserved(search_addr, size)) {
> > -		search_addr += size;
> > -	}
> > -	phys = search_addr;
> 
> This implies to me that the allocation will be 'size' aligned.
> 
> >  		if (!pmd) {
> > -			pmd = (pmd_t *) get_memblock(PAGE_SIZE << PMD_ORDER);
> > +			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
> > +					     SMP_CACHE_BYTES);
> 
> So why would this only need to be cacheline aligned?  It's pretty common
> for hardware to require that pgd/pud/pmd/pte tables be naturally aligned.
> 
> > @@ -700,7 +683,10 @@ static void __init pagetable_init(void)
> >  	}
> >  #endif
> >  
> > -	empty_zero_page = get_memblock(PAGE_SIZE);
> > +	empty_zero_page = memblock_alloc(PAGE_SIZE, SMP_CACHE_BYTES);
> 
> ... and surely the zero page also needs to be page aligned, by definition.
 
Right, I've completely missed the alignment. Will fix.

-- 
Sincerely yours,
Mike.

