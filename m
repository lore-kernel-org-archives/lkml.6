Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0418A20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iNcyBXxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0418A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeFTIyt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:54:49 -0400
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:30448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932677AbeFTIw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmp7UzsiXDgmOSHE6FdpiiBbadLNSIBQETZetrA6NoQ=;
 b=iNcyBXxr2Q9Fcd1t03opuf+p+dgyzfp4xBxbCnmD4LW8JN0Gf6zR0kdQ2HdvvI0khCHecuda48oB2+rdWrur4fWosEsb+26Ej/qPHM+ilGKnmlvFIwh9Zbb9eFqcWAxJQJI8nClJooZBn0YhUCKUCCh2XIOyByTCtBxEXRfLvsM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:23 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
Date:   Wed, 20 Jun 2018 10:51:54 +0200
Message-Id: <20180620085157.30121-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 1142936d-e804-403a-c145-08d5d68b24e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:DhjO/T+IPnJDBBFQ10002azKDg15zJV8y9c/TQjoZ3YYtqvL4tI+5knfVCZQ/eNIgHJi60+S8/0dv4llmpCzj9e37XqN+DuTItA44el1uM5KOPztwiOdRj1Hzdp0u67FoJepmOvXHZs057F9WWJ/BZOnsXlH9Nca8P3KLnskT+aYFzCTwO/5AzKiMZxr0pUyq4Ub75EFYJXi+/bboxahJ+INgCpq6uE1Pb9CZSuONwYiC+3CZ5lqeRWV9lfLkpvS;25:d0VfpJz9CwM0ZJd0UmXMXLp9bDlbi5kCBGXBAq4JYotngcjzMmriFvNtcUyP9Y14IfPEV4P5r4DVca8mw6xO6wHSvbgjU0hkcigmZ7m/6CESM43IM26HAa9hJxumZ6aG35nK4KlU8y4XEIVHcureHXBNCfbUdpRRgi+kailKOiPPYT3kU/XD3gOhgL7dB8oHilELbNLPtffkvwfgUwrHm+it9vXHcJ2E+8rMy9tct1pYc86n3DK7PhMMZoHmQPOqaORAhsMu2qnNEPcCDCldQmlqgfncrvtYhBjVpBxiizdqqgVxEKwteY7xAl/83vJsvY14W136s/M2mpZekhMtrg==;31:GZQLv3at93ILOrGpDUlYgBqcmvi0X+/WvbjDobFJ4psAzqcRu2t4TGKaqZOooX18zNbt44pfXFxbTw4dLJ2PRreeohdJfvNi6FhEjwWn1V24zmZ8XZAyvV2IEZ6mEAJ/Sqk10ZcbnoeQFlBYYPrKfliYSNCsmmfEmEt95xukYFxPD9vgSmT3IBTHL4f6uwv+/SoywvzM0OqAP/HDylV+soeG9ZE8C2IdrRI9LTlG/Uo=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464AAF5DE5732A33D101392BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:fpTWjbGgWn3cFA0aUozcMZ+EIGCsAmHOrWm/P/OummeJUAGTRsj/ekqQ5/W7OAXEXhUV6kdLd51tpfk+dTlfasRP7TvtH2mKn24JXaYN4AIQn6vhzVsqk3DEXqrM8w07gwCLt17OlfbPyvgLZFqekzhkB9MTKanL/bZwNjMx3II65hek3WcbZEApPhw/dO7syUiJVhi5NhohQpViEdELNo3LVnOXtXSQ6ifxFlnB/XtseKp2S/2ts/43ATsIifueddkfYuiCHRKU2czMHOjkCQ==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(39380400002)(346002)(376002)(366004)(189003)(199004)(48376002)(50466002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(81166006)(8936002)(86362001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(6506007)(76176011)(66066001)(476003)(486006)(446003)(11346002)(956004)(186003)(16526019)(70780200001)(133343001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:l8SWTv7XXq+DSyyB/VGAJKRwclj9KYG4y1+vYKX?=
 =?us-ascii?Q?711qTaIiokr9noiWb14iAzlh9u6rUYmXWLZXUUBTfd7Uz/7DegKBfTDil714?=
 =?us-ascii?Q?hwAiBxrzKemjEvECUk8iO+/dwd+E+yUgsr/bsHhDPez/8N5aGAlEL/bPCVWw?=
 =?us-ascii?Q?O6BbjrTdqRxq70NjeVR3MOTGuaSzoctRcDe5PZzr58DW1NmTjfTPxkx3qZvB?=
 =?us-ascii?Q?O8japBwdMpyKlKHuTtTr2bXfUM4UJuZEzcXmQH/f/ib5be0fzvrhmKywc6PA?=
 =?us-ascii?Q?lkp/OcYq3y27hhoKwzPvXnYxooQL3qpAfzryci04STjDuPrtSol7LtosDDc7?=
 =?us-ascii?Q?pX+7njiFrCC4SUcLAmumfFioEqZ2NX3sakTaj4kRwNoxnQj/H5DznzIhjvh7?=
 =?us-ascii?Q?dh7m0yx5jwoQ8QcqROQsW+5whd3UZZs0zxwsNFO8+Y4n8U2JZYZb/HMUx/rJ?=
 =?us-ascii?Q?z3uL3vpuekt/APQgz0VBbfTxb9Y6Pn3Fb5a65VzTmTfij/uvv//kQh2t0NR1?=
 =?us-ascii?Q?+tGaTLtM8+jDC9QV3u6zYgnojAqx0/7SuhIxfsudGs7dRwU3h8buQ+ausnd4?=
 =?us-ascii?Q?ZTb6JR4jvjbRdJL+cOByVP6NGCkC5fCSLW23GUAeM9vGSyVr9SZxdofn1W+R?=
 =?us-ascii?Q?yHeCmP/qDYuYO7i3hdB78lXTi3eCW1VSnR57Fthcf++4b51VGIPpcCQo4+Ho?=
 =?us-ascii?Q?hu7Sz+2YuAFruYn4LXzc2Zr9KPp9CDSs/IMaCHf0qKcxxWJHuqrOceA8Lr/p?=
 =?us-ascii?Q?MjnE479ryeTph1LXcb/CEZP7vWX2EEBIVqvT61UaTtaSFPF+RHDCq65IV5dm?=
 =?us-ascii?Q?0JJgXAiYGljqWCfNb0Lxw/mpfpmP09+38TXmOXJPMAWA+Fno9a7SBupHoGGt?=
 =?us-ascii?Q?fafJfkSTKcCisGb7VX4xYCGuVI38NYfYMiz39IFn02Nbcz5Hym3lr8HrOBAR?=
 =?us-ascii?Q?n8aVlyBTAcZxvjQg00K3laxC9pWH+Szx+MwWEVgeUqHoyGJR8wKkSdGvekf4?=
 =?us-ascii?Q?+za4Q5ZeYr4ElU/wmZNc1mH8lVApHLzFQZQKyNyGgQIF0Y+xEY93k8jqx8HI?=
 =?us-ascii?Q?UDlJWxsUA+9pcO+81hB2wjyn5WGSdSuhZdamk50tNxr0YuhYPyoQ33Lgkphh?=
 =?us-ascii?Q?YHofd6tMdfRExlL78MXnrSZvEQGQs6m643BpD7zFfQCcH9E+bYJCAnWR2csO?=
 =?us-ascii?Q?ABNdEab9idcW9taOJ7xHZD6I7+Bkwmel/aYfTdRgaYuwMu3pUpCkPlbfv9+s?=
 =?us-ascii?Q?+g/2o8M3ZvTmFO3wcaerzA70rb257GnEornTBLPC5OtmlPMCUUbd6bAW4Fmb?=
 =?us-ascii?Q?Uf1S/SolDsT02duWAEEEPCSonze57aekQH7i8LlxA4XinownUaGRCSykeIDd?=
 =?us-ascii?Q?4Z9wp3ke9CBGRI4JQ4UKtbF3BwQnmFhwL9nFqxZHsuqSAHRLk?=
X-Microsoft-Antispam-Message-Info: z8EXYhF98CYEHgFgqLnl1WEGzy9poLRFnZuVKR+N+ahTgAbRxN9KGn2JGMEdCv395GyaNTfy4Lveuw45sto4i1Jh0/ezFxiO8G/iYnJQCnAYTrslVasktDXO83IgfDETmUbEguFwzq/qpj1cA84guNMATjNusShZLJY225aRDEvmMXcgwqg3dBscRB7l1elPmkSrB3hKUjpRASEJGPGJMZuRmXObrnTX5XAIMbkWueW7pchd0HJxvlCUd2vbJKJKy4Z+6GT6NbcyBzmJOjxk6CtMIrKhcoUizy139erMjshxmOTc+HgXwgvnlRaRc9iqx8VXinfLdQhZOn4Gjps3Ag==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:6Wx/TiL/8Jjdv45PmkpFuKTeDsUz/16Api1FJKg9mjUrwm323j/3u2Obh/jK1oCJ74faEYC41cpA9CcuCrEK4ob4SbB48rm1DbWcIH6ebpYvQJUIMXMbJz+860pCS2yQMXp3W0MQ6jflne3Ij+4Ny1xOnmpMyY0pCO4ZZoLEKP2QXnyf/gynBwsBHvsppxFgpWA9uK4q0aDW0kUPaoxzpMkPqzmET6pkPZskG/+UeoOVv7kJZSr1cBtrZxPHdijooNyEGKlBi2PK8zn5WN1jzvtPBdrwcHKB8RzRxDpnmLOou5JjjBD9ghay8Z/PJlQYD7XTNxtYzfIeqAq8XwNHS2mqcyoQx7wykJTbPHfa4rZCNoIkcs8ohoFehpQG+NlegXjW0/M6nCgBZwiThtUc1+aadL5M/hxRSkdiqS2Q/iZci7BF+GMzllfrSX7esLQt9y3t5e2o5lyYObxxDPOEKg==;5:CGEwRcYTBhguqsmnPlFwEh2Q3MB2OD9V6oY29XCr88m/0EIDbYEVyJihVNKhw1uBq6XtaawvIZsQOqPSWz4Yx1VQtlqid5X3cr0IGd9ffFqgFyQiay5YlbxI/28ckBk07WC51Mj6C4DHFC82zOtLjd3F7LBrirve9G5+ZhrSgP4=;24:y2pIWMUnBN/m/U8L1+G6ZRQzpcRLR48OUPaNyxbpi5rk+TB62sQt4BEUTkTxaQ67WPThVDi+4y3Qud1SUcjtdkLTcX7m2Nby0o8cJTScTFU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:PogihxXiISSVNK5DhoP4als9DJULMJmR1ASzOhWxi3htwqvmVZc9sn6po4UDLT98EeXfNrNyGNJrjAK4jSkJbNznRfTTODasxGKUB4AKAoy+swvNGZXBtYXJTGZbuUiZzfAOJFO70r/TxxP8bGu/uqCVDilDXUhFA2OTfCHc2mYaKd9HBMtbENRq8vlnsU6bkKL020LP/GzDJzfp0O0qfuhv1jH5xHNK3+HGe+tA25i8PupV8x3XvI+KsjPvaZeg
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:23.7946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1142936d-e804-403a-c145-08d5d68b24e7
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
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index 12ad8d65faf6..f2bf3e57ed67 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -94,31 +94,11 @@ static int mlxcpld_mux_reg_write(struct i2c_adapter *adap,
 				 struct i2c_client *client, u8 val)
 {
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
-	int ret = -ENODEV;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		u8 msgbuf[] = {pdata->sel_reg_addr, val};
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 2;
-		msg.buf = msgbuf;
-		ret = __i2c_transfer(adap, &msg, 1);
-
-		if (ret >= 0 && ret != 1)
-			ret = -EREMOTEIO;
-	} else if (adap->algo->smbus_xfer) {
-		union i2c_smbus_data data;
-
-		data.byte = val;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags, I2C_SMBUS_WRITE,
-					     pdata->sel_reg_addr,
-					     I2C_SMBUS_BYTE_DATA, &data);
-	}
+	union i2c_smbus_data data = { .byte = val };
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, pdata->sel_reg_addr,
+				I2C_SMBUS_BYTE_DATA, &data);
 }
 
 static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
-- 
2.11.0

