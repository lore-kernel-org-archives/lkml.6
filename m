Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F772145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QhalDVCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F772145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLAEmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:42:01 -0500
Received: from mail-eopbgr790119.outbound.protection.outlook.com ([40.107.79.119]:20480
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbeLAEmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzfNPvOTYd1M8z2+IjfeMmaSvca62GvY5VWroQD2tHM=;
 b=QhalDVCkOrdHS9KLm+4TNyIFuvPyZ0Euhn+Tyf1ymKePmHYyIB16GUTyd0ZJrSZphhn1uStBM6yWEE/kdAecHWxq8KXjSbB4FaDZx4UzSYQ0ZR45vz2dI/JGONAa2QAvpPepKap8Nc8I7U9OHKsfqmPXsuZPO2b//+k8BOsatp0=
Received: from SN4PR2101MB0815.namprd21.prod.outlook.com (10.167.151.157) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (10.167.151.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.7; Fri, 30 Nov 2018 17:31:16 +0000
Received: from SN4PR2101MB0815.namprd21.prod.outlook.com
 ([fe80::2c8b:fbbc:72c9:5cc7]) by SN4PR2101MB0815.namprd21.prod.outlook.com
 ([fe80::2c8b:fbbc:72c9:5cc7%2]) with mapi id 15.20.1404.002; Fri, 30 Nov 2018
 17:31:16 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AdSHnLf8sFQRqiTYT1imO/A1WbZ3vgAGqdqAAACQe+AARPSgcA==
Date:   Fri, 30 Nov 2018 17:31:16 +0000
Message-ID: <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:d033:bd75:fad:93b1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0734;6:A2diPxXtoNhzLZz7WbidC20GnGqNS1HfVeGMW0hSn4SmKaQCp6IMX4p2uLjtqUPrLp+/IYcv0pcK2CQ4hgyp6j/1b2N9cEFnNvEWv8aI14IZikYebZ/11N9AmknwFRDks4aeO9p2qISrHGCBqpGGD33GzFqKguR6+ip2Yo7CLUf0u7RGTLzxWSDrEUCN2zTrpH7YuP9cKvH1PudEowOhq3S1MWe8kc/OhKRJDmDNSolrET8MFsAiNWLUy8L1uSWC18t3+Wl/U5TXASJrlfGEM/6zMQyYUkmI92KcIoFOwmSQBFOzRjvzoNvUFvJQXyK6h79w32V0PBw/qt+t2/ypn05apk5zSc7oeA/dwziFqIp2fHnUEd6haLrEqWZb45D5dzLNGVJeezzM7lCxBqPLy1ahXhblCgq7oGpKzTtR7ppz3LDlSruRCBKHJmBM3f1pbCHl1kBLRpfVahe83UrH5w==;5:6egM8sk35AWfQgjdL5zHTUM5cpX0d3FX0vC5VOc35d4SV8lwAfmO09ETLMjj2y1DXqiP2r4lAF290Ce5HqhpiPKV+xn2MWg+rlDUvOlZZDqIhlYCYeqcCFhn6O/20TQHQfG2xRp14JwSDdN6J/XHNav/5du0b1U/CpglUAvUBoA=;7:a9+tXaScldWR43TwOuJ+kgBKvYPMV8WJsZR6BMDf+/D2uhvZupOrtT8b0nNofvVf/fmPU6S/W00JrRbTHFC40zvaC9mENmh/gK81cKXdufKzWXZZAIWAogNb/LswiVz+oKtbOrdlZwYLe+Sh6wMz9Q==
x-ms-office365-filtering-correlation-id: 5deedabf-9eac-4c8d-9448-08d656e9a217
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN4PR2101MB0734;
x-ms-traffictypediagnostic: SN4PR2101MB0734:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN4PR2101MB07345E55FCE7BD46E850EAD9A0D30@SN4PR2101MB0734.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3231453)(999002)(2280197)(944501466)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0734;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(13464003)(99286004)(54906003)(8990500004)(110136005)(86362001)(8936002)(107886003)(186003)(105586002)(305945005)(7736002)(10090500001)(74316002)(6246003)(55016002)(6436002)(81166006)(81156014)(86612001)(14454004)(68736007)(8676002)(316002)(22452003)(97736004)(229853002)(2501003)(6116002)(2906002)(11346002)(486006)(4326008)(476003)(9686003)(478600001)(446003)(10290500003)(76176011)(71200400001)(33656002)(46003)(53936002)(102836004)(14444005)(7696005)(256004)(106356001)(25786009)(71190400001)(53546011)(6506007)(5660300001)(1511001)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:SN4PR2101MB0815.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MYTuG1TKgFQ+dbzVzSahakOo2HHMRUJVJWOAy2ajw5tzM4Nd8QfVcNFDU+SiHu8RN4r3PSmGCMqSGiEkkF0EfuTTJhyiDMAExY1q1Nt2pPbsVKLxI3jOYXEWVcg04iaBYMCv5ulGNfXfclzWwpJx7RnvjrLTfT64rVgcVOTkZYE88/JFX+dr0PSYJ2V29LkJvXqcx+unBGHj8W/VnABXOnbMimhfFOOXCQ+COL/kVt+WafrDBtR/1JhfjRtyJnYzo1jk6OlZzRjF2aJ8g/+TKawspRWxZTXAwsc4ULVoppEo6DtV+NuCby+0oQ+R593WL27AMj5RQJ28YSQGyBzFKlgXEhwE/EeY/wpBHIwNPL8SDCUDVoWfz4D62fOpyqNxwyct34vftICDis0Xhd6hmEJCE7V9usEIX3o3qlNNduBQUN5VWbZqTmQHOzKHzRcP9zgIAnJw6Y5031Uc3OzWD2YD9GzFtU0kw1xTPK7JAAvAebXx5mumFK8ggnp1d+tL1yODqk+Tqit1KpFJBKQ/uQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deedabf-9eac-4c8d-9448-08d656e9a217
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 17:31:16.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, November 29, 2018 12:17 AM
> To: gregkh@linuxfoundation.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; apw@canonical.com; vkuznets
> <vkuznets@redhat.com>; olaf@aepfle.de; jasowang@redhat.com; Michael
> Kelley <mikelley@microsoft.com>
> Subject: RE: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
> channels to two workqueues
>=20
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Wednesday, November 28, 2018 11:45 PM
> > >
> > > There is no change in this repost. I just rebased this patch to today=
's
> > > char-misc's char-misc-next branch. Previously KY posted the patch wit=
h
> his
> > > Signed-off-by (which is kept in this repost), but there was a conflic=
t issue.
> > >
> > > Note: the patch can't be cleanly applied to char-misc's char-misc-lin=
us
> branch
> > --
> > > to do that, we need to cherry-pick the supporting patch first:
> > > 4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> > vmbus_get_outgoing_channel()")
> >
> > That is not going to work for the obvious reason that this dependant
> > patch is not going to be merged into 4.20-final.
>=20
> It looks the dependent patch (4d3c5c69191f) is going to miss the v4.20
> release.
> This is not a big issue, as the dependent patch isn't really important.
>=20
> > So, what do you expect us to do here?  The only way this can be accepte=
d
> > is to have it go into my -next branch, which means it will show up in
> > 4.21-rc1, is that ok?
>=20
> Is there any chance for this patch ("Drivers: hv: vmbus: Offload the hand=
ling
> ...") to
> go into v4.20?
>=20
> If yes, I can quickly do a rebase to char-misc's char-misc-linus branch,
> because actually the conflict can be very easily fixed. And I can help to=
 fix any
> conflict when the dependent patch is backported to v4.20.1.

This patch fixes an important bug while the patch this depends on is not cr=
itical.
I suggest we revert the patch that this patch depends on
and we can submit a new version of this patch that can go in now - into 4.2=
0 release.

K. Y=20

