Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45560C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB884208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cl5ltXkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB884208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeGISdO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:33:14 -0400
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:5952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932607AbeGISdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWffguar0YuhUj8i/uSVelld8WSO7qK70UM6vjLcj6c=;
 b=cl5ltXkvM7zLXg9mkzN3cMrGaBf4ZAq9gE81dZEY5VLYHCfijfW5rS9RyNyQh+RVWoMoiuItM0rUFkQzxmNz70Bayc6F2BFTpjttnL7bXYsC91r6MKYSQJXzUNhZfXqu3hSiDo4YMrhaGqhlIEe4GeoqBRg0Gc71yEpNA8owvhs=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0820.namprd21.prod.outlook.com (10.173.204.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 9 Jul 2018 18:33:10 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::a8ec:75f7:dcca:cb23]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::a8ec:75f7:dcca:cb23%6]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 18:33:10 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Haiyang Zhang <haiyangz@linuxonhyperv.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH net] hv_netvsc: Fix napi reschedule while receive
 completion is busy
Thread-Topic: [PATCH net] hv_netvsc: Fix napi reschedule while receive
 completion is busy
Thread-Index: AQHUF6Qg3d9S/IY1GEy1u2wQsaJEVaSHMleAgAABTsA=
Date:   Mon, 9 Jul 2018 18:33:10 +0000
Message-ID: <BN6PR21MB01610CA420A8B31C2224D8C5CA440@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180709164319.5058-1-haiyangz@linuxonhyperv.com>
 <20180709111527.70ab354c@xeon-e3>
In-Reply-To: <20180709111527.70ab354c@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-09T18:33:08.6357612Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0820;7:08JJyDiAD9k+dBKqfctL8eevWMUeCHr4GW2BfX/7MG3p9i3V4RoZk8bI82a9H4FreuuV7pDcx6QErfwTmj8K84duPzUD87aZGOkimGusa1TdtrvKHTRbox1/PkC1Jr/rP/aqj2nScqD1uhX6Mf1ty9fOPwBDBRNECBsgxHMagqJeCLooFLoQMH/aqWH6jmpLww+GWcajkTyjaNdWEEnlxrvKHDZJA3m7tTsbCj5EP67yn7Gz8UA8bUMUUMPFLtJJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9803fae9-29e4-41dd-ab70-08d5e5ca6c39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BN6PR21MB0820;
x-ms-traffictypediagnostic: BN6PR21MB0820:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-prvs: <BN6PR21MB0820F47DD38374E97107AB28CA440@BN6PR21MB0820.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR21MB0820;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0820;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(13464003)(66066001)(14454004)(86612001)(229853002)(2900100001)(316002)(97736004)(86362001)(575784001)(5250100002)(81156014)(81166006)(10090500001)(6436002)(8990500004)(22452003)(256004)(99286004)(14444005)(68736007)(8676002)(2906002)(10290500003)(478600001)(55016002)(106356001)(486006)(26005)(6246003)(186003)(53936002)(105586002)(7696005)(54906003)(76176011)(6506007)(110136005)(8936002)(53546011)(4326008)(6116002)(11346002)(3846002)(102836004)(9686003)(5660300001)(476003)(446003)(74316002)(7736002)(33656002)(305945005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0820;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yz2QLpzneadVF5Uoife/0MgTPJ1UBQZE+feCWHVzY2f0fwJTXIPr3WgFN7yuWXYrdEgu8app9kUPZ/SPG7hcS+Z8138gzW/LYhUlWZ1QsxqoYD+QNJNEGZyv6x97RaLdjiyFj5iXhWfZeCE+kZH2n8mTbNtxz8kW8jPwMJvZIuwxU3KfKLKQO/mtVa+aiA7fVLMx0c7YnJ5KFZ9reA2d6qQgwXuZlMziFZ1UzmQjupexWCA9qlhl89XPG5HNnFJl3AtcO1BQvIekyvfJcnX3iDRj5RiJfec9sm82UinQRmYeObQiernDbMIC/3FfBqJZiIoawfzTHrBNiZQRzIMjloloU8bTjisa5gJ9FrGYB58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9803fae9-29e4-41dd-ab70-08d5e5ca6c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 18:33:10.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, July 9, 2018 2:15 PM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org; olaf@aepfle.de; Stephen Hemminger
> <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets@redhat.com
> Subject: Re: [PATCH net] hv_netvsc: Fix napi reschedule while receive
> completion is busy
>=20
> On Mon,  9 Jul 2018 16:43:19 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > If out ring is full temporarily and receive completion cannot go out,
> > we may still need to reschedule napi if other conditions are met.
> > Otherwise the napi poll might be stopped forever, and cause network
> > disconnect.
> >
> > Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/hyperv/netvsc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 8e9d0ee1572b..caaf5054f446 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -1285,14 +1285,14 @@ int netvsc_poll(struct napi_struct *napi, int
> budget)
> >  		nvchan->desc =3D hv_pkt_iter_next(channel, nvchan->desc);
> >  	}
> >
> > -	/* If send of pending receive completions suceeded
> > -	 *   and did not exhaust NAPI budget this time
> > +	send_recv_completions(ndev, net_device, nvchan);
> > +
> > +	/* If it did not exhaust NAPI budget this time
> >  	 *   and not doing busy poll
> >  	 * then re-enable host interrupts
> >  	 *     and reschedule if ring is not empty.
> >  	 */
> > -	if (send_recv_completions(ndev, net_device, nvchan) =3D=3D 0 &&
> > -	    work_done < budget &&
> > +	if (work_done < budget &&
> >  	    napi_complete_done(napi, work_done) &&
> >  	    hv_end_read(&channel->inbound) &&
> >  	    napi_schedule_prep(napi)) {
>=20
> This patch doesn't look right. I think the existing code works as written=
.
>=20
> If send_receive_completions is unable to send because ring is full then
> vmbus_sendpacket will return -EBUSY which gets returns from
> send_receive_completions.  Because the return is non-zero, the driver wil=
l not
> call napi_complete_done.
> Since napi_complete_done was not called, NAPI will reschedule the napi po=
ll
> routine.

With the existing code, we found in test, the rx_comp_busy counter increase=
d,
one of the in-ring mask is 1, but guest is not reading it... With this patc=
h, the=20
pending receive completion will stay in the buffer (no loss), and be sent n=
ext time.=20
It solves the disconnection problem when high number of connections.

If not calling napi_complete_done(), upper layer should guarantee napi_sche=
dule,
then seems the upper NAPI code may have a bug -- the auto scheduling did no=
t
happen in this case. I will check it further.

Thanks,
- Haiyang

