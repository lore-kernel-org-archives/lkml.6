Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeENOyU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:20 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:62484
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeENOyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:12 +0200
Message-Id: <20180514145330.4857-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:UybLdFGeceoN7uuZEold0WkP4t23G95rnRtOUjN5xy9O/6Shml+cm7EUFRAi0suyAnXSDsoQfusovWTluhkiqWnQoBcWbnFa0FYwahLWlZtUA5HvyKODm2HGdDC49NuYw5SjHF28/LrC02pm7etwuB0Xb/UEtQ0s5LuMZ6vssWWVQQt0BlAZ27POj90y7UhpyI4qlUWQcUSDRPipTo4EfZGcjzJXlC9W3crMpGM7PbrYJh3gH8tXy9bMI8giE7KO;25:Gh5zdVnS2VgQWL1lSFvqaBWiHNxlkSoqhygy+E0AlKw3h9WMY+pg14gAH8bo7wrCanDOx3CBZqIFu34T4fvp4olbZxkGqpYxLrPspJ+BZPQjvuNoqjJc19or+5ZMuawEM6xmXmvRF1NBEmP68gNv2ItHp5h0REp14f2YOt0eAraG/xj3zpYhVgBq2ptApPddlKhx7hn8NT2JTuqQIylvqyAi2hVSktRjf2/gd1caQXcz3awYkQa0QF3WVHbbFc7sSNNdQXfcOqOw+PYT9amsrnGUv42/aJiuQWqEaircoDHNKXSm7viIfIGf58I8IXQzxqBUk9cv4lhZ8xZRBNOmpg==;31:EW67W4uBFbrowU9QkL/pAofdccThJnps+uBhRzqXPtM8abLLTC16nvz2B5nJevLvEqCB7N4ZSSfDiuYq2eMdCPPvo+dHcSNgKNRxTZQ44elvv/hedZf3JsP7tYXpslL0po4NNzy0sRKfOEoQY6/+6i38IQAyzXzJErR1NhhMdgmVZgLat5NmCW5A/l5o4OYTHlryvJDEa1sWuXBIoqRRXKZfNAKITty7O5yJKqxOW4k=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278264AE903FB537BF6D7933BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:2BRi0+SO7yV82150EUl2aY7xMLlDlKliBVVwLrXKeUKXx/umSSZXbRI0FU2lWGH7nXaEp2j9OmGgA5lLylXbkqq4YUO9LGknUnT8k5kZkfeJOucZGU0tWtqdcyXsNkDO1sWobTMC3eEQMyFPUZT2avjeNAgpfElRL/gxRsh5Cgl3GyS0rzSy1rGFjCba7qT5MDc41d+v/qnj8RsG6iFsosIhNot8klzmP4t1EQKSCA6ZZLWAOy3PwYVn8IfesCnwzwC4ZzcExD8QXltds+cPeg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39830400003)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:3CTEFR5cYt9kJNQlcroAqCrqPbwkj2H1vUm8pqo?=
 =?us-ascii?Q?DAHLt4q8PO1/sb0ugwmYs/N8dm58dGPdkB600NstNXiTko80/HrNvVI4ZEH9?=
 =?us-ascii?Q?XpJ/jePxtC+/voFIDHStVTMT4kkfHsWacGiiFfYlKXFpxV8joF593DVDcCCc?=
 =?us-ascii?Q?yxgYfatzBL3e+RcQbsLBKo1EgYqrEg4KO2iwqb8VaKi+GtCmMsmcR14/LrA9?=
 =?us-ascii?Q?vTy8TV2E48C+fYJ2PnwxOpcY9w48oAzHIG65/jZuDPwO3ew/iIBLHTiPpr3Q?=
 =?us-ascii?Q?K1eNCzCRTprNrkvmRopeYomJrmgXmooraK065AsFCXPWyEAjFUGmzO0IYxh1?=
 =?us-ascii?Q?j3zjtarRHKtqASLDErS/MoD6WaxQ8ybv2cQLKqeYAcJYrNz16oxGGcueAqvu?=
 =?us-ascii?Q?Wnl1ktEC5iHtjsfEYDiF8wPsvwScL3QjUAPYNpB5bgycVS7bqxJr2N6sU0ZK?=
 =?us-ascii?Q?du81xJwtyFoohmGrGOfV22Qxbdbl0klbqIK91zMZmiYQTN0bO1N7y72V64Ab?=
 =?us-ascii?Q?9s/10SVvUnfxT7cO8SpdCc1wgUVbtpNZdeQxkYeItfyOKok0t/onDZ/UkQOq?=
 =?us-ascii?Q?Dc96btDWKbVfah9me1WEvzByhsDTkltFVHs9syX4BeroAaG9kd+zr0NlaDRz?=
 =?us-ascii?Q?hLeITueYaUWVMg2AIm+Goq0GkquEbJlZxTgr2ogeoQqJelvHxbBc+2cFUjE5?=
 =?us-ascii?Q?b9KJFaW+jo/jrbFd0YivgwWYwF6dI7WEXwV/bzecNYqI8K0kaDf4GMNaLzig?=
 =?us-ascii?Q?8jD7xCqUo/0Xrlb/fPDGuE5h4rkRwlqAFqTqgvA9r4ez4S//XbHt8fhoP79Q?=
 =?us-ascii?Q?4iC6uItETkH33rSY4WHvHCs5RbQp05UY1RcD/IxTIOTMonb6rbvDbVvGDVQt?=
 =?us-ascii?Q?WrNtPbgEQcXodeSSE5YrtsQPPzZAjns3EJcvBJSa2bvXTkuaDmiEOf8GGxqa?=
 =?us-ascii?Q?Qfflvn+YLCVJk3sfIja1WE3APt9t0E/K3dpSizZK0k4gXXXptsgKOBJ+kE9s?=
 =?us-ascii?Q?6823zBlNiQbiI4fWc4LI9Uq3iC8AItDLIPHItuhKYf4QqEGqEmqj5NocEgou?=
 =?us-ascii?Q?jgltsowPVIUCZdrHPytErE5fjDtYK+McmsVZkVW3m37F0IpKQO3kWeq7Kltn?=
 =?us-ascii?Q?vJzhyiHw3iLKBJkUdVq7X4WpFQL75aUsa4WhPKCvniib4KjnLOBOXPcElOur?=
 =?us-ascii?Q?fmby+KRwLe3kpusOAwBB/Hjqu8G6hnQtr3MlHwEdkIeyg0Qac6fYxCx5ZWHf?=
 =?us-ascii?Q?Z0rI5IXf5D0TCagHm37DyhYTTo5PZJv1EaW+wIVJEoNeNDKkGHWD47Yf0iek?=
 =?us-ascii?Q?ijPVT3o5W+rZ8OCAHgcykyWY=3D?=
X-Microsoft-Antispam-Message-Info: 3m4Kk0xcHOBa7RqMpYLViTG7u/k8qoE+X3oMnF4LCM/dSUy6VK0oJVBFL/IW2/1R8jt4dgVqC9jvB01NfNGia4FHI/+oS+NqyyKXwcGAx+9V0QOYECRRtRzao49vxymlZANbxnPXDhe5tmpgyLhXL5/MUVkyAIBECYbU9goN+DDURzbgTHkIW8Oq8+0ZSrmn
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:8SQOX8pwoxFao87qnfn3Ok8WDSGv+/8ORS6r1MlUPtdhooa/h5ZjaNJI/35b4qpgb8G7RIhxroXCzrcNAb2jeL1CKN9tUTZ3pmUiDotuXdSailWjoVKpqWMEvnxHUMsV9rQ1kQzt20nmTiEcy1bBYSwDalM73s3UJOZsaMXLtQSjEY3BXRf32Wf1Yn+rWCutBbToijup7yag/0TYvgbMv/C83adT4b9F/UzOLfSxteNECfM7EUXqb9tQjIoqf9zQ/aCg8HtbTWRwqZCTV8RjaLhVVRCre8+WlQn0J63O2PX3f5P0a53s7ZeIvfnuV9lTKDEXvH6Zn6ei+OoI3nNpzscweXx/nvQWVJikhS7CHN+pa3atHhtldksl77Vms+opxOLTqltiz8Or9dDHoIhhP/YOhZ3imeFgM2/BrsiTrSPf1x2DDxCQQMx4MMd2ssSSgSYc7/C97MtcUPBlHlBVNA==;5:Y75XOSo+cc0RoMPswoKq3syxDevDuqblo4XgP8pD1GRKkWH0Ex8/BMZyRmbmpd4ktEy4BDq7gqZICI7MKYp+pINW6Egkn1uaem4G/a4R4glRamvk+19wG+HF6gPTMPhcrpuyRks70I6X0Aaz/JcUTZcFw4M7Le1Sk8imw1ZUJiI=;24:cd2jW2vFo9WhO75LbFgcv/hvFLkX//UdDrtfsvFcPqm0MLZI+3SIA2hQOPEBuIa6szjZ3XWOTJXAp0vxvgHtjJwRQb/cIwSc6e8v97G7Fgc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:pitrE6+o3Yd2SCP0RnxeQTBkQUBxxsnJ5S+HDEbYf2ETxgUKEVyqyoIB1paEKG+B+8Vcco+Oqg+oWVFhQMBk6C/pR2sG+1pmtIKweOV1RYlY/1b3UzLzA9ZnoYumkKOy6u3dCDeNfs1jz7lrb0aN/z2aLkbvuU1OfW//PAQj7lcSBO3e1C9W1YQZsc8THU8rz5l871N9zps/5IqdwHrrcIWIyxVOCJNP4CfSVcL7CeB/zgPk3Kc+RgUdiogWuKeq
X-MS-Office365-Filtering-Correlation-Id: 9ad1f884-95ce-424b-c405-08d5b9aa8f5e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:14.0130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad1f884-95ce-424b-c405-08d5b9aa8f5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 270d84bfc2c6..bb60c1bd1f2d 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -292,11 +292,8 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned short flags = msg->flags;
-	unsigned char addr;
+	unsigned char addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = msg->addr << 1;
-	if (flags & I2C_M_RD)
-		addr |= 1;
 	if (flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
-- 
2.11.0
