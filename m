Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286532082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYa/S9aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286532082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJYRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:53:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44778 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJYRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:53:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P9IqhA066492;
        Thu, 25 Oct 2018 09:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tDXIBeM94Qr5AnzIfl+DMs7/xCDTAzub9/9rrEEqakQ=;
 b=OYa/S9aY5CulT1tDX8F/lVJkxSTe0OPxA8oavvTPpAJGpeFfyOdRkjVlEL6M8thvxBpO
 kvlp4Sa0fiEbuozqJEIJUoeSeFl9UBAU060oOU1H3cnYxHc/qfW8yH58q/Ucfh4d2m0e
 PxsEhIE/yId8wRPVrcCgLioUzInU6t6L4FtsTBm31JHIXnqka55VfieoJXmzMRYY+P16
 6/UZSv/r1uNarqDlc4qyNP5hJdd5ppc0ljrdjIvthq1GjGnmR3JRUD0WdpZqEyp48oYO
 bhvGtgejKeuWqiCaJTFV/5aCBioT++Uqe4UvgF6Ll94psoiNOhkLez+m/01WSuhwHofN UQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0r0bma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 09:21:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9P9L9G4008736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 09:21:09 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9P9L7Re013446;
        Thu, 25 Oct 2018 09:21:08 GMT
MIME-Version: 1.0
Message-ID: <bee18dd4-0012-44d0-9508-2987bfe521e5@default>
Date:   Thu, 25 Oct 2018 02:21:05 -0700 (PDT)
From:   Manish Kumar Singh <mk.singh@oracle.com>
To:     Michal Kubecek <mkubecek@suse.cz>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     =?utf-8?B?TWFoZXNoIEJhbmRld2Fy?=
         =?utf-8?B?ICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>, linux-netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] bonding:avoid repeated display of same link status change
References: <20181023152924.24033-1-mk.singh@oracle.com>
 <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
 <65f98009-1ce0-d6fd-06dc-233aa115abc9@gmail.com>
 <20181023162613.GA22291@unicorn.suse.cz>
 <20181023163825.GB22291@unicorn.suse.cz>
In-Reply-To: <20181023163825.GB22291@unicorn.suse.cz>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 14.0.7214.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michal Kubecek [mailto:mkubecek@suse.cz]
> Sent: 23 =E0=A4=85=E0=A4=95=E0=A5=8D=E0=A4=A4=E0=A5=82=E0=A4=AC=E0=A4=B0 =
2018 22:08
> To: Eric Dumazet
> Cc: Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=
=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0); Manish Kumar Singh; linu=
x-netdev; Jay
> Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] bonding:avoid repeated display of same link status
> change
>=20
> On Tue, Oct 23, 2018 at 06:26:14PM +0200, Michal Kubecek wrote:
> > On Tue, Oct 23, 2018 at 09:10:44AM -0700, Eric Dumazet wrote:
> > >
> > >
> > > On 10/23/2018 08:54 AM, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:
> > >
> > > > Atomic operations are expensive (on certain architectures) and miim=
on
> > > > runs quite frequently. Is the added cost of these atomic operations
> > > > even worth just to avoid *duplicate info* messages? This seems like=
 a
> > > > overkill!
> > >
> > > atomic_read() is a simple read, no atomic operation involved.
> > >
> > > Same remark for atomic_set()
> >
> > Which makes me wonder if the patch really needs atomic_t.
>=20
> IMHO it does not. AFAICS multiple instances of bond_mii_monitor() cannot
> run simultaneously for the same bond so that there doesn't seem to be
> anything to collide with. (And if they could, we would need to test and
> set the flag atomically in bond_miimon_inspect().)
>=20
Yes, Michal, we are inline with your understanding.
when the -original- patch was posted to upstream there was no -synchronizat=
ion- nor -racing- addressing code was in read/write of this added filed, as=
 we -never- saw need for either.

-only- writer of the added field is bond_mii_monitor.
-only- reader of the added field is bond_miimon_inspect.
-this writer & reader -never- can run concurrently.
-writer invokes the reader.

hence, imo uint_8 rtnl_needed is all what is needed; with bond_mii_monitor =
doing rtnl_needed =3D 1; and bond_miimon_inspect doing if rtnl_needed.

here is the gravity of the situation with multiple customers whose names in=
cluding machine names redacted:

 4353 May 31 02:38:57 hostname kernel: ixgbe 0000:03:00.0: removed PHC on p=
2p1
 4354 May 31 02:38:57 hostname kernel: public: link status down for active =
interface p2p1, disabling it in 100 ms
 4355 May 31 02:38:57 hostname kernel: public: link status down for active =
interface p2p1, disabling it in 100 ms
 4356 May 31 02:38:57 hostname kernel: public: link status definitely down =
for interface p2p1, disabling it
 4357 May 31 02:38:57 hostname kernel: public: making interface p2p2 the ne=
w active one
 4358 May 31 02:38:59 hostname kernel: ixgbe 0000:03:00.0: registered PHC d=
evice on p2p1
 4359 May 31 02:39:00 hostname kernel: ixgbe 0000:03:00.0 p2p1: NIC Link is=
 Up 10 Gbps, Flow Control: RX/TX
 4360 May 31 02:39:00 hostname kernel: public: link status up for interface=
 p2p1, enabling it in 200 ms
 4361 May 31 02:39:00 hostname kernel: public: link status definitely up fo=
r interface p2p1, 10000 Mbps full duplex
 4362 May 31 02:45:37 hostname journal: Missed 217723 kernel messages
 4363 May 31 02:45:37 hostname kernel: public: link status down for active =
interface p2p2, disabling it in 100 ms
 =09---------------------
                      11000+ APPROX SAME REPEATED MESSAGES in second
=09---------------------
15877 May 31 02:45:37 hostname kernel: public: link status down for active =
interface p2p2, disabling it in 100 ms
15878 May 31 02:45:37 hostname kernel: public: link status definitely down =
for interface p2p2, disabling it
15879 May 31 02:45:37 hostname kernel: public: making interface p2p1 the ne=
w active one

Thanks,
Manish

> Michal Kubecek
