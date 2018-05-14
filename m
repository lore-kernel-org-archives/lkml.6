Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeENOym (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:42 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:36671
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754001AbeENOyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 10/21] i2c: hix5hd2: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:19 +0200
Message-Id: <20180514145330.4857-11-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:lylTEIFpxS5DV+eRGqV1oIVwYThM4btB77k+Wh5cJG4iLvFlxcMViAe7TgnyAPJuqPkmmE7B3GfGpPNrlDaacmJPfxO/SMCq/jS1F10vAmPtCwSaZnXProssyOSN2BlUJfDuk8HOSUBi+1Tjjd6/ck/lp4Nh8dSdi48ER7Z8wHUxLoj0KomLNusTEVHL1CEGfnHwXV7dlGsLVbuqIbcWqsLr4oexkZ65zEbnEQ1pZyJAO6xPghbAHehN46kPX1HH;25:TIY6NNVhPRpMupvpBw1iK4jGRzL3Apu7CO0MyyXH0fMYltfp8MNu+TnYAJIFAFNheq8LswpGKKDrSmHDlC6amQWr9gC103q+X4zd1me6hiL47VHUW8QKvoeNIGZ3mgjWx0rQb9bltgonJF/hd2b1h4LeEHUuWYfBAcKpCW+JO35rHW16LqNH4tc7yMYXEdvyVIvXSRyldgCTF0gGAK7LjNX7zD3zA+qoyZx5xwUaIyyguJ/4fqaEKlCUAcNKUZ/vNKtlW4AHYPZYNc/ZNh9mD/91queqK3bDSHgILS0J6hDa2cojqzsd4u9d9Kk0vBAnjweI2UAY0mJKzG08d4zBvw==;31:/2BtuP8HPHvIA/yNjl6ChgtVKRkK+5XIn7lbBDa49cpFkH/9W+B5SSHxMthNyHFXZgLhZGA/rnBU36/fa25YJTrR3GP7o43WBGCw846LifQFWOVOlpsmrGhgyLvZJmz4NGqM6IAuX9+VDF6gy1bJ73SiSzFoomX9dTf+XMNO46BXCKCNkdkAnA8S05u2ypE6mYav9dd5Ik3GsW2B58Jv+tRKlpoSpu6QdGGeGeNRWyc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27827F15F974EF8EA452E106BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:5rgPYLY75W4nYqpr9DhL7hDWTBBHiBr6T9/oH4U/72JWjwDcKvTtw7af//fjdd2qB5VZmeg4gNeyz+vFLNYzpadulVl2a5clk5JJhfm6lWTg6B2rlt10gyIQ1lQRW2xazW7Z0snSvbPotCjruicudpLDo2ym0RT7v/nilu2X8d3iZwENMxmgC7arZz01dVBqCHcgUR3MirciRNbnEQeyFyp675TzDEx7s0epd5Uhgfwigl0cAbgzZP7CGoZSaAgCQOIWzOfL6mH+88VdCvLXDQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:T3atwzAQHak0eUZwWHcHmDW8TA/RDhFPwgUNZtW?=
 =?us-ascii?Q?eM+1zAAXfFV5PJFTeefkgDlfBkLwyjui/XSqMntklepnDysOaF7jOSXpBQAG?=
 =?us-ascii?Q?ePSCynIOpeXcSudcSn6EpxO025r/GkiBPmjWeKfDnYf6TopHuGnmIAvZE1uD?=
 =?us-ascii?Q?dGyrcRhoeu4ESGkVzCmeadYjUJbma8Fc0TV6CkhKBNYmQLREl+CQ+AAN/fXj?=
 =?us-ascii?Q?mY94aXnYc/2LasCOMJ4pW9PE3hXyv4HKSqStZLccXCClxGk3BLIE72X5hOUg?=
 =?us-ascii?Q?Dbx//loU4YuqE6MFacusUALzcNEcANg2UI73o9RHGQQpBoYqqHkYQ5OglPri?=
 =?us-ascii?Q?KxbM2FHeUe5Whh/UHFktYjpSXShjxOr2ODXC4IZIufpIDQkbpEKGyRgq6CGk?=
 =?us-ascii?Q?aOj6VKR37vqPdSAiRPhqiBtM0rgkJAVD8O7U5evyNUOxi8MfD82fxEK7bYx/?=
 =?us-ascii?Q?RphgZBLPSNuQqM8iAtuRU+Idssxo6+Vx1ij5x1NF8Bj+ULWdC8zgMjSKLMFY?=
 =?us-ascii?Q?OMKdp9/lf1o4xDljdBvL/te6+AF+phAARxWaTz9J/Apt+rWWvyiE8zL1Hds5?=
 =?us-ascii?Q?OOJwU+UzTni6LolyPamBlOfA4IlVXtAv9zzkvp6ZFyA2ybOoiKJASmS2f6Nw?=
 =?us-ascii?Q?HZamxtKKyR/VjAI07Om3lLYpFwXGG3RwcBu7B5qQHZrn9JrS/Hz+Rtvcg0SE?=
 =?us-ascii?Q?18ZJuCtJ0Wi7s8pB52FNAg8aWE0bDMvMt3valGQbjGk5J+D1gz2IJarmFFsv?=
 =?us-ascii?Q?o9R1PdMezFq3HgJe7Alaudq+zascSfV6/1c0HGh9kN9A3W81h/qSG3m1ABFE?=
 =?us-ascii?Q?4M+HPeJFG/i1rymf0Opt8ZjTik7GqL/cxNA/kKxguU16Svdl+lTMB9K6rAln?=
 =?us-ascii?Q?EF+eef1/qYZ4FVZfVsH24SPBR8+hb7wLamiFGrV+fGBmnWWCWlNmQWpJoEq/?=
 =?us-ascii?Q?5WHNExWU1pZBxyoWs1HT7vaKuLmKoSHkCITlHy/0OD/DvUyXNVLFxjn2BRhA?=
 =?us-ascii?Q?yPd85OM8s5Q4yujiGCfDYXS5gbijErBfkdmRgujtw4VC8CBlUWAZffkSx6Dd?=
 =?us-ascii?Q?QdrvLtD+hIq5XpYVjLkwAcsBXO+VI3J+crS/7ODxuprzmzef7q8HimTN1gJV?=
 =?us-ascii?Q?8donG2TQKs1Daw3GcIF1UUUkC/SHzXjPapzWJ5ibYmSANSw5t+PKYZGkbbzJ?=
 =?us-ascii?Q?LPRDs8kt2z3tITVEgskrGOIPIhXtB2SIdYmQmhO3/vORVLWqywWImo+0/VVm?=
 =?us-ascii?Q?PuTljXmNU0kDrn+0vtlh7iOqa9O+y6kiVvNLL3vxnkHIEkPl+at0IHpy1I5i?=
 =?us-ascii?Q?DP9Z9LvTok5pSTHCivnetyFjYP6LhlFwyBcpVVr/R/uVODIpgNkx8a2ZuvOB?=
 =?us-ascii?Q?xfNv2lg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0butQ/DBcnDKG41Yjt6czSh7Dzzn5bZ4815fdCYdfetRGrHURUXT4hzOeKKE8b+HGKDVigivqxsIdga0a6uMn/Wu27DGsEoKR7FkZ+Y12GyagYskVmaGHkUFTsYuu4uJatca9WP/gnhuOA7NkBZt8Lhy5zyr5oiCKkHxIRGSADnQcZWj2Nj/jIxlmCSq7yty
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:K5esNBr+CaO1UYcHHnh+88mE7CNqxmTSwUUhy/R3xRqLsxb7dACPa6BWTH5rz2SS29bnCrpOoQeG7dpWw73S5tht17aCfGjalVY7NSoBEON1DQdPKZDvf8UatIaNfyj8uSAgJT0PhcT0WKrtDJN9cHxBrs6jpGYeQo82lAdX/YaiyR/0Qxj5s3NHgtF0SANIXuVmydn0wL5ASZaGEj96W839cPSoUamiZIlNBdEVC3GpP7IoKcu+jpUwY0DkaqEHEycq91VOxhdMDZO6qzD9/UiEjXizBgR7Nu5+jx3YkGWBBiMbdguBCfgwK3C8z452GH+mjnK77P+LrWALVxs/IK4xXWIH0glZvPFBwv8JnC4jMlebELcLVdQD1KvnNiUfsYcjRFpQ9ZFLs/2oBlgncooskZiebiyh2lClkabd7SQqoXbKiPyyqIZKtbk4S10bWLOC4E3uYmBFIWO5AXWvJA==;5:iLulRaWiroOcZ6BD/81RpI2CXwdgH0gg5bfq4lIrHA24sFf+XWZaVqDXfebaogI531naWy5481TkH2JwXKCAqkqDL6U7kSfpTSLwOGU95rz34D0MAuBoDLM+7aUWTffy7xRHXpmXlcS5sHKXAaCtPhGUpGjp9GgHFOCfY/FVBqM=;24:3S/nrJ1+JO64ScsVn8Cq+BVxntKeH4+TzDfwQ2sjctvj2vmhPhYt2il1wDdcFIuiKVFOO+QJygxW7U4hOLEqMxsOMlTsVJHp+VfXk+LlpL8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:zIZ2EKShFkEphUgW3aS4brIG96cW5PjqG42pcMdL63eZUoLGhIgVeA4B2qkTimKTQVGSDyr5PZUcy3WwhqqS5qBKmFxWg8D6WgxrT8jT++xUUDqpkqyK1wxMMn9eEqxn2A1LnNkz3vcBEBQ0MrU1WTi1n4f7MjtCF538QYq8kyh0quW6dPTlbyxakxUlTng+hBRDjDdbYBLyxfB0fLadtKSsBinV5EUWs9O2LZ3LIsNh3ILADJCLoas7zZwRBtHT
X-MS-Office365-Filtering-Correlation-Id: dce97c81-ebd5-470f-64fe-08d5b9aa9b24
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:33.7475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce97c81-ebd5-470f-64fe-08d5b9aa9b24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..399b64c4c620 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -73,7 +73,6 @@
 #define I2C_OVER_INTR		BIT(0)
 
 #define HIX5I2C_MAX_FREQ	400000		/* 400k */
-#define HIX5I2C_READ_OPERATION	0x01
 
 enum hix5hd2_i2c_state {
 	HIX5I2C_STAT_RW_ERR = -1,
@@ -311,12 +310,8 @@ static void hix5hd2_i2c_message_start(struct hix5hd2_i2c_priv *priv, int stop)
 	hix5hd2_i2c_clr_all_irq(priv);
 	hix5hd2_i2c_enable_irq(priv);
 
-	if (priv->msg->flags & I2C_M_RD)
-		writel_relaxed((priv->msg->addr << 1) | HIX5I2C_READ_OPERATION,
-			       priv->regs + HIX5I2C_TXR);
-	else
-		writel_relaxed(priv->msg->addr << 1,
-			       priv->regs + HIX5I2C_TXR);
+	writel_relaxed(i2c_8bit_addr_from_msg(priv->msg),
+		       priv->regs + HIX5I2C_TXR);
 
 	writel_relaxed(I2C_WRITE | I2C_START, priv->regs + HIX5I2C_COM);
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.11.0
