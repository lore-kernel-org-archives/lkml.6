Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BBF20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfAKOIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:08:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbfAKOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:08:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BE43GL139602
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:08:16 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxuy8j420-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:08:15 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 11 Jan 2019 14:08:14 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 14:08:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BE8AwU24510570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 14:08:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74F7DB205F;
        Fri, 11 Jan 2019 14:08:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE9BB206A;
        Fri, 11 Jan 2019 14:08:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.208.131])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 14:08:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8816F16C2B83; Fri, 11 Jan 2019 06:08:10 -0800 (PST)
Date:   Fri, 11 Jan 2019 06:08:10 -0800
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
 <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
 <20190110202533.GK2861@worktop.programming.kicks-ass.net>
 <20190110222920.jqpzzv74huc2lb7f@breakpoint.cc>
 <20190111083411.GM1900@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111083411.GM1900@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011114-0040-0000-0000-000004B062CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010385; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144945; UDB=6.00593882; IPR=6.00925214;
 MB=3.00025083; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-11 14:08:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011114-0041-0000-0000-000008BB68FC
Message-Id: <20190111140810.GA1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:34:11AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 10, 2019 at 11:29:20PM +0100, Florian Westphal wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > > Would using synchronize_rcu() not also mean you can get rid of that
> > > xt_write_recseq*() stuff entirely?
> > 
> > No, because those are used to synchronize with cpus that read
> > the ruleset counters, see
> > 
> > net/ipv4/netfilter/ip_tables.c:get_counters().
> 
> Ah, bummer :/
> 
> > > Anyway, synchronize_rcu() can also take a little while, but I don't
> > > think anywere near 30 seconds.
> > 
> > Ok, I think in that case it would be best to just replace the
> > recseq value sampling with smp_mb + synchronize_rcu plus a comment
> > that explains why its done.
> 
> synchronize_rcu() implies smp_mb() on all CPUs.

Yes, it does, but in the case of idle CPUs, the smp_mb() calls are only
required to follow any pre-existing RCU read-side critical section on
the one hand an precede any RCU read-side critical section completing
after the synchronize_rcu() on the other.

To do more would mean waking up idle CPUs, which does not make the
battery-powered guys happy.  ;-)

							Thanx, Paul

