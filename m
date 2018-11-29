Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2A1C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FB320834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oSRduY6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FB320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeK2TVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:21:49 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:49072
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeK2TVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx2NAuSYdkIl6bjiquizRlj5UXEPkP08EAeLo+QB1Zs=;
 b=oSRduY6dq2iaPfVLlJbpJuCaUR1Q9BS6QILYP9DVemhY1k0FEexsC1A+wu9XpunbVYmn++R8K6psme7yAQEvoobjxtMJk1Fi30NVG8AWcCDQMw/x1hcX2rcbw0uKkiYpu4inAsQvCUIppLWO2FypnWagDamrFhIWKvGhFIdF7m4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.3; Thu, 29 Nov 2018 08:17:05 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1404.008; Thu, 29 Nov 2018
 08:17:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Thread-Topic: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Thread-Index: AdSHnLf8sFQRqiTYT1imO/A1WbZ3vgAGqdqAAACQe+A=
Date:   Thu, 29 Nov 2018 08:17:04 +0000
Message-ID: <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
In-Reply-To: <20181129074435.GA12347@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-29T08:17:00.0756666Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:fca5:5be0:9dc2:f9fc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:5tYuAsOxNHGqOpHipvg56BFO7l1Wj+/QpiE9llA7jUT0BevElLOu29cOn+/NgdUArRA6eg+7qmupVS4WEbw+lh9J5ROZf0bL7XvBB8Mqcn0du/bITl8noKxHNtQRunVU8/Kn2ddHlc/F8BbwzkZSMStSuvWcfTsab7sh0dq5gy1oys55RT+KJcHduj00OUEE23fQSKyTXcVyBUzv3bsaBf2YlXS72QBeUFshQLAxGuhLc2VXs5WNew9M0T1dBY8hL1YV9P0jFUx2H1OrNtCD9NZAH16jTyQabhsFGXDqFVdhQ7BN31wgsQZzTIP34UZ+0UQdnfFaFEGhnyb3+lZEO8XwxGfeiHPrquDcbDjRY1C4AxMIEPqsHR71/SIIeYRED60GmqOIXL7ucFPe4VkQhpMmFBGrOaOFGoQODAbDqzXiFBZLCB6H4n5R/C8obr0gzptGQ7JAO6dF9hkgYo5jXw==;5:CvOGgkGnlWE2PsIBtP7oFNyiqTf7/S4poiCKSCnmneqxJ691+cUmTlPL2bKnUbNZf/dVzEtH1B3xB9l75r/0gL1m4HZDEcbWuVpOMt3sfWYLLLsY1nGbnVaY5qdwelLxyC/b4HPhlQpGE0MBXzQ57pXvB3+65LDnPFsV0Upf49U=;7:P/xI/uFlJZROCbRKgNhg1RVNGWw71bSC3RJf3RNduqtGAv+QEVOZebEs3OLe2+zl7SLcOy5eckNetdw8pPyWBgk8yCMvrZVUivbt54CWl1S4t+YfZQT2Pyusn+yQlffcqwdgYxgtIN8Lqm5NmRURjw==
x-ms-office365-filtering-correlation-id: 2661471f-8f7c-491e-9f0b-08d655d30c2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB015591B6195628152755BD7ABFD20@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231453)(999002)(944501447)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0155;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0155;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(99286004)(486006)(54906003)(11346002)(476003)(1730700003)(446003)(55016002)(74316002)(22452003)(81156014)(8936002)(97736004)(9686003)(81166006)(106356001)(316002)(2351001)(68736007)(102836004)(8676002)(71200400001)(71190400001)(6506007)(33656002)(7696005)(6436002)(229853002)(6916009)(5640700003)(186003)(14454004)(46003)(14444005)(10290500003)(256004)(8990500004)(25786009)(4326008)(5660300001)(6116002)(6246003)(107886003)(2501003)(10090500001)(478600001)(76176011)(86612001)(105586002)(7736002)(53936002)(305945005)(86362001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lAHdPCT96SqRJLgZNiO3r9Fxo/j7stsAsyK0/ujZQ+Xfl0miln0AuUce4U9k/fArw/OOHqZT1wGiFXqoPm+01wcVi9doxt0iDIQNKFMyP+w9aJKhptaXjiQLzre+FCH4i3n0adPQ2ztBcPC+DJiZFDp1v5lbCTmeUiLdVQcRpAI8mQtAXy8fbJFfZ1cy0B8g/XC67aS64QkI0t6HqWIqqxww/kxba/fA6SLe8QIDlc+QlXFOGV4ChNEqoU5xQFZF2RSoUBdFdP0tB2rN577+dqE4GeC9jpvvgT0ogXFyKxiPJEukJJW2DGVFqHGagzwREWiYEDYMdldxQbYD3Mizqsqnmn9iGsjiCLwW7Y0tf+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2661471f-8f7c-491e-9f0b-08d655d30c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 08:17:04.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, November 28, 2018 11:45 PM
> >
> > There is no change in this repost. I just rebased this patch to today's
> > char-misc's char-misc-next branch. Previously KY posted the patch with =
his
> > Signed-off-by (which is kept in this repost), but there was a conflict =
issue.
> >
> > Note: the patch can't be cleanly applied to char-misc's char-misc-linus=
 branch
> --
> > to do that, we need to cherry-pick the supporting patch first:
> > 4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> vmbus_get_outgoing_channel()")
>=20
> That is not going to work for the obvious reason that this dependant
> patch is not going to be merged into 4.20-final.

It looks the dependent patch (4d3c5c69191f) is going to miss the v4.20 rele=
ase.=20
This is not a big issue, as the dependent patch isn't really important.
=20
> So, what do you expect us to do here?  The only way this can be accepted
> is to have it go into my -next branch, which means it will show up in
> 4.21-rc1, is that ok?

Is there any chance for this patch ("Drivers: hv: vmbus: Offload the handli=
ng ...") to
go into v4.20?=20

If yes, I can quickly do a rebase to char-misc's char-misc-linus branch,
because actually the conflict can be very easily fixed. And I can help to f=
ix any=20
conflict when the dependent patch is backported to v4.20.1.

If no, I think this patch and the dependent patch can both go into v4.21, a=
nd=20
they can be both backported to v4.20.1 in future.

> But then, if that happens, it will fail to apply to any stable tree for
> 4.20 and older, like you are asking it to be done for.
>=20
> So what do you expect me to do here with this?
>=20
> totally confused,
>=20
> greg k-h

I hope my above reply made me clear. Sorry, I'm not really know how exactly
the releasing procedure works...

Thanks,
-- Dexuan
