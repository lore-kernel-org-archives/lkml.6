Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB08C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A475208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A475208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeGKPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:18:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732409AbeGKPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:18:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BF9OZR022714
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:13:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5khq2bym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:13:46 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 11:13:45 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 11:13:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BFDe121573336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 15:13:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B283B2064;
        Wed, 11 Jul 2018 11:13:40 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25404B206C;
        Wed, 11 Jul 2018 11:13:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 11:13:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C18B416C3B66; Wed, 11 Jul 2018 08:15:59 -0700 (PDT)
Date:   Wed, 11 Jul 2018 08:15:59 -0700
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
 <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711104618.05dc4b46@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071115-0060-0000-0000-0000028A9601
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009351; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059830; UDB=6.00543966; IPR=6.00837750;
 MB=3.00022103; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 15:13:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071115-0061-0000-0000-000045C2B2E1
Message-Id: <20180711151559.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:46:18AM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 07:27:44 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Jul 11, 2018 at 09:00:03AM -0400, Steven Rostedt wrote:
> > > On Wed, 11 Jul 2018 14:49:54 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:  
> > > > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\    
> > > > 
> > > > I would convert to rcu_dereference_raw() to appease sparse. The fancy
> > > > stuff below is pointless if you then turn off all checking.  
> > > 
> > > The problem with doing this is if we use a trace event without the
> > > proper _idle() or whatever, we wont get a warning that it is used
> > > incorrectly with lockdep. Or does lockdep still check if "rcu is
> > > watching" with rcu_dereference_raw()?  
> > 
> > No lockdep checking is done by rcu_dereference_raw().
> 
> Correct, but I think we can do this regardless. So Joel please resend
> with Peter's suggestion.
> 
> The reason being is because of this:
> 
> 
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> 	extern struct tracepoint __tracepoint_##name;			\
> 	static inline void trace_##name(proto)				\
> 	{								\
> 		if (static_key_false(&__tracepoint_##name.key))		\
> 			__DO_TRACE(&__tracepoint_##name,		\
> 				TP_PROTO(data_proto),			\
> 				TP_ARGS(data_args),			\
> 				TP_CONDITION(cond), 0);			\
> 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> 			rcu_read_lock_sched_notrace();			\
> 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> 			rcu_read_unlock_sched_notrace();		\
> 		}							\
> 	}
> 
> Because lockdep would only trigger warnings when the tracepoint was
> enabled and used in a place it shouldn't be, we added the above
> IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> tracepoint was enabled or not. Because we do this, we don't need to
> have the test in the __DO_TRACE() code itself. That means we can clean
> up the code as per Peter's suggestion.

Indeed, the rcu_dereference_sched() would catch it in that case, so
agreed, Peter's suggestion isn't losing any debuggability.

						Thanx, Paul

