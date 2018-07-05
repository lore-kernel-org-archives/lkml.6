Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D505C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CA2406E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0CA2406E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeGEX3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:29:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753421AbeGEX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:29:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65NT8QD020419
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 19:29:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1ugfuaev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 19:29:13 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 19:29:12 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 19:29:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65NT8ag9044424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 23:29:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED66B2064;
        Thu,  5 Jul 2018 19:28:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D73DB205F;
        Thu,  5 Jul 2018 19:28:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 19:28:48 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 181EC16CA5C1; Thu,  5 Jul 2018 16:31:24 -0700 (PDT)
Date:   Thu, 5 Jul 2018 16:31:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com>
 <20180705165602.GQ3593@linux.vnet.ibm.com>
 <eeaf2ad2-39a0-2ce9-b628-6775baad4e8a@nvidia.com>
 <20180705183836.GA3175@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705183836.GA3175@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070523-0064-0000-0000-00000325C177
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009315; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057115; UDB=6.00542337; IPR=6.00835035;
 MB=3.00022015; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 23:29:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070523-0065-0000-0000-000039D59330
Message-Id: <20180705233124.GX3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:38:36PM +0200, Andrea Parri wrote:
> > No, I'm definitely not pushing for anything stronger.  I'm still just
> > wondering if the name "RCsc" is right for what you described.  For
> > example, Andrea just said this in a parallel email:
> > 
> > > "RCsc" as ordering everything except for W -> R, without the [extra]
> > > barriers
> 
> And I already regret it: the point is, different communities/people have
> different things in mind when they use terms such as "RCsc" or "ordering"
> and different communities seems to be represented in LKMM.

How about "RCsb" for release-consistency store buffering?  (Sorry,
couldn't resist...)

> Really, I don't think that this is simply a matter of naming (personally,
> I'd be OK with "foo" or whather you suggested below! ;-)). My suggestion
> would be: "get in there!! ;-) please let's refrain from using terms such
> as these (_overly_ overloaded) "RCsc" and "order" when talking about MCM
> let's rather talk, say, about "ppo", "cumul-fence" ...

What is in a name?  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > If it's "RCsc with exceptions", doesn't it make sense to find a
> > different name, rather than simply overloading the term "RCsc" with
> > a subtly different meaning, and hoping nobody gets confused?
> > 
> > I suppose on x86 and ARM you'd happen to get "true RCsc" anyway, just
> > due to the way things are currently mapped: LOCKed RMWs and "true RCsc"
> > instructions, respectively.  But on Power and RISC-V, it would really
> > be more "RCsc with a W->R exception", right?
> > 
> > In fact, the more I think about it, this doesn't seem to be RCsc at all.
> > It seems closer to "RCpc plus extra PC ordering between critical
> > sections".  No?
> > 
> > The synchronization accesses themselves aren't sequentially consistent
> > with respect to each other under the Power or RISC-V mappings, unless
> > there's a hwsync in there somewhere that I missed?  Or a rule
> > preventing stw from forwarding to lwarx?  Or some other higher-order
> > effect preventing it from being observed anyway?
> > 
> > So that's all I'm suggesting here.  If you all buy that, maybe "RCpccs"
> > for "RCpc with processor consistent critical section ordering"?
> > I don't have a strong opinion on the name itself; I just want to find
> > a name that's less ambiguous or overloaded.
> > 
> > Dan
> 

