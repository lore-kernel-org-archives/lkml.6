Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDAC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBBD20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HaYTlVyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBBD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeJZPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:25:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:25:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q6mWZu138434;
        Fri, 26 Oct 2018 06:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5k6etVbjMH757JRd3piRV4RIUmjtkkp0yzcCFP6Qlmc=;
 b=HaYTlVyQqw8mbq87nLllbnkYtQ73cw82Dw8Otn69prOJpSHnVGz2tj/nl81lAaIAELoT
 3eNgaQiK/N4K3GcUwlLArtuhTOvgEEuqHoc3B5dOYgSNCf6aiV/09ZWypwLLdy5Oaiix
 2GwkAZBVzxvtLmlXFWTIUFo9ESLoaBuKO/S8SYrqtw9gNeWS0ushU2s/RQEYEkZ4kcnK
 phFuPtrPdKCXVYRdwJzpXuao4l65aJZ0eA9lJbEl0H+w4YZ7rypCgyVxkSH+cvOqsT/T
 5Heevh/LaKsdx/rRaw7uTYC5lmMiDZlGomim2Ici5nxQqBe3NMHr4gF7NnWLEoiVLEba UA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqdfk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 06:49:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q6nsPx016715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 06:49:54 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q6nrmd002050;
        Fri, 26 Oct 2018 06:49:53 GMT
MIME-Version: 1.0
Message-ID: <4976cd2b-d782-4b01-8957-133d1b37a9c8@default>
Date:   Thu, 25 Oct 2018 23:49:51 -0700 (PDT)
From:   Manish Kumar Singh <mk.singh@oracle.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        =?utf-8?B?TWFoZXNoIEJhbmRld2Fy?=
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
 <bee18dd4-0012-44d0-9508-2987bfe521e5@default>
 <20181025092930.GC22291@unicorn.suse.cz>
In-Reply-To: <20181025092930.GC22291@unicorn.suse.cz>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 14.0.7214.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michal Kubecek [mailto:mkubecek@suse.cz]
> Sent: 25 =E0=A4=85=E0=A4=95=E0=A5=8D=E0=A4=A4=E0=A5=82=E0=A4=AC=E0=A4=B0 =
2018 14:59
> To: Manish Kumar Singh
> Cc: Eric Dumazet; Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=E0=A4=B6 =
=E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0); linux-net=
dev; Jay
> Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] bonding:avoid repeated display of same link status
> change
>=20
> On Thu, Oct 25, 2018 at 02:21:05AM -0700, Manish Kumar Singh wrote:
> > > From: Michal Kubecek [mailto:mkubecek@suse.cz]
> > > IMHO it does not. AFAICS multiple instances of bond_mii_monitor()
> cannot
> > > run simultaneously for the same bond so that there doesn't seem to be
> > > anything to collide with. (And if they could, we would need to test a=
nd
> > > set the flag atomically in bond_miimon_inspect().)
> > >
> > Yes, Michal, we are inline with your understanding.
> > when the -original- patch was posted to upstream there was no
> > -synchronization- nor -racing- addressing code was in read/write of thi=
s
> > added filed, as we -never- saw need for either.
> >
> > -only- writer of the added field is bond_mii_monitor.
> > -only- reader of the added field is bond_miimon_inspect.
> > -this writer & reader -never- can run concurrently.
> > -writer invokes the reader.
> >
> > hence, imo uint_8 rtnl_needed is all what is needed; with
> bond_mii_monitor doing rtnl_needed =3D 1; and bond_miimon_inspect doing
> if rtnl_needed.
> >
> > here is the gravity of the situation with multiple customers whose name=
s
> including machine names redacted:
> >
> >  4353 May 31 02:38:57 hostname kernel: ixgbe 0000:03:00.0: removed PHC
> on p2p1
> >  4354 May 31 02:38:57 hostname kernel: public: link status down for act=
ive
> interface p2p1, disabling it in 100 ms
> >  4355 May 31 02:38:57 hostname kernel: public: link status down for act=
ive
> interface p2p1, disabling it in 100 ms
> >  4356 May 31 02:38:57 hostname kernel: public: link status definitely d=
own
> for interface p2p1, disabling it
> >  4357 May 31 02:38:57 hostname kernel: public: making interface p2p2 th=
e
> new active one
> >  4358 May 31 02:38:59 hostname kernel: ixgbe 0000:03:00.0: registered P=
HC
> device on p2p1
> >  4359 May 31 02:39:00 hostname kernel: ixgbe 0000:03:00.0 p2p1: NIC Lin=
k is
> Up 10 Gbps, Flow Control: RX/TX
> >  4360 May 31 02:39:00 hostname kernel: public: link status up for inter=
face
> p2p1, enabling it in 200 ms
> >  4361 May 31 02:39:00 hostname kernel: public: link status definitely u=
p for
> interface p2p1, 10000 Mbps full duplex
> >  4362 May 31 02:45:37 hostname journal: Missed 217723 kernel messages
> >  4363 May 31 02:45:37 hostname kernel: public: link status down for act=
ive
> interface p2p2, disabling it in 100 ms
> >  =09---------------------
> >                       11000+ APPROX SAME REPEATED MESSAGES in second
> > =09---------------------
> > 15877 May 31 02:45:37 hostname kernel: public: link status down for act=
ive
> interface p2p2, disabling it in 100 ms
> > 15878 May 31 02:45:37 hostname kernel: public: link status definitely d=
own
> for interface p2p2, disabling it
> > 15879 May 31 02:45:37 hostname kernel: public: making interface p2p1 th=
e
> new active one
>=20
> When I was replying, I didn't know this was a v2 and I haven't seen the
> v1 discussion. I have read it since and I think I understand Eric's
> point now. The thing is that just adding e.g. u8 is OK as it is now.
> However, someone could later add another u8 next to it which would also
> be perfectly OK on its own but reads/writes to these two could collide
> between each other.
>=20
> And as pointed out by a colleague, even having atomic_t and u8 flag in
> one 64-bit word could be a problem on architectures which cannot do an
> atomic read/write from/to a 32-bit word (sparc seems to be one).

Thanks Michal for explaining it, now we understand the problem what Eric wa=
s referring to in v1 of the patch.
I could think of fixing it in 3 ways, Please suggest which one would be saf=
e and optimal fix:

1. Use type unit64_t for rtnl_needed .
2. Use type atomic64_t for rtnl_needed and atomic64_set/read.
3. Use type uint64_t for rtnl_needed with spinlock protection.

I think option 3 would be overkill keeping in mind the frequency of bond_mi=
i_monitor.

Thanks,
Manish
>=20
> Michal Kubecek
