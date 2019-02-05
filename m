Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3097C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24C2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vzDwJm95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfBEVII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:08:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBEVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:08:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x15L4ABx173307;
        Tue, 5 Feb 2019 21:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=m96kazws33ron0aki5AooH0yyu3XbZINH3epnn7EtvY=;
 b=vzDwJm9541ymmwW/tsjxwvwzXMFCaa4I7IEyuA1uLlVtG2m3rFvOz1vbXNyOY26CCCDR
 EFSj+7gT9Jwd8D9rZjb6QI9P+CGXnmCPGQQc/pBPlEJfNB6Nh9WhplueYbn7oOV6QJxh
 vJEx2+mrt4dSiT3Z1lOyPlFXgDixOTTJGEdEiUBu3iRKYFuPD5LRPGiSa1lOBvEFgG3t
 yHaU3tkS4AwbYiaAioc9s+VnX2RazaT7gwXEtGGMlEFKN5NHMU1DCBCXv/pcHslQAvj9
 AUH2emCMepvO8Zr8jTqfcZsZT9ArZ6s97X6xvVtm0gmcKDeh1dSTR/ssv5ZST/sSLZ3c 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qd9ardjvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 21:07:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x15L7dMG005170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 21:07:39 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x15L7cfu015545;
        Tue, 5 Feb 2019 21:07:38 GMT
Received: from [10.39.215.77] (/10.39.215.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 21:07:37 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Date:   Tue, 5 Feb 2019 16:07:37 -0500
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9158 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending after correcting an issue with the included URL and =
correcting a typo=20
in Waiman=E2=80=99s name =E2=80=94 sorry about that! ]

> On Feb 5, 2019, at 4:22 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
>>=20
>>> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>>>> Choose the next lock holder among spinning threads running on the =
same
>>>> socket with high probability rather than always. With small =
probability,
>>>> hand the lock to the first thread in the secondary queue or, if =
that
>>>> queue is empty, to the immediate successor of the current lock =
holder
>>>> in the main queue.  Thus, assuming no failures while threads hold =
the
>>>> lock, every thread would be able to acquire the lock after a =
bounded
>>>> number of lock transitions, with high probability.
>>>>=20
>>>> Note that we could make the inter-socket transition deterministic,
>>>> by sticking a counter of intra-socket transitions in the head node
>>>> of the secondary queue. At the handoff time, we could increment
>>>> the counter and check if it is below a threshold. This adds another
>>>> field to queue nodes and nearly-certain local cache miss to read =
and
>>>> update this counter during the handoff. While still beating stock,
>>>> this variant adds certain overhead over the probabilistic variant.
>>>=20
>>> (also heavily suffers from the socket =3D=3D node confusion)
>>>=20
>>> How would you suggest RT 'tunes' this?
>>>=20
>>> RT relies on FIFO fairness of the basic spinlock primitives; you =
just
>>> completely wrecked that.
>>=20
>> This is true that CNA trades some fairness for shorter lock handover
>> latency, much like any other NUMA-aware lock.
>>=20
>> Can you explain, however, what exactly breaks here?
>=20
> Timeliness guarantees. FIFO-fair has well defined time behaviour; you
> know exactly how long you get to wait before you acquire the lock,
> namely however many waiters are in front of you multiplied by the =
worst
> case wait time.
Got it =E2=80=94 thanks for the clarification!

>=20
> Doing time analysis on a randomized algorithm isn't my idea of fun.
>=20
>> It seems that even today, qspinlock does not support RT_PREEMPT, =
given
>> that it uses per-CPU queue nodes.
>=20
> It does work with RT, commit:
>=20
>  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
>=20
> it a direct result of RT observing funnies with it. I've no idea why =
you
> think it would not work.
Just trying to get to the bottom of it =E2=80=94 as of today, qspinlock =
explicitly assumes
no preemption while waiting for the lock.

Here is what Waiman had to say about that in =
https://lwn.net/Articles/561775:

"The idea behind this spinlock implementation is the fact that spinlocks
are acquired with preemption disabled. In other words, the process
will not be migrated to another CPU while it is trying to get a
spinlock.=E2=80=9D

This was back in 2013, but the code still uses per-CPU queue nodes,
and AFAICT, preemption will break things up.

So what you are saying is that RT would be fine assuming no preemption =
in
the spinlock as long as it provides FIFO? Or there is some future code =
patch=20
that will take care of the =E2=80=9Cno preemption=E2=80=9D assumption =
(but still assume FIFO)?

Thanks,
=E2=80=94 Alex=
