Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034048AbeCAShh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:37:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033985AbeCAShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:37:35 -0500
Date: Thu, 1 Mar 2018 10:37:58 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v2 RFC] tools/memory-model: redefine rb in terms of
 rcu-fence
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180301015531.olvuu5g35eta5xhr@tardis>
 <Pine.LNX.4.44L0.1803011027120.1394-100000@iolanthe.rowland.org>
 <20180301174906.GC3777@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301174906.GC3777@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030118-0036-0000-0000-000002C8D283
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996903; UDB=6.00506853; IPR=6.00776221;
 MB=3.00019804; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-01 18:37:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030118-0037-0000-0000-000043818703
Message-Id: <20180301183758.GA31761@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010229
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 09:49:06AM -0800, Paul E. McKenney wrote:
> On Thu, Mar 01, 2018 at 10:49:05AM -0500, Alan Stern wrote:
> > On Thu, 1 Mar 2018, Boqun Feng wrote:
> > 
> > > > +let rec rcu-fence = gp |
> > > > +	(gp ; rcu-link ; rscs) |
> > > > +	(rscs ; rcu-link ; gp) |
> > > > +	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> > > > +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> > > > +	(rcu-fence ; rcu-link ; rcu-fence)
> > > > +
> > > > +(* rb orders instructions just as pb does *)
> > > > +let rb = prop ; rcu-fence ; hb* ; pb*
> > > >  
> > > >  irreflexive rb as rcu
> > > 
> > > I wonder whether we can simplify things as:
> > > 
> > > 	let rec rcu-fence =
> > > 	    (gp; rcu-link; rscs) |
> > > 	    (rscs; rcu-link; gp) |
> > > 	    (gp; rcu-link; rcu-fence; rcu-link; rscs) |
> > > 	    (rscs; rcu-link; rcu-fence; rcu-link; gp)
> > > 	
> > > 	(* gp and rcu-fence; rcu-link; rcu-fence removed *)
> > > 	
> > > 	let rb = prop; rcu-fence; hb*; pb*
> > > 
> > > 	acycle rb as rcu
> > > 
> > > In this way, "rcu-fence" is defined as "any sequence containing as many
> > > grace periods as RCU read-side critical sections (joined by rcu-link)."
> > > Note that "rcu-link" contains "gp", so we don't miss the case where
> > > there are more grace periods. And since we use "acycle" now, so we don't
> > > need "rcu-fence; rcu-link; rcu-fence" to build "rcu-fence" recursively.
> > 
> > Would this definition of rcu-fence work for a sequence such as (leaving
> > out the intermediate rcu-link parts):
> > 
> > 	gp gp gp rscs rscs gp rscs rscs
> > 
> > ?  I don't think it would.  Yes, if you had a cycle of that form then 
> > your "rcu" axiom would detect it, but at some point we might want to 
> > use rcu-fence for some other purpose, one that doesn't involve cycles.
> 
> Let's see, that would map to this:
> 
> auto/RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R.litmus
> 
> And no, there is no such automatically generated litmus test.  Let's
> try reversing the "gp" and "rscs", which should have the same effect
> courtesy of symmetry:
> 
> auto/RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G.litmus
> 
> And that one doesn't exist, either.  So much for random test generation!  :-/
> 
> Clearly time to add them.  And here is what herd has to say about them:
> 
> l$ sh scripts/checklitmus.sh /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R.litmus
> Herd options: -conf linux-kernel.cfg
> Observation /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R Sometimes 1 255
>  ^^^ Unexpected non-Never verification
>  0inputs+32outputs (0major+2605minor)pagefaults 0swaps
> $ sh scripts/checklitmus.sh /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G.litmus
> Herd options: -conf linux-kernel.cfg
> Observation /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G Sometimes 1 255
>  ^^^ Unexpected non-Never verification
>  0inputs+32outputs (0major+2620minor)pagefaults 0swaps
> 
> In other words, they are in fact misclassified as "Sometimes" when they
> should be "Never".  I have my diffs below in case I misapplied Boqun's
> change.
> 
> With Alan's original formulation, these two litmus tests are correctly
> handled:
> 
> $ sh scripts/checklitmus.sh /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R.litmus
> Herd options: -conf linux-kernel.cfg
> Observation /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R Never 0 255
> 1.61user 0.00system 0:01.63elapsed 98%CPU (0avgtext+0avgdata 9572maxresident)k
> $ sh scripts/checklitmus.sh /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G.litmus
> Herd options: -conf linux-kernel.cfg
> Observation /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G Never 0 255
> 1.84user 0.01system 0:01.92elapsed 96%CPU (0avgtext+0avgdata 10112maxresident)k

And as Andrea pointed out off-list, I did indeed mess up Boqun's change.
I forgot to change the "irreflexive" into "acyclic".  Applying that change
makes everything work.

Please accept my apologies for my confusion!

							Thanx, Paul

> > > I prefer this because we already treat "gp" as "strong-fence", which
> > > already is a "rcu-link".
> > 
> > That's a good point; it had not occurred to me.
> 
> And if I remove the "gp" but leave the last line, it does properly
> classify the two new litmus tests.
> 
> 							Thanx, Paul
> 
> > >  Also, recurisively extending rcu-fence with
> > > itself is exactly calculating the transitive closure, which we can avoid
> > > by using a "acycle" rule. Besides, it looks more consistent with hb and
> > > pb.
> > 
> > That _had_ occurred to me.  But I couldn't see any way to do it while 
> > still defining rcu-fence correctly.
> 
> ------------------------------------------------------------------------
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 1e5c4653dd12..75d3c225146c 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -106,12 +106,11 @@ let rcu-link = hb* ; pb* ; prop
>   * Any sequence containing at least as many grace periods as RCU read-side
>   * critical sections (joined by rcu-link) acts as a generalized strong fence.
>   *)
> -let rec rcu-fence = gp |
> +let rec rcu-fence =
>  	(gp ; rcu-link ; rscs) |
>  	(rscs ; rcu-link ; gp) |
>  	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> -	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> -	(rcu-fence ; rcu-link ; rcu-fence)
> +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp)
>  
>  (* rb orders instructions just as pb does *)
>  let rb = prop ; rcu-fence ; hb* ; pb*
