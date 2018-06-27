Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E4424815
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E4424815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966397AbeF0W0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:26:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755065AbeF0W0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:26:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RMOuXg077898
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 18:26:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvjy5gw4d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 18:26:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 18:26:33 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 18:26:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RMQSDq5243252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 22:26:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9A4B205F;
        Wed, 27 Jun 2018 18:26:20 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA77DB2065;
        Wed, 27 Jun 2018 18:26:20 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 18:26:20 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EF64316C1222; Wed, 27 Jun 2018 15:28:35 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:28:35 -0700
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
References: <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
 <CA+55aFzyycJWD2xuo7wSptJ=D045yiZnmO+7iY6CapDvge_uCw@mail.gmail.com>
 <20180308204524.GW3918@linux.vnet.ibm.com>
 <20180410234425.GA30784@linux.vnet.ibm.com>
 <20180608165134.GA28693@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608165134.GA28693@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062722-0072-0000-0000-0000037625B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009266; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053254; UDB=6.00540020; IPR=6.00831178;
 MB=3.00021891; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 22:26:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062722-0073-0000-0000-00004882D3D6
Message-Id: <20180627222835.GA9656@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 09:51:34AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 10, 2018 at 04:44:25PM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 08, 2018 at 12:45:24PM -0800, Paul E. McKenney wrote:
> > > On Wed, Mar 07, 2018 at 10:48:50AM -0800, Linus Torvalds wrote:
> > > > On Wed, Mar 7, 2018 at 7:54 AM, Paul E. McKenney
> > > > <paulmck@linux.vnet.ibm.com> wrote:
> > > > >
> > > > > Ah, and any thoughts on how best to get feedback from the various people
> > > > > who would need to reprogram their fingers?  Or is everyone already on
> > > > > board with changing these various names?
> > > > 
> > > > I really would prefer to not see massive re-naming unless there is a
> > > > really good reason for it.
> > > > 
> > > > I'm all for simplifying RCU from a million different versions down to
> > > > just a few thousand, but I'm definitely not convinced we want to do
> > > > any search-and-replace.
> > > 
> > > I am currently in the design (more accurately, reredesign phase) for
> > > the simplification.  It is quite possible that there is a good reason
> > > for at least some renaming, but in that case, I would come back later
> > > with that as a separate proposal.
> > 
> > And I really am still working on this.  It is a bit tricky, but still
> > looks doable.  More likely to be ready for 4.19 than 4.18, though.
> 
> I suppose it is well past time for an update...
> 
> I believe I have the preparation work done (famous last words!), and I am
> now working on making rcutorture properly test the resulting compound RCU
> read-side critical sections.  User-level testing might be necessary (and
> has been for some of the preparatory work).  The ink-on-paper prototype
> is starting to look promising, and I expect to get the corresponding
> prototype patch posted by the end of this month.
> 
> A bit trickier than I expected (as usual), but still looking doable.

And it now passes light rcutorture testing, so I have posted an RFC
series to LKML:

lkml.kernel.org/r/20180627204835.GA25456@linux.vnet.ibm.com

There will be a long series of cleanups that will remove the other
flavors and also the code that supports multiple flavors, but there are
probably quite a few bugs to fix in this particular patch between now
and then.  ;-)

							Thanx, Paul

