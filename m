Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5621903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="txuOkRE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfBSHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:23:19 -0500
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:58769
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSHXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlulyL+gvQJeveEX2RwGdP7L+Mp9Ul6v3Aji28gJZMo=;
 b=txuOkRE9xuHTrQhgBuX09Ofd5bRjW4z0+OJPqSbHlR0pTlhgxqlFYiIMjCK+bh5Ra0sssojv91k58MGPdLKCySvdboFtNgXwQpk4RoVWabVN/iI63U/IMjyj11M2nlWHUliH8bcoOi9o2JfRR6iyGfjRvXgvvgOczmH+uIIKKAc=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2867.eurprd04.prod.outlook.com (10.175.41.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 07:23:14 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 07:23:14 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 1/2] usb: dwc3: Add avoiding vbus glitch happen during xhci
 reset
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUyCP5Y8sg90dKJ0SA+tfrnC4TyA==
Date:   Tue, 19 Feb 2019 07:23:14 +0000
Message-ID: <20190219072358.43493-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:203:36::33) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a38f4e-0882-4117-a7c5-08d6963b1c1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2867;
x-ms-traffictypediagnostic: AM5PR0402MB2867:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0402MB2867;23:5j88UCTP5s6+3fMtRzl1yn9vCZXpc8tt2vBJ9?=
 =?iso-8859-1?Q?BZmhLRiZEa7L2iifyNj/VFc2ZspN/b95oyrpa3aD1iKW3RuMx4VBXi/Dcl?=
 =?iso-8859-1?Q?WXMVtem5C/VcGvEhcNUNQhTeF5mF1SasTkCAlGSCOXLBSG4srNfHeIaz+M?=
 =?iso-8859-1?Q?ORzon6ikqMt0D5EKs6xAJskicTA4JrR57LX2yU4WpwqGmk2uLGvMkliuuU?=
 =?iso-8859-1?Q?dWrFm/n5jWqF0/PMX082cMgsQN6ghjSOdLNMrsWWp5dW4pLy7Fs98KFr50?=
 =?iso-8859-1?Q?0zSBi30pOsvm0J44VOOveBMO4EBPaIz88P1/8phrRzgzHZ9JaFQEidGCFm?=
 =?iso-8859-1?Q?viBbjvMBrfNEXpIUnqEQpuJxUdXVU39lmDrDlawlTrjw6oCe62mrr6YrAz?=
 =?iso-8859-1?Q?zwP7JwDs1jeyXeKtv0j/WoYSlJ77Tqu0sJK0ItHy5SsBayAO/j203F51rT?=
 =?iso-8859-1?Q?3JGFdUSRu9KBt5+JvkNKNGm5rC/tSLhokp7p5y85w8q1d86grB2MPfqegh?=
 =?iso-8859-1?Q?w6PswvT8uV/SOxVpmzMcHEdPmKkfR/eZ3OrjnsQc/H3k1kRDA8fpKY4Hcu?=
 =?iso-8859-1?Q?uWUnZudS5FoDCfd6gYHP1j9N7wxLgbSTsoycb6cn9iIxLzL18B65ZqEOdA?=
 =?iso-8859-1?Q?QBWlOz2ezpRZvjxxdReX83G+u4gNVGWlEnjI+bPXNCtMOdaHAYjvdGFMuQ?=
 =?iso-8859-1?Q?a8/3T7Bu0FNChjLuGn0kTDBEsbPXRVY5EA129toXUrZ788vE1OEK213X69?=
 =?iso-8859-1?Q?OkHHqWLbxEjsldvxguNP5WW/6wuMRJmV0cVrTm9zNxJaQjldQDT8NBNO45?=
 =?iso-8859-1?Q?BwfZeceyeT51SKzd8IToUt5GTKbCrzfKFZmAeCetnNwdfptKbwcANboL08?=
 =?iso-8859-1?Q?j1KGta+rIhVeJJIVj7Qu2fquedyEp7EK2T1ElAIfOtIyNxzAPnxIIlZZIk?=
 =?iso-8859-1?Q?JgUjoBcwWqiuUmaiWYYRYyKv444DX8SrSUmVZhP4rHkIzCd0S748xxvgV6?=
 =?iso-8859-1?Q?aAn7JVlbGHFCYPQLwv9tJkQro5ynX+jvr6DsME5fYLzHg20NXITu29/S1W?=
 =?iso-8859-1?Q?7JQlTXF519lmi2t1J0GvBY/bA5+oCdZTlX0+9zziIToykPVvUfiUBZBe32?=
 =?iso-8859-1?Q?NRQL0qbkoF1zXgL8JVu+/3iIcKNPYtlNm9EvInoXy6LEDZXsLrWQBahbaq?=
 =?iso-8859-1?Q?MTXJ1g83+urlC?=
x-microsoft-antispam-prvs: <AM5PR0402MB28678CC06628FF3BDCB6B566F17C0@AM5PR0402MB2867.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(81166006)(81156014)(71190400001)(71200400001)(50226002)(8676002)(256004)(2906002)(68736007)(476003)(2616005)(106356001)(8936002)(66066001)(97736004)(1076003)(105586002)(478600001)(6486002)(186003)(14454004)(99286004)(110136005)(316002)(25786009)(3846002)(26005)(6116002)(6512007)(86362001)(4326008)(486006)(36756003)(5660300002)(7736002)(305945005)(53936002)(52116002)(102836004)(6436002)(386003)(6506007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2867;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUYyVxD4CsRGGdl/QAwWsnJd+1SdcNuea6Kq7CZ1LvvkOjALACx0G39h97C524vJMMeUXhJ2EYfflatMh1kjQ+v51jNtXpPGJkAVO7S5N1qqbj711rrdaguShje/9SRJvWXbcJsBDc1lz5nUG0zAf1VKQvMmaR4t0f9pJsdTfwb1R6ARE2ztu8eklElriABVWAomcioTMQz7sIGq+dZW2kIbIkus9wxPLqhj+JaC0tjiHbLiFh49Y3uCJ2BDJMGVu7TfB5UBPcj8A7ZeA2y1+s+kbojrYFTop1Ki+Zgdhh0Z/ZmOA3yOC/q0neSXRnDOoHV6S7zdoEm/S1vuWjVEvWsqE6pt9Vgml8cKZ1QhJMSo4ANxYhIhSP9Zi2UVjYG17KVCU1qHvwKrLCz8uvdBAg3JdFMOn8xjxyXxSEj2grI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a38f4e-0882-4117-a7c5-08d6963b1c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 07:23:10.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will turn on immediately on related Root Hub
ports. Then the VBUS will be de-asserted for a little while during xhci
reset (conducted by xhci driver) for a little while and back to normal.

This VBUS glitch might cause some USB devices emuration fail if kernel
boot with them connected. One SW workaround which can fix this is to
program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
host mode in DWC3 driver(per signal measurement result, it will be too
late to do it in xhci-plat.c or xhci.c).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - Correct typos
  - Shorten the name to snps,host-vbus-glitches

 Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation=
/devicetree/bindings/usb/dwc3.txt
index 8e5265e..453f562 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -106,6 +106,9 @@ Optional properties:
 			When just one value, which means INCRX burst mode enabled. When
 			more than one value, which means undefined length INCR burst type
 			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
+ - snps,host-vbus-glitches: Power off all Root Hub ports immediately after
+			setting host mode to avoid vbus (negative) glitch happen in later
+			xhci reset. And the vbus will back to 5V automatically when reset done.
=20
  - in addition all properties from usb-xhci.txt from the current directory=
 are
    supported as well
--=20
1.7.1

