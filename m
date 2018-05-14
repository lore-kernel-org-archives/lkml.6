Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeENOy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:27 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:3416
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932507AbeENOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 05/21] i2c: axxia: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:14 +0200
Message-Id: <20180514145330.4857-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:RuELxTSSXfK1PVPHh11NKyqxdOZHfGUOBtyU0rDn0SJYXG5xiAk/RZlO6DvG6XxDTBouarpa8rTBXKIIAsmGassV3OdIpSy7sCGb8MdyLaLfqchABh/XKDEaEdzMSPsVhpP+Bi9075pSTKJ6/dQxuyVlzB9k0APzz+Qj8kAoSemoZhDG63N1za5BzQiTERwl9u53fs0XYWsDIKGJIO+tjvAH21//7zUT21XL5Y+PBECIFeG8xL7dGlQMlgiXdaE1;25:WgBAbmS7n+VCzExgJmrcICLC+FClG82KRasEeUR9O06bim2M5EeTry23sH7H59CnALOObC2vrqSIV1OwfI2xw3Va2ieeFtu64qtGvCnAYeWguiVa3jIbWiA7DZ7p7QOoOc25sEjElTWbEhMmM2Oy4x4zVyiYPlpi4ETbcFqEPrX8NFbkcbe/WFQzkubr3fBlCozHnZv45xxp70vLD776IIe4vHz9YTX3BtlnR3Rw59KHG8TaFTI2DYj+TBgDh72+Lt3ipKjGFZW20YXBUdZJ5LglXVEtXCHces5gPwIIf9dfyKYFhoRftemJtPocX6L8s4AqVZ/LRc85EcqzCyWb0Q==;31:QKYkvc3SmEbOUkds/nK+JgOXBv7fUDv29nvKeV11wBKTUERKXN7XIqc6lp6z6/u3lWtEadhP0+MikovN3hzrVn9CETMKiNoIET0IXBSFm8r9s3ErixhSBWnf0yRLU5JkqYVCi6R7618ZFiSHrNtMqTR8OUFqh96Zj4wtLnKutQPYuRSxGXHm89Sh73Eb2cP+bB3+4J1uuIRHO8Qr/S3q14CpyyFLPoPVeLXZCBlcaSE=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782510FAC2C772E3CE847FFBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:oPf/9WdecnoQ+qyiUjv7KEllz9QaYHrtNhq2ElXX/uqQ6amxTQ1hBZcZhXQZ4QjM9eIn9JXna7QJx1OofcUPPIjFXesOFo5VpD+aoBpmo6WKLCiCzk+kDGD95JyTE5STwVHHgY217udnO/aJHaFCKSquk9zCjE+e9AdZlyyopL4lxpw74Q5qfRByVCgE7TXyTx7R+mXKCPpqTU9UgvJdlhAxZsSmACwz7D8sfob53VOOMUEvKJjCLLb9/aVQTmmKfkMnRJ940Zpd77vmqiVvtQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:IWzuIBQlojXzcwU34zUK8HG/5EYLsi5+WWqfSdF?=
 =?us-ascii?Q?Bqj/qAYWE9Nnq9FbSnRbYFHx+uea9JWVhvpIl5eYYDkl86cHys1i1oS9rQ7w?=
 =?us-ascii?Q?Ui+86qiFsR53hzVgaFmpca6GxUr0exqv3sg6qoU+x2GwrjOK8kZw14dDGxSW?=
 =?us-ascii?Q?zkv0fmgxvKvOMFnN6Xz5qwQq5ON/+8QCcwwopAV2x9L6I5CCP4AchF9aYSki?=
 =?us-ascii?Q?jVdEswmhmVZCyYV8Z21+WdZWhk8qDnS+jZFEP90+A2L9k8n23RkAHVqpgPFT?=
 =?us-ascii?Q?p7FZNqgzePagnEYIwsJNdSfLhqWO9c7AZe1UhPkL3RjcZQ//wgluQW0AuJrX?=
 =?us-ascii?Q?IDuEt+oX4a4ad5o4eLLJGhSPhIxJjtNOnD+qzo9TB5e1VwN3hiuvkjnDlZvO?=
 =?us-ascii?Q?xdJ4LvZIScRKIIzkm5Iy451Hv+6K6fylF8Jjvs2swlzbYmZR3Hn+7S50O3wX?=
 =?us-ascii?Q?X3173ZPHcQCr+OMLD+GQ2LtX2q0L5vcOQZi4tN7gxSfWzyH+vHHLzUo/pe1y?=
 =?us-ascii?Q?CyqG1E69E+xCGmLihJu2wKFGxOkHh/3KucCcaTHRm0u2ykZ98g1Q22ae+V8B?=
 =?us-ascii?Q?Aca2plijaaU5ruNTyePg3K54aUWZpx48zEUXLAHBNGL7jWdgq8EY93/UQ32t?=
 =?us-ascii?Q?O3fbYPB8cPY9BMNDxCpXrOYnjA0revR4GoswCJMTFNNAMPt0t+JQProxCz6p?=
 =?us-ascii?Q?zMwZ9bFkHxTFIRtuWxth7SZEBJrI8sW0Scoe4vfnI3CA3pXqChwRM3Gz43CD?=
 =?us-ascii?Q?HjP33xkyOJtj6963+ZFBtCBWG7iURHNpIL0QAXQDwidh1Edk894risqtkFcf?=
 =?us-ascii?Q?bM5l9juBXCHJWs0lKS2UVS1KP2u5iK1ce2pd+lBqHH8jIj5Mo6e87qpbVX1d?=
 =?us-ascii?Q?hsEyplLa7a8MaUkbMF8awjqLRsYk4h/EFy4A4iP2RHgvzO2FW3UP9jkRbfPa?=
 =?us-ascii?Q?CyLhSr1AEeaE3u89xK4RCGLClXqm0ka+Qbj7Xb1+M20R//5eK7SS30fvVWCC?=
 =?us-ascii?Q?f6f7m/7kLo8ysMbTWs14WpRP97ZAVM9yMgHArpTU4qurWDKNis+gNkbUVhNK?=
 =?us-ascii?Q?iCdWvWjaiDGAg7/FxRtstZZYOb5mi5ahsh/LETBSRS8ISIs3nsnI6Mo0ICwa?=
 =?us-ascii?Q?UbVzWKEaUPoOAsOFpowUE6dcuF43aLktOekwzTL7mY8IIb/PycNOijuX+DvL?=
 =?us-ascii?Q?x/jrxUHg3qKB4asLhZnDutMmT+eFXWSwWbIcu/lVYuAzAB6n7fZXe7wT6Wo9?=
 =?us-ascii?Q?NX27nW86t4gofmVJS5vXtGw5pbombN4dGNCIn9ztzH4lz4DxXHd3WeWPXscd?=
 =?us-ascii?Q?V/bDkZ/DgqL9tQeyf1CKigDF5kXDVLcviMTaVeTkToUpb?=
X-Microsoft-Antispam-Message-Info: pGvz89OftH21gTPdBD/TXWsSYWIXAPU0aBNo2ebYwhAad+GUE8eO8kzzE1YV87zR2GCJPO54AAdTMGge1fDklZwfdTh5pMBcOmf0rDiqqn6Qyo+usGaspR2ELd+4E55v0qAwIUedP5fgqAPq0xRjxEuFb+Sm2fV3vtXUdLQHISQ9m7E+whm2ePXyRfCHdauG
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:0WTbfsfWF+tTJrX1MPj5hCJ2+wK6NVkDucEsore/wsYQaRo2VMgoPZj3M7C5oL1DgPrvNTPcXl1bmLuyoCLS6YLb5eQuivspo6hB2hu1emLFS/3B76JcJaXjPx/yVzaGFuNHnunlp6GUzL40zsi8XSj3I/2AsHluBpT180aG4vIkQ1+Oybl8y3uPm0qNaiXbD6V9MFZD2ZygXNGLerBdLfLCqSzYvQekD9CPm1HiiiJq3vm1nMqBWZ+WL3ARtIV1v0yCtpPfKxmCLYj/UJA0L8otWWQHIK/vSpADwY536wJj5zFqTWOkmu77XFg6gTNbH43+yteqXWWYlvmcmBpljJHD0xqipocDhgHKzQ4y2bV3AASy6gufpC0s3TOmpQlW2mLRoAYhGG52iNpBJwhJG6+xDBCo4pg8ZdfVwplYf+XzuY+2zAi2gaGm59BoTh9bUNNdWnVkZWPG5RKa6Ssetw==;5:58cMeKRY/vG0CEgT32d02o8n6peG6UpA14ZDBaPvtYw78BGkQrYPNZi6/a0IsB1x66zvO3PPMABKbshLkYfzHMrgQo5t/ieOgc8qUvE+/3t2TDPNIfIn/I6zPEsnMcuoGEl+9dHFdfkNm+DE4FjFOpzzHdoupIHsqKIqpdf3WNU=;24:52ZH72eUOyiQynjLzClkGg11NIvQpITFH9HGpslh62uYmh2Cw9xAaW3qIR8K4Dg1Zb6Gcymx/1OWysbDEE+AhGWy9oLbawlylrhgjQwrMQA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:hv19IVJuWhuVMukTsAgXDsjo0HngsUtSNh4jIvGGRFNwLFG567NJcv53XLqbatDMNiHsI5DnGeDlr41P3YM6g7i3y/EYERwyDDb7dpm+fkwXn9N75rxTkHa8K+GCFKmqfjP4g0ikPtww6rPnVYEMUs6wZDI/mW5ci62r6TSnVXa1odxu99vo398pAtHvfxpbsbCC64YB3ud+aK4IX3Pjbf4KdSnBAVL7XXsH2dgmFFyzjlO688YDMjQkK6vePo7Z
X-MS-Office365-Filtering-Correlation-Id: 9063856e-1394-4b28-010e-08d5b9aa92a6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:19.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9063856e-1394-4b28-010e-08d5b9aa92a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-axxia.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 13f07482ec68..f70b097fd567 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -351,13 +351,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		 *   addr_2: addr[7:0]
 		 */
 		addr_1 = 0xF0 | ((msg->addr >> 7) & 0x06);
+		if (i2c_m_rd(msg))
+			addr_1 |= 1;	/* Set the R/nW bit of the address */
 		addr_2 = msg->addr & 0xFF;
 	} else {
 		/* 7-bit address
 		 *   addr_1: addr[6:0] | (R/nW)
 		 *   addr_2: dont care
 		 */
-		addr_1 = (msg->addr << 1) & 0xFF;
+		addr_1 = i2c_8bit_addr_from_msg(msg);
 		addr_2 = 0;
 	}
 
@@ -365,7 +367,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		/* I2C read transfer */
 		rx_xfer = i2c_m_recv_len(msg) ? I2C_SMBUS_BLOCK_MAX : msg->len;
 		tx_xfer = 0;
-		addr_1 |= 1;	/* Set the R/nW bit of the address */
 	} else {
 		/* I2C write transfer */
 		rx_xfer = 0;
-- 
2.11.0
