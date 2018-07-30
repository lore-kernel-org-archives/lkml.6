Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9719C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C1F20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bBSbbOSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C1F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbeG3Up0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:45:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:37872 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730482AbeG3UpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:45:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UIxsoC006776;
        Mon, 30 Jul 2018 12:08:58 -0700
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0016.outbound.protection.outlook.com [216.32.181.16])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2kgqjf4u4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Jul 2018 12:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzl7Pyhz/ZFzUOwyPeIRTFmVswPdEW0kJMmibLvI3Fw=;
 b=bBSbbOSiDrMJr78yLfcpmPXxcRat3GpSFAqJJybq+e8tMROu+A1UDOOmJyYAhxcXdctKJuM1Lvfjfw7oBK0DayoLR42SDQsiIog5YcNXElae+muwkVEaGK9SIV4oUD5kywzbUd3B4WC+o7ZCDnWyr/T6lL98bJcEmqCG9kJrSqI=
Received: from BYAPR02MB4501.namprd02.prod.outlook.com (52.135.239.148) by
 BYAPR02MB4440.namprd02.prod.outlook.com (52.135.237.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Mon, 30 Jul 2018 19:08:55 +0000
Received: from BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da]) by BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da%4]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 19:08:55 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Thread-Topic: RCU nocb list not reclaiming causing OOM
Thread-Index: AQHUIH18yrHc1RUlUkiqYiJ1aV59oKSYwskAgAALDpiACqj1uYAAO1OAgAAHgDWAAA26gIAAAEYJgAAhJgCAAHCFAIAD1Gam
Date:   Mon, 30 Jul 2018 19:08:55 +0000
Message-ID: <BYAPR02MB4501BA05FDCDAAC8842B3EBD942F0@BYAPR02MB4501.namprd02.prod.outlook.com>
References: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180720233212.GC12945@linux.vnet.ibm.com>
 <BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
 <BYAPR02MB4501690DB627FBB8640A5C46942A0@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180727223125.GJ24813@linux.vnet.ibm.com>
 <DM6PR02MB4508A4A735450EAAC469E635942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
 <20180727234723.GN24813@linux.vnet.ibm.com>
 <DM6PR02MB4508E33C65B189DF3B5D6D54942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
 <20180728014700.GO24813@linux.vnet.ibm.com>,<20180728082944.GA23760@linux.vnet.ibm.com>
In-Reply-To: <20180728082944.GA23760@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4440;6:kgAxQcslh8KMlwizGls6zFSNCat9myoZGbEzgfuHtHSPZLOBhsjfsZTqH6Kx+uNtyLyrDxzm6EpvrYd4gH8BqkDwPBjtTSByZIlMBIW129gZ0G1fwCDjgx1q3596BlicTnmWY4gvJtrT29AYUr6MNqyQ1x2HjXz5OuLDQokQr+Cn/tUnHQb+UOhW+nKfo4oaKI5C+zcqX4UZ5n9rjfISWCRG3l1cJZSU0zz9ibHMfcSApBzh3MkQgv0/mcICnfBacI2YxylSr725SzZU5TGRdONSzR95U4a39NZ9BZYRk2H0Q9JC/JVm6gQTOqo+4lwevRHnmlzMsfTt3wh6ARyTbUx5ZzIJDUBlBkm4DGGW8Fl/w2FlGGG9YH01XUKiugENYBWcevQ/CZkibqEtzHWab7oES3Kds1IZX7aZutRgCTMq/tp/lOKklqNrg3ImcPwDX4E59xIs/AaGQLJHgh45tA==;5:NC7M9fo/dam0VXsENZ5RsCrwNDiqOQXiWKQ/PYBqQKu8gi+eAPGNwLL1FEbWSVoZjm2+xJ1bSZo4V+qQ9leTUCc9NOYQKNNbA2rGXTDwpeFF6stBWv7bvzYIs921pVMIAslg0fbHJyb14pdELFNH4dI4Eu97U9SXbI365eT3bdY=;7:4nZBN8snGa73iio+Wxjif/5O0vAma+CiUkXK15u6kdZMfjaV1CeCnBA588DI1X2lYzeCKqFbfYpdz5i8INz3QfvtXJDbbiGGDhY29y5rNbcnpmgdM+gu6rkKCIkxmThDuiHDi+CgmDwD2Wh9/xU8TEfM5jBNvdSBlDeXCygHWIlsmGNw1n5eTgzLTsL755PA0DkYL+U49WVlNezPHUOenl6t2hZFJkQ9yiiHMg8cJumsu/LJSUc3ExSsikHI7Uav
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d82091de-6f3e-453f-fe82-08d5f64fe5b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4440;
x-ms-traffictypediagnostic: BYAPR02MB4440:
x-microsoft-antispam-prvs: <BYAPR02MB4440D579E2B357FB7D8AA517942F0@BYAPR02MB4440.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4440;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4440;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(51914003)(55016002)(5660300001)(86362001)(575784001)(97736004)(5640700003)(6436002)(6116002)(33656002)(3846002)(105586002)(478600001)(14454004)(229853002)(81166006)(53936002)(4326008)(76176011)(7696005)(2900100001)(66066001)(486006)(102836004)(186003)(6246003)(53546011)(6506007)(26005)(2501003)(476003)(99286004)(5250100002)(44832011)(93886005)(68736007)(106356001)(1730700003)(81156014)(8676002)(14444005)(6916009)(256004)(9686003)(8936002)(2351001)(316002)(7736002)(25786009)(74316002)(446003)(11346002)(2906002)(305945005)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4440;H:BYAPR02MB4501.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lElQLUnfbWKASz/BjuMbA/wsby2dsjOSZjaLkUYvVvhSN4mCHNd1z9ndyo8GfkXnF8+kq8m/xTKMLA9q3lwZ/L+IdNmsbtQGxeMWhABwqliz6zpszR3L49HCOL7ZQSC9fPzZqGUI4JRPI7u4iQAeAbvv4lNy1/ABnYYTch3IqBw7NOiCVXFyBshiiU7BaPVqFSELptC9yfZpda3O6TKMHmTj+gL0sofywB48Wa+rDGdh5IIPwvn1RY3Utmc+LDtpWP9FHDChOZxM/4RiDhAxU/1OxsQXjjXj7SnpsMZhUVvZc/OfDjouQzrrfFNvz1B22UjlE90P6XdAR04AI1V8T1bY2pLYkl4pDeiHE583sfw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82091de-6f3e-453f-fe82-08d5f64fe5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 19:08:55.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4440
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Just want to know what's your plan on stable branches regarding this issue.
Do you intend to backport the ->nocb_lock? Or are you going with just the
memory barrier change?

Thanks,
David


From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Sent: Saturday, July 28, 2018 1:29 AM
To: David Chen
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU nocb list not reclaiming causing OOM
=A0=20

On Fri, Jul 27, 2018 at 06:47:00PM -0700, Paul E. McKenney wrote:
> On Sat, Jul 28, 2018 at 12:07:19AM +0000, David Chen wrote:
> > Hi Paul,
> >=20
> > I wasn't talking about the xchg() though.
> >=20
> > The smp_mb__after_atomic() is not for xchg(), it's for `*tail =3D rdp->=
nocb_gp_head;`
> > it's stated so in the comment. And I do think we need ordering between
> > `*tail =3D rdp->nocb_gp_head;` and wake up, because the waiter is check=
ing on head not tail.
> >=20
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swait_ev=
ent_interruptible(rdp->nocb_wq,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 READ_ONC=
E(rdp->nocb_follower_head));
> >=20
> > So what I'm saying is that since we need to maintain ordering between `=
*tail =3D rdp->nocb_gp_head;`
> > and wake up, we need to change the smp_mb__after_atomic() to smp_mb(). =
Because
> > smp_mb__after_atomic() wouldn't guarantee=20
> >=20
> > So this is what I'm proposing.
>=20
> Good eyes!
>=20
> Hmmm...=A0 What do I do about this in mainline?=A0 Ah, I introduced a
> ->nocb_lock in mainline to prevent this from happening.=A0 In that same
> commit that you didn't want to use because it is hard to backport.=A0 ;-)
>=20
> So yes, but there might well be other misorderings fixed by the
> hard-to-backport commit that your change below does not cover.=A0 Still I
> do agree that you need full ordering at that point.

Another approach would be to backport only the ->nocb_lock portions
of that patch.=A0 This would still potentially leave failure-to-wake
(as opposed to misordering-on-wake) issues, but it should cover all
of the misordering-on-wake issues.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Thanx, Paul

> > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel=
/rcu/tree_plugin.h
> > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0 2017-07-1=
2 06:42:41.000000000 -0700
> > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0 2018-07-27 16:23:41.349=
044259 -0700
> > @@ -2076,7 +2076,7 @@
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Append callbacks to follower'=
s "done" list. */
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb_followe=
r_tail, rdp->nocb_gp_tail);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp_head;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic(); /* Store *tail =
before wakeup. */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb(); /* Store *tail before wakeup.=
 */
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && tail =3D=
=3D &rdp->nocb_follower_head) {
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Lis=
t was empty, wake up the follower.
> >=20
> > Thanks,
> > David
> >=20
> > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Sent: Friday, July 27, 2018 4:47 PM
> > To: David Chen
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: RCU nocb list not reclaiming causing OOM
> > =A0=20
> >=20
> > On Fri, Jul 27, 2018 at 11:16:39PM +0000, David Chen wrote:
> > > Hi Paul,
> > >=20
> > > Thanks for the advice.
> > > The bug is kind of hard to hit, so I can't say for certain yet.
> >=20
> > Well, you can always remove the "tail =3D=3D &rdp->nocb_follower_head" =
as an
> > extra belt-and-suspenders safety net.=A0 I am not putting that in mainl=
ine,
> > but in the privacy of your own copy of the kernel, I don't see any real=
ly
> > serious problem with it.=A0 (As long as you aren't going for absolute m=
aximum
> > performance, but even then there are other more important tuning action=
s
> > and code changes you could make.)
> >=20
> > > Though after another look at the code, I found out the `smp_mb__after=
_atomic();`
> > > seems to be only a compiler barrier on x86.
> >=20
> > Yes, and that is because the locked xchg instruction used on x86 to
> > implement xchg() already provides full ordering.=A0 ;-)
> >=20
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->nocb=
_follower_tail, rdp->nocb_gp_tail);
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp_h=
ead;
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic(); =
/* Store *tail before wakeup. */
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && t=
ail =3D=3D &rdp->nocb_follower_head) {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
swake_up(&rdp->nocb_wq);
> > >=20
> > > But that wouldn't be enough right? Because from 6b5fc3a13318, it stat=
ed that
> > > wakeup operation don't guarantee ordering. And when the follower wake=
s up, it checks
> > > for nocb_follower_head, which is assigned by `*tail =3D rdp->nocb_gp_=
head;` which doesn't
> > > have LOCK prefix. So it's possible for follower to wake up and see th=
e list is empty and go
> > > back to sleep.
> >=20
> > Again, xchg() is defined to provide full ordering against all operation=
s
> > before and after it.=A0 Each architecture is required to do whatever is
> > necessary to implement that full ordering, and x86 need only provide
> > its "lock xchg" instruction.
> >=20
> > The smp_mb__after_atomic() has effect only after atomic read-modify-wri=
te
> > operations that do not return a value, for example, atomic_inc().
> > If you use it after a value-returning atomic read-modify-write operatio=
n
> > like xchg(), all you do is needlessly slow things down on platforms
> > that provide non-empty smp_mb__after_atomic() definitions.=A0 So again,
> > smp_mb__after_atomic() after xchg() is pointless.
> >=20
> > Please take a look at Documentation/core-api/atomic_ops.rst in the
> > Linux-kernel source tree for more information.=A0 Or get a v4.17 kernel
> > source tree and check this using the memory model (tools/memory-model
> > in that version).
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Thanx, Paul
> >=20
> > > Thanks,
> > > David
> > >=20
> > > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Sent: Friday, July 27, 2018 3:31 PM
> > > To: David Chen
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > =A0=20
> > >=20
> > > On Fri, Jul 27, 2018 at 07:07:46PM +0000, David Chen wrote:
> > > > Hi=A0Paul,
> > > >=20
> > > > I'd like to opinion again on this subject.
> > > >=20
> > > > So we are going to backport this patch:
> > > > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
> > >=20
> > > Does this one solve the problem, or are you still seeing hangs?
> > > If you are no longer seeing hangs, my advice is "hands off keyboard",
> > > though some would no doubt point out that I should follow that advice
> > > more myself.=A0 ;-)
> > >=20
> > > > But the other one:
> > > > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups=
")
> > > > It doesn't apply cleanly, and I'm not too comfortable porting it my=
self.
> > >=20
> > > Yeah, that one is a bit on the non-trivial side, no two ways about it=
.
> > >=20
> > > > So I'm wondering if I use the following change to always wake up fo=
llower thread
> > > > regardless if the list was empty or not, just to be on the safe sid=
e. Do you think
> > > > this change is reasonable? Do you see any problem it might cause?
> > > >=20
> > > > Thanks,
> > > > David
> > > >=20
> > > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/ke=
rnel/rcu/tree_plugin.h
> > > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=A0=
 2017-07-12 06:42:41.000000000 -0700
> > > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-27 11=
:57:03.582134519 -0700
> > > > @@ -2077,7 +2077,7 @@
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->no=
cb_follower_tail, rdp->nocb_gp_tail);
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *tail =3D rdp->nocb_gp=
_head;
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb__after_atomic()=
; /* Store *tail before wakeup. */
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp && tail =
=3D=3D &rdp->nocb_follower_head) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rdp !=3D my_rdp) {
> > >=20
> > > This will burn a bit of extra CPU time, but it should be fine other t=
han
> > > that.
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Thanx, Paul
> > >=20
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /*
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 * List was empty, wake up the follower.
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 * Memory barriers supplied by atomic_long_add().
> > > >=20
> > > >=20
> > > > From: David Chen
> > > > Sent: Friday, July 20, 2018 5:12 PM
> > > > To: paulmck@linux.vnet.ibm.com
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > > =A0=A0=20
> > > >=20
> > > > Hi Paul,
> > > >=20
> > > > Ok, I'll try those patches.
> > > >=20
> > > > Thanks,
> > > > David
> > > >=A0=A0=20
> > > > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Sent: Friday, July 20, 2018 4:32:12 PM
> > > > To: David Chen
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > > =A0=20
> > > >=20
> > > > On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> > > > > Hi Paul,
> > > > >=20
> > > > > We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower li=
st grows too
> > > > > large, and not getting reclaimed, causing the system to OOM.
> > > > >=20
> > > > > Printing the culprit rcu_sched_data:
> > > > >=20
> > > > >=A0=A0 nocb_q_count =3D {
> > > > >=A0=A0=A0=A0 counter =3D 32369635
> > > > >=A0=A0 },
> > > > >=A0=A0 nocb_follower_head =3D 0xffff88ae901c0a00,
> > > > >=A0=A0 nocb_follower_tail =3D 0xffff88af1538b8d8,
> > > > >=A0=A0 nocb_kthread =3D 0xffff88b06d290000,
> > > > >=20
> > > > > As you can see here, the nocb_follower_head is not empty, so in t=
heory, the
> > > > > nocb_kthread shouldn't go to sleep. However, if dump the stack of=
 the kthread:
> > > > >=20
> > > > > crash> bt 0xffff88b06d290000
> > > > > PID: 21=A0=A0=A0=A0 TASK: ffff88b06d290000=A0 CPU: 3=A0=A0 COMMAN=
D: "rcuos/1"
> > > > >=A0 #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
> > > > >=A0 #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
> > > > >=A0 #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
> > > > >=A0 #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
> > > > >=A0 #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
> > > > >=20
> > > > > And if we dis the address at ffffffff8d112337:
> > > > >=20
> > > > > /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7=
.centos.x86_64/kernel/rcu/tree_plugin.h: 2106
> > > > > 0xffffffff8d11232d <rcu_nocb_kthread+381>:=A0=A0=A0=A0=A0 test=A0=
=A0 %rax,%rax
> > > > > 0xffffffff8d112330 <rcu_nocb_kthread+384>:=A0=A0=A0=A0=A0 jne=A0=
=A0=A0 0xffffffff8d112355 <rcu_nocb_kthread+421>
> > > > > 0xffffffff8d112332 <rcu_nocb_kthread+386>:=A0=A0=A0=A0=A0 callq=
=A0 0xffffffff8d878e40 <schedule>
> > > > > 0xffffffff8d112337 <rcu_nocb_kthread+391>:=A0=A0=A0=A0=A0 lea=A0=
=A0=A0 -0x40(%rbp),%rsi
> > > > >=20
> > > > > So the kthread is blocked at swait_event_interruptible in the noc=
b_follower_wait.
> > > > > This contradict with the fact that nocb_follower_head was not emp=
ty. So I
> > > > > wonder if this is caused by the lack of memory barrier in the pla=
ce shown below.
> > > > > If the head is set to NULL after doing xchg, it will overwrite th=
e head set
> > > > > by leader. This caused the kthread to sleep the next iteration, a=
nd the leader
> > > > > won't wake him up as the tail doesn't point to head.
> > > > >=20
> > > > > Please tell me what do you think.
> > > > >=20
> > > > > Thanks,
> > > > > David
> > > > >=20
> > > > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/=
kernel/rcu/tree_plugin.h
> > > > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h=A0=A0=A0=A0=A0=A0=
=A0 2017-07-12 06:42:41.000000000 -0700
> > > > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h=A0=A0=A0=A0 2018-07-20 =
15:25:57.311206343 -0700
> > > > > @@ -2149,6 +2149,7 @@
> > > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG_ON(!list);
> > > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_rcu_nocb_wake(=
rdp->rsp->name, rdp->cpu, "WokeNonEmpty");
> > > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp->nocb=
_follower_head, NULL);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb();
> > > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tail =3D xchg(&rdp->=
nocb_follower_tail, &rdp->nocb_follower_head);
> > > >=20
> > > > The xchg() operation implies full memory barriers both before and a=
fter,
> > > > so adding the smp_mb() before would have no effect.
> > > >=20
> > > > But let me take a look at post-4.9 changes to this code...
> > > >=20
> > > > I suggest trying out the following commit:
> > > >=20
> > > > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
> > > >=20
> > > > If that one doesn't help, the following might be worth trying, but =
probably
> > > > a lot harder to backport:
> > > >=20
> > > > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups=
")
> > > >=20
> > > > Please let me know how it goes!
> > > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Thanx, Paul
> > > >=20
> > > > -------------------------------------------------------------------=
-----
> > > >=20
> > > > commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
> > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Date:=A0=A0 Fri Apr 28 20:11:09 2017 -0700
> > > >=20
> > > > =A0=A0=A0 rcu: Add memory barriers for NOCB leader wakeup
> > > > =A0=A0=A0=20
> > > > =A0=A0=A0 Wait/wakeup operations do not guarantee ordering on their=
 own.=A0 Instead,
> > > > =A0=A0=A0 either locking or memory barriers are required.=A0 This c=
ommit therefore
> > > > =A0=A0=A0 adds memory barriers to wake_nocb_leader() and nocb_leade=
r_wait().
> > > > =A0=A0=A0=20
> > > > =A0=A0=A0 Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.c=
om>
> > > > =A0=A0=A0 Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> > > > =A0=A0=A0 Cc: <stable@vger.kernel.org> # 4.6.x
> > > >=20
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 0b1042545116..573fbe9640a0 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data =
*rdp, bool force)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 if (READ_ONCE(rdp_leader->nocb_leader_slee=
p) || force) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Prior smp_mb__a=
fter_atomic() orders against prior enqueue. */
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(rdp_lea=
der->nocb_leader_sleep, false);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb(); /* ->nocb_lea=
der_sleep before swake_up(). */
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swake_up(&rdp_lead=
er->nocb_wq);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > =A0}
> > > > @@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data =
*my_rdp)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 * nocb_gp_head, where they await a grac=
e period.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 gotcbs =3D false;
> > > > +=A0=A0=A0=A0=A0=A0 smp_mb(); /* wakeup before ->nocb_head reads. *=
/
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 for (rdp =3D my_rdp; rdp; rdp =3D rdp->noc=
b_next_follower) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdp->nocb_gp_head =
=3D READ_ONCE(rdp->nocb_head);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rdp->nocb_gp_=
head)
> > > >=20
> > > >=A0=A0=A0=A0=A0=20
> > >=20
> > >=A0=A0=A0=A0=20
> >=20
> >=A0=A0=A0=A0=20

    =
