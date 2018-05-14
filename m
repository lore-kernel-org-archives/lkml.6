Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeENOyd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:33 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com ([40.107.2.133]:45712
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754001AbeENOy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 07/21] i2c: efm32: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:16 +0200
Message-Id: <20180514145330.4857-8-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:qw9zN3uG/6lOvtIEKT1aXWmKoyAiNQXRI59fHNK6mJmPuGjyO2MBJRVzLHK1BXeJS0D+dj1TnEs9hlsNNn99WcA1lRsolAzPyp2XWPoNP6ZBaS03RzvdWo9c+LDhSnBNIlqxNLDPOyp7bOpqQjoWKPbRBDTchltAn6eyztvtdSBZOy6qh+/Ok11qryNN3MenpaS7/8v0sDSl9LZ+Bp61c/Bh+mjud8suelFzET9Fr33AriOzbwdgXtFMJzRN/WGN;25:gcf9sL8uj2UqpBrbkO0eMJVkTarhm1UAptDDeCtA0HJMu7u20MyD0ZJmw9i0Y6ZZDVo3ugQm7YvVrXVTThR+cgg64uNkPGw0nr/EeTf6XRwJvcVo1sfb6qcvck1/8oTyRgKHEayh0R2PVthS6mnOdCAZvEbRUfu8UJO130VfguDN+Mqv5nbudgMduDN5tXiaFzGCT3dEknxTHtu9v7bryPPTxXnqv1fFea9gkMpkasiWkWmtQXmEkve6D3Azs47yLdeuNaiNeMuNEbukqSWd39NGdoaNgnX44LkEgIFJQ0zvo3ylw9NJrlRpkGt2XhCRSCsCN5OzAIpjWidRe5zsew==;31:OHoLPv7IcZCPs4v+k52BYutYYa/RUSkj6IaQfVEHe7+y9fZpp8vne61NO/wyzrmaKqYJxn00KdweGywDa+1SHEvVDOCqRX2mq6HpvFPlRqAcqk5RsJwNkuY/h/ZxDuUkvMbCXQVLHYBiWvKO00kuPPwaSdjg9Fk4YcPibaZHC1zGnavDybmsgTb8dXDth+LoQqo4JQE2mQwiiRc2sjkG3dwuuad75d/GKWRBM4GjR7c=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27821E22092350026AED9E50BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Zs0IgjazGSgAnw1QfQBJNspLgO6HKTQsO22M/JUTOivh3wXpbbIHT1KMrWIp/oOTD/0NmArws2DDy0573xh7aEkTyka3UwNl/Dob8td8hjePczlIV471N+IJvdwlYhU2KqWuuWY1lDg/TxFGpyoWK483ZhHuOcXWHOPSgJN7d8wJYCOU4b62RiW9+rchSr04dvc1XGMnYaH/v0TbEwr9Cgisp/eZ2LxVgYEYdpAHCEPlegi6lyimXp1NzTiKUrRgpkuk2B8heJDdwzXSE5lxJQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:yTilnvqr68a3w7ayI6091srFI7Q7tJ/ZbFAa/aK?=
 =?us-ascii?Q?VFs9bEBmVD/2yPuRuEA8Ha/1gWwoMeDixZDXOBC9Sm0nnL8Attix49NmtHYG?=
 =?us-ascii?Q?by32+zVM4wTidf9Of4hBM5WB80SdxSmBvLNYrlp42+QJSweM6opooD2aj5EJ?=
 =?us-ascii?Q?hf9BNNMmuYpWW/yjODpdH3hdUnigx9rvfY7su2LBIz5yXGACsXA3uCY+wtlD?=
 =?us-ascii?Q?Sza9CnJjKIhWGDjM+v/NqigZZoryIwbdZe03kbk5g0BzOEysE/Wo/ZkFKN/U?=
 =?us-ascii?Q?mCczh2pG1BpWnqYyFE/Y2PKINbhBUHbCbvOjNbND+o3waoDcvheptKNi7GhF?=
 =?us-ascii?Q?K9YWsyeKuOkr4Vr6PXr1nCML5dW7D30/spXjaiffq2t+mYoWEe9wl7cuCIg7?=
 =?us-ascii?Q?ctzVdMtJ1nBdxvD7PeTzTtkkLJxZyrYI/D/96D2jqUB7jkBPkKBPFDIFqRev?=
 =?us-ascii?Q?pjQbPRWL1w+ZGaS/Odz0uZXAM237/twHHHhfxwtC2ncNlW5kNQfjMBLdhGWJ?=
 =?us-ascii?Q?hLLE+SxCoTDrxQ5YZ4aO3m/FpfaHH86uWdI13HqviAC7ZeKMBFUJ+cf5Jb5K?=
 =?us-ascii?Q?dRNLD9cnxrEKn1cz/OgmdUVRTpqtvuw21oydWfQLw+41Ug0AIlwBSHMl12ec?=
 =?us-ascii?Q?OjTFwF/m9/26rYUBeJRiVhbx7qyr9bPhvuBWQvNq0Yl03KmEeoWaOB1lPpzw?=
 =?us-ascii?Q?FMP0qWRspcPKQTHvAlu44LlbLwkdkCA4q6cDARWslV96PDEzx4JuTZou46Nj?=
 =?us-ascii?Q?nCg2uu4IuJU/fYvlFz9y9CjB/YZMnbsDRRcc6XeTPqatz5BZ7RUE1wOKp6Wq?=
 =?us-ascii?Q?+ay+7npg71N+DsUYYbw3KHTMQCPQiSvvGrRqa23UtNWWoahQ2LP7QfzI6fRD?=
 =?us-ascii?Q?liuuUY+nQ9LWc1+WsH7RWRG9HNyna5hE4tR29UNTVAJ7dGY+PcyTuY5+1MHg?=
 =?us-ascii?Q?i5EM2et82Y0zaDvz/L9KovOz06bA3yC+8f2ZSxb4UyUtGBQU39ekX7uRgr63?=
 =?us-ascii?Q?4OFbLRKFLNWo/j0XGYn+kSodMy8BQJZmMczJQYzPx36Uhql/pNUgfFhGm1J3?=
 =?us-ascii?Q?rIBWg/muPFW6m9ou28wQnWrYDbTOTtozP4rDoKpYGp0GIJbmB8wYrsdjk6LK?=
 =?us-ascii?Q?d4YXB33ggSTqjB4mkeg+rp8zWIUQOwzRdCgplIFbeePPECXJR5HP/8GCsEJI?=
 =?us-ascii?Q?9Ow6DOYqfgCtCyAKavoyjtAJOeiHAiMv3JlIqwNu0jj/D/CVcOPhqu1kiV8n?=
 =?us-ascii?Q?w+E1P4flvM1tMAqy0+9PR+7F3nQeFwZ+J8khq5VXLKHH9nrIPJvR7JYYCkXO?=
 =?us-ascii?Q?LRvI4JoFvlwtZQKX3dV/P24z76vDKF0aFt2mk9vKm93uI?=
X-Microsoft-Antispam-Message-Info: rgB4rWaLqo16+Yl5LtiR2Qf+IKMQnSQDhgqWQse3heDYd7rppj6pW0pt2zQmv8kjROBeFiDeImiBa2kSI/8HgRniCZW4SIigdBb8VulPpKJIH1lHVyEtm7Et7DENzCwqxeGBOve5FBu/suoqkwifkRa9rhl+6i0NTRRlk+PeZ+R0dgFCit0D4b4F6XizFGiT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:ys0IApEbhwoZr2FtCmbJTJYbfG0isEE/CiAAdAZ9V7/+eqHC6xVl2XqAxiQVPy0hUuaQlO8rmrLZT5x0iW0jcsqlmUGqPbBQsfy1k6ZWt3pT5TgwGitPhhV6sxZJn7RcHPvQDCYCjhfys2BwSZQQAC4SuBtOp9uQT/BvEH7oOmIdLsRq/szdB8iHj8vV8KHGjrGr2BixpQNOPYvE4zC68w3LhkqIsI4fmsO3mOUXEaI7HquOsYbq8MXWBpvSKZ8p+r3cWRDeMPWdoDNGBxTukZEtGR8GWbw4Imefb2ua8ysDcwyzVxnkKNqR3JXnxwXQT059T+F4yOqpSeOm0evZNxgsWFTNGZ5PqJX7OvXDrsvKvRpxQ8ekUV3+62soxeXKEtz6VLTd4IZ3sryazj6h7AJEyknIeZTavvL/XZiEG2JlTyP5UeXnZLbI1JUjKCporg7mkywg7VbsnJzlWTmNsQ==;5:l8eswdc0LrRfdcDaXYboCpXvNoKMhfac+65ELGeTj6I8nit5CDaHvn6z9SLqbAavlntHb2anRdPR+LtNdKnFhQP0xXPEclKJuLO9l/QMap/sEj+VdcmXwhJd19t5I8Q8CaMwaBcnK66lrtQHJXpS9YXHL7JAvMGslsU008FMHS8=;24:AdnI6tPxyHFk66ADEi8Pl3nJyVfaTRetFPIzrVudF4d+x0zb4stxSoDfaKiVOxwV8L7CPOzg2c9EmCDtwLv4WiXDB35bWbj2I809LUtHi5g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:yluhiEPZJwK/Iv2zGGgInoX6/zxaXmFslf780wwU3S+5a0ewSE8LrEeeGUm8aPPyZTLszP8YJgGTKBGtgGd7RxwusWH0/JHBreP4D4dSlCkMFRBd5+eWZzc0rWV8+fwLdgJ9BK+kQfX31jBECZ9H18jvsCxFYfhDDQ1l+3MiLA6ARnptEE7pzuL9vacqgDY+rZ3kTgTTrgfdHTkL5gr4MV5GV9mkHD+vFpINThi0pl6Omt729nFWovCJBAeeLLDr
X-MS-Office365-Filtering-Correlation-Id: e189116c-8f41-49d8-6260-08d5b9aa9632
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:25.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e189116c-8f41-49d8-6260-08d5b9aa9632
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-efm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index aa336ba89aa3..5f2bab878b2c 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -144,8 +144,7 @@ static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
 	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
 
 	efm32_i2c_write32(ddata, REG_CMD, REG_CMD_START);
-	efm32_i2c_write32(ddata, REG_TXDATA, cur_msg->addr << 1 |
-			(cur_msg->flags & I2C_M_RD ? 1 : 0));
+	efm32_i2c_write32(ddata, REG_TXDATA, i2c_8bit_addr_from_msg(cur_msg));
 }
 
 static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
-- 
2.11.0
