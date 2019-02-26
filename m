Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56A2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfBZLMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:12:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbfBZLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:12:54 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QBC3BQ111110
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:12:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qw2ajygnr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:12:36 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 11:12:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 11:12:02 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QBC1eB31064226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 11:12:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74FAB42041;
        Tue, 26 Feb 2019 11:12:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB7542042;
        Tue, 26 Feb 2019 11:12:00 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 11:12:00 +0000 (GMT)
Date:   Tue, 26 Feb 2019 13:11:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
References: <20190214125704.6678-1-peng.fan@nxp.com>
 <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
 <b78470e8-b204-4a7e-f9cc-eff9c609f480@suse.cz>
 <20190219174610.GA32749@rapoport-lnx>
 <AM0PR04MB448139C6E264579818E94CF6887F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB448139C6E264579818E94CF6887F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022611-0028-0000-0000-0000034D2B68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022611-0029-0000-0000-0000240B7E14
Message-Id: <20190226111158.GF11981@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:55:41PM +0000, Peng Fan wrote:
> 
> 
> > -----Original Message-----
> > From: Mike Rapoport [mailto:rppt@linux.ibm.com]
> > Sent: 2019年2月20日 1:46
> > To: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Andrew Morton <akpm@linux-foundation.org>; Peng Fan
> > <peng.fan@nxp.com>; labbott@redhat.com; mhocko@suse.com;
> > iamjoonsoo.kim@lge.com; rppt@linux.vnet.ibm.com;
> > m.szyprowski@samsung.com; rdunlap@infradead.org;
> > andreyknvl@google.com; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> > van.freenix@gmail.com; Catalin Marinas <catalin.marinas@arm.com>
> > Subject: Re: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
> > 
> > On Tue, Feb 19, 2019 at 05:55:33PM +0100, Vlastimil Babka wrote:
> > > On 2/14/19 9:38 PM, Andrew Morton wrote:
> > > > On Thu, 14 Feb 2019 12:45:51 +0000 Peng Fan <peng.fan@nxp.com>
> > wrote:
> > > >
> > > >> In case cma_init_reserved_mem failed, need to free the memblock
> > > >> allocated by memblock_reserve or memblock_alloc_range.
> > > >>
> > > >> ...
> > > >>
> > > >> --- a/mm/cma.c
> > > >> +++ b/mm/cma.c
> > > >> @@ -353,12 +353,14 @@ int __init
> > cma_declare_contiguous(phys_addr_t
> > > >> base,
> > > >>
> > > >>  	ret = cma_init_reserved_mem(base, size, order_per_bit, name,
> > res_cma);
> > > >>  	if (ret)
> > > >> -		goto err;
> > > >> +		goto free_mem;
> > > >>
> > > >>  	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
> > > >>  		&base);
> > > >>  	return 0;
> > > >>
> > > >> +free_mem:
> > > >> +	memblock_free(base, size);
> > > >>  err:
> > > >>  	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
> > > >>  	return ret;
> > > >
> > > > This doesn't look right to me.  In the `fixed==true' case we didn't
> > > > actually allocate anything and in the `fixed==false' case, the
> > > > allocated memory is at `addr', not at `base'.
> > >
> > > I think it's ok as the fixed==true path has "memblock_reserve()", but
> > > better leave this to the memblock maintainer :)
> > 
> > As Peng Fan noted in the other e-mail, fixed==true has memblock_reserve()
> > and fixed==false resets base = addr, so this is Ok.
> > 
> > > There's also 'kmemleak_ignore_phys(addr)' which should probably be
> > > undone (or not called at all) in the failure case. But it seems to be
> > > missing from the fixed==true path?
> > 
> > Well, memblock and kmemleak interaction does not seem to have clear
> > semantics anyway. memblock_free() calls kmemleak_free_part_phys() which
> > does not seem to care about ignored objects.
> > As for the fixed==true path, memblock_reserve() does not register the area
> > with kmemleak, so there would be no object to free in memblock_free().
> > AFAIU, kmemleak simply ignores this.
> 
> I also go through the memblock_free flow, and agree with Mike
> memblock_free 
>     -> kmemleak_free_part_phys 
>           -> kmemleak_free_part
>                  |-> delete_object_part
>                          |-> object = find_and_remove_object(ptr, 1);
> 
> memblock_reserve not register the area in kmemleak, so find_and_remove_object
> will not be able to find a valid area and just return.
> 
> What should I do next with this patch?
 
I'd suggest to wait for Catalin to review it.

I think it's also worth making the changelog more elaborate and include the
details we've discussed in this thread.

> Thanks,
> Peng.
> 
> > 
> > Catalin, can you comment please?
> > 
> > --
> > Sincerely yours,
> > Mike.
> 

-- 
Sincerely yours,
Mike.

