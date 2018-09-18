Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07822086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sWcffnma";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qdPV5oHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07822086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeIRSv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:51:29 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36218 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728718AbeIRSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:51:29 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8IDDYd7024643;
        Tue, 18 Sep 2018 06:18:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=uge2ZgNW70hyfnuN17wUsIggDHH39DKwjkrr2Gorujs=;
 b=sWcffnmayqnzvWC3ymooCmgcsq4FuxKqxoUG1XFzJ3RjAQBvIwuFHAxGjrcLzDjMtmlB
 TXgoGgAEGXx2jkYCbvnCoMAn4aLb0Poc3VJOqCtOd/jORZnXDHDnmAhQ68uuNaSxWSki
 qVOjFOhaVEtUlGydqa017xQhvVxilC5gMFSns8iF8oB6DTeG0aBshRpa540WA8tDPizu
 o1cZdiG4PeTZC2vW7/nm480prXMwQ1qbN4v1sS8Py8Wbx2pSuUwKgi35SZ8KYsNAuw12
 T3WryCq3E1CtPtkqLQnYRMUU2z94O5b23Drpaa0SdrOFeiFtbf3zsKZTEDslK4xwPHGn oA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0022.outbound.protection.outlook.com [207.46.163.22])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnv72d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Sep 2018 06:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uge2ZgNW70hyfnuN17wUsIggDHH39DKwjkrr2Gorujs=;
 b=qdPV5oHiymlgXrqLixsAZtdcANcDTxHDMcN31bxwlFg88sfUl4G3sUqlPsFqj+tOHlYyhexK0dZWcyWWwOS8jKSRapGBjdwo+71i6/Rw56YdnfqKUDku5CWCeoV10nyDoIVcMwVUzrT95cug4BNhPKesMVk7oW3o0zm5S0gbljQ=
Received: from CO2PR07MB2551.namprd07.prod.outlook.com (10.166.201.14) by
 CO2PR07MB2566.namprd07.prod.outlook.com (10.166.201.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 18 Sep 2018 13:18:08 +0000
Received: from CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd]) by CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd%4]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 13:18:08 +0000
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
        Quentin Schulz <quentin.schulz@bootlin.com>,
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
        Piotr Sroka <piotrs@cadence.com>
Subject: RE: [PATCH v3 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Topic: [PATCH v3 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Index: AQHUPrl4RuV2nw6NZEamtE4X6JbKdaTuPgSAgAAo67A=
Date:   Tue, 18 Sep 2018 13:18:07 +0000
Message-ID: <CO2PR07MB255198B0CC8CD7DEA742C556CD1D0@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <11916444.D1tlAhbW8U@phil>
In-Reply-To: <11916444.D1tlAhbW8U@phil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTRiYzk4OGRmLWJiNDUtMTFlOC04NzFjLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFw0YmM5ODhlMS1iYjQ1LTExZTgtODcxYy1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9IjMzNDEiIHQ9IjEzMTgxNzUwMjk0MzU3NzAyMyIgaD0iSCtad00xTStiVDN1MURESEcrZThya3Z5YktRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2566;20:9jXDlg4Aj6OffKd10cAzPFeNMH6kOUl2ybPORhF062twxDnmHdztngUObPVmr0DcRVUGpSDEusaORxS0N0Ddh2wUpFxXJ2pQYkI18w4suQq9lDHfhzKlvbTtPmqZhLvTJo+Zd6kJNAclFfBfIqIoKZu0CmI7kZPDJYQ8tF4u3XTsmk8pbYHpXyTlMmYlaMerzoHcehAZvAGNS6+97ltRQSXxZt+u4bVFbd6gfrBx4mPZkMB1BnHVfIq+mSKHc+N3
x-ms-office365-filtering-correlation-id: aa15ca7d-40da-4fa1-a51f-08d61d692ce9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2566;
x-ms-traffictypediagnostic: CO2PR07MB2566:
x-microsoft-antispam-prvs: <CO2PR07MB25668612778A626536A03963CD1D0@CO2PR07MB2566.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(217544274631240)(7411616537696)(72806322054110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:CO2PR07MB2566;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2566;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(13464003)(36092001)(199004)(189003)(486006)(5660300001)(11346002)(8676002)(476003)(107886003)(86362001)(66066001)(74316002)(26005)(2906002)(186003)(6506007)(7416002)(446003)(2900100001)(53546011)(305945005)(6246003)(256004)(76176011)(102836004)(8936002)(68736007)(81166006)(9686003)(316002)(25786009)(6916009)(99286004)(7736002)(7696005)(81156014)(6436002)(6116002)(3846002)(4326008)(55016002)(53936002)(97736004)(5250100002)(14454004)(54906003)(33656002)(105586002)(106356001)(478600001)(229853002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2566;H:CO2PR07MB2551.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i6BWz11BOTQ5SfbJVACjzWRPJb97LIV35NePHStWfhQP8y2Mdx6FAf6m3fn1o/EKWs+2plgSPGIHRmNw4u267YRo3geeJtoA88qstnY+P+UWZMDfv9urRP98l1iKh92SGTJUnnx+2GYgBuQf7MJLowEi1NQXcY/9Ud6Jr3hEssBCgDN6Jn2RfmAKWqlQzhbS1D2/+RRnUD7XrZMVFf/2sbsr+WwMpntIFItAZTChiFl3gOHiPhd75J3usV5XeHaRdeFmx+F/t5t1PltiHPi32xVRfT4rBGYi9PQrUNR7G/nbcWH2tWMfy1Kua37vZLyPGzMKAgaW+ldvt7P2MsiOfoMCldJuG2+JcwlId+gN5xk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa15ca7d-40da-4fa1-a51f-08d61d692ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 13:18:07.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2566
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809180134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.

-depends on EXTCON=3Dy || (EXTCON=3Dm && DRM_ROCKCHIP=3Dm)
+depends on DRM_ROCKCHIP=3Dm
+select EXTCON

Damian
-----Original Message-----
From: Heiko Stuebner <heiko@sntech.de>=20
Sent: Thursday, September 13, 2018 14:32
To: Damian Kos <dkos@cadence.com>
Cc: David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark=
 Rutland <mark.rutland@arm.com>; Archit Taneja <architt@codeaurora.org>; An=
drzej Hajda <a.hajda@samsung.com>; Laurent Pinchart <Laurent.pinchart@ideas=
onboard.com>; Gustavo Padovan <gustavo@padovan.org>; Maarten Lankhorst <maa=
rten.lankhorst@linux.intel.com>; Sean Paul <sean@poorly.run>; Sandy Huang <=
hjc@rock-chips.com>; Quentin Schulz <quentin.schulz@bootlin.com>; dri-devel=
@lists.freedesktop.org; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; linux-arm-kernel@lists.infradead.org; linux-rockchip@lists.infradead=
.org; Przemyslaw Gaj <pgaj@cadence.com>; Lukasz Tyrala <ltyrala@cadence.com=
>; Scott Telford <stelford@cadence.com>; Artur Jedrysek <jartur@cadence.com=
>; Piotr Sroka <piotrs@cadence.com>
Subject: Re: [PATCH v3 0/5] drm: add support for Cadence MHDP DPI/DP bridge=
.

EXTERNAL MAIL


Am Dienstag, 28. August 2018, 12:24:43 CEST schrieb Damian Kos:
> Hello!
>=20
> This is the series of patches that will add support for the Cadence's=20
> DPI/DP bridge. Please note that this is a preliminary version of the=20
> driver and there will be more patches in the future with updates, fixes a=
nd improvements.
> Please keep that in mind when looking at FIXME/TODO/XXX comments.
>=20
> Initially, MHDP driver was developed as a DRM bridge driver and was=20
> planed to be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there=20
> was already a driver for Cadence's DP controller developed by=20
> RockChip, but that driver uses the different DRM framework and looks like=
 a part of a bigger system.
> Both controllers (including firmware) are quite different internally=20
> (MST/FEC/DSC support, link training done by driver, additional=20
> commands, IRQ's
> etc.) but they have similar register map, except for Framer/Streamer=20
> (which is noticeably different), so they appear similar.
>=20
> The following patches contain:
> - Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
>   modifying it a bit (mostly new prefixes for functions and data types) s=
o it
>   can be used by two, higher level, drivers.
> - Modifying existing RockChip's DP driver to use the common code after ch=
anges
>   made to it (use the new cdns_mhdp_device structure and new function nam=
es).
> - Modifying DRM helpers a bit. Some are required for new driver, some are
>   updates from DP 1.2 to 1.3 or 1.4.
> - Adding documentation for device tree bindings.
> - Adding preliminary Cadence DPI/DP bridge driver.
>=20
> Some of the things that will be added later on include (but are not=20
> limited
> to):
> - Support for Cadence SD0801 PHY (PHY's driver should be on the way by=20
> now)
> - MST support
> - DSC support
> - FEC support
> - HDCP support

with te Kconfig issue in patch5 fixed, this series tested on
rk3288 (analogix-dp) and rk3399 (analogix-dp + cadence-dp) Everything seems=
 to work that worked before.

Tested-by: Heiko Stuebner <heiko@sntech.de>


