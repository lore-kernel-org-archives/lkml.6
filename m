Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF7ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2B20869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E3iEjvD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeJRBxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:53:15 -0400
Received: from mail-sg2apc01on0098.outbound.protection.outlook.com ([104.47.125.98]:54202
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbeJRBxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuJR6UqdyBVfJyaDqLBPA0EQcvs7Fez+WWNgoxNoDw4=;
 b=E3iEjvD0MQxFTVdY+barXYhHw5+Cu9LlIVDlkRqmuwptdeSyaDUuB92x5Uq8C5IDPXpCKMrB4qYQwTw+c75z35BOvVkk7wquNx9IHzEZlWPlE5cCSNVBxBfkcNPH8N0WnpkcCs85BvZe86wBbY82s8aLcWLisYAxvp0PGw5UzLM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Wed, 17 Oct 2018 17:56:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1273.008; Wed, 17 Oct 2018
 17:56:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
Thread-Topic: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Index: AQHUZcegulXVID9FCEqE3hUXh86KfqUi4u6AgAAPWwCAAMUggA==
Date:   Wed, 17 Oct 2018 17:56:15 +0000
Message-ID: <PU1P153MB01698636C27A6DC822370379BFFF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
 <SN6PR2101MB1118766D1B569319FDB8E5FCA0FF0@SN6PR2101MB1118.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB1118766D1B569319FDB8E5FCA0FF0@SN6PR2101MB1118.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-17T17:56:09.1126641Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:1473:6c20:c44d:d299]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0156;6:PQwRTL03hE6+6N84k5Bki3rZkH6VQffo4LsGUVtzHfPfy6iRrwBCD9PPhFyyRQXGDPLfPKbP1FpekySQooRO47U0C2zHokYzvlGY3gZD05TVgM2oWWe+KNzRYsZjXD6ffe/99JFahSdtrNLT+/0QP29dJkAKDAhdkCvNtlp7o5Yo+nIOXYbuPb1Ad9jyB4eFyGvD/otJIc0SrCGqj2Ctye/FynBMgLrDIsc2bTvKDitWBgwqohYybAvwFh7HN0A4hx8gcxfpwppbueXu8wgGkeow0eUinN+c/ry0QP66+fv56CH7+eKb1kVExFivq5spL/k/cZ39NSrt/p/PrX1ISqbrdDWc8xIx7r1Ogo6PBWQqPlr8yXJgjHSRhCnRUzaXRsDVfC14I/J/d3scojD0NB6tSokxzyrY6GMw7gly4/UWdavrXHkqb9fA2sWn+Lb5lZo1VxIc2Qcpta3jYVwwyg==;5:z5o4Bi08fbpz4Btj+pEKta4FjpYQ4BcC0X2KQmdnTrFrdiGNYMhm1foteKIxWo8WAPqGe6VMmoCg0LNjRefvrUU1gGATiNz/3t4+Yi/sEN9eli1Elf4twd2Kil1OlRjQZrReHu04YpHMQCkgbmGDQL11wVpo5n4Hz0h6CB0ltUE=;7:RDmxMG0i7UOgMq+0+JvIGUBbGCHsrwuO5C22xKPJ5WxtWZKnQ07ImfQkJt/y7q7cbRnnwKrvWjdEn7kmrE7OmfKQFdzBCxje2ynrY4i2rjT2wVSK1PolviXi13MalMGLYF14lh0WIfgDJPc5rVXyhA==
x-ms-office365-filtering-correlation-id: c3eb2984-914a-42b2-1370-08d63459d5b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0156363881F1E8554B667BC6BFFF0@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0156;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0156;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(6506007)(14454004)(486006)(22452003)(76176011)(8676002)(86612001)(9686003)(68736007)(10290500003)(6436002)(110136005)(55016002)(7696005)(53936002)(54906003)(476003)(102836004)(14444005)(256004)(6116002)(7416002)(71190400001)(11346002)(71200400001)(8936002)(93886005)(316002)(478600001)(81156014)(86362001)(2906002)(99286004)(81166006)(97736004)(1511001)(5660300001)(186003)(8990500004)(105586002)(74316002)(5250100002)(446003)(305945005)(4326008)(10090500001)(46003)(25786009)(6246003)(229853002)(2900100001)(33656002)(106356001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dRdsM6e54CBqjKKGt4EnF5H5fqJ8Nc8RPYxHMnfo42yWdxuDtmdiytbd+syFO33FqwYH3cJssteZ7Kottxmj0qr2K0ylFP0WaPPJYxLKLsp9wnKPoYg3JFJCzVb2dCV1Y8TOfECwcqunw3LPUBu5sGg+rh88Zm1y0PN7+T7nm74ptg3o5kUh1wEpmBT57/9Q5iab7ViQ5AC1D+v8H7f8qg1bPNdnu7B/IFrX8aMeelFFosbhVdMgGwum/1ypSDwxwUk02F3X+dTNexw0c7ws7fjVsOU11p0l80EkpZ3nDEoDZTViX2kJbqW+Dc7XdurFongdjgSAJodueSZBD2PPltywfARWmOOam4rTvlet884=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb2984-914a-42b2-1370-08d63459d5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 17:56:15.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> KY Srinivasan
> Sent: Tuesday, October 16, 2018 23:02
> > > --- a/drivers/hv/hv_kvp.c
> > > +++ b/drivers/hv/hv_kvp.c
> > > @@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void
> > *out_msg, int op)
> > >
> > >  		out->body.kvp_ip_val.dhcp_enabled =3D in-
> > >kvp_ip_val.dhcp_enabled;
> > >
> > > +		__attribute__ ((fallthrough));
> >
> > The comment should be sufficient for this, right?  I haven't seen many
> > uses of this attribute before, how common is it?
>=20
> Yes; a common should be sufficient.

You all are right.=20
Right now, I realized the gcc warning can also be suppressed by a simple li=
ne
of comment:

/* fallthrough */

It looks gcc treats this comment specially.=20

If I add something more in the comment, like
/* add fallthrough */
, the warning can not be suppressed. :-)

I'll do a new version for KY.

Thank you all!

-- Dexuan
