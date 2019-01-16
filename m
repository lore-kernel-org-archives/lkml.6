Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46620C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165FE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpjB51qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfAPGsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:48:13 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:46048
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388079AbfAPGsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW9CAzB5jiiTi6Zgpp8pIkCsKP4et98is9UFOIhHCp0=;
 b=SpjB51qxTukabhqfuGJzukjpGT38pd9T8V6vtKHmmyHW4EgYoXoilqOKzYaqAMzB2gPwcqrfu85cJ4NUVmPqvNzXP/ciwaR59utvgX+3rEifFI/VQBfKuyMTHPtsy6tmWmlYcRulX3raQ9QYhqqToVAfCJSpeUJeV4kARTZBT3E=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:48:06 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 06:48:06 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during xhci
 reset
Thread-Topic: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUrWdviEVntsRQzEWnqfJhKWO2IA==
Date:   Wed, 16 Jan 2019 06:48:06 +0000
Message-ID: <20190116064820.20007-2-ran.wang_1@nxp.com>
References: <20190116064820.20007-1-ran.wang_1@nxp.com>
In-Reply-To: <20190116064820.20007-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0077.apcprd03.prod.outlook.com
 (2603:1096:203:72::17) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2785;6:8pxTbHtYvbIYazLCuydAm9wdfhellWxSzW4j1odnbv7G0Fr4S4T8pmZGC5/IR89NPMVsawtznDZF/8IMXRngbgyUeWAVCBt6z/JxmDSONjXzs8J0i40zalQPtsUEMNVXoI6UG9SDAWe3rkQzZbzZ3BDzMKYehH4rY3Tw6iYbrZsXgm2itZx75gyLW811C7L8fXAYHvSZjYW+Mc6RKOOtvJBETwfTvALkpyGlhB3N3ndJs+ksMwBXWTo9KAXo/wQueigJvpKmbLtM/fwRXHu3DunSkbBq+LqH0cSab0STyKhaOQK5dv6P2ppJuqLuINpSSoQBwm3lwIRDNjddSIsourbp6JEyEs8B1PZl+rRv3bDkKWglNxEVP1aOWPwG1XE/8M1k9bRHYxH3OrUjRU6OLNhjC0AdOkZxA48Wk+8I26a364lqLJMAo/3Q1mzr0QgiBLokC6If9cqARRlva4UVUw==;5:1n7Bbi43EzcC/g1OYh0UBf3r6CqPZ0N8cAdWZ/FqiCrwqjSzuIdBZn1EHd7fLr/PY0ceDTvPY8IPU1dXLJfSazjX5vOD1i5tXTUzruIpaRDVAq9zqi6SoptGhaHFCv/prmEXOYZwC4CEmjagJtdBSrOwL+9CKzdT+CLFQP1t0/dZoNNiuB9x5dGBz9Cvqzghxo+gcs16/1YtL3bGHb6HlQ==;7:K9wzRy12QLmZVm2jTqB+ts8//HadL+81Tp36I65ZgFih9avz6jRWlYUQTEve/EKeGBAEoB/XfEQopnB9bvyemtJ8GsdcxcZ2J0WoLgf9rPF2ZIcWqyF/JFt3etuXiV/qaO99N9pWjsxxh56ytTKSRw==
x-ms-office365-filtering-correlation-id: ad8cae19-7fac-4159-e004-08d67b7e91d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2785;
x-ms-traffictypediagnostic: AM5PR0402MB2785:
x-microsoft-antispam-prvs: <AM5PR0402MB278506234C2FB73D2036F9EAF1820@AM5PR0402MB2785.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(106356001)(105586002)(5660300001)(99286004)(6436002)(6486002)(6512007)(52116002)(76176011)(316002)(54906003)(110136005)(486006)(446003)(11346002)(2616005)(476003)(36756003)(186003)(1076003)(71200400001)(71190400001)(25786009)(4326008)(256004)(386003)(102836004)(26005)(6506007)(66066001)(53936002)(97736004)(86362001)(68736007)(478600001)(14454004)(50226002)(7736002)(2906002)(305945005)(6116002)(3846002)(8936002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2785;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UlGxOIYJ8R297czHfLTuFu+NbM+Nqc1UZsODiKacU7/uGArrLtZMwPLrETVcNKuUy77wwOR6ZiVe3hi2PggQgikH1mBth6bGKqH2OhrbM/MqS1nE8hgsySvm5C/ieg9YiaN1wZziZWhGRNwm1R+0o88jX5bag4ZRtzDbTZcheRfb6LSdgv2MpZNVk634HcDC7Gbf0oUTv5T3u8WnBqSdnyCatXkfmoVF+twU4txOv8CyNLkuul2CJP4DN8Q51Ghei4pL3vqY52DStcsShSB4yLE3MpXpVldWUTdaY7AkzklpmrhN/S917ibPwMqtlI2Qp72YH6lryahyP+S3hu1wr7QGwg1hIG4V31nJQeq0ZV0jZamjRHSg/KN4KXVwCzgciwj1TJEHp6+QAxZriMz4+tyMuutKymROJnQzTc/oGDA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8cae19-7fac-4159-e004-08d67b7e91d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:48:03.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DWC3 is set to host mode by programming register DWC3_GCTL, VUBS
(or its control signal) will on immediately on related Root Hub ports.
Then the VUBS will be de-asserted for a little while during xhci
reset (conducted by xhci driver) for a little while and back to normal.

This VBUS glitch might cause some USB devices emuration fail if kernel boot
with them connected. One SW workaround which can fix this is to program
all PORTSC[PP] to 0 to turn off VBUS immediately after setting host mode
in DWC3 driver(per signal measurement result, it will be too late to do
it in xhci-plat.c or xhci.c).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation=
/devicetree/bindings/usb/dwc3.txt
index 8e5265e..dadb530 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -106,6 +106,9 @@ Optional properties:
 			When just one value, which means INCRX burst mode enabled. When
 			more than one value, which means undefined length INCR burst type
 			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
+ - snps,avoid-vbus-glitch-when-set-host: Power off all Root Hub ports imme=
diately
+			after setting host mode to avoid vbus (negative) glitch happen in later
+			xhci reset. And the vbus will back to 5V automatically when reset done.
=20
  - in addition all properties from usb-xhci.txt from the current directory=
 are
    supported as well
--=20
1.7.1

