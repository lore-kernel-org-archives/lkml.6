Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD662C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6169221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLhQZO/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6169221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeIXNGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:06:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeIXNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:06:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8O6wR3X145098;
        Mon, 24 Sep 2018 07:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hu/tLYo0LMOkNLgYxXaGWbvGt42mbnJRXKKG4yTehuQ=;
 b=kLhQZO/74bz95yP12ZmwPPHx/Pr+DntOcgIdjJoUW3nmbsqsqxjnK+8sOAiN/ICVQbDK
 +I099bMaWRk/Du53bkDmJBx50Ufa6gGpSvTlqn9vlsRMrb8Jp44Xa+qrIXl9DEl2vE7L
 cRVZMcVeUE2DpmeIs6T8TclcHnKU4sI7pFMBYzR72OTnZKK7pN3gAdz+VR0kJ2DNhHb6
 s4GJy/PhMe9D4b1O+Pb9ZA3c2FPI6BIOG420+Td5wC8mcMUdAJM8lU69RuqgeKgWq+AT
 2V/z5WadLCS4Lf3L2ECsy+Hsm2lhCI1yCmtROGct+nkIS0ZrXObUurl2OG8L2kU1bU42 ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mndpp3wk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 07:05:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8O75j69030337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 07:05:45 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8O75i6M031677;
        Mon, 24 Sep 2018 07:05:44 GMT
MIME-Version: 1.0
Message-ID: <dd819430-a67e-4507-b03f-d9d40528e74d@default>
Date:   Mon, 24 Sep 2018 00:05:42 -0700 (PDT)
From:   Manish Kumar Singh <mk.singh@oracle.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] bonding: avoid repeated display of same link status
 change
References: <20180917072059.32657-1-mk.singh@oracle.com>
 <33a66a80-22ed-d6b3-f6b2-4463357c5ffa@gmail.com>
 <78bf3185-fbd1-4a6c-ae32-70da0af2cbb4@default>
 <05f57c08-3ebb-7ee5-7ab2-519cb5a70bd8@gmail.com>
In-Reply-To: <05f57c08-3ebb-7ee5-7ab2-519cb5a70bd8@gmail.com>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 14.0.7212.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> Sent: 18 =E0=A4=B8=E0=A4=BF=E0=A4=A4=E0=A4=AE=E0=A5=8D=E0=A4=AC=E0=A4=B0 =
2018 19:30
> To: Manish Kumar Singh; Eric Dumazet; netdev@vger.kernel.org
> Cc: Jay Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller; lin=
ux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] bonding: avoid repeated display of same link status
> change
>=20
>=20
>=20
> On 09/17/2018 10:05 PM, Manish Kumar Singh wrote:
> >
> >
> >> -----Original Message-----
> >> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> >> Sent: 17 =E0=A4=B8=E0=A4=BF=E0=A4=A4=E0=A4=AE=E0=A5=8D=E0=A4=AC=E0=A4=
=B0 2018 20:08
> >> To: Manish Kumar Singh; netdev@vger.kernel.org
> >> Cc: Jay Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller;
> linux-
> >> kernel@vger.kernel.org
> >> Subject: Re: [PATCH] bonding: avoid repeated display of same link stat=
us
> >> change
> >>
> >>
> >>
> >> On 09/17/2018 12:20 AM, mk.singh@oracle.com wrote:
> >>> From: Manish Kumar Singh <mk.singh@oracle.com>
> >>>
> >>> When link status change needs to be committed and rtnl lock couldn't =
be
> >>> taken, avoid redisplay of same link status change message.
> >>>
> >>> Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
> >>> ---
> >>>  drivers/net/bonding/bond_main.c | 6 ++++--
> >>>  include/net/bonding.h           | 1 +
> >>>  2 files changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/bonding/bond_main.c
> >> b/drivers/net/bonding/bond_main.c
> >>> index 217b790d22ed..fb4e3aff1677 100644
> >>> --- a/drivers/net/bonding/bond_main.c
> >>> +++ b/drivers/net/bonding/bond_main.c
> >>> @@ -2087,7 +2087,7 @@ static int bond_miimon_inspect(struct bonding
> >> *bond)
> >>>  =09=09=09bond_propose_link_state(slave, BOND_LINK_FAIL);
> >>>  =09=09=09commit++;
> >>>  =09=09=09slave->delay =3D bond->params.downdelay;
> >>> -=09=09=09if (slave->delay) {
> >>> +=09=09=09if (slave->delay && !bond->rtnl_needed) {
> >>>  =09=09=09=09netdev_info(bond->dev, "link status down
> for
> >> %sinterface %s, disabling it in %d ms\n",
> >>>  =09=09=09=09=09    (BOND_MODE(bond) =3D=3D
> >>>  =09=09=09=09=09     BOND_MODE_ACTIVEBACKUP) ?
> >>> @@ -2127,7 +2127,7 @@ static int bond_miimon_inspect(struct bonding
> >> *bond)
> >>>  =09=09=09commit++;
> >>>  =09=09=09slave->delay =3D bond->params.updelay;
> >>>
> >>> -=09=09=09if (slave->delay) {
> >>> +=09=09=09if (slave->delay && !bond->rtnl_needed) {
> >>>  =09=09=09=09netdev_info(bond->dev, "link status up for
> >> interface %s, enabling it in %d ms\n",
> >>>  =09=09=09=09=09    slave->dev->name,
> >>>  =09=09=09=09=09    ignore_updelay ? 0 :
> >>> @@ -2301,9 +2301,11 @@ static void bond_mii_monitor(struct
> >> work_struct *work)
> >>>  =09=09if (!rtnl_trylock()) {
> >>>  =09=09=09delay =3D 1;
> >>>  =09=09=09should_notify_peers =3D false;
> >>> +=09=09=09bond->rtnl_needed =3D true;
> >>
> >> How can you set a shared variable with no synchronization ?
> > Thanks Eric for reviewing the patch. rtnl_needed is not a shared variab=
le, it
> is part of bonding structure, that is one per bonding driver instance. Th=
ere
> can't be two parallel instances of bond_miimon_inspect for a single =C2=
=A0bonding
> driver instance at any given point of time. and only bond_miimon_inspect
> updates it. That=E2=80=99s why I think there is no need of any synchroniz=
ation here.
> >
> >
>=20
> If rtnl_trylock() can not grab RTNL,
> there is no way the current thread can set the  variable without a race, =
if the
> word including rtnl_needed is shared by other fields in the structure.
>=20
> Your patch adds a subtle possibility of future bugs, even if it runs fine=
 today.
>=20
> Do not pave the way for future bugs, make your code robust, please.

Thankyou Eric, we are making the changes and will repost the patch after te=
sting it.
-Manish
>=20
>=20
>=20
>=20
>=20
>=20
>=20
