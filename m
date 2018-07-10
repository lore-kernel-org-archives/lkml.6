Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9100BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597E120870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597E120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbeGJSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388073AbeGJSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AHdCHT054902
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:40:12 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k501vcd7g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:40:11 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 13:40:10 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 13:40:07 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AHe6XJ37814360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 17:40:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DCB4B2064;
        Tue, 10 Jul 2018 13:39:40 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F0FCB205F;
        Tue, 10 Jul 2018 13:39:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 13:39:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9516C16C19F1; Tue, 10 Jul 2018 10:42:25 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:42:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc@google.com
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180710051347.GA180724@joelaf.mtv.corp.google.com>
 <20180710164212.GY3593@linux.vnet.ibm.com>
 <20180710165744.GA99146@joelaf.mtv.corp.google.com>
 <20180710171229.GZ3593@linux.vnet.ibm.com>
 <20180710172957.GA103636@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710172957.GA103636@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071017-0040-0000-0000-0000044CAF0B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009346; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059399; UDB=6.00543707; IPR=6.00837319;
 MB=3.00022090; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 17:40:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071017-0041-0000-0000-00000852D2C0
Message-Id: <20180710174225.GA3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=729 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:29:57AM -0700, Joel Fernandes wrote:
> On Tue, Jul 10, 2018 at 10:12:29AM -0700, Paul E. McKenney wrote:
> [..]
> > > > > The other question I have is about the whole "nohz-full doesn't work" thing.
> > > > > I didn't fully understand why. RCU is already tracking the state of nohz-full
> > > > > CPUs because the rcu dynticks code in (kernel/rcu/tree.c) monitors
> > > > > transitions to and from usermode even if the timer tick is turned off. So why
> > > > > would it not work?
> > > > 
> > > > In the nohz_full case, there is no need for sys_membarrier()'s call to
> > > > synchronize_sched() to interact directly with the nohz_full CPU.  It
> > > > can instead look at the target CPU's dyntick-idle state, and that state
> > > > would potentially have been set in the dim distant past, thus having
> > > > no effect on the target CPU's current execution.
> > > 
> > > In nohz-idle case though, there's nothing to promote the barrier() to
> > > smp_mb() if you were to purely look at the dynticks-idle state on the
> > > nohz-full CPU executing in user mode?
> > > 
> > > So then it makes sense to me now that nohz-full needs something to IPI that
> > > CPU inorder to enforce the needed memory barrier and pure synchronize_sched()
> > > wouldn't work. So then makes me think the expedited versions of
> > > synchronize_sched should be able to do the job but I could off on a different
> > > track..
> > 
> > The problem is that the expedited versions also check the dyntick-idle
> > state and don't touch idle (or nohz_full usermode) CPUs.  This is by
> > design for the battery-powered embedded use case.  ;-)
> 
> Oh ok! ;)
> 
> I guess there's also a MEMBARRIER_CMD_GLOBAL_EXPEDITED which seems to IPI
> CPUs (I'm guessing regardless of dynticks state) and execute smp_mb within
> the IPI so userspace can fallback to using that incase MEMBARRIER_CMD_GLOBAL
> returns -EINVAL.

Yes, and this avoids IPIing idle CPUs via the ->mm checks.  But it will
IPI nohz_full CPUs in that same process, as it must for correctness.

							Thanx, Paul

