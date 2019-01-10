Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DD6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E194206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfAJENe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:13:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfAJENe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:13:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0A44rLj100149
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 23:13:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwsfck4ae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:13:32 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 04:13:31 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 04:13:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0A4DSaI18546762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 04:13:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CEBDB2067;
        Thu, 10 Jan 2019 04:13:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D042B2064;
        Thu, 10 Jan 2019 04:13:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.186.123])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 04:13:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 317D616C641B; Wed,  9 Jan 2019 20:13:28 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:13:28 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
Reply-To: paulmck@linux.ibm.com
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011004-0040-0000-0000-000004AF960B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010376; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144275; UDB=6.00593882; IPR=6.00924542;
 MB=3.00025059; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 04:13:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011004-0041-0000-0000-000008BA9ADE
Message-Id: <20190110041328.GE1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:38:51PM -0500, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> I've had a user report that trace_sched_waking() appears to be
> invoked while !rcu_is_watching() in some situation, so I started
> digging into the scheduler idle code.
> 
> It appears that interrupts are re-enabled before rcu_eqs_exit() is
> invoked when exiting idle code from the scheduler.
> 
> I wonder what happens if an interrupt handler (including scheduler code)
> happens to issue a RCU read-side critical section before rcu_eqs_exit()
> is called ? Is there some code on interrupt entry that ensures rcu eqs
> state is exited in such scenario ?

Interrupt handlers are supposed to invoke irq_enter(), which will in
turn invoke rcu_irq_enter(), which should take care of things.

However, there are cases where a given architecture knows that a given
interrupt handler does not contain RCU readers, and in this case, the
architecture might omit the rcu_irq_enter() or maybe even the whole
irq_enter().  And then it is all fun and games until someone adds an
RCU read-side critical section.  ;-)

							Thanx, Paul

