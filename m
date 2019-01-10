Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA6EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21662177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfAJOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:52:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbfAJOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:52:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AEnMa2147041
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:52:18 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2px5x5y09f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:52:18 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 14:52:18 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 14:52:15 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AEqEYp24117402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 14:52:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7A90B205F;
        Thu, 10 Jan 2019 14:52:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9F0DB2065;
        Thu, 10 Jan 2019 14:52:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 14:52:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7E93216C5F90; Thu, 10 Jan 2019 06:52:15 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:52:15 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Reply-To: paulmck@linux.ibm.com
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110124123.GA21224@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011014-0072-0000-0000-000003E7DFED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010379; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144485; UDB=6.00595914; IPR=6.00924749;
 MB=3.00025068; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 14:52:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011014-0073-0000-0000-00004AC1FD04
Message-Id: <20190110145215.GM1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:41:23PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 08, 2019 at 11:37:46PM +0100, Florian Westphal wrote:
> > Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> > > Or maybe xt_replace_table() can be enhanced? When I hear that
> > > something waits until an event happens on all CPUs I think about
> > > wait_event() function. Would it be better for xt_replace_table() to
> > > introduce an atomic counter that is decremented by CPUs, and the main
> > > CPU waits until the counter gets zero?
> > 
> > That would mean placing an additional atomic op into the
> > iptables evaluation path (ipt_do_table and friends).
> > 
> 
> For:
> 
> 	/*
> 	 * Ensure contents of newinfo are visible before assigning to
> 	 * private.
> 	 */
> 	smp_wmb();
> 	table->private = newinfo;
> 
> we have:
> 
> 	smp_store_release(&table->private, newinfo);
> 
> But what store does that second smp_wmb() order against? The comment:
> 
> 	/* make sure all cpus see new ->private value */
> 	smp_wmb();
> 
> makes no sense what so ever, no smp_*() barrier can provide such
> guarantees.

Agreed, this would require something like synchronize_rcu() or some
sort of IPI-based sys_membarrier() lookalike.

							Thanx, Paul

> > Only alternative I see that might work is synchronize_rcu (the
> > _do_table functions are called with rcu read lock held).
> > 
> > I guess current scheme is cheaper though.
> 
> Is performance a concern in this path? There is no comment justifying
> this 'creative' stuff.
> 

