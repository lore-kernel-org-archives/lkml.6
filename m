Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B14C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78622146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78622146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeLEVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:22:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbeLEVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:22:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB5LEQkB083910
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 16:22:41 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p6nq5hybm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:22:41 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 5 Dec 2018 21:22:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Dec 2018 21:22:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB5LMVLH56098844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 21:22:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFAD5A405B;
        Wed,  5 Dec 2018 21:22:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EF2A4060;
        Wed,  5 Dec 2018 21:22:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.89])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Dec 2018 21:22:29 +0000 (GMT)
Date:   Wed, 5 Dec 2018 23:22:27 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
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
Subject: Re: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual
 address
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
 <87woophasy.fsf@concordia.ellerman.id.au>
 <20181204171327.GL26700@rapoport-lnx>
 <87mupkkv3b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mupkkv3b.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120521-0028-0000-0000-00000326A21B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120521-0029-0000-0000-000023E2B09E
Message-Id: <20181205212226.GF19181@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:37:44PM +1100, Michael Ellerman wrote:
> Mike Rapoport <rppt@linux.ibm.com> writes:
> > On Tue, Dec 04, 2018 at 08:59:41PM +1100, Michael Ellerman wrote:
> >> Hi Mike,
> >> 
> >> Thanks for trying to clean these up.
> >> 
> >> I think a few could be improved though ...
> >> 
> >> Mike Rapoport <rppt@linux.ibm.com> writes:
> >> > diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> >> > index 913bfca..fa884ad 100644
> >> > --- a/arch/powerpc/kernel/paca.c
> >> > +++ b/arch/powerpc/kernel/paca.c
> >> > @@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
> >> >  		nid = early_cpu_to_node(cpu);
> >> >  	}
> >> >  
> >> > -	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
> >> > -	if (!pa) {
> >> > -		pa = memblock_alloc_base(size, align, limit);
> >> > -		if (!pa)
> >> > -			panic("cannot allocate paca data");
> >> > -	}
> >> > +	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
> >> > +					 limit, nid);
> >> > +	if (!ptr)
> >> > +		panic("cannot allocate paca data");
> >>   
> >> The old code doesn't zero, but two of the three callers of
> >> alloc_paca_data() *do* zero the whole allocation, so I'd be happy if we
> >> did it in here instead.
> >
> > I looked at the callers and couldn't tell if zeroing memory in
> > init_lppaca() would be ok.
> > I'll remove the _raw here.
>   
> Thanks.
> 
> >> That would mean we could use memblock_alloc_try_nid() avoiding the need
> >> to panic() manually.
> >
> > Actual, my plan was to remove panic() from all memblock_alloc* and make all
> > callers to check the returned value.
> > I believe it's cleaner and also allows more meaningful panic messages. Not
> > mentioning the reduction of memblock code.
> 
> Hmm, not sure.
> 
> I see ~200 calls to the panicking functions, that seems like a lot of
> work to change all those.

Yeah, I know :)

> And I think I disagree on the "more meaningful panic message". This is a
> perfect example, compare:
> 
> 	panic("cannot allocate paca data");
> to:
> 	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
> 	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);
> 
> The former is basically useless, whereas the second might at least give
> you a hint as to *why* the allocation failed.

We can easily keep the memblock message, just make it pr_err instead of
panic.
The message at the call site can show where the problem was without the
need to dive into the stack dump.

> I know it's kind of odd for a function to panic() rather than return an
> error, but memblock is kind of special because it's so early in boot.
> Most of these allocations have to succeed to get the system up and
> running.

The downside of having panic() inside some memblock functions is that it
makes the API way too bloated. And, at least currently, it's inconsistent.
For instance memblock_alloc_try_nid_raw() does not panic, but
memblock_alloc_try_nid() does.

When it was about 2 functions and a wrapper, it was perfectly fine, but
since than memblock has three sets of partially overlapping APIs with
endless convenience wrappers.

I believe that patching up ~200 calls is worth the reduction of memblock
API to saner size.

Another thing, the absence of check for return value for memory allocation
is not only odd, but it also makes the code obfuscated.
 
> cheers
> 

-- 
Sincerely yours,
Mike.

