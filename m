Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D353C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B170820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PpUEe+Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B170820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeFTIxT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:53:19 -0400
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com ([104.47.1.139]:2477
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932402AbeFTIwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB3ZCTt8qVAAXIGw4u2VY3Ii8LCPiHA7euLNjaY/znQ=;
 b=PpUEe+QyFUA9Kh47UQ3P/M2oUhvKRGcPfuih3+tG5c7lyA7T+hXMge4lLNVgqWxSukNAOapeL5ZhZ5kkZkoe48nBD8QNOEm/FuD5GaFIV+wYlilZpuUrToEF9TD+139bV2LEMzmdHmqsvwaaR+rSMg6Xmfg0pMkmf8drfz62BsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:33 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 4/5] i2c: mux: pca954x: make use of __i2c_smbus_xfer
Date:   Wed, 20 Jun 2018 10:51:56 +0200
Message-Id: <20180620085157.30121-5-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 6c5c4f27-9822-4127-5bbb-08d5d68b2acf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:lDe7uaUmjsdLUtrG3WKkaPXsy8PErqpzi1DkU1xAp+AaVXc1K6x69iV/K/xtksrhMwwTDwGritP8NNpv7envc0t3KTDp+ho7jB4zeUHSw0EIm5KnecFL5PfG9fE1X7oW9ui0z/uIGrr+z9BBwJ95SgNyddODPEnqoY2GwehiSb4Xj+iyrEa7qV3NdeP5fwn8L+A17F2c+2erjz1ZwIqV3tOL1U1pRSmvSbQdUgWkZFKkJLnvHnkakRfkAESd0+Vs;25:mDq/Inv/gXbZDCV8Ek/fqHfrZVQ47HSxDmegUkQXxPt26x0vj2GfRx/fJi1iD9JMGYJE7/PCLAE7mwtDl9lXgisuGYn8rXNwDOFJhpDK4XgiVrz2eATOQLPvwYCj7Gt+M+Ib176eN+U5irTyPY25fGoeSHcWNGVlE6fVl9blNXzsbxoerdg9kcFpmR2CZlUo5U3eJGeayQ0ONQvCBQH/GkVTWVQcUf9YzRsHn9r3Yq9Up2h6gLiYrkpDI0z4hriBXszli3AZlqy2ZPscKDoEckM8DFxbcH2hK40TQBK8NncMhFt+jCZFlwx0A6WTDtYFuvzS7zPykWwhG5CYHlTNyw==;31:9ehGDcg7kvFeOzs4bk1lOd7+XqaI5k+oc3pvI1k4EHd9q7Fvr8XzPJ3P+lPaJe4s17N8ofuWK583xqueYtq1guVdXgOqSUzJxHs54sGB9Ws39tHCMfrG+VhCtPc14v2C1vlI50ZacqwzoOepvYFnBLIKeLy91WmpFnVtyRi2G1d7kriEo0c+BqFEAQRZ1C0dace7oAx57O2gtBpjTf8m1CJEejbcl3BOo6CDz2LE0P8=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246481D82C17F54BDC9F9F7ABC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:Gex9bfDUT1cgYMPrtwLVNTspm1c5x9hpxdIOwBMqENfUiXj/qZUw5xwVkGLks4JL7/Thelc9NLCtSrQONTg/qNfGdaAKeO90tC2A58t0PALWdAMEdEOsfx44aOtps87Fr3VYqQmSrQMSUB67REWr38CPNFYRXVBHc/mWlk9ybeNFBzueVQbZIuj9froS91XM4cp4tVpNyi6fmo/2YSqA7EETyry3s8rYCijHQvHgbyljefTN957hxc2Vdj6UktQlHiQ8n8B/jY4c9t8mB18B1Q==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(48376002)(50466002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(81166006)(8936002)(86362001)(575784001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(6506007)(76176011)(66066001)(476003)(486006)(446003)(11346002)(956004)(186003)(16526019)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:mfYR6cH13e0l6crp9H12T5Enz7MGF1thEfGp4om?=
 =?us-ascii?Q?j+rcY564VvYYTbt5Wi8nMTMRX+tgTya6jyUgxHLefAzlBK1f5rrkJ9sU81p8?=
 =?us-ascii?Q?6U6e58v6O3PCNR+6OO6f6W2ZUOrnlWIxtlD2Zx9MLoEBjB5PlYICltJGxeOz?=
 =?us-ascii?Q?0y/r9qu0Y3vv+Z2YKwpZdxFpRuAmfiZ2n9c/JJKxXetc8x0IILu0+k+PAIdk?=
 =?us-ascii?Q?0EBiJR22UxGKJUDJc/xpvEfGsR0y3UDHe9XtLliysoW817Ivka2126O7c+zQ?=
 =?us-ascii?Q?TX97HOuGqidw4Y3npeh+aek0L+ZPVDmk7GTQ7MDP5LJjpbtaJiNDXqA7NW6p?=
 =?us-ascii?Q?hRbeUL0gy1TfOCans9O6yAxGFSk9o95V56ZRbTHlA+Uvru7d07JoSysSRAQ2?=
 =?us-ascii?Q?mmTjDHbI+vguAeyxHNfngog0nUbrnWPq9R+yMT/DYRagLZ669Xxou205tccj?=
 =?us-ascii?Q?QoMek0s2anhCdGhluI80K/3CNsXUOY0k3jhzuqicz6U1LLzCKvHTBlZ6tj+Z?=
 =?us-ascii?Q?LqMiDoeyhzGS/U6bZUvZmWBCTXuwJwEk/Us/Q16Ys+6WDALFBSe7VnKms+X/?=
 =?us-ascii?Q?y9PvBgDpTjUCwCDhorBNY9xLiCPdyX/HqvrkWoPwYBLLdN29dKnYsH/POvke?=
 =?us-ascii?Q?L+YpPQs0Z6XKKpjvjA1LzMYs/GI8Ihh7ZsLz5tiSHiTMQ1EtHv9xSIqH1RuP?=
 =?us-ascii?Q?TrxI77T03XF9qQXYWho39LvehaKqzs8J5C/AwDjMEYN/t7C6HURHLZ9RhR2o?=
 =?us-ascii?Q?pWnENU+OxCwCFCTKAY+m2F8iDl+eiOmPrEu6OBawcX9dARJ5zrnYJ2bBVIrX?=
 =?us-ascii?Q?yixI4OEbcTtYaOVoSy7CyzMzrgY+AtCAhmTs5xVcEaPTkSwNWmciV93NRU46?=
 =?us-ascii?Q?rya4YEgh5J08ESbyNkcwXqTHPNt0SN/lPIex1SwGY4NAp6aWg3VZAKtwqrEm?=
 =?us-ascii?Q?hiF1NNp890hkRVQPRFPzAAFIN123DTbC6jeHDfJVvgdsR/lJnTyxYN+1t+Sw?=
 =?us-ascii?Q?NL8O+Ox/dhfsNimt/10dGw/ryQt+0HPZQDIcDP0pVF0ypQBUV8yKNNL25FIt?=
 =?us-ascii?Q?PDuB1VYDhY3PzeuuqOnikg0qPnImoyZEmdDrsigzj0fsv0wyDp9ySL+DjHtZ?=
 =?us-ascii?Q?a7wLNNopXiVtgfCwy22VOK5F40NDsrdVeA6oWKyj86Zuu7iTtjdb1B+xIKNJ?=
 =?us-ascii?Q?ke5eF4E+vTN2XJpvatGHXc1qCzgk3VCsLr99mPHgusjz7KVJX6OZIZ55K0Q6?=
 =?us-ascii?Q?D1mSDN1x54K/ePVwoCn6zSOdn/nQYbmukL2lD1rLFhoPO8MBbLMOELfs/PLq?=
 =?us-ascii?Q?xs3tUjUCx7Z2bX6llUVxcRJeKpiqjoOz56FeLxGlt9418efw36LcMxTow5Rz?=
 =?us-ascii?Q?xuKNHU89A+3xNgO85aimcE25zWs89//F2jkFLglv+doB+PcMT?=
X-Microsoft-Antispam-Message-Info: BjkF38UfZB+8TWYYhI83ehKIJQXeh8YRSSHHfbeuvve5Hw0zOPUqS5jAe2uhE0eCZX7n0rxrVbTaOCtoas9W0caIy9vR/uDzGSH/U0ZGkffkmSVEQhz1kZ/CW1au5/OxQevYvfOnJoOSB2rWMlZ6OZGaNJsQ+u1NR/b/zdU/1hkSOLse8MBBhTFxRqap5+CIdLP8H2/mA3ujP210pL2JKxGNi2hlJZQOX1K5TqWRr0PhEJksIyRmGRARaVlCcBSjwIes3q5YRYYbxaY4IPwIgiHApGMMHkdhhthzGugJOlt1hojVcMFdOanFGLmC5YL8
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:+jZpg6pbuQuZ/Hffm9y0mIlfHpgK8hnCdKzt1lmpd5COSQb48z8whqpQ6EOpKCuFeO0hyhhyVyhZit2ngOifuo71H+l0g3hGipFNemQ7x8f3Oe+vPtm+0iYyLf9JTvKxxRDjPs0vtMiSDj9mnXDmlWYB+PcyPTYrArCHS1DAvg6QGM3G7PcYx58U75Pd+v3XEA/b1uHD8nQWkauN/L5IcLduQ3di/qo+n0pMHstxUW0F6r0hwvbdUAl/MaKtQyqJaDAPZ5KUamjL5F4sMYBxtMkfHmG9P/oOInBYLH7xrUnm72i+s15YAyWiT47DiNVW/gY7J/5zi6+/Urp4+7MI27JQEh2F072idmfy8PV5SvC4ec51D+aGRRHZxDvlVr8etHymnXwvEQv8hvg5AEilyFkuN+wdW5nBfHRONAuYgg0b4b7w+igm8yQf39nVepzWUQisMOz/Ap39rhyxJCljbA==;5:/C8ytcFAqiJN2O6wkyeg4iEgFT1In4j03C4CogdkYJpudmuFF7KWTO8WKJgJCSqQSxFEhDIvuZrzCLpWTPpETDgBIrxIHQRx1UGEqEyj9IgjG7lsLT7gNt49v6y/BtaMoOCKG350CrqAjcBe/H0YpscVTbIOs+4WubddP7cZz7U=;24:qgUYSO1FiBIFlTcUqKLFzUKyETwS1jo3kaorap3gwBI3q4bZe6dp4wnBOs719DZgdRic+EQn/bxxjy2aOMCm+78Z6DuV11nJ7Bk1+3La/1k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:mZgg9A2z1qrxTlonZL7phsxJWOfbbeTBnqjQe6c6/FKpmFRD9ZXYZCItAwarMyfC1BiREB2TvyoyLn7ODBSa+gKS/cUs2Bu+maJM7slQSKaC27tEcuS2+0m392ju/RXlVdaG2N0pni2z/Zfx4MZtzvESEtvY3fVjKhGjlTuujHofizeIk8KBS71JFFNGS7zIrkoUDUK67hxkwvHum51+0YTB9AIXSa3z6wTlPELihBh+USy2uJ0iiFwuVqeLLiBW
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:33.5292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5c4f27-9822-4127-5bbb-08d5d68b2acf
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
 drivers/i2c/muxes/i2c-mux-pca954x.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbc748027087..0e9a0e66e92f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -220,30 +220,11 @@ MODULE_DEVICE_TABLE(of, pca954x_of_match);
 static int pca954x_reg_write(struct i2c_adapter *adap,
 			     struct i2c_client *client, u8 val)
 {
-	int ret = -ENODEV;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		char buf[1];
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 1;
-		buf[0] = val;
-		msg.buf = buf;
-		ret = __i2c_transfer(adap, &msg, 1);
-
-		if (ret >= 0 && ret != 1)
-			ret = -EREMOTEIO;
-	} else {
-		union i2c_smbus_data data;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_WRITE,
-					     val, I2C_SMBUS_BYTE, &data);
-	}
+	union i2c_smbus_data dummy;
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, val,
+				I2C_SMBUS_BYTE, &dummy);
 }
 
 static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
-- 
2.11.0

