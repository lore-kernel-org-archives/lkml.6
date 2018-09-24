Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EAFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9387221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nYLGZYjG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="a9MA0cQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9387221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeIXRoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:44:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51588 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728006AbeIXRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:44:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OBXvUN002313;
        Mon, 24 Sep 2018 04:40:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=BfKR36khpUa7zkyncV+ZKnz6Fg2yglt4DZUEX19HbgI=;
 b=nYLGZYjGcbWS+Zvl2PZerQWGPBfGwWubv9dVJj7YdD5L9pUrwJTkOdMjFm97ErZinGi2
 J0nu9wWmOKtKZOR2UeAx883J/rIjG8lRgSQy2TwCTXWxGUc4FSWGao5sO3HyGibZhg15
 5nEbF1LJrahzqeCpAQYn4nVzBCwdO8Fk4G+IUV5ckDq8o5xt4RUVZbZ5OIJKgPONwqvZ
 wRNjBhmdcpWFWvxZIrQfZgbn4TuYZOTr4Y9VyUIFZjJ9+l0Y6uw+jGVjPBlXj/RcUplv
 xEk6II6G59Wx+HbX0iyVqPo/fcIwTlZjCCYuW0w25cdaK0Ea10A2gvCg/1V7nCVOOmnt Iw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0049.outbound.protection.outlook.com [207.46.163.49])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mnhawynjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Sep 2018 04:40:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfKR36khpUa7zkyncV+ZKnz6Fg2yglt4DZUEX19HbgI=;
 b=a9MA0cQDIRbpD8OMCWWJEHT4cHzstJancaDQ5PVLyFBGVQz6BfHamVQWC5/e8XTAIgVRd8lbipwchEmV4T81TJNwAtqi1Ca/1ShOdGyxD3vi5EEU/mrf1cbCr2+NYIkhAAnNxrziN7iPXtdNsd0Oe7DudrosF4jaq4jYzSs6wTE=
Received: from CO2PR07MB2551.namprd07.prod.outlook.com (10.166.201.14) by
 CO2PR07MB604.namprd07.prod.outlook.com (10.141.229.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Mon, 24 Sep 2018 11:40:03 +0000
Received: from CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd]) by CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 11:40:03 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Heiko Stuebner <heiko@sntech.de>
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
        Przemyslaw Gaj <pgaj@cadence.com>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Scott Telford <stelford@cadence.com>,
        Artur Jedrysek <jartur@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: RE: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP
 bridge
Thread-Topic: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP
 bridge
Thread-Index: AQHUUPIalRFVqo98AEqNqiK3AF19GqT6bAeAgATn/2A=
Date:   Mon, 24 Sep 2018 11:40:03 +0000
Message-ID: <CO2PR07MB2551EC0A7DEB61C54A4D6A5FCD170@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-6-git-send-email-dkos@cadence.com>
 <1903708.pJTgKoWLiI@phil>
In-Reply-To: <1903708.pJTgKoWLiI@phil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTk2NmQwYjhmLWJmZWUtMTFlOC04NzFkLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFw5NjZkMGI5MS1iZmVlLTExZTgtODcxZC1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9IjMxNTMiIHQ9IjEzMTgyMjYyODA5MTgzMTAzNiIgaD0iaXp5Qi8xSVhiTjVaZXVtSmcrSVFlVTJLZ3cwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB604;20:zKFJVsGX7Vaz914KHTUYa8Y8BZL2JNX6gvRaEbxRu4a+gClKF0pzmcMSKxo4pPdbOaFu96zFszkjpYPKSkgiJN62mgx+Snce37LW9R6Qy3k8yj+zEqmxh6EJ2E/WmOYZgcQ6AUbmzO1onZXrBA1C037EAc0ir3uG7eXB872be8pq5r4GeYv0uy3qotYmivS1uqr2jT0ZQ1fhOTyiyyD/aPS4aFtnJ9TECjrp0IlwgtKWMu1NPgi3m5rIVgwvBury
x-ms-office365-filtering-correlation-id: b8ec7ae8-27e9-47f7-817c-08d6221277fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB604;
x-ms-traffictypediagnostic: CO2PR07MB604:
x-microsoft-antispam-prvs: <CO2PR07MB604122F470A2A9B5CBD8C66CD170@CO2PR07MB604.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(58145275503218)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CO2PR07MB604;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB604;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(36092001)(6916009)(6246003)(53936002)(25786009)(54906003)(229853002)(4326008)(76176011)(256004)(7736002)(7696005)(305945005)(99286004)(2906002)(33656002)(106356001)(74316002)(71190400001)(8936002)(6436002)(2900100001)(5250100002)(97736004)(105586002)(7416002)(8676002)(14454004)(11346002)(316002)(486006)(71200400001)(446003)(102836004)(86362001)(478600001)(3846002)(26005)(9686003)(6506007)(68736007)(6116002)(5660300001)(476003)(186003)(66066001)(81166006)(55016002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB604;H:CO2PR07MB2551.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t9nFAbHAgzODNBMnHUOi1Zc9vK/U5k8UyEQUNTRJHxJpeWFjEdXbXQMd68YVHa+gNkwofDotHCPLgQaKkv8bhtEr9uBT8/smOhW0AOBOFZo1spc+ukYN7u9srXyGeUcbrDKKCbDs8f8SDBiS9eJmjn00L3u0NxEVltf4HyZ3pQcwAIKsF+beZsE+HhXG8a6wSodWAivUtJJDEGq/8nMBjupHv+Kei1mH0HqWt1CsffG6ZWDZwOpl44vg7MQwMjZSBlXSwR/cTzcSKFmtWUhB8Rl5XnBhCtOC8y8/TV8AsWF15RhTKll5BdnyD1HOPXs6N+jjEYEQtz0US7LLQOi/XFl3ngVvN/QEbPlRRLnZqME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ec7ae8-27e9-47f7-817c-08d6221277fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 11:40:03.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB604
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
 definitions=main-1809240118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

> Hi Damian,
>=20
> Am Donnerstag, 20. September 2018, 16:54:40 CEST schrieb Damian Kos:
> > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> >=20
> > This adds basic support for Cadence MHDP DPI to DP bridge.
> >=20
> > Basically, it takes a DPI stream as input and output it encoded in DP=20
> > format. It's missing proper HPD, HDCP and currently supports only SST=20
> > mode.
> >=20
> > Changes made in the low level driver (cdn-dp-reg.*):
> > - moved it to from drivers/gpu/drm/rockchip to
> >   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> > - functions for sending/receiving commands are now public
> > - added functions for reading registers and link training
> >   adjustment
> >=20
> > Changes made in RK's driver (cdn-dp-core.*):
> > - Moved audio_info and audio_pdev fields from cdn_dp_device to
> >   cdns_mhdp_device structure.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Signed-off-by: Damian Kos <dkos@cadence.com>
>=20
> [...]
>=20
> > diff --git a/drivers/gpu/drm/rockchip/Kconfig=20
> > b/drivers/gpu/drm/rockchip/Kconfig
> > index 0ccc76217ee4..129b0529f3e1 100644
> > --- a/drivers/gpu/drm/rockchip/Kconfig
> > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > @@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
> > =20
> >  config ROCKCHIP_CDN_DP
> >          bool "Rockchip cdn DP"
> > -	depends on EXTCON=3Dy || (EXTCON=3Dm && DRM_ROCKCHIP=3Dm)
> > +	depends on DRM_ROCKCHIP=3Dm
>=20
> Sorry, I wasn't fast enough in my reply to you mail to catch that before =
your v4, but I don't think this is necessary.
> Instead I do guess, the select below should do the right thing by making =
EXTCON=3Dy if DRM_ROCKCHIP=3Dy.
>=20
> Somewhat clumsily verified by making EXTCON=3Dm in my defconfig and seein=
g get changed to y upon build, which I guess comes from a different "select=
" in the config.
>=20

I've changed it to:

config ROCKCHIP_CDN_DP
        bool "Rockchip cdn DP"
        depends on DRM_ROCKCHIP
        select EXTCON if DRM_ROCKCHIP=3Dy
        select DRM_CDNS_MHDP
        help...

and it seems that there are no issues. At least for me.

Please let me know if that's OK.

>=20
> > +	select EXTCON
> > +	select DRM_CDNS_MHDP
> >          help
> >  	  This selects support for Rockchip SoC specific extensions
> >  	  for the cdn DP driver. If you want to enable Dp on diff --git=20
> > a/drivers/gpu/drm/rockchip/Makefile=20
> > b/drivers/gpu/drm/rockchip/Makefile
> > index a314e2109e76..16ba61ffca39 100644
> > --- a/drivers/gpu/drm/rockchip/Makefile
> > +++ b/drivers/gpu/drm/rockchip/Makefile
> > @@ -3,13 +3,15 @@
> >  # Makefile for the drm device driver.  This driver provides support=20
> > for the  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and h=
igher.
> > =20
> > +ccflags-y +=3D -I$(src)/../bridge
>=20
> hmm, instead of adding an include path, the shared header should probably=
 just live in /include/drm/bridge/... in the kernel source?
>=20

I'll move the common header to include/drm/bridge/ in v5.

>=20
> Heiko

--
Damian
