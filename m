Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeEVA04 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:26:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751019AbeEVA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:26:52 -0400
Date: Mon, 21 May 2018 17:28:23 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 4/4] rcu: Unlock non-start node only after accessing
 its gp_seq_needed
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-5-joel@joelfernandes.org>
 <20180521232537.GJ3803@linux.vnet.ibm.com>
 <20180522000734.GD40541@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522000734.GD40541@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052200-2213-0000-0000-000002A95DEA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009063; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035761; UDB=6.00529805; IPR=6.00814889;
 MB=3.00021229; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 00:26:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052200-2214-0000-0000-00005A3388DC
Message-Id: <20180522002823.GP3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:07:34PM -0700, Joel Fernandes wrote:
> On Mon, May 21, 2018 at 04:25:38PM -0700, Paul E. McKenney wrote:
> > On Sun, May 20, 2018 at 09:42:20PM -0700, Joel Fernandes wrote:
> > > We acquire gp_seq_needed locklessly. To be safe, lets do the unlocking
> > > after the access.
> > 
> > Actually, no, we hold rnp_start's ->lock throughout.  And this CPU (or in
> > the case of no-CBs CPUs, this task) is in charge of rdp->gp_seq_needed,
> > so nothing else is accessing it.  Or at least that is the intent.  ;-)
> 
> I was talking about protecting the internal node's rnp->gp_seq_needed, not
> the rnp_start's gp_seq_needed.

Ah, good point, I missed the "if" condition.  This can be argued to work,
sort of, given that we still hold the leaf rcu_node structure's lock,
so that there is a limit to how far grace periods can advance.

But the code would of course be much cleaner with your change.

> We are protecting them in the loop:
> 
> like this:
> for(...)
> 	if (rnp != rnp_start)
> 		raw_spin_lock_rcu_node(rnp);
> 	[...]
> 	// access rnp->gp_seq and rnp->gp_seq_needed
> 	[...]
> 	if (rnp != rnp_start)
> 		raw_spin_unlock_rcu_node(rnp);
> 
> But we don't need to do such protection in unlock_out ? I'm sorry if I'm
> missing something, but I'm wondering if rnp->gp_seq_needed of an internal
> node can be accessed locklessly, then why can't that be done also in the
> funnel locking loop - after all we are holding the rnp_start's lock through
> out right?

I was focused on the updates, and missed the rnp->gp_seq_req access in the
"if" statement.  The current code does sort of work, but only assuming
that the compiler doesn't tear the load, and so your change would help.
Could you please resend with your other two updated patches?  It depends
on one of the earlier patches, so does not apply cleanly as-is.  I could
hand-apply it, but that sounds like a good way to make your updated
series fail to apply.  ;-)

But could you also make the commit log explicitly call out the "if"
condition as being the offending access?

							Thanx, Paul
