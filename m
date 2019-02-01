Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E22CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3EF2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmhbAQai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfBAV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:26:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:26:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11LOJ7i086365;
        Fri, 1 Feb 2019 21:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dovBxOd9J5ZjP2z51d4DjxFghwISXIsl79OcbtFXKvA=;
 b=DmhbAQaiQPz1ohrEIV8ysPPzwMrVObCM+CNmhFqT1klQUU8cLvNLAAsNkqSX15qdx1eS
 TDAvKoxswxVSIlb3kxxGEdITpaCdswg8cYw9Z3sabTBU9APfwTNDRTdh41hQH4p0hlq5
 E9MjVSDCTn098zOEdY1RxeplbEDItfVk/PTNtsuD3GE1ztkJGMOFwikPUWpjeJezHLRH
 dU2gdiqEc+aGrvJnQONQ4ivhhzjuJ6nZ4OQWOP25IdEpCB85ZqNZk+awW/drHwXAA3Sw
 4QdBXrc+eTpF70MxI5j4qju9V3rWA/ZwKLl5edixQPUikMW7Yo5ifVn89WO1JPVeLUyv +w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q8d2es53a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 21:26:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x11LQDiM017941
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 21:26:13 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x11LQ9EV030487;
        Fri, 1 Feb 2019 21:26:09 GMT
Received: from [10.39.246.40] (/10.39.246.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 13:26:08 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 2/3] locking/qspinlock: Introduce CNA into the slow path
 of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
Date:   Fri, 1 Feb 2019 16:26:06 -0500
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62BE66CF-1CFA-4921-B2FF-70D5460845D6@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-3-alex.kogan@oracle.com>
 <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 31, 2019, at 12:38 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 01/30/2019 10:01 PM, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a main queue =
for
>> threads running on the same socket as the current lock holder, and a
>> secondary queue for threads running on other sockets. For details,
>> see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DRdsRU4oU2j-_hNG5kDC5ZEE_XHikl3Q=
LNttCaBde3QU&s=3DNQ840S1lz53Cq7AnOlPWdnjZI7_Ic3rfYsf-w2aYus4&e=3D.
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same socket. This issue
>> will be addressed later in the series.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>=20
> Just wondering if you have tried include PARVIRT_SPINLOCKS option to =
see
> if that patch may screw up the PV qspinlock code.
No, I haven=E2=80=99t yet.
The idea was to make it work for non-PV systems first, and then extend =
to PV.

>=20
> Anyway, I do believe your claim that NUMA-aware qspinlock is good for
> large systems with many nodes. However, all these extra code are
> overhead for small systems that have a single node/socket, for =
instance.
>=20
> I will support doing something similar to what had been done to =
support
> PV qspinlock. IOW, a separate slowpath function that can be patched to
> become the default depending on the system being run on or a kernel =
boot
> option setting.
>=20
> I would like to keep the core slowpath function simple and easy to
> understand. So most of the CNA code should be encapsulated into some
> helper functions and put into a separated file.
Sounds good.=20
I think it should be pretty straightforward to encapsulate the CNA code =
and do what you suggest.
We will look into that.

Thanks,
=E2=80=94 Alex

>=20
> Thanks,
> Longman
>=20

