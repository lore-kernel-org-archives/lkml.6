Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C6C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EBD2159B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EBD2159B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJUAVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:21:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726779AbeJUAVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:21:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KGA3OD096335
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:10:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n7yp4wfvg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:10:56 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 12:10:55 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Oct 2018 12:10:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9KGAnO935520730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Oct 2018 16:10:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E564B2066;
        Sat, 20 Oct 2018 16:10:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C161B205F;
        Sat, 20 Oct 2018 16:10:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.122])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 20 Oct 2018 16:10:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7234016C3013; Sat, 20 Oct 2018 09:10:49 -0700 (PDT)
Date:   Sat, 20 Oct 2018 09:10:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     davidtgoldblatt@gmail.com, stern@rowland.harvard.edu,
        andrea.parri@amarulasolutions.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com
Subject: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102016-0040-0000-0000-00000483D3FD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009907; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105477; UDB=6.00572377; IPR=6.00885527;
 MB=3.00023839; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-20 16:10:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102016-0041-0000-0000-0000088BEC54
Message-Id: <20181020161049.GA13756@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=437 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810200151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

David Goldblatt (CCed) came up with an interesting pair of C++ litmus
tests involving POSIX signals that have Linux-kernel counterparts
involving interrupts.  These litmus tests can (in paranoid theory, anyway)
produce counter-intuitive results on architectures that use explicit
fences to enforce ordering as part of a larger primitive, which in the
specific case of smp_store_release() includes all architectures other than
arm64, ia64, s390, SPARC, x86, and of course any UP-only architecture.

David's first litmus test made use of the C11 sequentially consistent
store, which in the Linux kernel would require two separate statements
anyway (a WRITE_ONCE() either preceded or followed by smp_mb()), so
the outcome that is counter-intuitive in C11 should be expected in the
Linux kernel.  (Yes, there are similar but more complicated examples that
would have more interesting outcomes in the Linux kernel, but let's keep
it simple for the moment.)

The second (informal) litmus test has a more interesting Linux-kernel
counterpart:

	void t1_interrupt(void)
	{
		r0 = READ_ONCE(y);
		smp_store_release(&x, 1);
	}

	void t1(void)
	{
		smp_store_release(&y, 1);
	}

	void t2(void)
	{
		r1 = smp_load_acquire(&x);
		r2 = smp_load_acquire(&y);
	}

On store-reordering architectures that implement smp_store_release()
as a memory-barrier instruction followed by a store, the interrupt could
arrive betweentimes in t1(), so that there would be no ordering between
t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.

In practice, we analyzed exception paths in the sys_membarrier() review,
and ended up with this function:

static void ipi_mb(void *info)
{
	smp_mb();	/* IPIs should be serializing but paranoid. */
}

So how paranoid should we be with respect to interrupt handlers for
smp_store_release(), smp_load_acquire(), and the various RMW atomic
operations that are sometimes implemented with separate memory-barrier
instructions?  ;-)

							Thanx, Paul

