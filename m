Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9667C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778F224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9778F224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeKMAL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:11:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeKMAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:11:28 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACEAcKY043312
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:17:59 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nq8sfpnmy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:17:59 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 14:17:57 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 14:17:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACEHowF19529974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 14:17:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D64382714;
        Mon, 12 Nov 2018 14:06:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4468B13B94F;
        Mon, 12 Nov 2018 13:28:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 13:28:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 01CE316C5D2C; Mon, 12 Nov 2018 05:28:52 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:28:52 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
 <20181112020710.GJ3056@worktop>
 <20181112022455.GD4170@linux.ibm.com>
 <20181112090047.GN3056@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112090047.GN3056@worktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111214-0060-0000-0000-000002D16578
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010034; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116382; UDB=6.00578955; IPR=6.00896490;
 MB=3.00024127; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 14:17:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111214-0061-0000-0000-0000472C0783
Message-Id: <20181112132852.GH4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:00:47AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 11, 2018 at 06:24:55PM -0800, Paul E. McKenney wrote:
> 
> > > > There were quite a few commits involved in making this happen.  Perhaps
> > > > the most pertinent are these:
> > > > 
> > > > 3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")
> > > > 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> > > 
> > > The latter; it does not mention that this will possible make
> > > synchronize_sched() quite a bit more expensive on PREEMPT=y builds :/
> > 
> > In theory, sure.  In practice, people have switched any number of
> > things from RCU-sched to RCU and back without problems.
> 
> Still, better safe than sorry. It was a rather big change in behaviour,
> so it wouldn't have been strange to call that out.

This guy:

45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")

Has a commit log that says:

	Now that RCU-preempt knows about preemption disabling, its
	implementation of synchronize_rcu() works for synchronize_sched(),
	and likewise for the other RCU-sched update-side API members.
	This commit therefore confines the RCU-sched update-side code
	to CONFIG_PREEMPT=n builds, and defines RCU-sched's update-side
	API members in terms of those of RCU-preempt.

That last phrase seems pretty explicit.  What am I missing here?

Not that it matters, given that I know of no way to change a mainlined
commit log.  I suppose I could ask Jon if he would be willing to take
a 2018 RCU API LWN article, if that would help.

> > > But for PREEMPT=y synchronize_sched() can be quite a bit shorter than
> > > synchronize_rcu(), since we don't have to wait for preempted read side
> > > stuff.
> > 
> > Again, there are quite a few places that have managed that transition
> > without issue.  Why do you expect this change to have problems that have
> > not been seen elsewhere?
> 
> I'm not, I'm just taking issue with the Changelog.

OK, good.

> > > Again, the patch didn't say that.
> > > 
> > > If the Changelog would've read something like:
> > > 
> > > "Since synchronize_sched() is now equivalent to synchronize_rcu(),
> > > replace the synchronize_sched() usage such that we can eventually remove
> > > the interface."
> > > 
> > > It would've been clear that the patch is a nop and what the purpose
> > > was.
> > 
> > I can easily make that change.
> 
> Please, sufficient doesn't imply necessary etc.. A changelog should
> always clarify why we do the patch.

???  Did you mean to say "necessary doesn't imply sufficient"?  If so,
what else do you feel is missing?

If not, color me confused.

							Thanx, Paul

