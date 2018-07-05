Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5959C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D851240FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D851240FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeGEQ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:56:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754581AbeGEQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:56:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65GtbqB007237
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 12:56:39 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1pyy8pqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:56:38 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:56:38 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:56:33 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65GuWNm10027318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 16:56:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C050BB2065;
        Thu,  5 Jul 2018 12:56:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7A8B205F;
        Thu,  5 Jul 2018 12:56:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:56:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C8D2D16CA477; Thu,  5 Jul 2018 09:58:48 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:58:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <20180705153906.GA2345@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705153906.GA2345@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070516-0072-0000-0000-0000037A87CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056984; UDB=6.00542258; IPR=6.00834904;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 16:56:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070516-0073-0000-0000-0000489A66A0
Message-Id: <20180705165848.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:39:06PM +0200, Andrea Parri wrote:
> > > At any rate, it looks like instead of strengthening the relation, I
> > > should write a patch that removes it entirely.  I also will add new,
> > > stronger relations for use with locking, essentially making spin_lock
> > > and spin_unlock be RCsc.
> > 
> > Only in the presence of smp_mb__after_unlock_lock() or
> > smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
> 
> There are at least two definitions of RCsc: one as documented in the header
> comment for smp_mb__after_spinlock() or rather in the patch under review...,
> one as processor architects used to intend it. ;-)

Searching isn't working for me all that well this morning, so could you
please send me a pointer to that patch?

							Thanx, Paul

