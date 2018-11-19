Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF19C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE26206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZZKPCbOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE26206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeKTBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:49:57 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:42431
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729474AbeKTBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifhBuml3WSVlNiK89m83718dMXSDYacSrM5YZEPdffw=;
 b=ZZKPCbOzsc3OgFu8mCPRXpyOng5PzvIJkszTfTslwEWNR0WkxWahkFyivHQa5rZg+vpgMfHTm6z2+ITcx7zQg4Bgc0+h/4FibNzc66b0e5jhXeCN+9wo0z2VUBib5OaB1M1Otdg6VeRrTHSdLj2olvBuYIfyRAPkVz97RiGDW/c=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB4688.eurprd04.prod.outlook.com (20.177.56.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 19 Nov 2018 15:25:59 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::bded:8cac:201e:eb8e]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::bded:8cac:201e:eb8e%4]) with mapi id 15.20.1294.045; Mon, 19 Nov 2018
 15:25:58 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: RE: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Topic: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Index: AQHUfP5F6CjK0TC0VUGuagGxPDq736VUaH0AgALRakA=
Date:   Mon, 19 Nov 2018 15:25:58 +0000
Message-ID: <VI1PR04MB48809E089371DA7DBA70AB1396D80@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
        <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
 <20181117.120800.2083117509893220159.davem@davemloft.net>
In-Reply-To: <20181117.120800.2083117509893220159.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4688;6:8UCpRV9baRRQxmZERg9apzjacmGiPdFvz9/oN9QXkoSCoWuNOmJ9yrNRlLErbMCxLl7wZSkXjMmcs4uYk+OgK/odLV7zxRN6mgV3MIPL1tDod3v4jz2xK/S+SGEK57KVt8k+TYC5uiD5JCQnqEUu9TQZ3wfO7WQNght6Awwr4Al+xSCcal+fG+c7FZgvTuUkTilRqlZic3D0xLYAJnVMfRASNV6hl7HPFz1dVtaByJ6By2Lf/FFdkNzyN7zQKkF7Grg2IvxmMSQcBVR9rF25gA3wIRYy5jwKxObaz/zBnnRZkWerrFYoE7aG0mCXWnptDrV9lKTQfO4aOvUcazGjsiUy75zjJvHX89yp7/eFZrX3mWswTdAC1JgUkDO1EBdjnbbsMgaaYcmUZ4w4Px9p9U2y2E6W7qeSMX4Xuql0mdpYs+o2pvoAxKd2jK9+Ok9WjkpM6KKio6fajdbN1y8n3A==;5:VfbDGVUlQ0JVbt/SZQo9UPL6NWcCmmiZKqrfGmxsEM4LeHUxQF1pq0ulqwQDAxc0yNKYxtME172nsXdOz+DLULs99mLHGf8y96t4cRUeG+f+bp0UjowsarfyT1CXa0j+Wv64oxhEJpPGWcJZ3Mgt3BWqxdibOFZbriERvyrzJPQ=;7:Zp6EpCQVMa3xR8O17xGGkwssJJ2slnK+vGG+Ktkx+DZ4I6xue1fLLwfOu8pssXqkrBLtFcPpu9NTGvEytI2F262vz+oLZyYuha78cwBi2SWacbA2bcuCZZ+WlCoesHNXMKtc2LiLL+VnbFyM0OfTMw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 920d9950-7df0-48c5-70de-08d64e334eab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4688;
x-ms-traffictypediagnostic: VI1PR04MB4688:
x-microsoft-antispam-prvs: <VI1PR04MB46885A384F82D1A10AD4B76796D80@VI1PR04MB4688.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4688;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4688;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(13464003)(44832011)(6436002)(68736007)(7696005)(478600001)(55016002)(9686003)(97736004)(33656002)(6116002)(4326008)(2900100001)(11346002)(2906002)(229853002)(105586002)(476003)(8676002)(25786009)(81156014)(81166006)(6246003)(53936002)(3846002)(106356001)(5660300001)(86362001)(8936002)(316002)(14454004)(54906003)(26005)(71190400001)(6916009)(71200400001)(305945005)(66066001)(99286004)(186003)(76176011)(7736002)(102836004)(446003)(256004)(486006)(74316002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4688;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q48YP1hvwf24ZFWXUaQ219fMVvpWiLzwaLt9xC0odX2FaZQvv615109PKLT24wGGYo5z1CJ2dhwHXed5Xn5dtYxsjk4BDYcuQ3TXrTFAUkxbpEPxqFALHvNQMEcBKBm/scNT8ngqtqGvFyLZyl4MKIFlKvaReMaiuv1KVrqdeeFteXjgZCE6UYGTvhu+prAhmKRCu6/qz551ODPJmod+Zra9lzcGOzP/Z20gWsV46j/kmAcPErYsmSlVQ79dizd3FH6mFctiO2UuIVgqfgduFnxqMGmevgxefa2gUi70jUg7FeevoTmiXnHXFEJCe84oji3zKNgjToLdOMeX1r6XzzMqbq548hyNN56f+qb/1ks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d9950-7df0-48c5-70de-08d64e334eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 15:25:58.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: David Miller <davem@davemloft.net>
>Sent: Saturday, November 17, 2018 10:08 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Alexandru
>Marginean <alexandru.marginean@nxp.com>; Catalin Horghidan
><catalin.horghidan@nxp.com>
>Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
>ethernet drivers
>
>From: Claudiu Manoil <claudiu.manoil@nxp.com>
>Date: Thu, 15 Nov 2018 18:13:53 +0200
>
>> +	if (!nr_frags && !(flags & ENETC_TXBD_FLAGS_EX))
>> +		flags |=3D ENETC_TXBD_FLAGS_F;
>> +
>> +	txbd->flags =3D flags;
>> +
>> +	if (flags & ENETC_TXBD_FLAGS_EX) {
> ...
>> +		if (!nr_frags)
> ...
>> +	}
>> +
>> +	frag =3D &skb_shinfo(skb)->frags[0];
>> +	for (f =3D 0; f < nr_frags; f++, frag++) {
> ...
>> +	}
>> +
>> +	if (nr_frags)
>> +		/* last BD needs 'F' bit set */
>> +		txbd->flags =3D ENETC_TXBD_FLAGS_F;
>
>Isn't it so much simpler to just have an unconditional:
>
>	txbd->flags |=3D ENETC_TXBD_FLAGS_F;
>
>at the end of this code segment?
>
>Then all of this code conditional on nr_frags can go away.

True, but this code also avoids reading from the buffer descriptor memory
area (dma coherent), which is not cheap.  As it is now, the driver only wri=
tes
the txbd  (excepting the extension descriptor).  I'll look into how big thi=
s penalty
really is.  I'm also in favor of more readable code.

Thanks,
Claudiu

