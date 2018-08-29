Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B73B20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B73B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH3BqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:46:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbeH3BqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcqPV138069
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:21 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629dty1r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:21 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:20 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlGNM43057276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E933B2064;
        Wed, 29 Aug 2018 17:46:12 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D8A1B205F;
        Wed, 29 Aug 2018 17:46:12 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:12 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7C68016C3063; Wed, 29 Aug 2018 14:47:16 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:47:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
 <CA+55aFzyycJWD2xuo7wSptJ=D045yiZnmO+7iY6CapDvge_uCw@mail.gmail.com>
 <20180308204524.GW3918@linux.vnet.ibm.com>
 <20180410234425.GA30784@linux.vnet.ibm.com>
 <20180608165134.GA28693@linux.vnet.ibm.com>
 <20180627222835.GA9656@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627222835.GA9656@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082921-0064-0000-0000-00000343FBD4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0065-0000-0000-00003A782F36
Message-Id: <20180829214716.GA25597@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 03:28:35PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 08, 2018 at 09:51:34AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 10, 2018 at 04:44:25PM -0700, Paul E. McKenney wrote:
> > > On Thu, Mar 08, 2018 at 12:45:24PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Mar 07, 2018 at 10:48:50AM -0800, Linus Torvalds wrote:
> > > > > On Wed, Mar 7, 2018 at 7:54 AM, Paul E. McKenney
> > > > > <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >
> > > > > > Ah, and any thoughts on how best to get feedback from the various people
> > > > > > who would need to reprogram their fingers?  Or is everyone already on
> > > > > > board with changing these various names?
> > > > > 
> > > > > I really would prefer to not see massive re-naming unless there is a
> > > > > really good reason for it.
> > > > > 
> > > > > I'm all for simplifying RCU from a million different versions down to
> > > > > just a few thousand, but I'm definitely not convinced we want to do
> > > > > any search-and-replace.
> > > > 
> > > > I am currently in the design (more accurately, reredesign phase) for
> > > > the simplification.  It is quite possible that there is a good reason
> > > > for at least some renaming, but in that case, I would come back later
> > > > with that as a separate proposal.
> > > 
> > > And I really am still working on this.  It is a bit tricky, but still
> > > looks doable.  More likely to be ready for 4.19 than 4.18, though.
> > 
> > I suppose it is well past time for an update...
> > 
> > I believe I have the preparation work done (famous last words!), and I am
> > now working on making rcutorture properly test the resulting compound RCU
> > read-side critical sections.  User-level testing might be necessary (and
> > has been for some of the preparatory work).  The ink-on-paper prototype
> > is starting to look promising, and I expect to get the corresponding
> > prototype patch posted by the end of this month.
> > 
> > A bit trickier than I expected (as usual), but still looking doable.
> 
> And it now passes light rcutorture testing, so I have posted an RFC
> series to LKML:
> 
> lkml.kernel.org/r/20180627204835.GA25456@linux.vnet.ibm.com
> 
> There will be a long series of cleanups that will remove the other
> flavors and also the code that supports multiple flavors, but there are
> probably quite a few bugs to fix in this particular patch between now
> and then.  ;-)

If anything, the new consolidated-flavor version is now more stable than
the old one ever was.  So I am posting the consolidation patch and a
lot of cleanup patches.  Taken together, these reduce the size of RCU
by more than 400 lines of code.

The cleanups for the next merge window are confined to RCU itself.
For the merge window after that, I will have cleanups outside of RCU,
for example, replacing synchronize_sched() and synchronize_rcu_bh()
with synchronize_rcu() and removing synchronize_rcu_mult().

							Thanx, Paul

