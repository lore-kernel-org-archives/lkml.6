Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7733EECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FF121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EvZMp6qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FF121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbeITIa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:57 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387736AbeITIal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grt3hlirwTRAOjLYJzEgvqesLcdjo4RC9xaCntxZ1VE=;
 b=EvZMp6qKUYS3sdzS7zLBXrbF0Olq1OSxIQ5cenD0NKvfx+LUDRx+prg6ORcs/scghgOTqfkPipxGX5MiiZ8MRwUJBQUsyw/DHjC/GMnkYBjFCSWHEnXKnf5KeRj2y/ztWMjsEMvXT6sydc6V7i0/2V/4SHDvquvm2TsjfeotbWU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/25] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Topic: [PATCH AUTOSEL 4.14 09/25] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Index: AQHUUIxkkTifi7gaTUGqiafAAIqMfA==
Date:   Thu, 20 Sep 2018 02:48:20 +0000
Message-ID: <20180920024810.58594-9-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:Cnt1OhnnlC8VhpTdzcyS6H13Kq9OWvFPggxAFU9g/z5N70WzokDTcvmqmLKOVDUF+QyVLQvfZzMyJLcVa4C/k3nVC254+GvhVS/+NGgg19XiYtThc5mb/EozuGIzd589x/0cOotK8LGkt9y3SP48ojLwJARfRnhdm7PcSV6Mp+KOx6llVZ3SOzc4uw4boPDnXCBUjgRCjMrzRGQ7JhjvVPodz1PzidJ1W4G7Y8PK4rwr+HgJuHFs/KV8v6ttBdwcPtpB6wuLke+JkBOBLjnA/5V4diqZJJZ7p6VSWmrxZG8JDz/NxZ8SdQkshAriEiaSZGtX93VyBPVub/QKYmPE/snR3h/078YwVUtDUhlPhwJ2P93vaNV7J1trV9cmLoYbmCuTPQw7HvKBIGY6rBuq1VCsasXqZ6HR72ryNDfaM4rYiioEwzFqQMdLRgEaRB0DURWymoeKmkpR3HmFmyzGPw==;5:w3tzcAGbQLGtQHMLT32vSeqVpXvMTQKp5qxLcKOfzkBCLZANNBKorvXSZELGm2cu+FPpPhQqT7j/krvTL6GzaUGHtB+o+UQGwg7/2NhZjevY8AKbHgSwd9SiaIHGvYCo3tMJc55Dh6WWDRJ0pYrR9rwZA85EsnixrPo0bY68JPQ=;7:B8XfvzWtgp4BLiLmWu9K1frSP2qK8yh0nrl6dUylbd3cIXFpzPPIopgDZdCZEJOw1JQhs6lY1qqgL0iXcTbbWoLcH9p0oEGGfK1ISQgPw4q7NhmjedxR5pnhQisSRZRSMbHaHD6nUFQpN9I5BFXeLsAJPL2OIu8VzpfJBsCfgM36fMWKmzZwlSTa0l4cGf8tZYwkBsHevAhAP8ffJS8A0OfGBeFYbi32M8VXluK4k4ax/bwwKLW5C0hv3h+oQlq8
x-ms-office365-filtering-correlation-id: b6c06694-652d-4617-94bc-08d61ea3a50a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011947F6C62E1207346520EDFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(15760500003)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fhX9ihxy2JqkoV3Uqu2z9WJsH1q52/YwfGVTIA0jTwLg8/dlMVDS6bitDo4k4L/XBqf6o++/C5myhCuqTO/ty36fFVftXGq939IiSlLPvOQ+SiRs6u9+2Dm+w4ZhTi5bj61T2dpHYCLqrG+IMiDlvfwcJGjHXXW0PET28HSkmoc53t2FEf+fgSVKuiVM8tTXjUaJoCVZC44oYUUbIaDRwf298qCgOO5CnT5kMaQngcw8ot+lMPFPW3wsyQGJ7ZhuEnHlrGHu1oidt4vJOq21GSZSFTYjke+4w7/2A6gl3hFWLNvXanIHc56FGFBMKtA5XdiYHY5l3qB2iN6x72EnRI8R3DHQs3zoYiysBjKsjKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c06694-652d-4617-94bc-08d61ea3a50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:20.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
