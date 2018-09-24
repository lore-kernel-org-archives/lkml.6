Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1302ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2020842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g1h47XOk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Fmz2Qo9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B2020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbeIXSu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:50:26 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47804 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727518AbeIXSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:50:25 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OChnk1030832;
        Mon, 24 Sep 2018 05:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=CYOJ020+YmIX6P+SF9hr1uHAIwchNhCI9SDihiQ2MWs=;
 b=g1h47XOkpQ+hJd8wQ15LaCGDJfwh2jvYkrhQmG1LXJ+2HZ2GnFxgGAKvnDbE5E+Sr1Kk
 /oC9W+ccNoZKY1xsQUR/5hXGXU0kc4vogkPDhorCIiYHqax1n8Pz94SBPnidpqhtxZ2v
 ZPcLvL763uVqVKeJ5wzBKfFL1kvKcYGuw2ERIR0qM/9v8KAYTb6viO5Dh11RBJUJX77W
 22eWVBfZz3W97CMAoETTaUhWqYxgSGt3bUZTLzfrAojBKagNIRKM0CmcMen8QAKURhte
 XIdbDxdxByudFIvWvdb/jR8p7C3yJeSNfnAfWbVzMzJBuUD2tXmvl2oiPknEK89KjRUV Mw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0079.outbound.protection.outlook.com [216.32.180.79])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mnhawyurs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Sep 2018 05:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYOJ020+YmIX6P+SF9hr1uHAIwchNhCI9SDihiQ2MWs=;
 b=Fmz2Qo9nHodZebuNn1oaW6J+b7d283oydI9UnnDXgRpkxBuR01Qk0uVI1Bfj7oI+5UBcRfUsGLSqTqbISFEwm8UUI1y2RlWcM/Xlocmj2+rk7GuGZSIaw5JnyHCo7zfDPYdhYe2Q2UFnPCrDsixZ5pqG+easmhE7am4LeZ4Ql1s=
Received: from CO2PR07MB2551.namprd07.prod.outlook.com (10.166.201.14) by
 CO2PR07MB969.namprd07.prod.outlook.com (10.141.229.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 12:47:40 +0000
Received: from CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd]) by CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 12:47:39 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Artur Jedrysek <jartur@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Piotr Sroka <piotrs@cadence.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: RE: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP
 bridge
Thread-Topic: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP
 bridge
Thread-Index: AQHUUPIalRFVqo98AEqNqiK3AF19GqT6bAeAgATn/2CAAA4tgIAABRGw
Date:   Mon, 24 Sep 2018 12:47:39 +0000
Message-ID: <CO2PR07MB2551CD9AD02B57D818B7FD23CD170@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1903708.pJTgKoWLiI@phil>
 <CO2PR07MB2551EC0A7DEB61C54A4D6A5FCD170@CO2PR07MB2551.namprd07.prod.outlook.com>
 <6154358.J9crsCiUTz@phil>
In-Reply-To: <6154358.J9crsCiUTz@phil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTA4NWEzZGVmLWJmZjgtMTFlOC04NzFkLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFwwODVhM2RmMS1iZmY4LTExZTgtODcxZC1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9IjM4NzYiIHQ9IjEzMTgyMjY2ODY1Nzg4MzkwMCIgaD0id2c3YWRVSmhjb1dMdThsQmUzSTRzVFY5MGZZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB969;20:Ot3BZJFahTOdK1TUptfkkyK+uJ1uXhqI0BUsp/W25lZL1lR6u7G8a6BnAFIW2yMfAhw4PuN8t1Nsw/NovZTocBNIrccUE74hTCkOC8BZcezH8NW6UlWZ9hYNAll4LuCoTBEUIIa0e3OTcZXQK5jrDpobWG7diZ4vPpG0sun16PrNt1DtiKYzIde8v3CrosBPeIl9WCte61hP92HjfsK3IDKyjUofAxkrmRlq4iE0opTHtduR5FWp9tSu5Z7eqwPY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(36092001)(199004)(189003)(2900100001)(316002)(6246003)(110136005)(2501003)(5250100002)(9686003)(54906003)(6116002)(3846002)(5660300001)(55016002)(229853002)(99286004)(97736004)(8936002)(7696005)(256004)(25786009)(8676002)(4326008)(14454004)(81166006)(81156014)(6436002)(76176011)(86362001)(11346002)(446003)(186003)(26005)(6506007)(102836004)(2906002)(7736002)(74316002)(305945005)(478600001)(71200400001)(7416002)(71190400001)(486006)(93886005)(33656002)(66066001)(53936002)(68736007)(105586002)(476003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB969;H:CO2PR07MB2551.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1a8af7b2-fc5e-42a0-b08e-08d6221be9a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB969;
x-ms-traffictypediagnostic: CO2PR07MB969:
x-microsoft-antispam-prvs: <CO2PR07MB969AD59827BF85AA9762542CD170@CO2PR07MB969.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(58145275503218)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CO2PR07MB969;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB969;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BtPbRSe8J85IZtuII+/gxucoDk6hQJ239Qq6UI6yHIpPkc3+TjRVH33zJqdLuNRkNB2GTn4cFEuvcpVMRhDCnz7ndheQ5ufS5Uuu6p+TD3SboLhk8sUqp5pB3OWmwqzCsrCe6wMTXqZhwZeIMjC9i1+W54VdTVoZDvBWJIDnS0NpkERqKjaJNvM+MnBtGbQXTQulmTcn4XeB0IQX/Xa2U1ODFJkHn24t+BHy4jkfM9v3JnUe3iTZFkYjc4l+6WFpdcO+wy/CYbERWrPNwIoJRlf/FEZVvBKnuZe8jppQGbAEtVz/1AuONsRjBEH5IClCU+4dL5TAeoGbupn+KaImx0KjONL10OIZsQyZRB+pUAc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8af7b2-fc5e-42a0-b08e-08d6221be9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 12:47:39.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB969
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809240127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko,

> Hi Damian,
>=20
> Am Montag, 24. September 2018, 13:40:03 CEST schrieb Damian Kos:
> > > Am Donnerstag, 20. September 2018, 16:54:40 CEST schrieb Damian Kos:
> > > > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > >=20
> > > > This adds basic support for Cadence MHDP DPI to DP bridge.
> > > >=20
> > > > Basically, it takes a DPI stream as input and output it encoded in=
=20
> > > > DP format. It's missing proper HPD, HDCP and currently supports=20
> > > > only SST mode.
> > > >=20
> > > > Changes made in the low level driver (cdn-dp-reg.*):
> > > > - moved it to from drivers/gpu/drm/rockchip to
> > > >   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> > > > - functions for sending/receiving commands are now public
> > > > - added functions for reading registers and link training
> > > >   adjustment
> > > >=20
> > > > Changes made in RK's driver (cdn-dp-core.*):
> > > > - Moved audio_info and audio_pdev fields from cdn_dp_device to
> > > >   cdns_mhdp_device structure.
> > > >=20
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > > Signed-off-by: Damian Kos <dkos@cadence.com>
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/drivers/gpu/drm/rockchip/Kconfig
> > > > b/drivers/gpu/drm/rockchip/Kconfig
> > > > index 0ccc76217ee4..129b0529f3e1 100644
> > > > --- a/drivers/gpu/drm/rockchip/Kconfig
> > > > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > > > @@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
> > > > =20
> > > >  config ROCKCHIP_CDN_DP
> > > >          bool "Rockchip cdn DP"
> > > > -	depends on EXTCON=3Dy || (EXTCON=3Dm && DRM_ROCKCHIP=3Dm)
> > > > +	depends on DRM_ROCKCHIP=3Dm
> > >=20
> > > Sorry, I wasn't fast enough in my reply to you mail to catch that bef=
ore your v4, but I don't think this is necessary.
> > > Instead I do guess, the select below should do the right thing by mak=
ing EXTCON=3Dy if DRM_ROCKCHIP=3Dy.
> > >=20
> > > Somewhat clumsily verified by making EXTCON=3Dm in my defconfig and s=
eeing get changed to y upon build, which I guess comes from a different "se=
lect" in the config.
> > >=20
> >=20
> > I've changed it to:
> >=20
> > config ROCKCHIP_CDN_DP
> >         bool "Rockchip cdn DP"
> >         depends on DRM_ROCKCHIP
> >         select EXTCON if DRM_ROCKCHIP=3Dy
> >         select DRM_CDNS_MHDP
> >         help...
> >=20
> > and it seems that there are no issues. At least for me.
> >=20
> > Please let me know if that's OK.
>=20
> nope, just do "select EXTCON" . It works nicely and the above would not s=
elect EXTCON at all if the the rockchip-drm driver gets built into the kern=
el.

That's weird. I'm pretty sure that I've tried that and got circular depende=
ncy error, but now it's working fine. Anyway:

config ROCKCHIP_CDN_DP
        bool "Rockchip cdn DP"
        depends on DRM_ROCKCHIP
        select EXTCON
        select DRM_CDNS_MHDP
        help...

>=20
> To be sure I just did a little experiment and added:
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig index 4ad85c046dcd..64e2b096afd8 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -154,4 +154,11 @@ source "drivers/gpu/drm/bridge/ite/Kconfig"
> =20
>  source "drivers/gpu/drm/bridge/synopsys/Kconfig"
> =20
> +config DRM_TMP1
> +       tristate "option to select"
> +
> +config DRM_TMP2
> +       tristate "option doing the selecting"
> +       select DRM_TMP1
> +
>=20
> If I select DRM_TMP2=3Dm as module I end up with CONFIG_DRM_TMP1=3Dm CONF=
IG_DRM_TMP2=3Dm in the defconfig and wit DRM_TMP2=3Dy it changes to CONFIG_=
DRM_TMP1=3Dy CONFIG_DRM_TMP2=3Dy
>=20
> so all is well with just doing "select EXTCON" above and will select the =
correct "m" or "y" stance as needed.
>=20
>=20
> Heiko

--
Damian
