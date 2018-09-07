Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0017B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y72aNDYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0017B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbeIGFRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:32 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIGFRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJsi6zuOfY+fLEoIeWr0oIIYdfe0rEs/NVrkGJ2sJVU=;
 b=Y72aNDYeAj3TmIyXQhls6PRf3Mo6LpQ4ictgeiUJB6SAZCTyvNNRr5hzF1FsntKPM4udUlmWNnjxDJpd3ebtbC7Qg27CbW6QZ+UCI5bAfaW48BR73YmB65Fo0BR2qZxohAsz+dpQBXGyI2xhOXVYVNChkNG1sODjYPsJwlEJo0E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 51/67] reset: imx7: Fix always writing bits as 0
Thread-Topic: [PATCH AUTOSEL 4.14 51/67] reset: imx7: Fix always writing bits
 as 0
Thread-Index: AQHURkMG559wdnRLLkOyLatDXPl+Ug==
Date:   Fri, 7 Sep 2018 00:37:58 +0000
Message-ID: <20180907003716.57737-51-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:s86QoMHw+1KFmSlXzUqKkQKIHXpxf8yFB+epRzd1AyqOYsuAlOk+g7Uduy/Upf2jjQr5IHG6NcaTDDlchWOxTA+sWyWR5ujKQMjjgwBnWBpFDZSX+C7KegaR3z1IgGdl65r6b1KzYWmsB8z8IJ9OsyMUPBQvkMIhtC1GnIRZKDydDT/AReCny8RxswGpsHmD1RMaXDeoXXhBmgP+T4gwzICdevCYJi4nxrYCLTQNGYToQ9JQz/rR27TYaMpiZdL/GKw7ttvfEiauOJmh8AbAMG6cZuA1T6LLgoPD85wOEujn7H876LV7owlITrtfVYew/mGQP6pA63pYw7Ua+3qCzcRRN/SdA16wnd7EHI8oYaO3sdc+4I1KIpefVhH/t3bcHaSTJ02OaWf2SofqdLAYE5Y/gGMiHmf4uiUFe7kHt2PrmAySzfwUwOFXvctrHrIimhS4qiYcjZU8v0N7CHMKgg==;5:BH8EK6NJ7JyuSUJLUzMFRD4dGUH0nRwnOWUmkLAK4C/qk2hi/hL3mmddZstv0KV0kyJBIHwfeMGzhQdLsTzgRfyhBf28gbbX7H6ZXYdvBAv4QPxmf3hah65OsgRRWc0wklEIbnW5BkgnJIiMD2iFfneFtfzvuGRD8u6ViXWedls=;7:k62qkPo4UJPPFkSYJY5mTNJDcGJPR6gYbScdGJHm3n/JsA7G3ACEJ3cLPOMKLlEns5pMe1fRxTwbYDcmVoW91tM4EaAoWcY8UHEOjYsgYAmC1IbupMf9d4xT2ZnyKsMWykDpa2XI/mFO/2K9qxMchygrlGGfgig4/UmeqDYDwR/cmIoqaEy3NNRiiOc8p9Srm8quJ05IBoNuB+BeZzqw3lpNn+yzrG9KJIDUZNGtViqX7JfhpYTooXNoLwi+pq6H
x-ms-office365-filtering-correlation-id: 5abdf249-e05a-4085-186d-08d6145a504d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839A12173EE303995B9F441FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zstEcgZ5j7R+uVSbBTeYd98x+9tEn+Vs16kjLce577K6j3pMRT8LRguzy0a8AS+NFdZbnDXdc4N2n1wfCG3pjHOLjMJo1iKjAXOU7QoE+GIpFtgOUhzenflqscMlZRpAJfBg6qcNl1LQyVvCuR5MAW5cxVD0WFQoYiEhwkyBqNM1noN937HB4nMCmb+J83G4pRz3d8BV2n3KBBtheMOmYvjIJYVXxDDompMbBDlcOxx0RLA1U/l486JaoF5h8s8mJmYtt3GLSAZlhg+cTkgjDWYpiKFxq0DLFZMV1ZwtKbRcoVIv/stkSW7j4Xx14oaI0CW7BkVhoP4WdeOEYADtwsx0WJJI53AsU07w8VP2MVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abdf249-e05a-4085-186d-08d6145a504d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:58.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 26fce0557fa639fb7bbc33e31a57cff7df25c3a0 ]

Right now the only user of reset-imx7 is pci-imx6 and the
reset_control_assert and deassert calls on pciephy_reset don't toggle
the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
1 or 0 respectively.

The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
other registers like MIPIPHY and HSICPHY the bits are explicitly
documented as "1 means assert, 0 means deassert".

The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 4db177bc89bc..fdeac1946429 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -80,7 +80,7 @@ static int imx7_reset_set(struct reset_controller_dev *rc=
dev,
 {
 	struct imx7_src *imx7src =3D to_imx7_src(rcdev);
 	const struct imx7_src_signal *signal =3D &imx7_src_signals[id];
-	unsigned int value =3D 0;
+	unsigned int value =3D assert ? signal->bit : 0;
=20
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
--=20
2.17.1
