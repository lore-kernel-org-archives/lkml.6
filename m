Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA98C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5A4208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PBs3tZ46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5A4208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934380AbeGJPzh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:55:37 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:27680
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933846AbeGJPzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20d3Iyiqp9ABSrZnVo/qJtoEREky2d2iZRKceBMCs48=;
 b=PBs3tZ46Yxi+BqJgt4KzFCkek05EWNjiHUBKZMmRlxe86M+tMbK62c38B/VrMi6pcvzAHdZlIzIxl/kRwJBTXdEVGi3fC/tv36z5wXqfe1CZbMARmhVis2n6cTXbaAMHFDHryUHKUsE90qHBfRl8YXEGjsL4Hebl1L3oFCDwZsE=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB1218.eurprd04.prod.outlook.com (10.163.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 15:55:32 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720%10]) with mapi id 15.20.0930.022; Tue, 10 Jul
 2018 15:55:32 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: RE: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
Thread-Topic: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
Thread-Index: AQHUF5W7AkhTBmuvJU2/fCjJwRzd7qSHRsSAgAFV10A=
Date:   Tue, 10 Jul 2018 15:55:32 +0000
Message-ID: <AM3PR04MB338B88A42C1B4802D832DCE945B0@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
 <20180709150111.8875-6-ruxandra.radulescu@nxp.com>
 <20180709192809.msmwmtmgj4yxrhme@mwanda>
In-Reply-To: <20180709192809.msmwmtmgj4yxrhme@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1218;7:uwhHmkUk5sBNOcns3554GUNBGU35UsYRIlxFgcwFDYfJjj6eDKDcOl5za4KEYD9eQWpwJy0aDQtHyFpWW6OVGAl/5ZdvM2geAcA8YqejXBHd2WJEswFGZ8epgmrhrqva96GuMJQeB5xwr3A69RKswaoKzvpLJn2qCdoUCTJ9kdcZfmFemrtmJoNNWaeSScTwlnwOanFgtMr/zSDZe6XKS9qNzR3ytrCKA/ZiNgcA7o9dPPbXt7XQQPLc081p7tRf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a859a620-c449-4d52-e5b7-08d5e67d9171
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1218;
x-ms-traffictypediagnostic: AM3PR04MB1218:
x-microsoft-antispam-prvs: <AM3PR04MB12188159A1562634FEAC7AE0945B0@AM3PR04MB1218.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(146099531331640)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1218;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1218;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(13464003)(6436002)(74316002)(33656002)(86362001)(106356001)(7736002)(66066001)(229853002)(305945005)(105586002)(6916009)(6116002)(25786009)(4326008)(81156014)(81166006)(2906002)(53936002)(3846002)(97736004)(8936002)(6246003)(68736007)(2900100001)(8676002)(478600001)(14444005)(5660300001)(256004)(14454004)(55016002)(26005)(186003)(53546011)(446003)(11346002)(476003)(102836004)(6506007)(316002)(9686003)(7696005)(486006)(99286004)(54906003)(76176011)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1218;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GLxP/mnrW34pKpI83vsj8kKr1Abmout1RLIhOSEKzcX8ENKM4M8IqT8663wRCP6TCIQCyMXYixGUFf4w/+NGQNtN35fRWhQZwITpuI+g3de0SMbvLotC4udzSLlhmyo0zwPtDYqEJJKcjKUd0EoJy2SU5xCClz0ioE0JxhiKV/KZdnWPcb6xsEex5X6Oy0ec9FgaVqcBMIdaOohz4pK9VPOtjEdebNUAnVAJnVtZcycDLBCv8PUVBaf9xVN96sMQQKdg8lRgsozgz0cyqe/Y3TsSO2rU2Wkh/1Jo7Sjvzit7eox234zI4S0ONZhHRW9RQacimT4W2jvoP6L/Xs0zGkzDcRt2vDxTTVfZg6Sv0Zs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a859a620-c449-4d52-e5b7-08d5e67d9171
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 15:55:32.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, July 9, 2018 10:28 PM
> To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; Ioana Ciornei <ioana.ciornei@nxp.com>
> Subject: Re: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size che=
ck
>=20
> On Mon, Jul 09, 2018 at 10:01:11AM -0500, Ioana Radulescu wrote:
> > @@ -2385,6 +2365,12 @@ static int netdev_init(struct net_device
> *net_dev)
> >
> >  	/* Set MTU upper limit; lower limit is 68B (default value) */
> >  	net_dev->max_mtu =3D DPAA2_ETH_MAX_MTU;
> > +	err =3D dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
> > +					(u16)DPAA2_ETH_MFL);
>=20
> The cast was there in the original code so this is not a comment on this
> particular patch (which seems fine) but there is no need to cast.
>=20
> Generally it's best to avoid unnecessary casts.  As a human reader, I
> find the cast confusing.  It indicates that DPAA2_ETH_MFL somehow
> requires special handling.  Perhaps it's negative or we are trying to
> truncate away the high bits.  But neither of those things really make
> sense.
>=20
> From a static analysis perspective if DPAA2_ETH_MFL doesn't fit nicely
> then we would want to generate a warning.  But the cast explicitly
> disables the check.

I really don't remember why the cast was there in the first place.
It doesn't look like it's needed anymore, DPAA2_ETH_MFL has a
positive value (around 10K) that fits just fine inside a u16.

I see Greg already applied the patch, so I'll send a separate one to
remove the cast.

Thanks,
Ioana

