Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C720867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cyT/wIL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033C720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbeITIhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:37:36 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387824AbeITI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grt3hlirwTRAOjLYJzEgvqesLcdjo4RC9xaCntxZ1VE=;
 b=cyT/wIL2qGRVTsveSc5BGcn5sMC8gvUih/p6B8Dj9cjAgZx+NqijevZRLr7OhQl1HqUBSiWOHoWOpidTw07D3END26xvp52WqFXyazNtrPh2ZptqnAeAr9ryEy5wJs42Dty/8QwjdT5EgqqOLsk/oDq5sy8rbGRT90Kv4f7SjVQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 24/56] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Topic: [PATCH AUTOSEL 4.18 24/56] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Index: AQHUUIxOWS5k8hSYQUiPA62+2X1WSA==
Date:   Thu, 20 Sep 2018 02:47:43 +0000
Message-ID: <20180920024716.58490-24-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:2KaXmKN8DgiDjtShm+l+In+aZG2e2V1bpCaU+w+qJ9dPyGopwkqqTd8sJTPDlEjmuhK/sPSVHk4gpi8AGe1eJailllvkYy4vHIHmLwQ3Sk2gBvInOhpHXWXtoeZBJ6FMWJl5td3hBP83OgSLrcIP47hnjgJY2Q9QO/5EhaGiEw8QxTmXFv0c0y4LCO2+99ykAq4fy2mXbOjo7oxnBXpUR64zjR0b4sj0uEwg+kbkdvmmXe3Bl+tNDw8kGvI31TNYBf0R991pP9QFjB/9rT3msZyF6bQfccHEIspX0+Koku9vKHmUM+f1zgmIDZNNiFmPJUIwEd1fZYfc0KKHBHaP3XQKXIYcsZqxNFF6jtJXDO4FzcNiTvKa5YLfA+93ugPicaTrSjg6trJp11/TSJ82WiYvbThy/0eOm3aYFWcQWvgv3/OjD41Dxrlewh4f3UmPD1F09JKon3cBJz/RPToikA==;5:NqigvhhXgqP3QjYQi0QxuiRR0SYUIyQfr31laXz2CJUTjJ9dS/bFq8SrFfqWJhZJxAuQQPiylZe3rvNTgzE0ASzRV7kXxZO+MPsBKH9eTUBEamugKYFi93m1gvE5l9SccxQ2dS2fJt4y9EJ1PteyVT6t5g/i//UnH3a7eZGJzHY=;7:qLBZc3pTxcYJUbqOLLWozmZSLVs06iXQDpEjJb513AQ5V4YRWaH3EgbDf95WXBfnVfk8O4uXse6i1KmKIVKDRygebUv2CJvXrR5BQZYtFNuwsJWMzhI7KIpm63JIVCow+tf97lq2SXgBPvaNzni6cvTkBYOqCC/GnRRYozBN6IXXDQaBh/7d1TGjLag145mQwmjboAkCN/pS63GiG85GaGEWZW0FwL1q2f8njyczbfCYzXE6/Zi4BUk+sbgEsEXi
x-ms-office365-filtering-correlation-id: 14fcc5f0-5ffa-4419-b5c5-08d61ea371f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082279207C61D1E274F0F104FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(15760500003)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5qu7tYw3fCdoKvXKjTSxSNxn3ATcgUtjd2s6bm0s21GtCLqKLxdCsPXUWPZY5TIYLHGEb2D9SO8OMprrf+ePaqoXZZQOtbwbhvtukExlReGeQHi5oVVL0NoEIWTJNkaL6GOUSrbAvKTzVyigZ5eMFkE40TkfsRU3e+mMk8rWv8mDQ0AA4GX9XMxuKS1xCJSLELnjaMhZ/9bAhvr4g2d1VY+wzhxIEvx0sjzcpxyTPOsOMJivMJOvJJh0hSw60iVMFqzofzYO2BwesUt3bhfUC1GSVxdX/NCOviSQ/RNaaeTS52cujQBTFN54EfVZuO8DspFYwfSrQ8O9POPp1hattkIrLnRvCqjKR7kmZHWHK1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fcc5f0-5ffa-4419-b5c5-08d61ea371f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:43.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 3ed614dce3ca9912d22be215ff0f11104b69fe62 ]

When enable the config item "CONFIG_ARM64_64K_PAGES", the size of PAGE_SIZE
is 65536(64K). But the  type of length and page_offset are u16, they will
overflow. So change them to u32.

Fixes: 6fe6611ff275 ("net: add Hisilicon Network Subsystem hnae framework s=
upport")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethern=
et/hisilicon/hns/hnae.h
index fa5b30f547f6..cad52bd331f7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -220,10 +220,10 @@ struct hnae_desc_cb {
=20
 	/* priv data for the desc, e.g. skb when use with ip stack*/
 	void *priv;
-	u16 page_offset;
-	u16 reuse_flag;
+	u32 page_offset;
+	u32 length;     /* length of the buffer */
=20
-	u16 length;     /* length of the buffer */
+	u16 reuse_flag;
=20
        /* desc type, used by the ring user to mark the type of the priv da=
ta */
 	u16 type;
--=20
2.17.1
