Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8432FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FAA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FamPl2qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FAA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeG0UbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:31:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:45712 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388899AbeG0UbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:31:05 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RJ52tQ020886;
        Fri, 27 Jul 2018 12:07:49 -0700
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0048.outbound.protection.outlook.com [207.46.163.48])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2kffuck0n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Jul 2018 12:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8PLEtifYbKxN4CS6tm139qr90hIjFIrQKRC6VqEj6o=;
 b=FamPl2qm/PNaUZeY0NXVJ8WdwR9LPHzaGIv5VnbPZ3d/Nr/GXCxbCM35pVMt4dM7JrQmScMNMb9gwZtfJMZBZb54B+vvMtnUjYzxQDyOhKH2062PFUeEOnB03cW+ZqwHJ4CrGJHweytK3+6VKc9uOy12uZChv768+/JnmxI3Kws=
Received: from BYAPR02MB4501.namprd02.prod.outlook.com (52.135.239.148) by
 BYAPR02MB4549.namprd02.prod.outlook.com (52.135.239.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Fri, 27 Jul 2018 19:07:46 +0000
Received: from BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da]) by BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da%3]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 19:07:46 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Thread-Topic: RCU nocb list not reclaiming causing OOM
Thread-Index: AQHUIH18yrHc1RUlUkiqYiJ1aV59oKSYwskAgAALDpiACqj1uQ==
Date:   Fri, 27 Jul 2018 19:07:46 +0000
Message-ID: <BYAPR02MB4501690DB627FBB8640A5C46942A0@BYAPR02MB4501.namprd02.prod.outlook.com>
References: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>,<20180720233212.GC12945@linux.vnet.ibm.com>,<BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4549;6:2EEQkQaxxgPRwviEz1GI0RXCEOM0EIGLzh7XxguJGin17ryzS4zmxo4svBJyVkcJxxGmsiT1Aj1YkHLy7x8TfWUlUG7ARKwHjDAaepI1EKpbAcjXwClBi9U1N60ZQRwFTaf7QDXKniusUtQU4UkyxBgXX/u6wj8cvCKTNpVB497ZmjGPvOCK8nM6Q8Vcotrxzsli4/0IR+KIFl3WBEbuzCf6rf/yxlW+p4O9xepFqCY+Vj/34j4VGpAMITiWCeZ6RNE3eDsRN3V8NANY7VS2OG2uyAyWz4vN7ASOzJwpBIhkyPp6vEskwzCzI+Ri54uGqyki+D3hFlsfVz/x79rS5/jtPcbZg/SqO6PRZVjkZpFpIWTkM33LLI/dbL2395F/hiqATIA/OlBsx2s8617yvsDefSUXivWs5UfwgpLNuPmGsHyecW2EQDguH1XV7RHhZl0pp00w5FBhm6EqE5XwZA==;5:MgAwQ0qql1mFkASIIJRjmBwOKRntNdBn2p1yos13v+bMC2ZBy9iM3ElYsJCc/c5NI60ruLzuUJNkjQMTTXkGOn0tf/wrnyFOBFS3DhCFWEA6OyiLmVT/e9FEm8yHn3b7P4J0ph94dloqe5H+YYb8pCPMzWhsF4bqpAr3tgENYXE=;7:HXmfa7KIpYnumDTHUxC+QvAv3/SvJk6NV/pfWKM9AoF1yc3ba7Otev1vuw7fj+5b1Qv1+k3Y0AtzCjXZaGGsHRIpl3GCTTV1PkWjjEpSGiXH69L9XAz0ZgLY6y34rzuddJFllcTsJeu9xkYgumls8P5IPCDQ3jIdGd7ohhqPC3nOmkIXSSwNCb3oQ6fyakwK3WIvtuxmj+LMJvR+kblZdFj+RXpOjNUeI6D+0xKglf4nQ4R5nQBcyF2JV+SoMiqy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 04fa002e-a249-4c07-6f4a-08d5f3f43ce5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4549;
x-ms-traffictypediagnostic: BYAPR02MB4549:
x-microsoft-antispam-prvs: <BYAPR02MB4549D406A7AFA03E86FF95A2942A0@BYAPR02MB4549.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4549;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4549;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(346002)(366004)(189003)(199004)(5250100002)(25786009)(53936002)(97736004)(8936002)(26005)(44832011)(11346002)(86362001)(486006)(55016002)(2900100001)(478600001)(6246003)(6506007)(446003)(2906002)(575784001)(106356001)(476003)(229853002)(9686003)(68736007)(2351001)(102836004)(6916009)(6436002)(186003)(4326008)(76176011)(8676002)(81156014)(256004)(14444005)(81166006)(14454004)(7736002)(105586002)(53546011)(7696005)(3846002)(5640700003)(1730700003)(74316002)(99286004)(316002)(305945005)(5660300001)(2501003)(66066001)(6116002)(33656002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4549;H:BYAPR02MB4501.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ip2aj9RmnDccjzCMeJpOHOkkis4Wmf739DaiOoQU1la2Sfb74RrtVT/HOjUIw8YS5MUveLWbnAHUqpz5X2BVm8B3yaeN4Anp3AVt1LWN5WaR4jfimttn9AxT320cDFYn0PLvriXGzHtBqMNVB6Edap4RHp3mIB7oWjk5nOyfR5mt6DZUcxT8jnLVeieOvAYl6JAiaOOYQ44+L09QbS++VD6+K17/5gqZKJivipUykw+9swB0zDhFteUibkUU/1jg2TCi/5DY591A+diYo56xVNYrGt3AijJ4nBEXTVBTFyaTj73GDEq7gnL1g9vK4G/l45rlTNMjjxrrLXtX/+BKvELnTDYXNFcKN7ib9oXPZ7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fa002e-a249-4c07-6f4a-08d5f3f43ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 19:07:46.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=A0Paul,

I'd like to opinion again on this subject.

So we are going to backport this patch:
6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")

But the other one:
8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
It doesn't apply cleanly, and I'm not too comfortable porting it myself.

So I'm wondering if I use the following change to always wake up follower t=
hread
regardless if the list was empty or not, just to be on the safe side. Do yo=
u think
this change is reasonable? Do you see any problem it might cause?

Thanks,
David

diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu=
/tree_plugin.h
--- linux-4.9.37.orig/kernel/rcu/tree_plugin.h	2017-07-12 06:42:41.00000000=
0 -0700
+++ linux-4.9.37/kernel/rcu/tree_plugin.h	2018-07-27 11:57:03.582134519 -07=
00
@@ -2077,7 +2077,7 @@
 		tail =3D xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
 		*tail =3D rdp->nocb_gp_head;
 		smp_mb__after_atomic(); /* Store *tail before wakeup. */
-		if (rdp !=3D my_rdp && tail =3D=3D &rdp->nocb_follower_head) {
+		if (rdp !=3D my_rdp) {
 			/*
 			 * List was empty, wake up the follower.
 			 * Memory barriers supplied by atomic_long_add().


From: David Chen
Sent: Friday, July 20, 2018 5:12 PM
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU nocb list not reclaiming causing OOM
=A0 =20

Hi Paul,

Ok, I'll try those patches.

Thanks,
David
 =20
From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Sent: Friday, July 20, 2018 4:32:12 PM
To: David Chen
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU nocb list not reclaiming causing OOM
=A0=20

On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> Hi Paul,
>=20
> We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list grows=
 too
> large, and not getting reclaimed, causing the system to OOM.
>=20
> Printing the culprit rcu_sched_data:
>=20
>=A0=A0 nocb_q_count =3D {
>=A0=A0=A0=A0 counter =3D 32369635
>=A0=A0 },
>=A0=A0 nocb_follower_head =3D 0xffff88ae901c0a00,
>=A0=A0 nocb_follower_tail =3D 0xffff88af1538b8d8,
>=A0=A0 nocb_kthread =3D 0xffff88b06d290000,
>=20
> As you can see here, the nocb_follower_head is not empty, so in theory, t=
he
> nocb_kthread shouldn't go to sleep. However, if dump the stack of the kth=
read:
>=20
> crash> bt 0xffff88b06d290000
> PID: 21=A0=A0=A0=A0 TASK: ffff88b06d290000=A0 CPU: 3=A0=A0 COMMAND: "rcuo=
s/1"
>=A0 #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
>=A0 #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
>=A0 #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
>=A0 #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
>=A0 #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
>=20
> And if we dis the address at ffffffff8d112337:
>=20
> /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.centos.=
x86_64/kernel/rcu/tree_plugin.h: 2106
> 0xffffffff8d11232d <rcu_nocb_kthread+381>:=A0=A0=A0=A0=A0 test=A0=A0 %rax=
,%rax
> 0xffffffff8d112330 <rcu_nocb_kthread+384>:=A0=A0=A0=A0=A0 jne=A0=A0=A0 0x=
ffffffff8d112355 <rcu_nocb_kthread+421>
> 0xffffffff8d112332 <rcu_nocb_kthread+386>:=A0=A0=A0=A0=A0 callq=A0 0xffff=
ffff8d878e40 <schedule>
> 0xffffffff8d112337 <rcu_nocb_kthread+391>:=A0=A0=A0=A0=A0 lea=A0=A0=A0 -0=
x40(%rbp),%rsi
>=20
> So the kthread is blocked at swait_event_interruptible in the nocb_follow=
er_wait.
> This contradict with the fact that nocb_follower_head was not empty. So I
> wonder if this is caused by the lack of memory barrier in the place shown=
 below.
> If the head is set to NULL after doing xchg, it will overwrite the head s=
et
> by leader. This caused the kthread to sleep the next iteration, and the l=
eader
> won't wake him up as the tail doesn't point to head.
>=20
> Please tell me what do you think.
>=20
> Thanks,
> David
>=20
> diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/r=
cu/tree_plugin.h
> --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0 2017-=
07-12 06:42:41.000000000 -0700
> +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-20 15:25:57=
.311206343 -0700
> @@ -2149,6 +2149,7 @@
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG_ON(!list);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_rcu_nocb_wake(rdp->rsp=
->name, rdp->cpu, "WokeNonEmpty");
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp->nocb_followe=
r_head, NULL);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb();
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_fol=
lower_tail, &rdp->nocb_follower_head);

The xchg() operation implies full memory barriers both before and after,
so adding the smp_mb() before would have no effect.

But let me take a look at post-4.9 changes to this code...

I suggest trying out the following commit:

6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")

If that one doesn't help, the following might be worth trying, but probably
a lot harder to backport:

8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")

Please let me know how it goes!

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Thanx, Paul

------------------------------------------------------------------------

commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:=A0=A0 Fri Apr 28 20:11:09 2017 -0700

=A0=A0=A0 rcu: Add memory barriers for NOCB leader wakeup
=A0=A0=A0=20
=A0=A0=A0 Wait/wakeup operations do not guarantee ordering on their own.=A0=
 Instead,
=A0=A0=A0 either locking or memory barriers are required.=A0 This commit th=
erefore
=A0=A0=A0 adds memory barriers to wake_nocb_leader() and nocb_leader_wait()=
.
=A0=A0=A0=20
=A0=A0=A0 Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
=A0=A0=A0 Tested-by: Krister Johansen <kjlx@templeofstupid.com>
=A0=A0=A0 Cc: <stable@vger.kernel.org> # 4.6.x

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b1042545116..573fbe9640a0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, bo=
ol force)
=A0=A0=A0=A0=A0=A0=A0=A0 if (READ_ONCE(rdp_leader->nocb_leader_sleep) || fo=
rce) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Prior smp_mb__after_ato=
mic() orders against prior enqueue. */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp_leader->noc=
b_leader_sleep, false);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb(); /* ->nocb_leader_slee=
p before swake_up(). */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swake_up(&rdp_leader->nocb=
_wq);
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0}
@@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * nocb_gp_head, where they await a grace period=
.
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0=A0 gotcbs =3D false;
+=A0=A0=A0=A0=A0=A0 smp_mb(); /* wakeup before ->nocb_head reads. */
=A0=A0=A0=A0=A0=A0=A0=A0 for (rdp =3D my_rdp; rdp; rdp =3D rdp->nocb_next_f=
ollower) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdp->nocb_gp_head =3D READ=
_ONCE(rdp->nocb_head);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rdp->nocb_gp_head)

     =
