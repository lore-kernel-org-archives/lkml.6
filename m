Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8298A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KDS4yOSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8298A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeLAFUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:20:08 -0500
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:23520
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725754AbeLAFUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stBj3HBaS5qh4Z9mgeA3l1R9NnI0fV0e5R4qM/VCxXg=;
 b=KDS4yOSeYzC3RvtBCySqGiK+18bdw2Fzzjj4M/cYYrF+x2k8BZWrbKwWhG74iyilci5CRF3MlX1d8Rx86CBy4hBi6xvLdWhQA/uWs0kaPg9IKNtxUIPGlmesRozk/45eZLYjPiH/MNyQAa9Na1SJbvqN2vW5A7c5jE3baMa0DtI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.5; Fri, 30 Nov 2018 18:09:54 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1404.011; Fri, 30 Nov 2018
 18:09:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
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
Thread-Index: AdSHnLf8sFQRqiTYT1imO/A1WbZ3vgAGqdqAAACQe+AARPSgcAACV9+Q
Date:   Fri, 30 Nov 2018 18:09:54 +0000
Message-ID: <PU1P153MB016907FDC34F47CFE71B82EABFD30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-30T18:09:48.2302059Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:1d99:15b2:9273:972a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0203;6:c+zRWmJqx6R642GHrcP3M6vRkf5W0F3U6YNo2pxdMkiR37yB1YdfHo+deKj7VgK+QxghBcR6tK05E1r+Sv7ltTh9S4qqcq3KUSrj4buLdifPxBwYwp+ghiZnZoi6E0vjCNwwX8YZFtlkUyqb/ZUMnvjTzLIdKQqReBtyfvr4iMIrJeufI5oq4BVTNR+VX9rAAJucCfWNBaElLwRozXoW6yn9uR4DTZn52EG1MFPM1DQIEMjIVSNuuClcbtFWJMZfcdafDiz8xKBWo/twip9nXRIoz1GvjIVmF2GqqiuRqZ2mIWps8XbPz46QOx0xEONv7BwDMpdaAvcEZ97pMhf0BeqfQg7+Z70dtBr/kqq9xkBqBIxd7hjy4IKoZx9bsXGGwLAlqpG2/+MnSEDMj02rPUqCYLHQPRtu71XAuZZ78S/CemRNg16qL5WD749Sv5Tgrp/lE8rR7C8Y02GUrh9knw==;5:Ov4wlD4xqg0uhh9RlTBtbsazvvOCZ04RSkRcAjgiLdcTXo8hSJ5R6XJS2y8VbRR/BHybcuxVBCmwMPFmAr4auY08hTNodpaDJH7t4W2xVfDgGvZ0JBPT7/EXLL+c8CCmjz894SAUe0JRLNJVYYAj4Q8udpRO+lUX2x8ZWRdYeh4=;7:hH9+43X1uCLPMGtUK0hRGW6f2L5Y/iL+flVjyTLZtyNFxe69m1kcKGoCSfBYAiVoQEYSRbryWD2NXCwYs9XBDA8lrxJV55xdLOug+kq+jtQaTRHBS3Z5WUYlbFgmQhXT96nA99DvfX7Jj7g6ExyYmA==
x-ms-office365-filtering-correlation-id: 404c6e58-6537-42c2-51f2-08d656ef07c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0203;
x-ms-traffictypediagnostic: PU1P153MB0203:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0203B8EAED30BDB2097639E6BFD30@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231453)(999002)(2280197)(944501466)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0203;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0203;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(478600001)(33656002)(86612001)(316002)(6506007)(97736004)(22452003)(446003)(229853002)(53546011)(11346002)(102836004)(93886005)(1511001)(74316002)(305945005)(68736007)(486006)(476003)(5660300001)(7696005)(76176011)(99286004)(7736002)(105586002)(46003)(106356001)(2906002)(107886003)(25786009)(6436002)(55016002)(10090500001)(10290500003)(6116002)(6246003)(14444005)(14454004)(256004)(8936002)(71200400001)(54906003)(53936002)(71190400001)(110136005)(81166006)(8990500004)(4326008)(186003)(8676002)(2501003)(86362001)(81156014)(9686003)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MAKBITcadaUPai2SEDhAn6m3vXxyHJixggrYkAKIOtPzxAN8pIvYgXCP2CX2uESY/F/uNyfR3fv7XZzGKZra2ynbo4EZBbLfFHz3gSZU1Ff8VAD0cfKQxj3Ov70mPxv0K7yqPilQq7UaKxxKfEQ2cR80K5erMk9LbB6PxL6VM3Zr4S6rmpr/6mG2uCKbrDE1+JcMdXb1gYy5fKiqmGeTW8Eu93er1NHLiA2+4vL5DfmFM1xiGumcLJZNavtvX5ekmyIz5aLUCaRKnOkTIKmUk+izjMlej1K6xiewOkIrMfam/jamFoW/NGozEcZFFxADFkoXHLXdTdzbYXRvDWx9HOrYiDAd3QlOMUWQI59wHNk8t20Sgw4cxnkhjUPI00ojdL5tkUajYmV5v1qsFPoABH90NbqX9/W6CR4vN5R3K9sDewUR0uWeM3aHdxZ1Gv3nudnFoKQ+XoMXfBHPghNPCkA9e1bDNjcKym12jq9tjdIspU20lydGlVhTEUE7iO0PlNKDvbIOIOSCnw439eiczQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c6e58-6537-42c2-51f2-08d656ef07c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 18:09:54.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: KY Srinivasan <kys@microsoft.com>
> Sent: Friday, November 30, 2018 9:31 AM
> > From: Dexuan Cui <decui@microsoft.com>
> > Sent: Thursday, November 29, 2018 12:17 AM
> > To: gregkh@linuxfoundation.org
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; apw@canonical.com; vkuznets
> > <vkuznets@redhat.com>; olaf@aepfle.de; jasowang@redhat.com; Michael
> > Kelley <mikelley@microsoft.com>
> > Subject: RE: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling =
of
> > channels to two workqueues
> >
> > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, November 28, 2018 11:45 PM
> > > >
> > > > There is no change in this repost. I just rebased this patch to tod=
ay's
> > > > char-misc's char-misc-next branch. Previously KY posted the patch w=
ith
> > his
> > > > Signed-off-by (which is kept in this repost), but there was a confl=
ict issue.
> > > >
> > > > Note: the patch can't be cleanly applied to char-misc's char-misc-l=
inus
> > branch
> > > --
> > > > to do that, we need to cherry-pick the supporting patch first:
> > > > 4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> > > vmbus_get_outgoing_channel()")
> > >
> > > That is not going to work for the obvious reason that this dependant
> > > patch is not going to be merged into 4.20-final.
> >
> > It looks the dependent patch (4d3c5c69191f) is going to miss the v4.20
> > release.
> > This is not a big issue, as the dependent patch isn't really important.
> >
> > > So, what do you expect us to do here?  The only way this can be accep=
ted
> > > is to have it go into my -next branch, which means it will show up in
> > > 4.21-rc1, is that ok?
> >
> > Is there any chance for this patch ("Drivers: hv: vmbus: Offload the ha=
ndling
> > ...") to
> > go into v4.20?
> >
> > If yes, I can quickly do a rebase to char-misc's char-misc-linus branch=
,
> > because actually the conflict can be very easily fixed. And I can help =
to fix any
> > conflict when the dependent patch is backported to v4.20.1.
>=20
> This patch fixes an important bug while the patch this depends on is not
> critical.
> I suggest we revert the patch that this patch depends on
> and we can submit a new version of this patch that can go in now - into 4=
.20
> release.
>=20
> K. Y

I agree.

Hi Greg,
Please let us know what we can do to try to push this important fix into v4=
.20.

Actually it's straightforward, though it looks big. And, we ave done a full=
 testing
with the patch.

Thanks,
--Dexuan
