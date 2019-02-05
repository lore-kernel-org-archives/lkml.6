Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2625C4151A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03392145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFN9hJ9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBEDpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:45:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBEDpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:45:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x153YDEN088462;
        Tue, 5 Feb 2019 03:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JMERaVWO3bx90UjO8dqcTmU3ZftGStLoslI5tKbbeNQ=;
 b=ZFN9hJ9GJ5s8T+SL6MZYd0lXtiRvjqMgYqzLwXTrvzOuw4ETLNmAwID4SNYaTZQmhlbz
 302Wtv2hKupvgWGETYz2IWTl+3pC25aAzSWZz7zj2eZ4/GBj5ymKnHI7de+gC8m4mQFy
 Is+huBEcwy8dCpAN5Dwztu7HG5PimDknoekVaI1dwppSQ7ASq+/vRciL41tUf7JI1hbq
 HyEwy8aYxY/BMZiUGPv6ncdnB8F23MEdDUFxOqF9ksY7O+j+HMZVhsxZNwlYOr/bAEwN
 GA+yLMimtdhoFhUH8vZ3ZoqViSnqfXMyj5iLHkRvugWY1ZSBG8YCvln1/ehYjAqJ/aAf QQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97erpgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 03:35:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x153ZHoN026523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 03:35:17 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x153ZEPS012979;
        Tue, 5 Feb 2019 03:35:14 GMT
Received: from [192.168.0.6] (/209.6.165.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 03:35:13 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
Date:   Mon, 4 Feb 2019 22:35:09 -0500
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=766 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>> Choose the next lock holder among spinning threads running on the =
same
>> socket with high probability rather than always. With small =
probability,
>> hand the lock to the first thread in the secondary queue or, if that
>> queue is empty, to the immediate successor of the current lock holder
>> in the main queue.  Thus, assuming no failures while threads hold the
>> lock, every thread would be able to acquire the lock after a bounded
>> number of lock transitions, with high probability.
>>=20
>> Note that we could make the inter-socket transition deterministic,
>> by sticking a counter of intra-socket transitions in the head node
>> of the secondary queue. At the handoff time, we could increment
>> the counter and check if it is below a threshold. This adds another
>> field to queue nodes and nearly-certain local cache miss to read and
>> update this counter during the handoff. While still beating stock,
>> this variant adds certain overhead over the probabilistic variant.
>=20
> (also heavily suffers from the socket =3D=3D node confusion)
>=20
> How would you suggest RT 'tunes' this?
>=20
> RT relies on FIFO fairness of the basic spinlock primitives; you just
> completely wrecked that.

This is true that CNA trades some fairness for shorter lock handover =
latency, much like any other NUMA-aware lock.

Can you explain, however, what exactly breaks here?
It seems that even today, qspinlock does not support RT_PREEMPT, given =
that it uses per-CPU queue nodes.

Thank you,
=E2=80=94 Alex



