Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78093C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358152173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ie196uoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfBZG70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:59:26 -0500
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:64286
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfBZG7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Maf3dinF8BFqTW1gygX80fRXMIYgN9gCrIsTDcR3vi0=;
 b=Ie196uoM5Q5h3+wLHiQjV9ShgFACMGiYHoOeYPb6E2kUtFkeFDy9BivV+5FGj4ODnV830DBPjVuZZkQvhZ0Rj2zXFnei/P9iVPO39g3ADO9BUV1b390R86AXnqZQ4VmMvOMa7uPgj2Y/4fSQV4FWYkzV75FErdyQ+5nXiQIxNho=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 06:59:21 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 06:59:21 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>, Yang Li <pku.leo@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen during xhci
 reset
Thread-Topic: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUzaDMOP2YLLnAD0aJ43gCn//B+Q==
Date:   Tue, 26 Feb 2019 06:59:21 +0000
Message-ID: <20190226070016.27372-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f80b7cc3-4a37-4a63-c530-08d69bb7ef26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2865;
x-ms-traffictypediagnostic: AM5PR0402MB2865:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0402MB2865;23:QGty5+DKbGPFSg2I+koRehyhNCTbsqoxrGIOa?=
 =?iso-8859-1?Q?ctlrSs0txQweeZCiZTrEh7m1UDy3HzybiTxAZdACu9DBY1FNTprhEayMGT?=
 =?iso-8859-1?Q?ytcY08g162F6zUyCRPl/QI+FnxavqIvvX4Un5Cu8PXul5JAv2GbKkCUe3k?=
 =?iso-8859-1?Q?g7pKICSAk1VNL+Q8sYz9wjMNdUKbDyVn8+hoB4y3WHc91bOMZf9ka8Nc+1?=
 =?iso-8859-1?Q?73G5/sZSpfCU7kYnnsDSDsZIGVLmfp5FLE+uZoBS3AaGbUxj0iDfYnHwdI?=
 =?iso-8859-1?Q?YTB9QjLQSKhUAdwkgZL0OSbZGAippYqnP8O5Ceco7hFSZrHpOA79ZgDxpK?=
 =?iso-8859-1?Q?KNCI5bhyh5Rs4IkqviU1W0GqPLUGRz+MfMHPIg/KakgUbHs2cd54GVTdfh?=
 =?iso-8859-1?Q?FQ8EshFtGRsG3hR6vwAMSvfSBcOksvNwAYW8hlDLY1B6fHfPXxH4Wc4EL+?=
 =?iso-8859-1?Q?WSPeDWfcyN0MZWgxQYYg8oYl7BBfumgJy/lLhv+5X2sl6FpcRzO3GA+3RI?=
 =?iso-8859-1?Q?V2SjnuWD8J/nfcK8qY8AGJjDHJt4TadiZOuPahFWYsW2P2JmQUpBeZgogP?=
 =?iso-8859-1?Q?9EeHv+8dqLBlih9fENJQgg0sK5YkOxSZoVK71I5xoxAR8L+sfsxcfZo6m+?=
 =?iso-8859-1?Q?N1lsgB5pRQHcNxcj9T5YXRgDN3COgOz4LToJo8sNRv+ML5gmbpgnZUKpwa?=
 =?iso-8859-1?Q?CQDkHZ4GheuZ91wnNFHz/N73IUNwy9jQNwBduax+3z2NO814mb8GnNrR/i?=
 =?iso-8859-1?Q?FB+As7oBbCjz7FCvvZLSvK4f3n/ckfcuTpvLoE0uAis3ol7+6S9x92KthD?=
 =?iso-8859-1?Q?yjetTknKc2hSy1jb/DWIVBcxUxQ1lNhJ0OjOmII5F7TUYE5ChlHlrNmLQK?=
 =?iso-8859-1?Q?X7VRsCFOpwCPDmk3ZPDwVZHGZQxoh5okFSJNdg1IRx/dsw09XnTBQgTf3z?=
 =?iso-8859-1?Q?wVaMS+G/5UZKqXveONitrOmOH62msMYpqGhMZb9C8QfmI59nxwUQ9O6R+z?=
 =?iso-8859-1?Q?N8ZWlLQFEfLC7fd+qD9DQ9hQFXDD26cfzmg7LczUVyOnF/yQfoxhnDGOXa?=
 =?iso-8859-1?Q?F7x7V+untn5jwM60X0+QnzSf4fCmZxdf3Hv+Zq6NJtOr1HuydAUopTaoS5?=
 =?iso-8859-1?Q?9pShfdv9Q+SLfm5KwwhLvGUadE8BxHEC3wIrPSPoSRMmTK/Zn67wc8heHw?=
 =?iso-8859-1?Q?BRHon/8/1gen8?=
x-microsoft-antispam-prvs: <AM5PR0402MB2865CC1F0A7AAA9B1F053C96F17B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(86362001)(25786009)(478600001)(316002)(14454004)(8676002)(66066001)(305945005)(6436002)(4326008)(8936002)(7736002)(50226002)(71190400001)(3846002)(6116002)(5660300002)(71200400001)(81166006)(81156014)(1076003)(486006)(68736007)(105586002)(2616005)(476003)(106356001)(110136005)(99286004)(6512007)(53936002)(256004)(97736004)(186003)(6486002)(36756003)(26005)(102836004)(54906003)(2906002)(6506007)(386003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2865;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fHqOzlHwM1lgPtA1kXjDdvELZmEWTzTKLaAoztHsSm9ISJjKpAZd1sXVJnunmC64MuGFZeESDVEvUdJJb+A9RGekdEorLzL83UiTM5LKSjJp7XnoQbLMitx7NrOfBllD7nZpk1zMsVSsLbDcc+tF6jW6RAmV5ogXBMU99/oMiAq7hMuuVUQSDjgf3NGr8X1H5Kpdb8LV3hZdDwhuKCf+Xf21Dtv5XoZrQjxaptsF8YCuVUs2SEzjADaRcOjzc3hXoT0m6SGAMy17PFwLRy/eZBokkugX8tciL8qxqgcGvUukhriRou2XIDiRw5GBIhERQC3sc2b6gi6Rl0RFLflm3aSQTicnKd14bs2yPW/s0VBeVEb9TODsfspqb6LC4fuZFG4bJG6v8CQ1MNnxdNqPPX32lh4UfUre0UoBft3eFcc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b7cc3-4a37-4a63-c530-08d69bb7ef26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 06:59:18.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2865
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
Changes in v3:
  - None

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

