Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9385C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEEF20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEEF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeLCQ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:28:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbeLCQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:28:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3GQTg3125980
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 11:28:32 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p5685e5my-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:28:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 3 Dec 2018 16:28:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 16:28:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3GSKaf25690160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 16:28:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99EB6A4054;
        Mon,  3 Dec 2018 16:28:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55F64A4060;
        Mon,  3 Dec 2018 16:28:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Dec 2018 16:28:18 +0000 (GMT)
Date:   Mon, 3 Dec 2018 18:28:16 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
 <20181203161052.GA4244@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203161052.GA4244@ravnborg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120316-4275-0000-0000-000002EB6519
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120316-4276-0000-0000-000037F86955
Message-Id: <20181203162816.GA26700@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:10:52PM +0100, Sam Ravnborg wrote:
> Hi Mike.
> 
> On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> > Rather than use the memblock_alloc_base that returns a physical address and
> > then convert this address to the virtual one, use appropriate memblock
> > function that returns a virtual address.
> > 
> > There is a small functional change in the allocation of then NODE_DATA().
> > Instead of panicing if the local allocation failed, the non-local
> > allocation attempt will be made.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/sh/mm/init.c | 18 +++++-------------
> >  arch/sh/mm/numa.c |  5 ++---
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index c8c13c77..3576b5f 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
> >  void __init allocate_pgdat(unsigned int nid)
> >  {
> >  	unsigned long start_pfn, end_pfn;
> > -#ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	unsigned long phys;
> > -#endif
> >  
> >  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >  
> >  #ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> > -	/* Retry with all of system memory */
> > -	if (!phys)
> > -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> > -	if (!phys)
> > +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> > +				sizeof(struct pglist_data),
> > +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> > +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > +	if (!NODE_DATA(nid))
> >  		panic("Can't allocate pgdat for node %d\n", nid);
> > -
> > -	NODE_DATA(nid) = __va(phys);
> > -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
> The new code will always assign NODE_DATA(nid), where the old
> code only assigned NODE_DATA(nid) in the good case.
> I dunno if this is an issue, just noticed the difference and
> wanted to point it out.

If the allocation fails the NODE_DATA(nid) remains zero anyway and there is
a panic() call. So I think there is no actual functional change here.

> 	Sam
> 

-- 
Sincerely yours,
Mike.

