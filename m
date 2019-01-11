Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46222C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Obz3GK5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfAKOJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:09:45 -0500
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:8064
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733016AbfAKOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3YUJhjW7jmVBHRs0fOqZkOpI7AFMdHPswyS/MgHhnE=;
 b=Obz3GK5Pwj5IUC4h6RJ7XRn6bzi93yEgrw1WwlqGO7zomybur6A+nGRIjuoYghhptXv1sYxAbPX5upADKocFbcXkr2N439cKZgpnBHAhF3n5tqCX0SB9IcMg2Zk2NUdtBM8aAm730G1iTciCFSYNuG8P/itC6IS6L3ZqjrsXBRE=
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.48.220) by
 VI1PR04MB4320.eurprd04.prod.outlook.com (52.134.122.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 14:09:40 +0000
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::1503:3059:d104:d46f]) by VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::1503:3059:d104:d46f%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:09:40 +0000
From:   Camelia Alexandra Groza <camelia.groza@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "oss@buserror.net" <oss@buserror.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: guard against accessing a NULL features
 bitmap
Thread-Topic: [PATCH net] net: phy: guard against accessing a NULL features
 bitmap
Thread-Index: AQHUqaTCFTUvECMNUEezNU0fW67z6KWqEk8AgAAGkbA=
Date:   Fri, 11 Jan 2019 14:09:40 +0000
Message-ID: <VI1PR04MB47994BB92D3E766C6B4E37C9F2850@VI1PR04MB4799.eurprd04.prod.outlook.com>
References: <1547207806-30572-1-git-send-email-camelia.groza@nxp.com>
 <20190111133730.GA1895@lunn.ch>
In-Reply-To: <20190111133730.GA1895@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4320;6:MZXI3LAQhcJnzSBFIcbuQeRXXbSqcLZdtWjajc6iQyhJXr0EmCUiXM6zmUc7odCwYPdbyBmoesg7kBh3OPDBbgM6TbNiiGB02du6kQeeFr4cUe5tz3I7Z0ERauuS8ooNAmJhlnS/7BGOfBukIofxQFiSBoaKTGPAAp5O/9d040AbS+Zrr+XyQTkCio/jQU8QeJOIh+NVkgTrKz4/+JqFPVukmcb38qXx+rMY5dMwBdweuaV6FvGYj7T2SeBDPs6HbDwoTuxKiZp2SLkGDEw6SC/EefHpgixD7RCUlYUH0b5rNA1Y01wmoQSkTZdBLVTCadYTJvRuNwtqK8tvhgCLqFGTM1bCPs25KracT99lAgsHCXbQGyt7Pd7lZr8dAfNY6PoSDl4al6/Lop/A6BTr6DW9bcHMWfWZDnDEgMAmhc7wN6J41f68HBxo1QkmtjNnDFDdp8j5pn/h6ofQUHc1zA==;5:XJQI9ESAl30Pa4fqkAraYoeNpHWzQ3zWxdZ1Xks6AJDH7WDbd24A/VJPbUDBXUs0keFWHot5vdL2FadSFaguWkHc3Ro1nGcBKl2GKqb9Tf5RtQMe8JB1os0h2DfrpYmUwJQNZD7DJneMNrWshpjBlDIj2QUpr+HB07TguX7I2QCtkjjPFhtD9id+UGsSlXUflL5hofcX5ScQJkg0VEnFZg==;7:zWtptrthI65VfkiJ0JiNnIo5EeG2+sPsl7vprUofEXJrFIyShcVJ+zBXCnzjES4mg065hLHP8dW8g+m5nIuSWan0UoRYEhBqqEx9soeClFmg77aVSjONo27UDwbDwzAJY6MwVP5g7eAJW3bUldY9mQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e6f08f1e-e1e1-4443-6822-08d677ce6dce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4320;
x-ms-traffictypediagnostic: VI1PR04MB4320:
x-microsoft-antispam-prvs: <VI1PR04MB43205461C15B7FF2F3F07DF6F2850@VI1PR04MB4320.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(13464003)(189003)(199004)(446003)(11346002)(55016002)(7696005)(26005)(106356001)(76176011)(305945005)(186003)(229853002)(6506007)(53546011)(105586002)(102836004)(54906003)(97736004)(99286004)(486006)(53936002)(6246003)(74316002)(66066001)(256004)(9686003)(6916009)(2906002)(8676002)(6436002)(476003)(68736007)(39060400002)(81156014)(25786009)(8936002)(6116002)(86362001)(3846002)(81166006)(14454004)(71200400001)(4326008)(7736002)(33656002)(5660300001)(478600001)(316002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4320;H:VI1PR04MB4799.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ntnD1b56kgEI46I8QXgQ+rVo7MMc3wL5fvVvPUUvVJOfqzlht+3RqmEsEKIGR/Xf4CS5/TFBTpI+1IsjGjb9OpSog0s+wHlv+w8XPL7DA1mi7DjWwHq0KyHpjGJtIa4d192Ab2PKIbmufQoodcqWtskyYIK4JvH3Fg4DU0uy0G5ie7FVlNDDwYfABLJ6jNUcMx0+zA+K8XB2u8XkQc7BELCJuFVh6oOl+tdYROLeIsfFpTmRT7F7tAJn+b+zOtkcLBJhaAK4GGBB40csfQi4CheMXM9If1yx1VwI0cHf311MgVOp8fPdgT9tOe8bkEqLaEl/SKX4DaZISeJ7JJua6Xstwkw/NFXQilTEOwunHVDsgmf0y0h8DZ4oJ6x26blzJ0TCDLUAtYy62X82HjFjObIvGv87ko+gyc+5ZtCvZag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f08f1e-e1e1-4443-6822-08d677ce6dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:09:40.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, January 11, 2019 15:38
> To: Camelia Alexandra Groza <camelia.groza@nxp.com>
> Cc: f.fainelli@gmail.com; hkallweit1@gmail.com; davem@davemloft.net;
> oss@buserror.net; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net] net: phy: guard against accessing a NULL feature=
s
> bitmap
>=20
> On Fri, Jan 11, 2019 at 01:56:46PM +0200, Camelia Groza wrote:
> > Since phy driver features became a link_mode bitmap, phy drivers that
> > don't have a list of features configured will cause the kernel to crash
> > when probed.
>=20
> Hi Camelia
>=20
> A NULL features is a driver bug. So i would prefer to solve this
> differently.
>
> Please make phy_driver_register() do a WARN_ON(!new_driver->features)
> and return -EINVAL.

I wasn't aware that features are mandatory. I'll make the change.

> Do you know of a specific driver which as a NULL value? We should fix
> that as well.

Yes, there are five drivers that don't have features configured: BCM8706, B=
CM8727, CS4340, TN2020 and KSZ8873MLL.

I'm planning to send patches on net-next for the Cortina and Teranetics one=
s at least, but fixing the generic crash was my priority.

Thanks,
Camelia
