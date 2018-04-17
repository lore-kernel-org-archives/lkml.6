Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDQOdq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:33:46 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:16622
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752670AbeDQOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:32:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: [PATCH 1/4] i2c: mux: ltc4306: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:30 +0200
Message-Id: <20180417143233.25145-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417143233.25145-1-peda@axentia.se>
References: <20180417143233.25145-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0039.eurprd03.prod.outlook.com
 (2603:10a6:4:3e::49) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:+bnLw8zIlJsE/CWyaPsvV8x42h0WdxpreUfiFXNsci6DyVL++XuNmvN9Yc3Z/1jw3PX5FsxPxqRUAy6aAq1JrcGumWbx3pWsrs1M7TojdFSDNOC3y9UM8Gc1KSrIERhwCi6uXDXx4WkWLQqCu7CTZRr+L5Oxd1QrzIx34m596TSXtlQJt+dQ3NtK81CJHT5F72eAwqWaPIspkWCRNmbQmTAek92WUqcPPwEMZ0sBA9jS2OAGC4k/hPcuZUAszmTc;25:9hsk32iowP3x/iQcKtqK3ZyWQdQVlaM+XptRKHSKNI1xxcFUfKPo18hOccbSy8A4iwE8yhfWqMBqcOwbNnOlKO2X+qGXlTjN+6a8LWejNZz961bUX32MBFsTi3lMB6AHsERjqrCUtznfN3m8EGXVwsVGkm53uP0Ue8XTtt9CtWnJo+Yl/nG762vDX8w4Ddk/LAwuLz0SFpsgY9L+wDwAdnFED/JO6GjDjr7sYO9XZ49VpctGsyz4MkezXefseU+5FgpOKkUcFqE5hmSslTxEyH5kWeuVjnySd3TdbxYfQYnpgKBwaDUTzgM5gRTnCfr3/oaXPA0muFAxJvHMob/7kw==;31:w8szXw+XXLKWhrIpVb4q9VYwSyRoq2jk4gKPzP1uUtWnV7niy0TO4zdKJhquxlNUBsYNQEqgxSygfGyILcecp8jEMPelIK5ilQAX1aptoRzdVa12yZldePUHmlc7Jn3tdti06kqMWSXNuBNYR+woiXnKhcoXnSu9WXxEHKQmEcLwT0f8lUtBTKtG09vggU8533gDBB27SWOQV9Uw4Pnw1nkogfP6A4k6G4hMEUS84Bg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2777FD34A141878EBF8A55B8BCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:rVx2q7/gw2eMj2bNpw5MT+0e1xL24ILp2zw25AsBtZhXBtkECGXLR8/0kJEfiwoYVvRIz/TV8r/KFzs47Cai3Vy+H90Rrk4EfpTDBAdc8Y2O/ehxxE50lhqZEWh9AQsDmToQUum28kqTMJivGMuYcLahW8Vc35+7eANFbF/pVgjMIPcehDTb7WrsHxN1JCn+LBc9CvIS1Xf6/0gFciNO2hsWumu+IoqrcxM+RViyf4R2CJuPYTDYm+EOqNOO55afJDqx3cc1Q/PsHzMjFU20Ig==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39840400004)(366004)(346002)(189003)(199004)(6486002)(4326008)(1076002)(316002)(186003)(16526019)(53936002)(81156014)(6666003)(47776003)(52116002)(16586007)(105586002)(50226002)(8936002)(106356001)(8676002)(81166006)(48376002)(386003)(97736004)(6506007)(478600001)(74482002)(76176011)(305945005)(50466002)(7736002)(486006)(51416003)(6916009)(6116002)(2906002)(575784001)(446003)(2361001)(476003)(3846002)(2351001)(25786009)(5660300001)(66066001)(26005)(8666007)(11346002)(2616005)(36756003)(54906003)(956004)(68736007)(86362001)(6512007)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:L9HovkIAbJ3xUbzY4sxauuJbfjUBBGLSKoY6CaX?=
 =?us-ascii?Q?5aWQcQNCpGxDhSJbgk1+V7FSnxK28bQJSISYoDhwXZkDnIDKP7nrnAu9Pk/j?=
 =?us-ascii?Q?f/mBJ7JxSd91i3MrFmFcMrxK47WVDW/10Nq93+RSAt5cQb8rv0D9Vax6TGkp?=
 =?us-ascii?Q?c+/tmGLYoQIv71eTGUxJcSxiM8bHNGr26K7+5nHx/sGq3a/h/TD5UUEIz58o?=
 =?us-ascii?Q?1yKi29+k1Jo2npCJuZ7ZaQ3kYgd1QznpGq8DBNAIHnaje49xNZr8pkglsEF4?=
 =?us-ascii?Q?2mgxvB/SOXtJ7Gi1YgFVp4c1swrn6QkgIWsc+YHFmut01taRsXuMxCwgZbVc?=
 =?us-ascii?Q?His7mieYXZkCcBk3hsVGKbTx5swlFde61/pyaUKl22eFj+I1Tjni2EIpvDNU?=
 =?us-ascii?Q?OF/V1vOL57A+FUwaNN4wcQ94IfAcBKi2HAN3wrGzhHllaOCsQsXQSLa1S0Cm?=
 =?us-ascii?Q?Fu5lq+P8iITTgW1riXX64PAGUHXGwWzRA4vOTM6gHm985rMENWwztlHJVfiS?=
 =?us-ascii?Q?fYKQuxlbp4GNKCgkKTu6htiBCFNbji0L8hm6moEkcyWAeys9OrN8NF9gyV4H?=
 =?us-ascii?Q?ZXH9enQuieL1rpGoBmxOLJIO2vcFV0+9W6rtUhF5frvwq0gwD6YxZfLVJYxb?=
 =?us-ascii?Q?VBhKDdnHTZj4SbwujD2JAZrdXsKo6VXTaeny5tHwDAK51V9oBRxW7tmH+74X?=
 =?us-ascii?Q?woW5RKGHkqHeqx0XIWHg/J96KYWGi1mdcGvOQgUlAHD+YYaa+IS/bZKANmxp?=
 =?us-ascii?Q?wAj3QBZ0U61iRE8SK3DUFGtKfK7nsaDdQ+LSKpBfWD/HBsI3N+Ok5sc7IYFT?=
 =?us-ascii?Q?AvOWXotD+9W2SreSO6BTmdHrIPy+R7TTP0Yth45lJZ0ru1/oMJLF8RQ89lMj?=
 =?us-ascii?Q?PgFYV84kOZTtLiYpTR8VIqHjKaPTUrozvyT12iYYxLjh7044oJpvM67LL0nR?=
 =?us-ascii?Q?vQC+Flwj3jKKT2H6LFs9/2lbQSqwf6Y2C3Yt6NzxmVrQNBXFpDAjN5oF8eMQ?=
 =?us-ascii?Q?XUUNOY2xbNZgnQN+A+5jiM5GGnp+/asxzCOwMPv1Lyb1099lSdo9rlUeD9WF?=
 =?us-ascii?Q?F0hAlr+m8ItoDgwoYbz3+YYYln6QjWRuJ6ALCJdenfIHHxbCbuiMpVIk6+fF?=
 =?us-ascii?Q?uYdsQ37G0CBlhIv1z6XPEAiZEznYp5oIzxua+2ipyoD6Xhq6mmt9n40Mvka+?=
 =?us-ascii?Q?eyo1C056afqAkKWaA3fp/zKjsNeUm24Kf2PiTS43nqkUku2RhzOqKK3D5ovr?=
 =?us-ascii?Q?mbZCtH785MTsvfZDLrp7BP7gjwcMT4wP/u4TGxaeRGt6VLiJMLJtqU58QF6m?=
 =?us-ascii?Q?0izdYHi5tfoiStDj5qkp9EYO/Py7dOpFosFlvtd+0yNBPVi4dR2FFgPJYEnb?=
 =?us-ascii?Q?POZs+pA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2zSYnh7HnTIgKwzB6ki6iBmgtELUUUkgbv/HRPiVe/8H0j7vhw52DcD2XmnflC/ZQDTQMbAZpEF0Rtr5wuagObKu63KTyR3Z/3f4R4cXRc+bHsAeao3Tb34P9QvlsxIITy8LB/BgzT/WCBWyK4em2BxnJvqDQmDiwvtE9rN3Z9S0yuZiKVcY4Hpn5sufDTKm
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:WEdWpmGJVe0frohUeqHi5fetMKkwrmO6vNpC0ZoRFBytzNmL/NbBuRyVHT6jLRu530h1z0JrZsM5RcHtNIz/b49R8e5Qmb3oSfAvd01oqDGUoaId7HRfTgxWGHuYZCmgIXIUeia5cu7xbd24FgycBI67UlKN5XO72odjoIOCz7VJ/tNNnS3leuUcst52aZAiXZFfHqa2LkA6b09EWgAI1KyJo/tk2KZCGYhS8hGI4WqaI23UJoH5YTB5nefC/TMMkMhv6onMjNCqUT/R7OfYw0B+f4qAVpZjqTRvK6kZpWwU0nwnaMQUREW7HYwvVwrSfZUMi3OaW1vOvM/ngfGgQ4YdfpRG65NQOz72SCk3QBXtYfFRRqcDuDXvR8g5gUXKN22CheqkrPRsK9lCJDvJupweWwouYPx03xekKtbJoSH6qRSTm9vjfntd9i6g1qEwaffA3Ww3F+l7URF0Hdr+2g==;5:sW4jm9XOYnspUD5OD6aXk393A3Q6hWsKxiLA8XZAO9mEJ3QAs2nDnh45n8i3a5CofUledQ5LlhvlKhaYjvt0LPe3yjx33zOveEq/3XvQbBzNFvCEG2Z1wcqNPTB5TIPybxgaz95z86+kLiURhv30oXTYqGIHypg8EmjKwhnTdGc=;24:SikQDjna3vzsDNMcqtbmpNTkHctisUDRizHM1TFEZq5G73RTWkLXfCh6MpIPjebByDDLoNIrwFYNsNXoZQJz/GuCj/6PdlOCwNsZLcFomag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:0urkigwyQixhWcwQsPyvfLqcKsFqVj1lj6VF+yaemHUhLcTCY/GGSyOoBuNTFSsb9pZCnbwBktwVgnE7RKQUFfnDfi88WaQ3EXRebWw+oNp+5gACShKu3S99OlvcNA8HG89vcuJ8JEZ8HI1rSVVxFunlxEdK9Pf4q8bIY883biJyYvzOVz4qmaaTVSJeIF/zZDQ+AiGt6AnsiciYVWUOEIP9qj5pv7do+wTPOv+H9srQttpbb/UedF3OjEGhfz77
X-MS-Office365-Filtering-Correlation-Id: 2a28c5ea-6331-4352-906e-08d5a4701658
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:32:45.1769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a28c5ea-6331-4352-906e-08d5a4701658
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index 311b1cced0c0..a9af93259b19 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -206,8 +206,7 @@ static const struct of_device_id ltc4306_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ltc4306_of_match);
 
-static int ltc4306_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int ltc4306_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	const struct chip_desc *chip;
@@ -221,7 +220,7 @@ static int ltc4306_probe(struct i2c_client *client,
 	chip = of_device_get_match_data(&client->dev);
 
 	if (!chip)
-		chip = &chips[id->driver_data];
+		chip = &chips[i2c_match_id(ltc4306_id, client)->driver_data];
 
 	idle_disc = device_property_read_bool(&client->dev,
 					      "i2c-mux-idle-disconnect");
@@ -310,7 +309,7 @@ static struct i2c_driver ltc4306_driver = {
 		.name	= "ltc4306",
 		.of_match_table = of_match_ptr(ltc4306_of_match),
 	},
-	.probe		= ltc4306_probe,
+	.probe_new	= ltc4306_probe,
 	.remove		= ltc4306_remove,
 	.id_table	= ltc4306_id,
 };
-- 
2.11.0
