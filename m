Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeEKQX0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:23:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752405AbeEKQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:23:22 -0400
Date: Fri, 11 May 2018 09:24:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu, 05/21] rcu: Make rcu_gp_cleanup() more accurately
 predict need for new GP
Reply-To: paulmck@linux.vnet.ibm.com
References: <1524452624-27589-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180510072133.GA122810@joelaf.mtv.corp.google.com>
 <20180510131546.GN26088@linux.vnet.ibm.com>
 <20180510173754.GB228531@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510173754.GB228531@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051116-0048-0000-0000-0000026BAF15
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009006; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01030800; UDB=6.00526835; IPR=6.00809931;
 MB=3.00021049; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 16:23:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051116-0049-0000-0000-00004515E040
Message-Id: <20180511162443.GA26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:37:54AM -0700, Joel Fernandes wrote:
> On Thu, May 10, 2018 at 06:15:46AM -0700, Paul E. McKenney wrote:
> [...] 
> > > Also in rcu_future_gp_cleanup, we call:
> > > 	trace_rcu_future_gp(rnp, rdp, c,
> > > 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
> > > For this case, in the final trace event record, rnp->completed and c will be
> > > the same, since c is set to rnp->completed before calling
> > > trace_rcu_future_gp. I was thinking they should be different, do you expect
> > > them to be the same?
> > 
> > Hmmm...  That does look a bit inconsistent.  And it currently uses
> > rnp->gp_seq instead of rnp->gp_seq_needed despite having the same
> > "CleanupMore" name.
> > 
> > Looks like a review of the calls to trace_rcu_this_gp() is in order.
> 
> I see you changed trace_rcu_future_gp to use trace_rcu_this_gp in 15/21.. I
> am not sure if the concern is still valid then since you seem to be correctly
> getting the future GP in those cases, except for the naming which I suggest
> be changed from 'c' to 'future_gp' just for clarity / self-documenting code.

Indeed, "c" for "->completed" is completely outdated.  ;-)

Would you be willing to send a patch providing a better name?

								Thanx, Paul
