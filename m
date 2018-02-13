Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeBMBiB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:38:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933164AbeBMBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:37:59 -0500
Date: Mon, 12 Feb 2018 17:38:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
 <20180211115148.iylaqk3f53f2vgf4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211115148.iylaqk3f53f2vgf4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021301-0052-0000-0000-000002B43013
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008524; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000252; SDB=6.00988892; UDB=6.00502082; IPR=6.00768246;
 BA=6.00005825; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019523; XFM=3.00000015;
 UTC=2018-02-13 01:37:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021301-0053-0000-0000-000053902FF4
Message-Id: <20180213013803.GI3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 12:51:48PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
> > > >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
> > > From: Akira Yokosawa <akiyks@gmail.com>
> > > Date: Fri, 9 Feb 2018 04:51:05 -0800
> > > Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
> > > 
> > > As of herd7 7.47, these '-'s are not permitted and end up in
> > > errors such as:
> > > 
> > >     File "./linux-kernel.def", line 44, characters 29-30:
> > >     unexpected '-' (in macros)
> > > 
> > > Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
> > > identifiers match ASPLOS paper") in the repository at
> > > https://github.com/aparri/memory-model can restore the compatibility
> > > with herd7 7.47.
> > > 
> > > Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > > Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> > > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > > ---
> > > Paul,
> > > 
> > > FWIW, this is a squashed version relative to patch 07/10 in the RFC series.
> > 
> > Thank you, Akira!
> > 
> > I am going to hold off on this for a bit to see if we can instead get
> > a new release of herd7, but if we can't. this might well be a very good
> > way to go.
> 
> I'm wondering:
> 
> > >  // RCU
> > > -rcu_read_lock() { __fence{rcu-lock}; }
> > > -rcu_read_unlock() { __fence{rcu-unlock};}
> > > -synchronize_rcu() { __fence{sync-rcu}; }
> > > -synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > > +rcu_read_lock() { __fence{rcu_lock}; }
> > > +rcu_read_unlock() { __fence{rcu_unlock};}
> > > +synchronize_rcu() { __fence{sync_rcu}; }
> > > +synchronize_rcu_expedited() { __fence{sync_rcu}; }
> 
> What's the point of using '-' instead of '_'? In a program language syntax 
> environment it's easy to confuse it with a '-' operator, and it also looks 
> slightly sloppy and inconsistent if we sometimes have '_' and sometimes '-'.
> 
> If it used on purpose, to separate namespaces from kernel internal API names,
> then that's rather obscure IMHO and then I'd rather suggest proper prefixes 
> instead.

These lines are connecting Linux-kernel names to cat-language names.
The cat language can be thought of as a set-based constraint language,
which doesn't have subtraction (the closest analog being set difference,
which is denoted by "\").  Cat-language code has used "-" as a word
separator in names, and the model had previously had an odd mixture of
"-" and "_".  Hence, the switch to the cat-language convention.

Of course, if underscore is strongly preferred, underscore does work,
and it should be possible to move in that direction.

							Thanx, Paul
