Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4756BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23C123CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23C123CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeFVDl7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:41:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934345AbeFVDl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:41:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5M3dBg8115758
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:41:57 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jrp945gwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:41:57 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 23:41:57 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Jun 2018 23:41:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5M3fq8n18743622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 03:41:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB98B206E;
        Thu, 21 Jun 2018 23:41:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 750B1B2066;
        Thu, 21 Jun 2018 23:41:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.197.125])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jun 2018 23:41:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AD1BE16C9CF7; Thu, 21 Jun 2018 20:34:40 -0700 (PDT)
Date:   Thu, 21 Jun 2018 20:34:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
 <20180621180422.GF3452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621180422.GF3452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062203-0064-0000-0000-0000031EC5F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009236; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050489; UDB=6.00538358; IPR=6.00829459;
 MB=3.00021797; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 03:41:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062203-0065-0000-0000-000039ACD7D2
Message-Id: <20180622033440.GM3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:04:22PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by release-acquire chains and by
> > locking.  In other words, given the following code:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&s);
> > 	WRITE_ONCE(y, 1);
> > 
> > or the following:
> > 
> > 	smp_store_release(&x, 1);
> > 	r1 = smp_load_acquire(&x);	// r1 = 1
> > 	WRITE_ONCE(y, 1);
> > 
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s or be part of
> > the release-acquire chain.  In terms of the memory model, this means
> > that rel-rf-acq-po should be part of the cumul-fence relation.
> > 
> > All the architectures supported by the Linux kernel (including RISC-V)
> > do behave this way, albeit for varying reasons.  Therefore this patch
> > changes the model in accordance with the developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thanks for that Alan!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I queued both, with Peter's ack on the second, thank you both!

(Peter, if you meant to ack both, please let me know.)

							Thanx, Paul

