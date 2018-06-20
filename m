Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42709C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC4420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kuNlrVpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFTIwk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:40 -0400
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:30448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933161AbeFTIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU3vk9GNtYqwMNczFxJ/+bX8iqQI0qJkOaOPEautN9A=;
 b=kuNlrVpA489EvuN0nJPAhI7vGww4bwbagN0Ng+ScTjvMKn/ajeuP2h4B9bY3imCE43p4sJY+ey+fSd7s0JTUmPZAfLR5DeV6/Ji+F+ErofsyTsCh1pblooQnNiZPYbTvIVm4bNOp0pznZTWRdR8bPap63oW1YtuBJuVXjgLL09c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:29 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 3/5] i2c: mux: pca9541: make use of __i2c_smbus_xfer
Date:   Wed, 20 Jun 2018 10:51:55 +0200
Message-Id: <20180620085157.30121-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180620085157.30121-1-peda@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0301CA0014.eurprd03.prod.outlook.com
 (2603:10a6:3:76::24) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df3fe207-838d-44a8-3f07-08d5d68b27ec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:VlQevVIYmBs8iDYQDyt1lmtoZg10GlZCvU5OwlMNbs8xhdOCxkRtFEV9f0vjqwx8I5PU4B5iz7n6rknqRqcHCCbAtMTOlshh9xsxx4CxFutb9PjaT/aGjTgSlSHKXSNaAlhyXjfxx1M5YqruMd9ftgY2yTMMxh8vfbxd7zo5zvLKu6QKkSgwbTMoYU1K7KFkB5Ii908HJY1lRse1IFluqhqbuIITbI73zMyLgV8Pw7Nx1BUcsYRTh6wEW1q6k1Qt;25:kRnDbrw3kHgkdpAwAXGAliuXsWykC1mLkVp7s1VLytgtj7Cdzk1frYtMAdNeu3l74ECFjoIabBLF/o3luXN7YtjWrV2R+vTzICpahR3PnSTGcbS/9bY/pcE6JCdsqbfzq7Sux/VoF3M0MuPMKDDexibd0pGx+W3FWJYABrUPgTfzTcRJYbGtHaqpGigelbhV2WmCNxs2nHF60P1unMrGBdAulxK7hTxd9pSrINetVNS6eERNqh5VDc2lYxJz9DXoI+DofCyd2jE0sucaGdZKKhX89Cq46CA1nnXOn2vMec4ocswIuTFHWHeW3p6m1bk7Z9ZPgzIyo0rgwzkcujGKng==;31:RcxI+BmG+4XZdojtfa/6qtqvARLKivd68XjiCGDsQGrx5BHkPAaLEuXewFG9kL8CzD7jFVBwLNasvWE2C8HKXtUztT16he28iQNmkPlG+rxWI7UPo+RhTG9euSGRkPgZ+EbcRkAgwh7JrlFAywiH3KRG3BpNB99TQNpl/t40fl9q0oTTVIBwPPN4f1ZJhV5pv30lBeDN9VGblTUy1sh+G7bb/zigIIjTGUh60Ang90w=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246412AB045C68297D0BA433BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:MuY40Zx+cnjYfETPlFZ0C/Ymsq2qJu254AKUxgCMsW6ZZgY3JJI1W2wut0d55a6zfloHkWBrMyfPvZ1BQJ3vGA/E2mnQpQGy9Bx1RSWyCFyFvr5swrryFce61Aew4qBRkbtP9fsHWWtFMRJWUidcz0eow69v6GUBQ2OS6X+Zo6f73sK3DPw3CJ1R0eGo1eCl+nqiBjcyxh1FB6908rgksKyaobhl+he5U1C5xnCI4VTJl4X1nkxH49vlYEiArFWj/FGUeLDzvWlFGf2Xq2mpQQ==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(48376002)(50466002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(81166006)(8936002)(86362001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(6506007)(76176011)(66066001)(476003)(486006)(446003)(11346002)(956004)(186003)(16526019)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:cUUbg2azG8FYU2vPhScAniiuks4zfI6T6Aer9F9?=
 =?us-ascii?Q?ebZaaahDqxo5b6IauyPloYfYIY5a9iHznuzPdIX4WlDeRLET1qt2yPN4zzW/?=
 =?us-ascii?Q?jZA+pGaXEDXvaV9FCXNt5SMYgDr6XVEK/NjgZBLpknQviWksKo07tEszqAG1?=
 =?us-ascii?Q?FkxrcSW6xlsOEcrFZcUuzvBk9R7VwEehoPYh5+shDW1UWcjit4p9FzS0t+i+?=
 =?us-ascii?Q?0xUaWJnohmZGuKmLf+Mm66mbQmuMSVxfsBfjzob4YR03h1kBK/NGTV0Hk0mV?=
 =?us-ascii?Q?KXzHqxTyFgAzOxPqiAnl3qCd1UTHwuO0z4cLfgfmYdvrVdpgQWzOOA0YMF/L?=
 =?us-ascii?Q?f8aisfrJp89sUbkNZzhReFf1kxCZ4ra3ks4xFhtO1nONfp1vQwDPH/2sL76R?=
 =?us-ascii?Q?ZfU5hfqYBCGk47uOGLwfFy2QsnxnjJHOSyz9mBcjZxwnVnaTHo7+NkyRTtCP?=
 =?us-ascii?Q?4Hh8+1tmnbGApP1Sp9qRrwXM8amXsbR/tfEk3g7nvnINj5m4lUWbMOsSTUKx?=
 =?us-ascii?Q?FvozxBw+XFIgXbyZr3vmRPtnOa1C1cM+dZycnA31+D2ol4OjxCx058T8pgWT?=
 =?us-ascii?Q?spGQfA82fY/gdAgosZ80C9pJHMLMQttmDagpXM4BL3nI5bUoqzmtzYINhPLD?=
 =?us-ascii?Q?OsNvatiZ/upnVhx5aCYmU0JcceaqBATkxnfmMaof2rayu5xCioMklLgpZezL?=
 =?us-ascii?Q?n33PFk3HcF6xV5azW/N8c+CUGNiMIWZV54EAu7TAJj0ssx7jF9n6WU8RS6x/?=
 =?us-ascii?Q?Ys6dTRsIRX+p6CsV4xvV69Rp1hOWJH3I80zCw92g6cP2i6W3HG5RMSrhH3uU?=
 =?us-ascii?Q?XCbLR3Ogkh6PqiDmDKdiwBze7Gc+f5MfMxUbAp1odFNJGjB2GKZJLgtgZRG+?=
 =?us-ascii?Q?RNgJMySE3pLDnf8dMoh3FokwQOkOBfdAG+MPTxtQ/7p26n7NwM0v6O+HSTL/?=
 =?us-ascii?Q?5u33FtLj4bmRkvB4jffrpDEhF6Hj+yzKxi3XyelO1k/MQFbTYFruLbdhUsxJ?=
 =?us-ascii?Q?Lep/oymstMo2xzKqVGCxG9I1EOqZH0/ZG46M0+Jw673oCocqjBHU0MsESnpw?=
 =?us-ascii?Q?9e4O5seIN5nlhphRZ5x0wYbm44XgtyphNZ4U9fG5ppKXoHdeTG5flBIKoYXL?=
 =?us-ascii?Q?cQBKcOD6ZNwhvf8s2s7gC9VUzykOjVZuldoHM/tXgaPFmVlknqdX1favEyzT?=
 =?us-ascii?Q?1MN9d8N2DgyCZlDEpqx71ecJ7NPawmnunODxq5Qclr1vEVuj6SFYeId7kQyz?=
 =?us-ascii?Q?HQLOUh81b4XIMdzNX2YEVCpH+zU3+1gKCxSu1vvcpoWh3KeF4REdhfd1gMRj?=
 =?us-ascii?Q?4EqD0wY3Hsnd49nvJzPu6WZWj2Pms3M4epSzGE/yZ+2qBCzDRK2UYM7Skpli?=
 =?us-ascii?Q?Ro1k19svHtwfDSfj4RBqyv6BqTnU=3D?=
X-Microsoft-Antispam-Message-Info: txA6hcLiRxVSPD0LSq/Xw6vgsfuE+RzKd9Hna763pVkuQ7I8D4rwjWHRR3MlkZRhDcO7Nvkwdi/Q9MP2Wzy/KadCmUOjJg0V4SFTvHwkLihrpr+5w9Szsbo/RT42pVli1kk+FNj6gWTtDzjG/7eLTnZDz27YeLTfYTheh4kGvrIQeljE9piizxdssRM01ejYJh/a63izUhDKCiyd6Ia/6vg22K6mwnfZH1f9Wcb/Gv623WZCpkSZ+xxSN6boThbfmIC0vFjrv7Mmq3HQwzMUcjZBozKQLQ7Oq++ZPOi2oJE6euEMOpSC2LfxNxUvB+Gq8ygpSf3CQfOFzhVCpI4bag==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:Afpb/pgVbw2RMXZDWUElij/i7tZ1LUYhyLWtaoHz57SXumjwXJxBX+f9OlhCw96OqSK67DtxBtADpM7e/WNRinPVwOq22ZMsxM37HZ++tAbJvCqbk+oD4V1gg1o9Zlf2MD4wFZa1cXJ9Pl09705uOeDENY2sq3Kv7b3oy7gATmq4RGLfbpDdia6YvPn6qw2+wMjm7kKgUZv2uPksoGgKmEfji+MazPXYDW9vQHk9x48a/5zHMk/AQhl3Ygt+2gsW+omjBuiXWoFD9MloCXw1M839KCCQMRpNbUISc7/2qh4hyvBk4dct68RQ2BUfjlQC9nAIBycZv+9BdDYnKjFwUQqe/3spW5uu6znmLzgUB5/6RfMxE2j0JQmAq3DEVrjgXdb6b8ss/mOynlcED8CWptel3K2LslJJg6V/0XnCCQn6o1GTHT0JroKKcCuL8OH0KMzyfZovmukuf0ib9odoTQ==;5:NFiLWafFdlXa1yAzguoWx6u7BcG1nFbOKGcuZ9QZbKcDCKy5zouyNDVjN3ICIQERMbi7kkrJA5sue6n4J2AtUKO/+yyDk/cYZAkgZJspCZvTLI4d4Mbp8eckhFmOTjYim4slC3Gg+GT5TdWv+Ys+OsxgSgQ54siuIY2K6sB0BhI=;24:00biUuJGVpFmClCjE48f/bcS5yia2FIvc4VDpSQoV1SBGfz0eCe6HdMdvSu87HfR0sAl3XopFUpwaUsPHIFk6ydfg5KchSKcs73/IEMUBbo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:1AqYGAjj7AIAJxifsr+R0+tJFnHSjCWU7J2Kar7Il5nXyYs8PqN8EtKssu/BOV4fAvmU9geNcHzPKcGWU89AJNUF7RLQymn+mheRiJEHN13ZUph3wQsDwk/iXNhTOa9bnM5Veqc4gExhhCyPVW5WsLG0Vc170sxwZZ3g5r8N7NGiTnJW47lwGjZAvqHzGCTG0V3ESStwYo3Z/TKTdezBaunAytuZQU6xy5xjhgWoUBb5NzrUWNzCA2Ve0i8fZb5i
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:29.1854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3fe207-838d-44a8-3f07-08d5d68b27ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code, and you get retries for free if the adapter
does not support ->master_xfer.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 69 ++++++-------------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..3d8c938e99e7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -99,31 +99,11 @@ MODULE_DEVICE_TABLE(of, pca9541_of_match);
 static int pca9541_reg_write(struct i2c_client *client, u8 command, u8 val)
 {
 	struct i2c_adapter *adap = client->adapter;
-	int ret;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		char buf[2];
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 2;
-		buf[0] = command;
-		buf[1] = val;
-		msg.buf = buf;
-		ret = __i2c_transfer(adap, &msg, 1);
-	} else {
-		union i2c_smbus_data data;
-
-		data.byte = val;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_WRITE,
-					     command,
-					     I2C_SMBUS_BYTE_DATA, &data);
-	}
+	union i2c_smbus_data data = { .byte = val };
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_BYTE_DATA, &data);
 }
 
 /*
@@ -133,41 +113,14 @@ static int pca9541_reg_write(struct i2c_client *client, u8 command, u8 val)
 static int pca9541_reg_read(struct i2c_client *client, u8 command)
 {
 	struct i2c_adapter *adap = client->adapter;
+	union i2c_smbus_data data;
 	int ret;
-	u8 val;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg[2] = {
-			{
-				.addr = client->addr,
-				.flags = 0,
-				.len = 1,
-				.buf = &command
-			},
-			{
-				.addr = client->addr,
-				.flags = I2C_M_RD,
-				.len = 1,
-				.buf = &val
-			}
-		};
-		ret = __i2c_transfer(adap, msg, 2);
-		if (ret == 2)
-			ret = val;
-		else if (ret >= 0)
-			ret = -EIO;
-	} else {
-		union i2c_smbus_data data;
-
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_READ,
-					     command,
-					     I2C_SMBUS_BYTE_DATA, &data);
-		if (!ret)
-			ret = data.byte;
-	}
-	return ret;
+
+	ret = __i2c_smbus_xfer(adap, client->addr, client->flags,
+			       I2C_SMBUS_READ, command,
+			       I2C_SMBUS_BYTE_DATA, &data);
+
+	return ret ?: data.byte;
 }
 
 /*
-- 
2.11.0

