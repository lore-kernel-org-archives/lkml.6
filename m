Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154A21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FcuVAdkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJQWLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:11:32 -0400
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:7776
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbeJQWLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKwuMA8XTvBQ/XnFLv82/TExtYugza5KKDT7VA7WoGk=;
 b=FcuVAdkfRLG/nKJjzGQvPAJrSN3ZBl6mWCVc0plVdx2sJlEkgQ7Fn8zJOBO7AKzTr3Mw8YT23l83GYVKOk5Nre0eB4+U6caYEzGFHuyH0QdZOgR2MhqxXjcJ7v/dMFj7fab4hjTc7Iw+mJ5bWEyw0163qFQhCAw1DrWYQ3fhCrg=
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) by
 DM5PR2101MB0919.namprd21.prod.outlook.com (52.132.132.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.2; Wed, 17 Oct 2018 14:15:30 +0000
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124]) by DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124%3]) with mapi id 15.20.1273.004; Wed, 17 Oct 2018
 14:15:30 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Topic: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Index: AQHUZXPIE/St4iULVkCeltejmox0kaUiPMFwgADTXoCAAFVTAIAABxqAgAANFyA=
Date:   Wed, 17 Oct 2018 14:15:30 +0000
Message-ID: <DM5PR2101MB101355087924D6C8442BDA4ACAFF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
 <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017074629.GD25537@kroah.com>
 <DM5PR2101MB1013C986EEC151F096313D17CAFF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017131717.GA10130@kroah.com>
In-Reply-To: <20181017131717.GA10130@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-17T14:15:29.1714963Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;6:+OhjdKt1pm843RXa+Vnup68wsPli5weG8VHkJK8dlIV7tVYTv1ENOY36wX5SjGGXmcamtFHYQAfPOH9kaxYpOcP0i1LNRob71q3b2cFy3L2HqBoNd4qgxKEIVr5M9D3P5XlEi/MxZuhX96CJpD6WkWerLnJWiJzLtCoqsCxW43VcBvQynbT76vytF1JXrPRcCDsDAQ5cWdFfMlbyYFooI2i+9qDu8k2vEvjxeNOtUbkfo4opDVBBaLANYxyfYioQkGfrJkM1W5/TPtmcc0N/hzNgxNBQiPoxeXfd3f2pMCqwClAsdGjyKzE49uD7A+75FfabysQlerxqQEuKaiIddWyK2+p7Gv9WBTs0mcEItRpaT0MND+HEQrDGhoff4Tq9c8U0WiKkeH5QO6M8uMbWxWygIFVxRW4q/qnlwCc+jB5Wy2K2KKyCs9KrWz0QC1TL7qKcBPL+UkV4YqxQi5eNxw==;5:l5m7iKorXB0SpEmIrMkQlqKrytBjQpbTtjIFn3UlPRzp/HVfuQ3virtym85CX6Eop4RTaHzXCKoadVje8BjPGEoafGxjTvd5Z0e8MxyziUb+au/61g0Qlq+aJoeLvVaozuqdFtqRYw6YGNVjn8ADycRvzVATUrwbZXi9wT/ecS4=;7:MmikdzQRjfeo0TaZ8UUYi/Uj3dKpl2mO0BYbSDPnEV2ec0UeoPiH614FGi+1nUSZ/I7kdGUKCBjRfzzpWPHRdeQ1BSlN4UlKqG+a/flBfXc8bFlY42Pt4M4O2oOEtadV0J+4sBaefqRAqHGtO316Dw==
x-ms-office365-filtering-correlation-id: 16679489-e631-47be-0437-08d6343afecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
x-microsoft-antispam-prvs: <DM5PR2101MB09198AEAA376FDB2911E35AACAFF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(219752817060721)(189930954265078)(84791874153150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(346002)(396003)(366004)(13464003)(189003)(199004)(40224003)(6436002)(66066001)(53546011)(6506007)(6246003)(6916009)(9686003)(478600001)(6306002)(74316002)(71190400001)(71200400001)(305945005)(33656002)(8990500004)(5660300001)(2900100001)(7696005)(316002)(229853002)(10290500003)(4326008)(93886005)(10090500001)(107886003)(55016002)(76176011)(14454004)(22452003)(966005)(53936002)(6346003)(102836004)(26005)(25786009)(575784001)(99286004)(14444005)(86362001)(54906003)(86612001)(2906002)(5250100002)(97736004)(6116002)(3846002)(106356001)(105586002)(7736002)(476003)(446003)(256004)(68736007)(11346002)(8936002)(186003)(81156014)(8676002)(486006)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1013.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: NTj5dsa7DuvTYI5L+6kOe+/Z0p/v5oLKYyaTbd7hubyAt+lQAEoCM0viylwXpJLWyWKotliOJAR4vglDlZ5on4zNspAAE+FptBv3UkRWvTFJ53A9b6iMnpdbrtgXLOKnnEyW0YCz2JKkRXhQVfD/BcTA4cYyvIabvzz3gvEWMbgPjQxT38Is47+V60m7Z5SuvHiwL6Z5UrFKqF4VqsXytdDDrxWM+p+cvCEngO8AQBewIv84BQrkssoZd4UditdoGMG+HweZMRUCWSEuDagGWC/b6j+wJVvkYjpqQMxxH7iuLPoE4K3IYISqU2z4DO4aqfQuQXkMn4BK/VVEl58jH8yUubnsdH3Gf7uUew5Ni3M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16679489-e631-47be-0437-08d6343afecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 14:15:30.5439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 17, 2018 9:17 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Stephen Hemming=
er
> <sthemmin@microsoft.com>; David S. Miller <davem@davemloft.net>; Sasha
> Levin <Alexander.Levin@microsoft.com>
> Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial numb=
er
>=20
> On Wed, Oct 17, 2018 at 01:02:17PM +0000, Haiyang Zhang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, October 17, 2018 3:46 AM
> > > To: Haiyang Zhang <haiyangz@microsoft.com>
> > > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Stephen
> > > Hemminger <sthemmin@microsoft.com>; David S. Miller
> > > <davem@davemloft.net>; Sasha Levin <Alexander.Levin@microsoft.com>
> > > Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial
> > > number
> > >
> > > On Tue, Oct 16, 2018 at 07:13:12PM +0000, Haiyang Zhang wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > > > owner@vger.kernel.org> On Behalf Of Greg Kroah-Hartman
> > > > > Sent: Tuesday, October 16, 2018 1:06 PM
> > > > > To: linux-kernel@vger.kernel.org
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > > stable@vger.kernel.org; Stephen Hemminger
> > > > > <sthemmin@microsoft.com>; David S. Miller <davem@davemloft.net>;
> > > > > Sasha Levin <Alexander.Levin@microsoft.com>
> > > > > Subject: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial
> > > > > number
> > > > >
> > > > > 4.18-stable review patch.  If anyone has any objections, please l=
et me
> know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > > >
> > > > > [ Upstream commit 00d7ddba1143623b31bc2c15d18216e2da031b14 ]
> > > > >
> > > > > Matching network device based on MAC address is problematic
> > > > > since a non VF network device can be creted with a duplicate MAC
> > > > > address causing confusion and problems.  The VMBus API does
> > > > > provide a serial number that is a better matching method.
> > > > >
> > > > > Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> > > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > >  drivers/net/hyperv/netvsc.c     |    3 ++
> > > > >  drivers/net/hyperv/netvsc_drv.c |   58 ++++++++++++++++++++++---=
----
> -----
> > > -----
> > > > > -
> > > > >  2 files changed, 36 insertions(+), 25 deletions(-)
> > > > >
> > > > > --- a/drivers/net/hyperv/netvsc.c
> > > > > +++ b/drivers/net/hyperv/netvsc.c
> > > > > @@ -1203,6 +1203,9 @@ static void netvsc_send_vf(struct net_de
> > > > >
> > > > >  	net_device_ctx->vf_alloc =3D nvmsg-
> >msg.v4_msg.vf_assoc.allocated;
> > > > >  	net_device_ctx->vf_serial =3D nvmsg-
> >msg.v4_msg.vf_assoc.serial;
> > > > > +	netdev_info(ndev, "VF slot %u %s\n",
> > > > > +		    net_device_ctx->vf_serial,
> > > > > +		    net_device_ctx->vf_alloc ? "added" : "removed");
> > > > >  }
> > > > >
> > > > >  static  void netvsc_receive_inband(struct net_device *ndev,
> > > > > --- a/drivers/net/hyperv/netvsc_drv.c
> > > > > +++ b/drivers/net/hyperv/netvsc_drv.c
> > > > > @@ -1794,20 +1794,6 @@ out_unlock:
> > > > >  	rtnl_unlock();
> > > > >  }
> > > > >
> > > > > -static struct net_device *get_netvsc_bymac(const u8 *mac) -{
> > > > > -	struct net_device_context *ndev_ctx;
> > > > > -
> > > > > -	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > > > > -		struct net_device *dev =3D hv_get_drvdata(ndev_ctx-
> > > > > >device_ctx);
> > > > > -
> > > > > -		if (ether_addr_equal(mac, dev->perm_addr))
> > > > > -			return dev;
> > > > > -	}
> > > > > -
> > > > > -	return NULL;
> > > > > -}
> > > > > -
> > > > >  static struct net_device *get_netvsc_byref(struct net_device
> *vf_netdev)  {
> > > > >  	struct net_device_context *net_device_ctx; @@ -1936,26
> > > > > +1922,48
> > > @@
> > > > > static void netvsc_vf_setup(struct work_
> > > > >  	rtnl_unlock();
> > > > >  }
> > > > >
> > > > > +/* Find netvsc by VMBus serial number.
> > > > > + * The PCI hyperv controller records the serial number as the sl=
ot.
> > > > > + */
> > > > > +static struct net_device *get_netvsc_byslot(const struct
> > > > > +net_device
> > > > > +*vf_netdev) {
> > > > > +	struct device *parent =3D vf_netdev->dev.parent;
> > > > > +	struct net_device_context *ndev_ctx;
> > > > > +	struct pci_dev *pdev;
> > > > > +
> > > > > +	if (!parent || !dev_is_pci(parent))
> > > > > +		return NULL; /* not a PCI device */
> > > > > +
> > > > > +	pdev =3D to_pci_dev(parent);
> > > > > +	if (!pdev->slot) {
> > > > > +		netdev_notice(vf_netdev, "no PCI slot information\n");
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > > > > +		if (!ndev_ctx->vf_alloc)
> > > > > +			continue;
> > > > > +
> > > > > +		if (ndev_ctx->vf_serial =3D=3D pdev->slot->number)
> > > > > +			return hv_get_drvdata(ndev_ctx->device_ctx);
> > > >
> > > > Greg,
> > > >
> > > > I had a fix to this patch. If not already, Could you include my
> > > > following fix
> > > together?
> > > > hv_netvsc: fix vf serial matching with pci slot info
> > > > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
g
> > > > it.k
> > > > ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fdavem%2Fnet-
> > > next.git%2F
> > > >
> > >
> commit%2F%3Fid%3D005479556197f80139771960dda0dfdcd2d2aad5&amp;da
> > > ta=3D02%
> > > >
> > >
> 7C01%7Chaiyangz%40microsoft.com%7C6ce194a47449435fe82a08d63404a94e
> > > %7C7
> > > >
> > >
> 2f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636753591959679786&amp
> > > ;sdata
> > > >
> > >
> =3DReWYMZW%2FYtoFSbFSxny9VGw6V8v9J4sGanfJjbVd34A%3D&amp;reserved=3D
> > > 0
> > >
> > > I can not take a patch that is not "upstream" yet, sorry.
> > >
> > > Also, this really feels like a "new feature" to me.  Can someone
> > > explain what bug this is fixing?
> >
> > Patch #A: hv_netvsc: pair VF based on serial number
> > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
k
> > ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2
> >
> Fcommit%2F%3Fid%3D00d7ddba1143623b31bc2c15d18216e2da031b14&amp;
> data=3D02
> > %7C01%7Chaiyangz%40microsoft.com%7C2e07aa3f8a9d4f32526008d63432d
> f14%7C
> >
> 72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636753790439794786&am
> p;sdat
> > a=3D0ZyQ7jJdgsEZbh8TqA0eypvPUJVQaxSJcSNYuhLSl%2Fc%3D&amp;reserved=3D0
> >
> > Patch #B: hv_netvsc: fix vf serial matching with pci slot info
> > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
k
> > ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2
> >
> Fcommit%2F%3Fid%3D005479556197f80139771960dda0dfdcd2d2aad5&amp;d
> ata=3D02
> > %7C01%7Chaiyangz%40microsoft.com%7C2e07aa3f8a9d4f32526008d63432d
> f14%7C
> >
> 72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636753790439794786&am
> p;sdat
> >
> a=3DJPfFlatrkt1K6zMLHmZDRG51cCLwVk9pXqHVtLm26hA%3D&amp;reserved=3D0
> >
> > The patch #A is a feature that use VF serial number for matching. But #=
A has
> a bug causing mismatch.
> >
> > Patch #B, upstream now (see the link to Linux-next), is a fix to #A.
>=20
> You didn't answer my original question here, what bug is this fixing?

Patch #A: hv_netvsc: pair VF based on serial number
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D00d7ddba1143623b31bc2c15d18216e2da031b14

Patch #B: hv_netvsc: fix vf serial matching with pci slot info
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D005479556197f80139771960dda0dfdcd2d2aad5

The VF NIC needs to be paired with synthetic NIC on HyperV  --  to do that =
we=20
use MAC address matching before the patch #A. But a non VF NIC can also=20
have the same MAC, which shouldn't be paired with synthetic NIC. So a bette=
r=20
method is implemented by #A to use VF serial number for matching.

But, #A has a bug, which causes matching to fail. Patch #B fixed it by extr=
acting=20
the VF serial number correctly from slot info.

Thanks,
- Haiyang



