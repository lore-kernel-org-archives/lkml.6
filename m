Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCAA219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCAA219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeHHR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:26:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbeHHR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:26:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78F0Dg4117680
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 11:06:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr1evmbvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 11:06:07 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 11:06:04 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 11:05:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78F5wJW8847744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 15:05:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0CEB2066;
        Wed,  8 Aug 2018 11:05:21 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB73B2065;
        Wed,  8 Aug 2018 11:05:21 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 11:05:21 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8389716C0EBA; Wed,  8 Aug 2018 08:05:58 -0700 (PDT)
Date:   Wed, 8 Aug 2018 08:05:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180807215522.04114097@vmware.local.home>
 <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808084629.3290d1d6@gandalf.local.home>
 <20180808130302.GJ24813@linux.vnet.ibm.com>
 <20180808090724.41677176@gandalf.local.home>
 <20180808143310.GL24813@linux.vnet.ibm.com>
 <20180808104910.2ced5e51@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808104910.2ced5e51@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080815-0052-0000-0000-0000031B7E6A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070987; UDB=6.00551370; IPR=6.00850521;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 15:06:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080815-0053-0000-0000-00005DA877B6
Message-Id: <20180808150558.GO24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=556 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:49:10AM -0400, Steven Rostedt wrote:
> On Wed, 8 Aug 2018 07:33:10 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Aug 08, 2018 at 09:07:24AM -0400, Steven Rostedt wrote:
> > > On Wed, 8 Aug 2018 06:03:02 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >   
> > > >  What's wrong with a this_cpu_inc()? It's atomic for the CPU. Although  
> > > > > it wont be atomic for the capture of the idx. But I also don't see
> > > > > interrupts being disabled, thus an NMI is no different than any
> > > > > interrupt doing the same thing, right?    
> > > > 
> > > > On architectures without increment-memory instructions, if you take an NMI
> > > > between the load from sp->sda->srcu_lock_count and the later store, you
> > > > lose a count.  Note that both __srcu_read_lock() and __srcu_read_unlock()
> > > > do increments of different locations, so you cannot rely on the usual
> > > > "NMI fixes up before exit" semantics you get when incrementing and
> > > > decrementing the same location.  
> > > 
> > > And how is this handled in the interrupt case? Interrupts are not
> > > disabled here.  
> > 
> > Actually, on most architectures interrupts are in fact disabled:
> > 
> > #define this_cpu_generic_to_op(pcp, val, op)				\
> > do {									\
> > 	unsigned long __flags;						\
> > 	raw_local_irq_save(__flags);					\
> > 	raw_cpu_generic_to_op(pcp, val, op);				\
> > 	raw_local_irq_restore(__flags);					\
> > } while (0)
> > 
> > NMIs, not so much.
> 
> And do these archs have NMIs?

It would appear so:

$ find . -name 'Kconfig*' -exec grep -l 'select HAVE_NMI\>' {} \;
./arch/sparc/Kconfig
./arch/s390/Kconfig
./arch/arm/Kconfig
./arch/arm64/Kconfig
./arch/mips/Kconfig
./arch/sh/Kconfig
./arch/powerpc/Kconfig
./arch/x86/Kconfig

							Thanx, Paul

