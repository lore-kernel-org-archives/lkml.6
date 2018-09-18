Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C3ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413DC2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="htSmSLWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413DC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeIRKgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:36:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34398 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeIRKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:36:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8I54U6G024130;
        Tue, 18 Sep 2018 05:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NOhhqppCfusASO2UaXupwb1emFwGwj5eRZMPrDNIoZM=;
 b=htSmSLWWqwOBO1lTrdSjuqctNRD+jxDRhDpsJkIENaEkxGxQ3Jps7Iv1Pl8zsEq6f3bP
 ueQME4aWKhQdS+sX+HJyQxYv71RY9n+BiJGqXKzl131LeH5oi5dhATEeztBMAJdgzwMj
 0AFk0TyrzhW7Rl3TQCTGqI/sH+So43OWcDscDt6xJs40dS0HIh2i22lltfnZpKE/qx5P
 5ikRAC/VczcQ8kBtWtXRqKYnA2pj0CJB5CKft/ntadgr3JIRge1q00J7FRjXYJYk9RIa
 yJ3wLlhDRZEWSelDsxaYBvau6pGM1WM6VIPo8VRb3wd/c0MoIElqW/dHwHSAisX74yB+ MQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mgt1phy1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 05:05:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8I55nOi019909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 05:05:49 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8I55mZ0004293;
        Tue, 18 Sep 2018 05:05:48 GMT
MIME-Version: 1.0
Message-ID: <78bf3185-fbd1-4a6c-ae32-70da0af2cbb4@default>
Date:   Mon, 17 Sep 2018 22:05:44 -0700 (PDT)
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
In-Reply-To: <33a66a80-22ed-d6b3-f6b2-4463357c5ffa@gmail.com>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 14.0.7212.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> Sent: 17 =E0=A4=B8=E0=A4=BF=E0=A4=A4=E0=A4=AE=E0=A5=8D=E0=A4=AC=E0=A4=B0 =
2018 20:08
> To: Manish Kumar Singh; netdev@vger.kernel.org
> Cc: Jay Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller; lin=
ux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] bonding: avoid repeated display of same link status
> change
>=20
>=20
>=20
> On 09/17/2018 12:20 AM, mk.singh@oracle.com wrote:
> > From: Manish Kumar Singh <mk.singh@oracle.com>
> >
> > When link status change needs to be committed and rtnl lock couldn't be
> > taken, avoid redisplay of same link status change message.
> >
> > Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 6 ++++--
> >  include/net/bonding.h           | 1 +
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c
> b/drivers/net/bonding/bond_main.c
> > index 217b790d22ed..fb4e3aff1677 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2087,7 +2087,7 @@ static int bond_miimon_inspect(struct bonding
> *bond)
> >  =09=09=09bond_propose_link_state(slave, BOND_LINK_FAIL);
> >  =09=09=09commit++;
> >  =09=09=09slave->delay =3D bond->params.downdelay;
> > -=09=09=09if (slave->delay) {
> > +=09=09=09if (slave->delay && !bond->rtnl_needed) {
> >  =09=09=09=09netdev_info(bond->dev, "link status down for
> %sinterface %s, disabling it in %d ms\n",
> >  =09=09=09=09=09    (BOND_MODE(bond) =3D=3D
> >  =09=09=09=09=09     BOND_MODE_ACTIVEBACKUP) ?
> > @@ -2127,7 +2127,7 @@ static int bond_miimon_inspect(struct bonding
> *bond)
> >  =09=09=09commit++;
> >  =09=09=09slave->delay =3D bond->params.updelay;
> >
> > -=09=09=09if (slave->delay) {
> > +=09=09=09if (slave->delay && !bond->rtnl_needed) {
> >  =09=09=09=09netdev_info(bond->dev, "link status up for
> interface %s, enabling it in %d ms\n",
> >  =09=09=09=09=09    slave->dev->name,
> >  =09=09=09=09=09    ignore_updelay ? 0 :
> > @@ -2301,9 +2301,11 @@ static void bond_mii_monitor(struct
> work_struct *work)
> >  =09=09if (!rtnl_trylock()) {
> >  =09=09=09delay =3D 1;
> >  =09=09=09should_notify_peers =3D false;
> > +=09=09=09bond->rtnl_needed =3D true;
>=20
> How can you set a shared variable with no synchronization ?
Thanks Eric for reviewing the patch. rtnl_needed is not a shared variable, =
it is part of bonding structure, that is one per bonding driver instance. T=
here can't be two parallel instances of bond_miimon_inspect for a single =
=C2=A0bonding driver instance at any given point of time. and only bond_mii=
mon_inspect updates it. That=E2=80=99s why I think there is no need of any =
synchronization here. =20

>=20
> A bool is particularly dangerous here, at least on some arches.
Thank you for cautioning us on bool usage. even a u8 can meet our requireme=
nt.  we will change it.  but; if time permits can you share more on "partic=
ularly dangerous here, at least on some arches".

F
>=20
> >  =09=09=09goto re_arm;
> >  =09=09}
> >
> > +=09=09bond->rtnl_needed =3D false;
> >  =09=09bond_for_each_slave(bond, slave, iter) {
> >  =09=09=09bond_commit_link_state(slave,
> BOND_SLAVE_NOTIFY_LATER);
> >  =09=09}
> > diff --git a/include/net/bonding.h b/include/net/bonding.h
> > index 808f1d167349..50d61cf77855 100644
> > --- a/include/net/bonding.h
> > +++ b/include/net/bonding.h
> > @@ -234,6 +234,7 @@ struct bonding {
> >  =09struct=09 dentry *debug_dir;
> >  #endif /* CONFIG_DEBUG_FS */
> >  =09struct rtnl_link_stats64 bond_stats;
> > +=09bool rtnl_needed;
> >  };
> >
> >  #define bond_slave_get_rcu(dev) \
> >
