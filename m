Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeENOzF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:55:05 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:12352
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932507AbeENOy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 17/21] i2c: qup: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:26 +0200
Message-Id: <20180514145330.4857-18-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:4XmT93Sdo8jtRaErOx+5p6fwMA02LqICw9Ao4QzbuIRNmi71vGTdjNYAZUx3COJ2lmChfQALvtp8xOXa520g7XW0Nv6cxZXDv6YUGxyNBawKNTRycjZHAc2bNOCNEx5M10FELHym7LB6Ka6RUOsKIVwRsxKfd256jTBNiKk7LVzSRdPWVvf9SvG1Ov0ANHGkUlPHSxYiTzSANDcpTUE/Z950ZlNBfDC01prgpuVTHWGBHbi6k47T3Exh7YtB48rz;25:1tathxGoH+iPQNAhZG5uq//h/9lNpR5mUfOE5iD4uAESkpTXODgwzLuKxSrMu6sCT+mUX30U783mNF/3q8fZEoA9Okwi7ehpviCw/1lU+GvHUIRqcoBcQCDHk7JF63c66w0hztabW/cNYEpe/PfL06OWmaQbCL91k3AQqpz2kipKq9/iqG+qs3+SUYp1cH9oBP0OT1zE6VBEZ3Tfxi0fsB1fNd4beBf2QLoUgavoAh+RK1kYFpoyrw2soXmm5aO37AxJT5jBCr/LNKkKWXUHMXrsLB544PM1xEZCeTlEIhX3FmhAU39bf0S//gVQVxaVlxNZGb4msqTd+vwtv9TbRw==;31:gC5CRZlgpdd8mU0UCfjpVSjiol8Z5Kix4bLH3gPrTdt1sfmK0hfh7hfoXUc4eoxsXloBLmePbkbNlSfYxYzHb2QWHUGY9cnUjcj400SAwUT6dD9dIERxviYAnDKey1POZPvKg047upUlb8TAArhJeg1UHrFTIGzZsrlKHblCmmJ1UPwGHuRolLK1xZV1oS/iofKHUGAf5rW89bb/eaAoQqbIomHJYmYrpYWqu1pPjp8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782A9F91E1D3CBB7FE71276BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:AjoNifd2Xsi1NhJnZV7U0tpCZ7wXVKePx+xxJDn+nMdJ4dZNak3VDw6TZg1FSwjz6IGrNxxN6QJe2yO7Ch89bMAP2ONlppwk+yjYANnJKymD4nsuNHG52Jnn+gV60vflQ4TVhmAJQETwpHiSIA6GbEVZ2bD2InSwkY5yKNLksPWUlXlgBS2kkd/T2AVW42Qhl1i5au36iSOKiVGI47ZAVhEwaXIMH5deXlYup5bWZji+GcFv08LcqetlO1aEMLjL5ryAZfnrjMG/wVBjXcCT3Q==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:NazMYFrKC0C/Lhcn1X2IsQkeVlU6qvXrAzZeVNd?=
 =?us-ascii?Q?8KiaCjnFv5S9LbZABY5V1LOY0EeyCVG+Iv/iM/NFjM2O78qaeoSlWtv3Tjsk?=
 =?us-ascii?Q?Sr5/WcSIZ8Xosp4COJh90giTha2t+Zo7JrR0jFOWChbldCNRSjfUAH5jHRNa?=
 =?us-ascii?Q?RWZQvY+LxgljP2tRQ4W86oJjIQRdSW6biBk6QiHshV6nnh+VAHsVkr6yjyVE?=
 =?us-ascii?Q?HQ7iGrSKpoJUIH3ieyrpMD1QHpgTIL9FxLpGCevHfvZ65JYKqoLbB/PW+WuE?=
 =?us-ascii?Q?Y6VdCFd+/4IYooW589eBs0JrI4Ot3S3Mo2fdiddSdlDBRABSVTI7efKRRatm?=
 =?us-ascii?Q?GhujAorRFLvELPuhShvvzHGZ1nfP6nVgydNWTUdiGl8Ak/xfXDl6+CbMieTi?=
 =?us-ascii?Q?J2/n4x+vp89VR5ipm6TBwWYGeIwbslSdZldE5lr22ZwLVICS5hd8dcxISdpH?=
 =?us-ascii?Q?11ED0JHOuiwkqvAZEI9o5PTntANvycnE2uYQHDcVxEkRQADH5UeZmZ2FDz7q?=
 =?us-ascii?Q?DS88y2RwZqdr8yhwaShKtakbjj1TyDV0lNn3l2mX6/w2R7GTuN+/Rq5t8SUg?=
 =?us-ascii?Q?ceusM9T2QFmd4g5+y5FpXjmZVqJnQwVBA984hmiixhqHJ98PXZ4s0IgBysYX?=
 =?us-ascii?Q?3p+m0SS+Aq5mVwg986BXMGQdfJvaORBecB7XMHtc98QDvsANuQJncCQyiFNM?=
 =?us-ascii?Q?fDjYIiU8ph55EWLPVpXz4iE5WIVxcmy4VxYe2sMfx4UQ0PYcXtyVkTNAJYAs?=
 =?us-ascii?Q?P37xfzAC9JvdIPWy+M8pIpiRq5SUJsJZM1+2PsQJDoUk76zFlwNIdFR6oY0/?=
 =?us-ascii?Q?WXEBYsVyePMKtT0VckJj7mJB9Em+ImqFmQ+GTT/OBoNOkCQarzZAjYiS6DuL?=
 =?us-ascii?Q?abuZWk/SJPsOXkvh3MY4IiK1IiP+cytNHgGae+1ak9R6q+0HNv3a9i5SR0Lj?=
 =?us-ascii?Q?7QgzDkBOsSHcjnysDAALiAEAAaR/1aPVgkC/hyBxnCzNtoBJUAZZ2abHa9Pp?=
 =?us-ascii?Q?LKVo12rlZaz7lefAq4v8tcqQgFvRJ3XvEUxrEROcL+y9utlNATgQXLd6JDgY?=
 =?us-ascii?Q?mujdyeqHD1BFfBF8ODliVGzEfBC637PvNQ2H5kitFBRCDOPELlBkm1zeCP1+?=
 =?us-ascii?Q?u6fsvgJamuprbyZHqZFInZn0N2nG75/EC0805XQmUOgU0mw1jL7ZbakbA2QV?=
 =?us-ascii?Q?wFVtR3eBrqutJM5oPeUJ/3BTTJVBE/9qNcGGobHUmnMZfkz1oZEfFbsgtzBN?=
 =?us-ascii?Q?FycPm/egJ0FP8igQgADLqhbpSoOcn5lfcg3sTiqDTAY5lNPtT62cntPmG5GG?=
 =?us-ascii?Q?nkzJ37VZ5TsKerahss9W32UBEOEDh/3sfUY/R1iJdIXL3PsZY7Kz7II41aq0?=
 =?us-ascii?Q?zVK/8sQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: GJLQcHeed2Es0qZmASJ65UhoKObxvJi12GYZdO6hl3uhnBlb3LKOjnF+pIaKBQ3Za0MWq84+ZAnzkrBeSsqUJD6fNYwsSktTyDenHyJhOE1r44vdqQ1cvk8AfKn+1tvW9CvZ21g5HkAu8AL+Q16UmDlukpUvqibDtiHOWcTKyqj7b4MZsx/ekfcpK69OMGyo
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Nqnl5T0vaRnXDCZ0ZXYH04W8PeyS/3FH7A4y+hWcBsiDkLO56EVojTl/ocMM3MJtlR1KqMivJfzVJJYPRMiR3Zw9pyCGgM5YFf+NhEh7oPwQp45hD1qK/WidEpjshiVNiwSZvEmuJCIaWg29H0j6e0aHKL95vU3oI3y4QYeUHgBuXLBenpdBkCJyyFtxxJfAjOWXtisqUuf4jIvucqjKAbqkBcS94rwmIoR2uxGQI2peEUAUX4aVpJ179vzB93YX4UwoRYytyaOo08Ta8UlZNj6ySBm612n2HMDJtKAgZWlynUHGm9fbWFu/mbJ0llPN7FrRcoLACAMr+YszFnh3a0IxhxYYR8UMIP9pLUTI17DUkprrok/Zt/U1JQS9DqLaicXfCthcosBiBuVxRrh/DBGIe4G1JPJ3x+X0O53ZTzllVS3kA/jgRk6of8blVhNWkOLWXlTSy8X3aH3JbyceSg==;5:ZuoG3eyzfsp+pCoGxeo2PowaJ4EruAPQUGCKB2WRtJ5hWEa459V4882+bJcwJ9KrFJaJYMfXkauA0yPpKOMP0aYiTa6B3e/JhHAW7VK/ZCRmIFcJp80C/yDZbdhXjxl3FFVG3YFlWQdgjeTRzjbW5SKVa2e0LLH9Hx2NH5w7UM8=;24:gb9fSirhiS/wh6A+BpMVNbSTGnoxHuFEPrA26M+HTaKywN/GaxG/UBTxl7EK5uU0rkR+I9Xy4aHn36VpWhIUaL/WQ2AZZFcJmmXjjvfYcYc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:GtHoQy15HELurotoYUqIb3Y+E1h+8ioUNidn6VsVqFRfMo1NuN4PKa+94iIBXW1H0FbiF4r57mVFIlVpAwF3qSHKXUxdQti5p1jex8OWllr2BjSy5Qv1F1fR/skTDmkKLOi1v6p4NVZhWYzlrAxbTUvN/ftr6811aHGaf0bkx7RIIfOmfFxNXpvICnK1Q7TvgupAE6rPiYLOXwSct9oLSh3OqlIqQ4i9JtByfk5VnRsgUMG7eVN+qZJ9qUSJj2UH
X-MS-Office365-Filtering-Correlation-Id: 854a3c9d-cb89-4dd3-89df-08d5b9aaa76f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:54.1226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 854a3c9d-cb89-4dd3-89df-08d5b9aaa76f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.
qup_i2c_write_tx_fifo_v1 is always called with a write in
qup->msg->flags.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 904dfec7ab96..025232207aeb 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -453,7 +453,7 @@ static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
 {
 	struct qup_i2c_block *blk = &qup->blk;
 	struct i2c_msg *msg = qup->msg;
-	u32 addr = msg->addr << 1;
+	u32 addr = i2c_8bit_addr_from_msg(msg);
 	u32 qup_tag;
 	int idx;
 	u32 val;
-- 
2.11.0
