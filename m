Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC641C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E99E271D6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99E271D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935230AbeF1Mge (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:36:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932214AbeF1Mgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:36:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SCYpe9021962
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:36:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvwde6yep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:36:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 08:36:31 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 08:36:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SCaQQb4260212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:36:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B86BB2067;
        Thu, 28 Jun 2018 08:36:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F30BB2066;
        Thu, 28 Jun 2018 08:36:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.192.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 08:36:16 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7332616C5F10; Thu, 28 Jun 2018 05:38:33 -0700 (PDT)
Date:   Thu, 28 Jun 2018 05:38:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
 <20180627094633.GG2512@hirez.programming.kicks-ass.net>
 <20180627155721.GZ3593@linux.vnet.ibm.com>
 <20180627175134.GV2494@hirez.programming.kicks-ass.net>
 <20180628051334.GG3593@linux.vnet.ibm.com>
 <20180628082653.GX2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628082653.GX2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062812-0060-0000-0000-00000283D2C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009270; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053538; UDB=6.00540190; IPR=6.00831460;
 MB=3.00021905; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 12:36:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062812-0061-0000-0000-0000459AE44B
Message-Id: <20180628123833.GJ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:26:53AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 27, 2018 at 10:13:34PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 27, 2018 at 07:51:34PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 27, 2018 at 08:57:21AM -0700, Paul E. McKenney wrote:
> > > > > Another variant, which simply skips the wakeup whever ran on an offline
> > > > > CPU, relying on the wakeup from rcutree_migrate_callbacks() right after
> > > > > the CPU really is dead.
> > > > 
> > > > Cute!  ;-)
> > > > 
> > > > And a much smaller change.
> > > > 
> > > > However, this means that if someone indirectly and erroneously causes
> > > > rcu_report_qs_rsp() to be invoked from an offline CPU, the result is an
> > > > intermittent and difficult-to-debug grace-period hang.  A lockdep splat
> > > > whose stack trace directly implicates the culprit is much better.
> > > 
> > > How so? We do an unconditional wakeup right after finding the offline
> > > cpu dead. There is only very limited code between offline being true and
> > > the CPU reporting in dead.
> > 
> > I am thinking more generally than this particular patch.  People
> > sometimes invoke things from places they shouldn't, for example, the
> > situation leading to your patch that allows use of RCU much earlier in
> > the CPU-online process.  It is nicer to get a splat in those situations
> > than a silent hang.
> 
> The rcu_rnp_online_cpus() thing would catch that, right? The public RCU
> API isn't that big, and should already complain afaict.

Please let me try again.

The approach you are suggesting, clever though it is, disables a check
of a type that has proved to be an important diagnostic in the past.
It is only reasonable to assume that this check would be important
and helpful in the future, but only if that check remains in the code.
Yes, agreed, given the current structure of the code, this particular
instance of the check would not matter, but experience indicates that
RCU code restructuring is not at all uncommon, with the current effort
being but one case in point.

So, unless I am missing something, the only possible benefit of disabling
this check is getting rid of an acquisition of an uncontended lock in
a code path that is miles (sorry, kilometers) away from any fastpath.
So, again, yes, it is clever.  If it sped up a fastpath, I might be
sorely tempted to take it.  But the alternative is straightforward and
isn't anywhere near a fastpath.  So, though I do very much appreciate
the cleverness and creativity, I am not seeing your change to be a
good tradeoff from a long-term maintainability viewpoint.

Am I missing something here?

							Thanx, Paul

