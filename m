Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F967C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732121758
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732121758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeHHTlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:41:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727472AbeHHTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:41:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78HK6gs100457
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 13:21:07 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kr1gfsr28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:21:06 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 13:21:06 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 13:21:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78HKxRw8323416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 17:20:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37745B206B;
        Wed,  8 Aug 2018 13:20:23 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DB2B2067;
        Wed,  8 Aug 2018 13:20:23 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 13:20:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6148916C0FCF; Wed,  8 Aug 2018 10:21:00 -0700 (PDT)
Date:   Wed, 8 Aug 2018 10:21:00 -0700
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
        Tom Zanussi <tom.zanussi@linux.intel.com>, will.deacon@arm.com
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808084629.3290d1d6@gandalf.local.home>
 <20180808130302.GJ24813@linux.vnet.ibm.com>
 <20180808090724.41677176@gandalf.local.home>
 <20180808143310.GL24813@linux.vnet.ibm.com>
 <20180808104910.2ced5e51@gandalf.local.home>
 <20180808150558.GO24813@linux.vnet.ibm.com>
 <20180808112309.6edda174@gandalf.local.home>
 <20180808160243.GQ24813@linux.vnet.ibm.com>
 <20180808122404.67bdb77b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808122404.67bdb77b@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080817-0068-0000-0000-000003259BE7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009508; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071017; UDB=6.00551397; IPR=6.00850566;
 MB=3.00022591; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 17:21:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080817-0069-0000-0000-00004552D4DC
Message-Id: <20180808172100.GW24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:24:04PM -0400, Steven Rostedt wrote:
> On Wed, 8 Aug 2018 09:02:43 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > Which leaves us with sparc, arm, mips, sh and powerpc.
> > > 
> > > sh is almost dead, and powerpc can be fixed, which I guess leaves us
> > > with sparc, arm and mips.  
> > 
> > If we want to stick with the current srcu_read_lock() and srcu_read_unlock(),
> > you mean?  I would like that sort of outcome, at least assuming we are not
> > hammering any of the architectures.
> 
> I would go with the local_inc approach, and even add a
> srcu_read_un/lock_nmi() that does that if you want. Probably should add
> lockdep to detect if the _nmi calls is ever used along with non _nmi
> calls and complain about that.

Would it be reasonable to also add a check for non-_nmi calls being
used in both NMI and non-NMI contexts?

> But this will be something for the next merge window, not the one
> coming up.

Completely agreed!

							Thanx, Paul

