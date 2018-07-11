Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1837720BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1837720BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeGKOaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:30:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388569AbeGKOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:30:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BENqlP110373
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:25:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5k41hnfs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:25:31 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 10:25:30 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 10:25:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BEPPJU9699782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:25:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96DCFB2065;
        Wed, 11 Jul 2018 10:25:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77A1CB205F;
        Wed, 11 Jul 2018 10:25:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 10:25:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0D8BE16C196F; Wed, 11 Jul 2018 07:27:44 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:27:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711090003.42596c2b@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071114-0068-0000-0000-000003166C5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009350; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059814; UDB=6.00543956; IPR=6.00837734;
 MB=3.00022102; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 14:25:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071114-0069-0000-0000-000044FE3A1D
Message-Id: <20180711142744.GN3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:00:03AM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 14:49:54 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\  
> > 
> > I would convert to rcu_dereference_raw() to appease sparse. The fancy
> > stuff below is pointless if you then turn off all checking.
> 
> The problem with doing this is if we use a trace event without the
> proper _idle() or whatever, we wont get a warning that it is used
> incorrectly with lockdep. Or does lockdep still check if "rcu is
> watching" with rcu_dereference_raw()?

No lockdep checking is done by rcu_dereference_raw().

							Thanx, Paul

> -- Steve
> 
> > 
> > > +									\
> > > +		/*							\
> > > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > > +		 * doesn't work from the idle path.			\
> > > +		 */							\
> > > +		if (rcuidle) {						\
> > > +			if (in_nmi()) {					\
> > > +				WARN_ON_ONCE(1);			\
> > > +				return; /* no srcu from nmi */		\
> > > +			}						\
> > > +									\
> > > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > > +			it_func_ptr =					\
> > > +				srcu_dereference_notrace((tp)->funcs,	\
> > > +						&tracepoint_srcu);	\
> > > +			/* To keep it consistent with !rcuidle path */	\
> > > +			preempt_disable_notrace();			\
> > > +		} else {						\
> > > +			rcu_read_lock_sched_notrace();			\
> > > +			it_func_ptr =					\
> > > +				rcu_dereference_sched((tp)->funcs);	\
> > > +		}							\  
> 

