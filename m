Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928DBC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CAC20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="zm8B0F/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CAC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbeG1A5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:57:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:42246 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730636AbeG1A5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:57:11 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2018 20:57:09 EDT
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RNF87j011618;
        Fri, 27 Jul 2018 16:16:41 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0050.outbound.protection.outlook.com [216.32.181.50])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2kc3wdx857-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Jul 2018 16:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/aVrAaEdDH2GnlT3mfdMS+ekU/Q6ERStf7yBYmFnY4=;
 b=zm8B0F/iOjal71qU0k/aR3LFxfoIBKDqS/NMRrmI0iEyS5O0u/1TNNWxnF/yoxQl7ezDz0dM7cYT2x98PNVJMDkh7z/L17x9OIFzY8a/HQeUh78LUqBEfdP/RtybTwb3OkRB4Itizx5poNLC2poNalMGgV3S5vj/Me5sllm/978=
Received: from DM6PR02MB4508.namprd02.prod.outlook.com (20.176.107.21) by
 DM6PR02MB5228.namprd02.prod.outlook.com (20.176.116.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Fri, 27 Jul 2018 23:16:39 +0000
Received: from DM6PR02MB4508.namprd02.prod.outlook.com
 ([fe80::4c8d:ac7a:cee4:bcc]) by DM6PR02MB4508.namprd02.prod.outlook.com
 ([fe80::4c8d:ac7a:cee4:bcc%5]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 23:16:39 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Thread-Topic: RCU nocb list not reclaiming causing OOM
Thread-Index: AQHUIH18yrHc1RUlUkiqYiJ1aV59oKSYwskAgAALDpiACqj1uYAAO1OAgAAHgDU=
Date:   Fri, 27 Jul 2018 23:16:39 +0000
Message-ID: <DM6PR02MB4508A4A735450EAAC469E635942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
References: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180720233212.GC12945@linux.vnet.ibm.com>
 <BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
 <BYAPR02MB4501690DB627FBB8640A5C46942A0@BYAPR02MB4501.namprd02.prod.outlook.com>,<20180727223125.GJ24813@linux.vnet.ibm.com>
In-Reply-To: <20180727223125.GJ24813@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5228;6:oLatBK8CPJUaQv9ZzU5XNhTgkm4c6BqoW232BrDdHEUb39UYkBpYqs1iSPqTLHNW7h0iNivpwjvou3bLp4pR/rPE54fkofJk9joTjQiPqPDleBoiQr/6Qp3MF4iWP475hBOgA8sBr7rizz4JtoOArTy9eX4OTd2Y5BsT2z28SMe5/C3u/A+2CQFL2zZlvW5X7O3tKm9Yk8vliI8JOz+5mKRhVv/TyHPhH/YK9tFTvbccEWblFDMDvoyFYNR/ybXr4jXqUDzq8KiRjN9OKGOfBbO6EpGNmbtshWRvmaiYHMzaRyCb3vCAphyjjB0F0OuOl0GKz7iTSri7ku/peREWkr3htYGGq9ZWaWPGyKsGviuwWGLlo8/oJkC+1IS5lcCIwcD8d1/Fq9qq7ZDc6Q7TVfmpHL/R1OVwGXqQmrPi4p6yTcPtASogRNDGmT9MsFxNuUA7Snm4yjBuP3SNWhZ/bA==;5:cFgYGax/vfjVMQEsxHUVL39/imy0VAcF9nhhO+IwU1o+tNsm9PBfOZ318tlw9F7klQ0iPSMZtkq4gmo0G1B68Wg3ig1E75J7yQbmndgd8a+iZFQhes8m+40DfoddTeG8Opg4pko80/WPG1tMgsIje275vujFYKjXdDqetQ2XbxU=;7:NMFNP/v0izIqJ5pWLBCPNxjcxk/HfQBeqtC98sLWMmf781gxL9P6vGOR+2HtkMM1E5jAmIKwAcaRUMB0UKtiuccZ6o8j8eKZdOMkuJQgqQ/pFpmCq3kNlRjStTznzE+KklDVNL/KuxIGcXHYmOc0ZDRpmQ2Z55woZ7tU1zeXYNGN2rwg3dorXUa3ekEUYaatbAxwEyQq8GogzHQ64h0RyHZNZl3X1qdnZ6559lcIILSlAWOiq1vsfCIc78uHkHMO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6694bd9c-13e3-405e-8c5d-08d5f41701e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5228;
x-ms-traffictypediagnostic: DM6PR02MB5228:
x-microsoft-antispam-prvs: <DM6PR02MB5228105AC4445DF3D2E0C331942A0@DM6PR02MB5228.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB5228;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5228;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(51914003)(189003)(93886005)(316002)(2906002)(229853002)(5660300001)(55016002)(7696005)(9686003)(3846002)(6116002)(25786009)(81166006)(6916009)(81156014)(76176011)(11346002)(6246003)(446003)(6436002)(53936002)(102836004)(53546011)(33656002)(8676002)(4326008)(6506007)(26005)(5640700003)(186003)(486006)(14454004)(8936002)(478600001)(1730700003)(2501003)(97736004)(476003)(68736007)(256004)(14444005)(7736002)(44832011)(2351001)(66066001)(2900100001)(5250100002)(575784001)(86362001)(305945005)(106356001)(99286004)(105586002)(74316002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR02MB5228;H:DM6PR02MB4508.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fPgNbtJbpSMqXEcQSxWS6luvNOJhRQ1e+t8H9IILc9RIz8d7OjOH/fztoX+sKgWm8basv7xOMo/csYE93rWE4dOWq6y2Lxzb0J6ssugllHeoBiHhmqYiFa1OloZerhWwgNP/idseMcNrzOd42RbFqCaid4IXrKkvBUAWYcL1REQ6SAieYRWlN05B2lv8ZfTjRM8s4eABHpuWT4LFtQ0P8gnPEymbFl62CRk+WsNjAUKn2951SAANX8kTEvgTl0rew3Cy7ntlvSU3OceZMNfRLmAaangDfT4KHT6GZQ7uy2CCLJBQt+gq2S7TCEbASh9xg1KvkKLPoWQ3pyJpo4lYVf7xw7GkfeGIydOGXdmrHLQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6694bd9c-13e3-405e-8c5d-08d5f41701e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 23:16:39.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5228
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the advice.
The bug is kind of hard to hit, so I can't say for certain yet.

Though after another look at the code, I found out the `smp_mb__after_atomi=
c();`
seems to be only a compiler barrier on x86.

		tail =3D xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
		*tail =3D rdp->nocb_gp_head;
		smp_mb__after_atomic(); /* Store *tail before wakeup. */
		if (rdp !=3D my_rdp && tail =3D=3D &rdp->nocb_follower_head) {
			swake_up(&rdp->nocb_wq);

But that wouldn't be enough right? Because from 6b5fc3a13318, it stated tha=
t
wakeup operation don't guarantee ordering. And when the follower wakes up, =
it checks
for nocb_follower_head, which is assigned by `*tail =3D rdp->nocb_gp_head;`=
 which doesn't
have LOCK prefix. So it's possible for follower to wake up and see the list=
 is empty and go
back to sleep.

Thanks,
David

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Sent: Friday, July 27, 2018 3:31 PM
To: David Chen
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU nocb list not reclaiming causing OOM
=A0=20

On Fri, Jul 27, 2018 at 07:07:46PM +0000, David Chen wrote:
> Hi=A0Paul,
>=20
> I'd like to opinion again on this subject.
>=20
> So we are going to backport this patch:
> 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")

Does this one solve the problem, or are you still seeing hangs?
If you are no longer seeing hangs, my advice is "hands off keyboard",
though some would no doubt point out that I should follow that advice
more myself.=A0 ;-)

> But the other one:
> 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
> It doesn't apply cleanly, and I'm not too comfortable porting it myself.

Yeah, that one is a bit on the non-trivial side, no two ways about it.

> So I'm wondering if I use the following change to always wake up follower=
 thread
> regardless if the list was empty or not, just to be on the safe side. Do =
you think
> this change is reasonable? Do you see any problem it might cause?
>=20
> Thanks,
> David
>=20
> diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/r=
cu/tree_plugin.h
> --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0 2017-=
07-12 06:42:41.000000000 -0700
> +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-27 11:57:03=
.582134519 -0700
> @@ -2077,7 +2077,7 @@
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_fol=
lower_tail, rdp->nocb_gp_tail);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp_head;
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic(); /* S=
tore *tail before wakeup. */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && tail =3D=3D =
&rdp->nocb_follower_head) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp) {

This will burn a bit of extra CPU time, but it should be fine other than
that.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Thanx, Paul

>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=
 List was empty, wake up the follower.
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=
 Memory barriers supplied by atomic_long_add().
>=20
>=20
> From: David Chen
> Sent: Friday, July 20, 2018 5:12 PM
> To: paulmck@linux.vnet.ibm.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: RCU nocb list not reclaiming causing OOM
> =A0=A0=20
>=20
> Hi Paul,
>=20
> Ok, I'll try those patches.
>=20
> Thanks,
> David
>=A0=A0=20
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Sent: Friday, July 20, 2018 4:32:12 PM
> To: David Chen
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: RCU nocb list not reclaiming causing OOM
> =A0=20
>=20
> On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> > Hi Paul,
> >=20
> > We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list gro=
ws too
> > large, and not getting reclaimed, causing the system to OOM.
> >=20
> > Printing the culprit rcu_sched_data:
> >=20
> >=A0=A0 nocb_q_count =3D {
> >=A0=A0=A0=A0 counter =3D 32369635
> >=A0=A0 },
> >=A0=A0 nocb_follower_head =3D 0xffff88ae901c0a00,
> >=A0=A0 nocb_follower_tail =3D 0xffff88af1538b8d8,
> >=A0=A0 nocb_kthread =3D 0xffff88b06d290000,
> >=20
> > As you can see here, the nocb_follower_head is not empty, so in theory,=
 the
> > nocb_kthread shouldn't go to sleep. However, if dump the stack of the k=
thread:
> >=20
> > crash> bt 0xffff88b06d290000
> > PID: 21=A0=A0=A0=A0 TASK: ffff88b06d290000=A0 CPU: 3=A0=A0 COMMAND: "rc=
uos/1"
> >=A0 #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
> >=A0 #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
> >=A0 #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
> >=A0 #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
> >=A0 #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
> >=20
> > And if we dis the address at ffffffff8d112337:
> >=20
> > /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.cento=
s.x86_64/kernel/rcu/tree_plugin.h: 2106
> > 0xffffffff8d11232d <rcu_nocb_kthread+381>:=A0=A0=A0=A0=A0 test=A0=A0 %r=
ax,%rax
> > 0xffffffff8d112330 <rcu_nocb_kthread+384>:=A0=A0=A0=A0=A0 jne=A0=A0=A0 =
0xffffffff8d112355 <rcu_nocb_kthread+421>
> > 0xffffffff8d112332 <rcu_nocb_kthread+386>:=A0=A0=A0=A0=A0 callq=A0 0xff=
ffffff8d878e40 <schedule>
> > 0xffffffff8d112337 <rcu_nocb_kthread+391>:=A0=A0=A0=A0=A0 lea=A0=A0=A0 =
-0x40(%rbp),%rsi
> >=20
> > So the kthread is blocked at swait_event_interruptible in the nocb_foll=
ower_wait.
> > This contradict with the fact that nocb_follower_head was not empty. So=
 I
> > wonder if this is caused by the lack of memory barrier in the place sho=
wn below.
> > If the head is set to NULL after doing xchg, it will overwrite the head=
 set
> > by leader. This caused the kthread to sleep the next iteration, and the=
 leader
> > won't wake him up as the tail doesn't point to head.
> >=20
> > Please tell me what do you think.
> >=20
> > Thanks,
> > David
> >=20
> > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel=
/rcu/tree_plugin.h
> > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0 201=
7-07-12 06:42:41.000000000 -0700
> > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-20 15:25:=
57.311206343 -0700
> > @@ -2149,6 +2149,7 @@
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG_ON(!list);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_rcu_nocb_wake(rdp->r=
sp->name, rdp->cpu, "WokeNonEmpty");
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp->nocb_follo=
wer_head, NULL);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb();
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_f=
ollower_tail, &rdp->nocb_follower_head);
>=20
> The xchg() operation implies full memory barriers both before and after,
> so adding the smp_mb() before would have no effect.
>=20
> But let me take a look at post-4.9 changes to this code...
>=20
> I suggest trying out the following commit:
>=20
> 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
>=20
> If that one doesn't help, the following might be worth trying, but probab=
ly
> a lot harder to backport:
>=20
> 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
>=20
> Please let me know how it goes!
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:=A0=A0 Fri Apr 28 20:11:09 2017 -0700
>=20
> =A0=A0=A0 rcu: Add memory barriers for NOCB leader wakeup
> =A0=A0=A0=20
> =A0=A0=A0 Wait/wakeup operations do not guarantee ordering on their own.=
=A0 Instead,
> =A0=A0=A0 either locking or memory barriers are required.=A0 This commit =
therefore
> =A0=A0=A0 adds memory barriers to wake_nocb_leader() and nocb_leader_wait=
().
> =A0=A0=A0=20
> =A0=A0=A0 Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> =A0=A0=A0 Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> =A0=A0=A0 Cc: <stable@vger.kernel.org> # 4.6.x
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0b1042545116..573fbe9640a0 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, =
bool force)
> =A0=A0=A0=A0=A0=A0=A0=A0 if (READ_ONCE(rdp_leader->nocb_leader_sleep) || =
force) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Prior smp_mb__after_a=
tomic() orders against prior enqueue. */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp_leader->n=
ocb_leader_sleep, false);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb(); /* ->nocb_leader_sl=
eep before swake_up(). */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swake_up(&rdp_leader->no=
cb_wq);
> =A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0}
> @@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data *my_rd=
p)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * nocb_gp_head, where they await a grace peri=
od.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0=A0 gotcbs =3D false;
> +=A0=A0=A0=A0=A0=A0 smp_mb(); /* wakeup before ->nocb_head reads. */
> =A0=A0=A0=A0=A0=A0=A0=A0 for (rdp =3D my_rdp; rdp; rdp =3D rdp->nocb_next=
_follower) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdp->nocb_gp_head =3D RE=
AD_ONCE(rdp->nocb_head);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rdp->nocb_gp_head)
>=20
>=A0=A0=A0=A0=A0=20

    =
