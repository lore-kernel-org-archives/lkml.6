Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22345C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913B20673
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RyuPiufC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9913B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbeG1Bbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:31:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:51092 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388879AbeG1Bbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:31:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6S04lFn004090;
        Fri, 27 Jul 2018 17:07:22 -0700
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0175.outbound.protection.outlook.com [216.32.181.175])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2kgb48r9m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Jul 2018 17:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0eJwUG8yuTL2+jQpJTwS/iLG5Nm+e83lQ5pcJaywHI=;
 b=RyuPiufCoaM9AJH+M/mRTeT9FW9tdgHXphNP+ZW64sTSIcrA1jYyXtYM+lLdoohyKOEkNg766B78kKxdbiqelwvBxeN0QrobOKLaenu2fh9SB3cTjSR2hP8I22aPVpww42HglsyB8SVqc2xbpgMvHlkO9dEcYunQTMIhDtU7mMg=
Received: from DM6PR02MB4508.namprd02.prod.outlook.com (20.176.107.21) by
 DM6PR02MB4697.namprd02.prod.outlook.com (20.176.108.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 00:07:19 +0000
Received: from DM6PR02MB4508.namprd02.prod.outlook.com
 ([fe80::4c8d:ac7a:cee4:bcc]) by DM6PR02MB4508.namprd02.prod.outlook.com
 ([fe80::4c8d:ac7a:cee4:bcc%5]) with mapi id 15.20.0995.019; Sat, 28 Jul 2018
 00:07:19 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Thread-Topic: RCU nocb list not reclaiming causing OOM
Thread-Index: AQHUIH18yrHc1RUlUkiqYiJ1aV59oKSYwskAgAALDpiACqj1uYAAO1OAgAAHgDWAAA26gIAAAEYJ
Date:   Sat, 28 Jul 2018 00:07:19 +0000
Message-ID: <DM6PR02MB4508E33C65B189DF3B5D6D54942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
References: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180720233212.GC12945@linux.vnet.ibm.com>
 <BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
 <BYAPR02MB4501690DB627FBB8640A5C46942A0@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180727223125.GJ24813@linux.vnet.ibm.com>
 <DM6PR02MB4508A4A735450EAAC469E635942A0@DM6PR02MB4508.namprd02.prod.outlook.com>,<20180727234723.GN24813@linux.vnet.ibm.com>
In-Reply-To: <20180727234723.GN24813@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4697;6:eXnvSUMoqN3SrFHdcycit1SuDRhshLFGCffxOyvDyLVTyCYoFKP1dE/A9L0am6MQG5GbJxYxf1URlB7BC1bStII5nhU+Jw3ej5ZmLx7hAk0Y6w7pzTysOp7lD+sHu6cMJHZVD8BgERpG3lJRFvOhkObdlh0df5+T0uBNAbLXyGKmfQIb1jEvtxIyfaoGFFRQSDXEr4qHYaNRU0k9tuxh7Bfz6YacqJtXL30njSktyAIO4mUU9iCDeeXiY8D8RB/MXYb4Hcciqn+GVdwJZy7kaMwB0xCq0BIvI/lXtaJDeWH97a3HrLFfVXO8niNWf46Vl2EHK0eIs9tt7yHudhF642T6V6Kd0uknO10IL6eOMZl/nYCE9UzT/P8uLHY9A9n7Ych1x+ow9+oRZyptMJVRg1zO8Xrf2vRlD6jltSUhpTO4hQC49H6ZRUMkfoJjyQRtLcKej7/qo1yLmVRNflPX1A==;5:mWIEb52D8bDn0PDcCdtaVecQ7trTHedCoSymef+fVNk+7BYVJnqUuIKk988RH4db9LYFYI9a8hTk5nL5vG+lOYuiaQkOFadVqmjJ9WM6gtw8cUxyqPXBnUJE5j6L9evzp/zTTqgixmF2o82cW5vyNSj61oOtd6ZhYhauNQk+tAc=;7:8nNhfNe6gDAPI6eZJaP6wfgtr/utezSdSxr3YkYRxrMGftmYyMGh1Tvm8OHatxZd/hDSk0yCAE04XQCOHxaFQF9WMbsdcBoUEPhHnxeb261JgKQ1S7aPSYDay0bRl8z2wn0A9fdR9Za4hoPOJK5x/AXA2MFfm3EOVs2yiSESsZaOC/atTkUjzumUd4ErkEMzJHvAb6naDDSL1iTv2q40xPb25Prjs7DqSnMGB23Nasi4wBPtM2ZfClK/cbMjqGCc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1617c89b-52f3-40ac-2be4-08d5f41e1600
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4697;
x-ms-traffictypediagnostic: DM6PR02MB4697:
x-microsoft-antispam-prvs: <DM6PR02MB4697A6699CB0F1E384E3BDBF94290@DM6PR02MB4697.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4697;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4697;
x-forefront-prvs: 07473990A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(51914003)(93886005)(2900100001)(81156014)(14454004)(8676002)(81166006)(25786009)(1730700003)(6436002)(7736002)(68736007)(6246003)(44832011)(53936002)(478600001)(5250100002)(97736004)(575784001)(9686003)(2501003)(86362001)(6916009)(256004)(74316002)(14444005)(7696005)(2906002)(105586002)(305945005)(476003)(99286004)(5660300001)(2351001)(6116002)(76176011)(102836004)(186003)(4326008)(5640700003)(33656002)(316002)(11346002)(66066001)(8936002)(26005)(106356001)(446003)(53546011)(229853002)(486006)(55016002)(6506007)(3846002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR02MB4697;H:DM6PR02MB4508.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zeT7XjdV6dB+Rk5ufcyvzOzKFU/63GD/DVh/LsaNZ8JMa8luzayunZajsr6G64bxphUY+2nZze/pZ39iUsGRX87+60G2QfglaiE5OS33OTGPYlOwgg2rZ7WGq24ZG+8fOiTTYemDtmvv3LNqSRG6tin1dNdbt2cRakxOxHGcqDKPV2uxF1xKvm+CwT+/bZWmxyC3lgRoT1viejI2ECCvZek20YAbjkx+msPQmAnskicTMmB85mgWgysSNcbqOVEdKobvoJ1xEuiQoPclr0YI09tBWseNgF+iyYbJ9ngA4vw4ENUCSsSAUMgaHYLRjGWMYHbSKZMMJ65A0BOHWgwbxoirEdE0RA2eWFEpNLnIG2Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1617c89b-52f3-40ac-2be4-08d5f41e1600
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2018 00:07:19.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4697
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807280000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I wasn't talking about the xchg() though.

The smp_mb__after_atomic() is not for xchg(), it's for `*tail =3D rdp->nocb=
_gp_head;`
it's stated so in the comment. And I do think we need ordering between
`*tail =3D rdp->nocb_gp_head;` and wake up, because the waiter is checking =
on head not tail.

			swait_event_interruptible(rdp->nocb_wq,
						 READ_ONCE(rdp->nocb_follower_head));

So what I'm saying is that since we need to maintain ordering between `*tai=
l =3D rdp->nocb_gp_head;`
and wake up, we need to change the smp_mb__after_atomic() to smp_mb(). Beca=
use
smp_mb__after_atomic() wouldn't guarantee=20

So this is what I'm proposing.

diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu=
/tree_plugin.h
--- linux-4.9.37.orig/kernel/rcu/tree_plugin.h	2017-07-12 06:42:41.00000000=
0 -0700
+++ linux-4.9.37/kernel/rcu/tree_plugin.h	2018-07-27 16:23:41.349044259 -07=
00
@@ -2076,7 +2076,7 @@
 		/* Append callbacks to follower's "done" list. */
 		tail =3D xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
 		*tail =3D rdp->nocb_gp_head;
-		smp_mb__after_atomic(); /* Store *tail before wakeup. */
+		smp_mb(); /* Store *tail before wakeup. */
 		if (rdp !=3D my_rdp && tail =3D=3D &rdp->nocb_follower_head) {
 			/*
 			 * List was empty, wake up the follower.

Thanks,
David

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Sent: Friday, July 27, 2018 4:47 PM
To: David Chen
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU nocb list not reclaiming causing OOM
=A0=20

On Fri, Jul 27, 2018 at 11:16:39PM +0000, David Chen wrote:
> Hi Paul,
>=20
> Thanks for the advice.
> The bug is kind of hard to hit, so I can't say for certain yet.

Well, you can always remove the "tail =3D=3D &rdp->nocb_follower_head" as a=
n
extra belt-and-suspenders safety net.=A0 I am not putting that in mainline,
but in the privacy of your own copy of the kernel, I don't see any really
serious problem with it.=A0 (As long as you aren't going for absolute maxim=
um
performance, but even then there are other more important tuning actions
and code changes you could make.)

> Though after another look at the code, I found out the `smp_mb__after_ato=
mic();`
> seems to be only a compiler barrier on x86.

Yes, and that is because the locked xchg instruction used on x86 to
implement xchg() already provides full ordering.=A0 ;-)

>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_fol=
lower_tail, rdp->nocb_gp_tail);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp_head;
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic(); /* S=
tore *tail before wakeup. */
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && tail =
=3D=3D &rdp->nocb_follower_head) {
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swak=
e_up(&rdp->nocb_wq);
>=20
> But that wouldn't be enough right? Because from 6b5fc3a13318, it stated t=
hat
> wakeup operation don't guarantee ordering. And when the follower wakes up=
, it checks
> for nocb_follower_head, which is assigned by `*tail =3D rdp->nocb_gp_head=
;` which doesn't
> have LOCK prefix. So it's possible for follower to wake up and see the li=
st is empty and go
> back to sleep.

Again, xchg() is defined to provide full ordering against all operations
before and after it.=A0 Each architecture is required to do whatever is
necessary to implement that full ordering, and x86 need only provide
its "lock xchg" instruction.

The smp_mb__after_atomic() has effect only after atomic read-modify-write
operations that do not return a value, for example, atomic_inc().
If you use it after a value-returning atomic read-modify-write operation
like xchg(), all you do is needlessly slow things down on platforms
that provide non-empty smp_mb__after_atomic() definitions.=A0 So again,
smp_mb__after_atomic() after xchg() is pointless.

Please take a look at Documentation/core-api/atomic_ops.rst in the
Linux-kernel source tree for more information.=A0 Or get a v4.17 kernel
source tree and check this using the memory model (tools/memory-model
in that version).

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Thanx, Paul

> Thanks,
> David
>=20
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Sent: Friday, July 27, 2018 3:31 PM
> To: David Chen
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: RCU nocb list not reclaiming causing OOM
> =A0=20
>=20
> On Fri, Jul 27, 2018 at 07:07:46PM +0000, David Chen wrote:
> > Hi=A0Paul,
> >=20
> > I'd like to opinion again on this subject.
> >=20
> > So we are going to backport this patch:
> > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
>=20
> Does this one solve the problem, or are you still seeing hangs?
> If you are no longer seeing hangs, my advice is "hands off keyboard",
> though some would no doubt point out that I should follow that advice
> more myself.=A0 ;-)
>=20
> > But the other one:
> > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
> > It doesn't apply cleanly, and I'm not too comfortable porting it myself=
.
>=20
> Yeah, that one is a bit on the non-trivial side, no two ways about it.
>=20
> > So I'm wondering if I use the following change to always wake up follow=
er thread
> > regardless if the list was empty or not, just to be on the safe side. D=
o you think
> > this change is reasonable? Do you see any problem it might cause?
> >=20
> > Thanks,
> > David
> >=20
> > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel=
/rcu/tree_plugin.h
> > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0 201=
7-07-12 06:42:41.000000000 -0700
> > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-27 11:57:=
03.582134519 -0700
> > @@ -2077,7 +2077,7 @@
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_f=
ollower_tail, rdp->nocb_gp_tail);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp_hea=
d;
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic(); /*=
 Store *tail before wakeup. */
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && tail =3D=
=3D &rdp->nocb_follower_head) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp) {
>=20
> This will burn a bit of extra CPU time, but it should be fine other than
> that.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Thanx, Paul
>=20
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 * List was empty, wake up the follower.
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 * Memory barriers supplied by atomic_long_add().
> >=20
> >=20
> > From: David Chen
> > Sent: Friday, July 20, 2018 5:12 PM
> > To: paulmck@linux.vnet.ibm.com
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: RCU nocb list not reclaiming causing OOM
> > =A0=A0=20
> >=20
> > Hi Paul,
> >=20
> > Ok, I'll try those patches.
> >=20
> > Thanks,
> > David
> >=A0=A0=20
> > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Sent: Friday, July 20, 2018 4:32:12 PM
> > To: David Chen
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: RCU nocb list not reclaiming causing OOM
> > =A0=20
> >=20
> > On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> > > Hi Paul,
> > >=20
> > > We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list g=
rows too
> > > large, and not getting reclaimed, causing the system to OOM.
> > >=20
> > > Printing the culprit rcu_sched_data:
> > >=20
> > >=A0=A0 nocb_q_count =3D {
> > >=A0=A0=A0=A0 counter =3D 32369635
> > >=A0=A0 },
> > >=A0=A0 nocb_follower_head =3D 0xffff88ae901c0a00,
> > >=A0=A0 nocb_follower_tail =3D 0xffff88af1538b8d8,
> > >=A0=A0 nocb_kthread =3D 0xffff88b06d290000,
> > >=20
> > > As you can see here, the nocb_follower_head is not empty, so in theor=
y, the
> > > nocb_kthread shouldn't go to sleep. However, if dump the stack of the=
 kthread:
> > >=20
> > > crash> bt 0xffff88b06d290000
> > > PID: 21=A0=A0=A0=A0 TASK: ffff88b06d290000=A0 CPU: 3=A0=A0 COMMAND: "=
rcuos/1"
> > >=A0 #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
> > >=A0 #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
> > >=A0 #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
> > >=A0 #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
> > >=A0 #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
> > >=20
> > > And if we dis the address at ffffffff8d112337:
> > >=20
> > > /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.cen=
tos.x86_64/kernel/rcu/tree_plugin.h: 2106
> > > 0xffffffff8d11232d <rcu_nocb_kthread+381>:=A0=A0=A0=A0=A0 test=A0=A0 =
%rax,%rax
> > > 0xffffffff8d112330 <rcu_nocb_kthread+384>:=A0=A0=A0=A0=A0 jne=A0=A0=
=A0 0xffffffff8d112355 <rcu_nocb_kthread+421>
> > > 0xffffffff8d112332 <rcu_nocb_kthread+386>:=A0=A0=A0=A0=A0 callq=A0 0x=
ffffffff8d878e40 <schedule>
> > > 0xffffffff8d112337 <rcu_nocb_kthread+391>:=A0=A0=A0=A0=A0 lea=A0=A0=
=A0 -0x40(%rbp),%rsi
> > >=20
> > > So the kthread is blocked at swait_event_interruptible in the nocb_fo=
llower_wait.
> > > This contradict with the fact that nocb_follower_head was not empty. =
So I
> > > wonder if this is caused by the lack of memory barrier in the place s=
hown below.
> > > If the head is set to NULL after doing xchg, it will overwrite the he=
ad set
> > > by leader. This caused the kthread to sleep the next iteration, and t=
he leader
> > > won't wake him up as the tail doesn't point to head.
> > >=20
> > > Please tell me what do you think.
> > >=20
> > > Thanks,
> > > David
> > >=20
> > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kern=
el/rcu/tree_plugin.h
> > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0 2=
017-07-12 06:42:41.000000000 -0700
> > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-20 15:2=
5:57.311206343 -0700
> > > @@ -2149,6 +2149,7 @@
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG_ON(!list);
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_rcu_nocb_wake(rdp-=
>rsp->name, rdp->cpu, "WokeNonEmpty");
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp->nocb_fol=
lower_head, NULL);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb();
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb=
_follower_tail, &rdp->nocb_follower_head);
> >=20
> > The xchg() operation implies full memory barriers both before and after=
,
> > so adding the smp_mb() before would have no effect.
> >=20
> > But let me take a look at post-4.9 changes to this code...
> >=20
> > I suggest trying out the following commit:
> >=20
> > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
> >=20
> > If that one doesn't help, the following might be worth trying, but prob=
ably
> > a lot harder to backport:
> >=20
> > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
> >=20
> > Please let me know how it goes!
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Thanx, Paul
> >=20
> > -----------------------------------------------------------------------=
-
> >=20
> > commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:=A0=A0 Fri Apr 28 20:11:09 2017 -0700
> >=20
> > =A0=A0=A0 rcu: Add memory barriers for NOCB leader wakeup
> > =A0=A0=A0=20
> > =A0=A0=A0 Wait/wakeup operations do not guarantee ordering on their own=
.=A0 Instead,
> > =A0=A0=A0 either locking or memory barriers are required.=A0 This commi=
t therefore
> > =A0=A0=A0 adds memory barriers to wake_nocb_leader() and nocb_leader_wa=
it().
> > =A0=A0=A0=20
> > =A0=A0=A0 Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > =A0=A0=A0 Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> > =A0=A0=A0 Cc: <stable@vger.kernel.org> # 4.6.x
> >=20
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 0b1042545116..573fbe9640a0 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data *rdp=
, bool force)
> > =A0=A0=A0=A0=A0=A0=A0=A0 if (READ_ONCE(rdp_leader->nocb_leader_sleep) |=
| force) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Prior smp_mb__after=
_atomic() orders against prior enqueue. */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp_leader-=
>nocb_leader_sleep, false);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb(); /* ->nocb_leader_=
sleep before swake_up(). */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swake_up(&rdp_leader->=
nocb_wq);
> > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > =A0}
> > @@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data *my_=
rdp)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 * nocb_gp_head, where they await a grace pe=
riod.
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > =A0=A0=A0=A0=A0=A0=A0=A0 gotcbs =3D false;
> > +=A0=A0=A0=A0=A0=A0 smp_mb(); /* wakeup before ->nocb_head reads. */
> > =A0=A0=A0=A0=A0=A0=A0=A0 for (rdp =3D my_rdp; rdp; rdp =3D rdp->nocb_ne=
xt_follower) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdp->nocb_gp_head =3D =
READ_ONCE(rdp->nocb_head);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rdp->nocb_gp_head=
)
> >=20
> >=A0=A0=A0=A0=A0=20
>=20
>=A0=A0=A0=A0=20

    =
