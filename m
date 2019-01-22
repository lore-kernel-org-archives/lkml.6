Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB91C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FA2217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KtsfITRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAVSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:41:27 -0500
Received: from mail-eopbgr1300101.outbound.protection.outlook.com ([40.107.130.101]:27250
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfAVSl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmJbE7jRiearj35MkT7X5gPbVJIxhSUR0u6aoKS2Ok8=;
 b=KtsfITRtTuWIqBiPvfeoq0G/4VwnvMxQUvUet65So8PK4+6jrKT1BWmvHt0FD5cYY2IjOuwL7IWl9ta6MzeM7SxTw94xNb8TYU/O6BrEl8bdEP7Tdk/4rGKSRSwGUXPcPsRCntYViyZZqEmaw1vKNadGT8+UOnRY55/ZaejNABI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.4; Tue, 22 Jan 2019 18:40:31 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710%7]) with mapi id 15.20.1580.004; Tue, 22 Jan 2019
 18:40:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Index: AQHUsfdSwFQKguS0PEqWQ+jwS7iPOKW6o/swgAAzdACAAAXaYA==
Date:   Tue, 22 Jan 2019 18:40:30 +0000
Message-ID: <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
In-Reply-To: <20190122064246.GA28613@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-22T18:40:29.1483268Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cdc0e642-2184-4d36-a3f8-b59e492a4a5c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:b:a629:90de:3d18:9e9f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0156;6:QF1ggZ+3QNW6XMqX8LC3qsWJDvjraJ3cE6fTlqyvytkywAEBao3Vz3XYfn9i8a9GhbmazGSiYHcw/83GvOkTPvBVU77bhVpjh8jcIQNZHdQAUWrOgYEYChQCpD0KsJM+Kf9A/PJ/7B03aZrTjMojj6GKh+E3WNXtmeTUx2P3oAwKitKUIzahUiLrJw0ZkBf6OPCKuMWyd5K7C1YWZZiQz7VCjcZqUwI9zlI54q9P2TqsbvkUwQgOfWWtTsilQUOJazQyxuaqL2WgYxY77yJE7HZj3YEe3anHwydf0Pc3Wa13QZwHYyXsYuMIazV7CaslXpuCYRmBhR/nRdmg2y9yDRnEcr2Kw4LmasuK+xSeJoGG75A2OR2NrMN2/gDGXy2fBKvF2s6w2+vKW001GT8i/+PG2zw61JjaYSY3Ak4HSP//HIz1dAkW8/QWvJsUsLwyuFa3FPlcCBu4+ussOLBUtg==;5:CGsiSLQcuJN7bRK4Lh52unMkQ0KpUuKpMXS45Ywd1AIAbt7DWWEurLYF2hKm1rEjx2g1YeJL4BM5Sto/fuv19Hx0jwNq+c5oTr+rKZqWX96Kylv1QR/hZS4fi+EADqT3zZW0iEuOo9SIR21rEOI2rUYBM0mOXPMnT28alxD3XNLG1BW9VYtnOdBSh9+PmbOIPOULKI53449iE841BkbBUQ==;7:WWrUPDa61caXLmojlkLu3vVEGDFCPjTPpv4UsE3t1KPL917PWo5UN0of5HQy3gDi5Hra2chYkztgkA0bsqi4isyqq4SMAVTSBTHMbweUcsU/QYbibGA2tIVX9waFX6BjpcNghdJOi8v6ULro4ljYJw==
x-ms-office365-filtering-correlation-id: 26831928-2917-471b-546b-08d68099166f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0156EC3BCC5932909E86003CBF980@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(376002)(346002)(51444003)(199004)(189003)(86362001)(7736002)(71190400001)(71200400001)(316002)(99286004)(55016002)(6116002)(74316002)(256004)(14444005)(305945005)(6436002)(97736004)(6246003)(22452003)(478600001)(86612001)(105586002)(106356001)(9686003)(53936002)(39060400002)(1411001)(4326008)(25786009)(14454004)(8990500004)(8676002)(2906002)(81166006)(6916009)(10290500003)(68736007)(446003)(81156014)(8936002)(476003)(11346002)(486006)(54906003)(10090500001)(6506007)(102836004)(46003)(7696005)(76176011)(33656002)(229853002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ae6uGRkQTo6gcdR8ff+2egrYrnOV2eVu1FT45YDfoRI7lpbSnOQamLOm/IjnDvMuGRr3EGS6B2CYSE+GKx1htmCUMxALYhdj5adaKAVi7Q3BsecJPaC5+k9st0ynVV8f0JRmws0AQ29/l5yPcxD7xCIRqj256kzAZtOokc1BcidWzwU20+tLC7LISonKzic0OpdhZPeMLY9ulQYGsz4aXMkEIjca84XMcPC0w04p+lJ/e7V6eBvplLRHBO4N60k8NVn1o4Zzjhbv6AsPr1FEjL6BW2gRatX3BEWfR2i6EQF7xXWFY8pJBO+UP07AuhU4v65kCt2Z1h9ulsSvZ8bAS3hZQ4NDnG0ODGsvm8xxh/KB1yCawefczNY3QAlpzBgKyF6m562KallWLjpGtzsQJzwfgqrr5rwm47+SkvM2sB4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26831928-2917-471b-546b-08d68099166f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 18:40:30.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> Sent: Monday, January 21, 2019 10:43 PM
> > > @@ -1421,7 +1422,10 @@ static ssize_t vmbus_chan_attr_show(struct
> > > kobject *kobj,
> > >  	if (chan->state !=3D CHANNEL_OPENED_STATE)
> > >  		return -EINVAL;
> > >
> > > -	return attribute->show(chan, buf);
> > > +	mutex_lock(&vmbus_connection.channel_mutex);
> > > +	ret =3D attribute->show(chan, buf);
> > > +	mutex_unlock(&vmbus_connection.channel_mutex);
> > > +	return ret;
> > >  }
> >
> > It looks this patch is already able to fix the original issue:
> > 6712cc9c2211 ("vmbus: don't return values for uninitalized channels"),
> > as chan->state can't be CHANNEL_OPENED_STATE when
> > channel->ringbuffer_page is not set up yet, or has been freed.
> > -- Dexuan
>=20
> I think that patch 6712cc9c2211 fixes the problem when the channel is
> not set up yet, but it doesn't fix the problem when the channel is being
> closed
Yeah, now I see your point.

> The channel could be freed after the check that "chan->state" is
> CHANNEL_OPENED_STATE, while the "attribute->show()" function is running.

IMO the channel struct itself can't be freed while the "attribute->show()"
function is running, because I suppose the sysfs interface should have an e=
xtra
reference to channel->kobj (see vmbus_add_channel_kobj()), so before the sy=
sfs
files are removed, the channel struct itself can't disappear.
(I didn't check the related code very carefully, so I could be wrong. :-) )

But as you pointed, at least for sub-channels, channel->ringbuffer_page
can indeed disappear in vmbus_close() -> ... -> vmbus_free_ring(), and
the "attribute->show()" could crash when the race happens.
Adding channel_mutex here seems to be able to fix the race for
sub-channels, as the same channel_mutex is used in vmbus_disconnect_ring().

For a primary channel, vmbus_close() -> vmbus_free_ring() can still
free channel->ringbuffer_page without notifying the "attribute->show()".
We may also need to acquire/release the channel_mutex in vmbus_close()?
=20
> Actually, there should be checks that "chan" is not null and that
> "chan->state" is CHANNEL_OPENED_STATE within the locked section. I'll
> need to fix that.
I suppose "chan" can not be NULL here (see the above).

Checking "chan->state" may not help to completely fix the race, because
there is no locking/synchronization code in
vmbus_close_internal() when we test and change "channel->state".

I guess we may need to check if channel->ringbuffer_page is NULL in
the "attribute->show()".=20

PS, to prove that a race condition does exist and can really cause a panic =
or
something, I usually add some msleep() delays in different paths so that I
can reproduce the crash every time I take a special action, e.g. when I rea=
d
the sysfs files of a NIC, I try to remove hv_netvsc driver. This way, I can=
 prove
a patch can indeed help, at least it can fix the crash which would happen
without the patch. :-)

-- Dexuan
