Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A1AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C44F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3qK5cpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C44F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbeKPTnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:43:53 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:2609
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbeKPTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+VNHv8oje0GGxEki5hw2mNjgkeEiJuU4M3Daga3/cw=;
 b=a3qK5cpFHWh79ZCbaHhEojtUrG7QK4RhShF10aZddQQq4I7xgZhRDDz6r0g04WDdAdnGOSWzyZwYCA/HUh5/D53Ag/yZDrg46xGQO8xZwnoq67pPX2EhJGT1rVhmHQgT0YwUqNWWwZioZ8x8pXOUqyfdyAX63mhEGAKeYZFKUpU=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.49.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 09:32:19 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::bded:8cac:201e:eb8e]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::bded:8cac:201e:eb8e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 09:32:19 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: RE: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Topic: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Index: AQHUfP5F6CjK0TC0VUGuagGxPDq736VRS5MAgADKVFA=
Date:   Fri, 16 Nov 2018 09:32:19 +0000
Message-ID: <VI1PR04MB4880BE4EA7B7C0A1EEA0A0D196DD0@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
 <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
 <20181115203544.GG32274@lunn.ch>
In-Reply-To: <20181115203544.GG32274@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4830;6:oOddTOpS6AL+0voJktOn48qWFl0vUYfia2iEqyvEPUnlH6jmDALZWZza5SIFitXsTgHF9EPbvg5mbALfewlM5yzP4YrJfmbgbr+1m6eO5M2uG/32u8KuCZIYvIPbHyWNB/1z61sZ3k+Z6UbQljAKJ+gWg2OClexzzUIgwYVtxSXntIX8ct9yzo6dsFPmM1+lQA8aHuDq4voxFbiFXU2MRBd6NPoHF/4+jO8MMMcXKh7q2GSd8mpWOxcmTO6kBvqGZajti4yCLJdM/FQbUhv8hWBWKZDOIJunZUWnlz6iOJOBnYj1nsaSeRPlbLjTPfM2FfIzAEry3LCCVjjSJHuKrMEDOJB2A9fLiaYybo4wFYn0BEkVfY2i54KTFdWVKM8uT8+xxWMf14PjL9FJbrcm3LtjaGSEmNzwTkHFEYiQVel4FA8meTrVSUqUrijtfl09wI6AdEQ2tS9jtoT5SJSphQ==;5:jGqv8bN9fHLWEFSvYP8DJwhWhFazVrFJcKSBxsqQ0y37JvN0cGg86XpYzKiBp0/uhg5tow+xfv45tMdritfvUhzmpRhe5PzmTEuvixF9u0lJCoveq/r8hGfRp4AeupCiSyyU+hNWuI3NnjRVKVO9mRYizmiOFzFFznmz5apeC24=;7:tIUGG1IfJYnUsL/WIE+gebaKOrMKmEneEwOv2Sg6Erc9E9+zfZXHQLgwAjyG7IR5OC1LCaOaxODOvyBp+rb0nSJ5g4FGjYCBbvNzcelchF+LiFxo12TrFzKzaZbb6Tg2agyiDswANPeXiwCT/XWHbQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2c085024-f66a-406f-fe7e-08d64ba667af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4830;
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-microsoft-antispam-prvs: <VI1PR04MB48305AE312DFC5CB1FB14AEB96DD0@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4830;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4830;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(13464003)(53936002)(25786009)(102836004)(8676002)(105586002)(76176011)(54906003)(229853002)(5660300001)(86362001)(7696005)(9686003)(316002)(6506007)(99286004)(55016002)(6916009)(8936002)(74316002)(81166006)(68736007)(14454004)(6436002)(4326008)(97736004)(81156014)(106356001)(33656002)(305945005)(26005)(486006)(7736002)(71200400001)(71190400001)(66066001)(44832011)(2906002)(186003)(478600001)(446003)(6116002)(11346002)(3846002)(2900100001)(476003)(256004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rw6dnSDoW6LQ++G3d71YtNygH3r4CuXId9b5urQSIqH+dlfQArUTHtAwTqe8fF58fkmiP+QtBoQPsID6uxtarSeAR0t1f9MC8StoCjHSc0xyXP5VDqPuYTBPhLWh6thiQK8Yhp9qDCjnNFYo9TheQBnBNH6gFF1t0GBpATfa0V69juO2SjA1XcdgF5QCXVFB9vXIwXpymrCwzaNg3gY9wEEmqmOP3g4FkAn5TLv8wXNIPryu6Oz6WJQ7Zm6oEPOBaPrR01m+iDQUiq2q2v4/sDh98UKm3lPiFLFpgfkgLLKIwJ4/sh+lFp6Vt3QsgQVs497vSQgr8rRtzT79ynw/OjjN2bf/IV+3MfG/nD0xYZ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c085024-f66a-406f-fe7e-08d64ba667af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 09:32:19.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Thursday, November 15, 2018 10:36 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: David S . Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; Alexandru Marginean
><alexandru.marginean@nxp.com>; Catalin Horghidan
><catalin.horghidan@nxp.com>
>Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
>ethernet drivers
>
>On Thu, Nov 15, 2018 at 06:13:53PM +0200, Claudiu Manoil wrote:
>> ENETC is a multi-port virtualized Ethernet controller supporting GbE
>> designs
>
>Hi Claudiu
>
>Do you mean 1GbE, or multigigabit? Do you have a SERDES between the MAC
>and the PHY? Could an SFP be connected?
>

Hi Andrew,

On the first chip to include enetc, LS1028A SoC, you have SGMII ports mostl=
y but
there's also one RGMII port. Depending on phy type (board design) the SGMII=
 ports=20
can also support 2.5G links. The first board available however, ls1028a-rdb=
, will only=20
feature 1G links.  I think SFP phys could be supported in future board desi=
gns.

>> +static int enetc_of_get_phy(struct enetc_ndev_priv *priv) {
>> +	struct device_node *np =3D priv->dev->of_node;
>> +	int err;
>> +
>> +	if (!np) {
>> +		dev_err(priv->dev, "missing ENETC port node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	priv->phy_node =3D of_parse_phandle(np, "phy-handle", 0);
>> +	if (!priv->phy_node) {
>> +		if (!of_phy_is_fixed_link(np)) {
>> +			dev_err(priv->dev, "PHY not specified\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		err =3D of_phy_register_fixed_link(np);
>> +		if (err < 0) {
>> +			dev_err(priv->dev, "fixed link registration failed\n");
>> +			return err;
>> +		}
>> +
>> +		priv->phy_node =3D of_node_get(np);
>> +	}
>> +
>> +	priv->if_mode =3D of_get_phy_mode(np);
>> +	if (priv->if_mode < 0) {
>> +		dev_err(priv->dev, "missing phy type\n");
>> +		of_node_put(priv->phy_node);
>> +		if (of_phy_is_fixed_link(np))
>> +			of_phy_deregister_fixed_link(np);
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>
>I asked the above questions because of this. Using phylink will simplify a=
 lot of
>this. And it makes you future proof for faster speeds and handling the SER=
DES
>between the MAC and the PHY, and having an SFP, etc.
>

I know phylib has some limitations that are supposed to be addressed by phy=
link,
but I didn't figure out yet how phylink does that or whether it works on ou=
r designs
too.  Last time I checked, only marvell had phylink integrated, and it sure=
 doesn't
look as easy to integrate as phylib.  I think the plan is that we can switc=
h from phylib
to phylink when needed (once we figure it out), since phylib is less intrus=
ive to integrate.
Until then, phylib should be good enough, at least for the ls1028a-rdb boar=
d which=20
doesn't feature SFPs nor 2.5G links.

Thanks,
Claudiu
