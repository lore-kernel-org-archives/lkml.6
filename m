Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADFF20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADFF20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbeGKPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:44:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389203AbeGKPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:44:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BFdamk088759
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:39:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5md98ve3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:39:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 11:39:57 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 11:39:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BFdrK827787502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 15:39:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030F3B205F;
        Wed, 11 Jul 2018 11:39:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7A6DB2065;
        Wed, 11 Jul 2018 11:39:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 11:39:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9149D16C3B6D; Wed, 11 Jul 2018 08:42:11 -0700 (PDT)
Date:   Wed, 11 Jul 2018 08:42:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180710162555.GV3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
 <20180711094344.GE13963@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711094344.GE13963@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071115-0072-0000-0000-0000037E5685
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009351; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059839; UDB=6.00543970; IPR=6.00837759;
 MB=3.00022104; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 15:39:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071115-0073-0000-0000-000048AD2F7F
Message-Id: <20180711154211.GT3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:43:45AM +0100, Will Deacon wrote:
> Hi Alan,
> 
> On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking.  In other words, given
> > the following code:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&s);
> > 	WRITE_ONCE(y, 1);
> > 
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s.  In terms of
> > the memory model, this means expanding the cumul-fence relation.
> > 
> > Locks should also provide read-read (and read-write) ordering in a
> > similar way.  Given:
> > 
> > 	READ_ONCE(x);
> > 	spin_unlock(&s);
> > 	spin_lock(&s);
> > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > 
> > the load of x should be executed before the load of (or store to) y.
> > The LKMM already provides this ordering, but it provides it even in
> > the case where the two accesses are separated by a release/acquire
> > pair of fences rather than unlock/lock.  This would prevent
> > architectures from using weakly ordered implementations of release and
> > acquire, which seems like an unnecessary restriction.  The patch
> > therefore removes the ordering requirement from the LKMM for that
> > case.
> > 
> > All the architectures supported by the Linux kernel (including RISC-V)
> > do provide this ordering for locks, albeit for varying reasons.
> > Therefore this patch changes the model in accordance with the
> > developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thanks, I'm happy with this version of the patch:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

I have applied your Reviewed-by, and thank you both!

Given that this is a non-trivial change and given that I am posting
for -tip acceptance in a few days, I intend to send this one not
to the upcoming merge window, but to the one after that.

Please let me know if there is an urgent need for this to go into the
v4.19 merge window.

							Thanx, Paul

