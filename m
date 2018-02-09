Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBIMb4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:31:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751142AbeBIMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:31:54 -0500
Date: Fri, 9 Feb 2018 04:31:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ildar Ismagilov <devix84@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: Prevent sdp->srcu_gp_seq_needed_exp counter
 wrap
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180131193954.28386-1-devix84@gmail.com>
 <20180203091628.GF3617@linux.vnet.ibm.com>
 <CADCZxWdVnpjS7Xqs_-tJcxLRTONrEEh8yF32F=mZUNhyj8bBfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADCZxWdVnpjS7Xqs_-tJcxLRTONrEEh8yF32F=mZUNhyj8bBfw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020912-0044-0000-0000-000003DE2359
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008503; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987191; UDB=6.00501061; IPR=6.00766549;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019456; XFM=3.00000015;
 UTC=2018-02-09 12:31:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020912-0045-0000-0000-0000080D95E7
Message-Id: <20180209123159.GZ3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 01:44:10PM +0300, Ildar Ismagilov wrote:
> The results of rcutorture tests in attachment. I only tested: SRCU-N,
> SRCU-P, SRCU-t and SRCU-u configs.

That is a good set for an SRUC change, thank you!

							Thanx, Paul

> 2018-02-03 12:16 GMT+03:00 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> > On Wed, Jan 31, 2018 at 10:39:53PM +0300, Ildar Ismagilov wrote:
> >> Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
> >
> > I did apply this for testing and review, thank you and good eyes!
> >
> > However, I had to:
> >
> > 1.      hand-edit it to make it work against the rcu/dev
> >         branch of my -rcu tree:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >
> > 2.      fill out the commit logs.
> >
> > Please see below for the updated patch, and please let me know if I
> > messed something up.
> >
> > In the future, could you please apply your patches against the rcu/dev
> > branch of -rcu and provide more complete commit logs?  The commit log
> > should describe the problem and how that problem is fixed.
> >
> > Also, are you able to test these using rcutorture?  If not, let's get you
> > set up for that, as I am prone to testing backlogs just now.  Plus I am
> > writing this while 34,000 feet over Western Australia.  So it would mean
> > fewer delays for you if you could test your own patches.  ;-)
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 753abb606ba61012c8838c73e2c888aea20efe13
> > Author: Ildar Ismagilov <devix84@gmail.com>
> > Date:   Wed Jan 31 22:39:53 2018 +0300
> >
> >     srcu: Prevent sdp->srcu_gp_seq_needed_exp counter wrap
> >
> >     SRCU checks each srcu_data structure's grace-period number for counter
> >     wrap four times per cycle by default.  This frequency guarantees that
> >     normal comparisons will detect potential wrap.  However, the expedited
> >     grace-period number is not checked.  The consquences are not too horrible
> >     (a failure to expedite a grace period when requested), but it would be
> >     good to avoid such things.  This commit therefore adds this check to
> >     the expedited grace-period number.
> >
> >     Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2878387d4189..ad3e1aa5e6ea 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -579,6 +579,9 @@ static void srcu_gp_end(struct srcu_struct *sp)
> >                                 if (ULONG_CMP_GE(gpseq,
> >                                                  sdp->srcu_gp_seq_needed + 100))
> >                                         sdp->srcu_gp_seq_needed = gpseq;
> > +                               if (ULONG_CMP_GE(gpseq,
> > +                                                sdp->srcu_gp_seq_needed_exp + 100))
> > +                                       sdp->srcu_gp_seq_needed_exp = gpseq;
> >                                 spin_unlock_irqrestore_rcu_node(sdp, flags);
> >                         }
> >         }
> >
> 
> 
> 
> -- 
> Best regards
> Ildar
