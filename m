Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78250C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444372147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAGTC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:02:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728312AbfAGTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:02:23 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07IhuUL089162
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 14:02:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvb4cd1n5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:02:22 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 7 Jan 2019 19:02:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 19:02:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07J2Dgu22610062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 19:02:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F589B206A;
        Mon,  7 Jan 2019 19:02:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ABC6B206C;
        Mon,  7 Jan 2019 19:02:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 19:02:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1219816C14EE; Mon,  7 Jan 2019 11:02:36 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:02:36 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Reply-To: paulmck@linux.ibm.com
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
 <20190107094610.GA2861@worktop.programming.kicks-ass.net>
 <20190107082223-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107082223-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010719-0052-0000-0000-0000037443A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010362; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000273; SDB=6.01143148; UDB=6.00595104; IPR=6.00923399;
 MB=3.00025019; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-07 19:02:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010719-0053-0000-0000-00005F608915
Message-Id: <20190107190236.GF1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:
> > On Sun, Jan 06, 2019 at 11:23:07PM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Jan 07, 2019 at 11:58:23AM +0800, Jason Wang wrote:
> > > > On 2019/1/3 上午4:57, Michael S. Tsirkin wrote:
> > 
> > > > > +#if defined(COMPILER_HAS_OPTIMIZER_HIDE_VAR) && \
> > > > > +	!defined(ARCH_NEEDS_READ_BARRIER_DEPENDS)
> > > > > +
> > > > > +#define dependent_ptr_mb(ptr, val) ({					\
> > > > > +	long dependent_ptr_mb_val = (long)(val);			\
> > > > > +	long dependent_ptr_mb_ptr = (long)(ptr) - dependent_ptr_mb_val;	\
> > > > > +									\
> > > > > +	BUILD_BUG_ON(sizeof(val) > sizeof(long));			\
> > > > > +	OPTIMIZER_HIDE_VAR(dependent_ptr_mb_val);			\
> > > > > +	(typeof(ptr))(dependent_ptr_mb_ptr + dependent_ptr_mb_val);	\
> > > > > +})
> > > > > +
> > > > > +#else
> > > > > +
> > > > > +#define dependent_ptr_mb(ptr, val) ({ mb(); (ptr); })
> > > > 
> > > > 
> > > > So for the example of patch 4, we'd better fall back to rmb() or need a
> > > > dependent_ptr_rmb()?
> > > > 
> > > > Thanks
> > > 
> > > You mean for strongly ordered architectures like Intel?
> > > Yes, maybe it makes sense to have dependent_ptr_smp_rmb,
> > > dependent_ptr_dma_rmb and dependent_ptr_virt_rmb.
> > > 
> > > mb variant is unused right now so I'll remove it.
> > 
> > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > implications at all. The address dependency is strictly weaker than an
> > rmb in that it will only order the two loads in qestion and not, like
> > rmb, any prior to any later load.
> 
> So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> 
> 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> the madatory one can't, so assuming we do not want
> it to be stronger than rmp then either we want
> smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> or we just will specify that dependent_ptr() works for
> both DMA and SMP.
> 
> 2. Down the road, someone might want to order a store after a load.
> Address dependency does that for us too. Assuming we make
> dependent_ptr a NOP on x86, we will want an mb variant
> which isn't a NOP on x86. Will we want to rename
> dependent_ptr to dependent_ptr_rmb at that point?

But x86 preserves store-after-load orderings anyway, and even Alpha
respects ordering from loads to dependent stores.  So what am I missing
here?

							Thanx, Paul

