Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeENOyP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:15 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:39648
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeENOyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 01/21] i2c: algo: bit: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:10 +0200
Message-Id: <20180514145330.4857-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:u7EF49DwTl1+PpBXqIYDel67pSR6it7GV3NOtyAuw9/5Vc/Oi/yT8AoOpx/MMbOsYvdSYHQmIL4a4qYaaz+A3AVVb6OEm5qAHZyLMVVd3d3/f2YuaO1iJal6EVF09mOfoI2Wqxv3XQdGh+iQ2qsIH3FRqmNRzGpPoLjU5lf5Q9bbx580LBECe1LPqj50SUWwHwPRWxT4eGFKtT5fr/VR/KN7wLeaUIkOt2L0H8P0Rh7HkNXKVNBkqYS+l0TdfRlc;25:Lev1wpcSNhY0l165Jh6v8VoPXW1bCNLHE387fTlu9F0AbeYwi42cojgrfrmddyYBC5/kvwW/xVwYTL6zkCguOlyNcbGwgbyLMAET/D+zuQQ9KMqCrw3pGnD3aHUcyU47O3kpF242wIXMPmeKgfsn0wBU24jiY9PwRkmn05KXZfDEpWvXTXNpw2O4i9RDm1BX7w7eLIDAAIFFxrwqknr5SrDOdMCVExjMMQzId9LR1WzdcGMfzme3kjdSI3TOwww8DAmTQ6q1ejVdkR45CAyBt+MXGzp3iE9QH7f4kxZlvGEkfEapLjtRFZhwH7p81dLa+GC0ppNnr+rgqwI8h4VEkA==;31:MPOBEo81kBp8+qpecSCBaZ8TGp8egzFqSLCmV4X0gD/SUjclB5xODkpueRhlDc+v994Ast+7ll3zsQKWHkXxvzkZ91HkGHoF3BKz5o8a0LZwXW725E5AYVg4IGaudQzQTkFicxCprCfqkA2+U7QHiOXZVQ124qQLkay1hYTXKqgMf4G8ZCouhaON/AfYh1cIT4A514SfOAo2PcTF7al/mY63GutdtHOYSpCF3IHnwzI=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782881690B4130133FB86CEBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:FHYGq7wddCeNFWVn+6C608qNHoAd5QBS7qjtPQdJwxrN0byOh1f8MQH+a7rtG1fBA46GOU3zpwXjB7mflVJa7nbsbCRQPhech7ERJYH0IXGSSoGa+EH+sLJVXA++pKRV+ss3o+c/rr2l7S+AB2XCvipVq+o9Hl+GBvZKF7Ck6A2LaJa0sVuNZDtjp1o9EqOScKGw/hvAUyYCpGmlaTHlvqM3B5pLyVqGNUl0DXb/d/ZEPkvulcIFRCh+PBZJCf3oZa0IHR7IeeWzJNbQ5V/ZAg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39830400003)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(575784001)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:KHobnmirYS4rkBsf9Ui6DTFieXAASrAULnx/3nY?=
 =?us-ascii?Q?KuiFVOevI8misF0JQYks0ZabOLPT83zf6UINYC+9pu1N3PYeVLQ+TXq1Kmur?=
 =?us-ascii?Q?mXt63SYpXoNASPv9FD5NutdvtfCytSuTsu7oVRo5ttOg3Ns+fhsJwoUo1Xxg?=
 =?us-ascii?Q?oJaV46vyg3qEBcbmxjfejNjUbpMgawrO509CnkGTRbg96hVrQnL6t5BT4wPn?=
 =?us-ascii?Q?zFqyxTCplQG5puI2FMN7hKxMT8Hhs+BtVpM1/xmwHqgAocVgVrD/sYLbY7Zc?=
 =?us-ascii?Q?pdI7Qan+hz0qwNm3R5IGrS7UrV4qfSWlBQh963lpP/Z5CUliaVjRZ5pWGPFX?=
 =?us-ascii?Q?gslWhnPQFft4k+qLouj4DN1IlBW/Mw1u6uy39sRZn/AkRkzZXXt7mRSLIFQ6?=
 =?us-ascii?Q?YPW6uyXguDj8by6kyI/LvfLdFYufeL5O1dhZ6vL9kjid96Jpw3eBRKVL51Qi?=
 =?us-ascii?Q?bcj6SpoeOIbxYgb6si/kC9DKvK6axHaeNwqv+c8J0w9Tt09fG7Yj+Ck+v+m1?=
 =?us-ascii?Q?zYMj2i9U7Xb2Vzj5qwg8WkzE+Rta6D0E0Jcp0bdq7m8ITDYDi/gw2rEItC+u?=
 =?us-ascii?Q?iAGNsyUC84DCaa1WVtSJ7cnHtb3aqdm8xqNdXFidSf4t4FH9fJ/MbxICKwxJ?=
 =?us-ascii?Q?mdVG8B16yfpBEAxuR/0aQZ3EjoI3L7cRt+O4WAWE3vlWNoleWgOTRIzFYlN0?=
 =?us-ascii?Q?mmqkdb6n8X1ofYeIv8c+Vq+3ISYNs5pmXryAeIKyCGigCt5XoNkyA3MeC50Y?=
 =?us-ascii?Q?NLcUyk+Uu/RLokZfzd0pJFI724o00d7PZ5yoM7ogCaI5MaQlF6yBjkYDFCzM?=
 =?us-ascii?Q?rYrq2Ep91LxBxQHTteUl+bUebsm6dh9hLbZBzEiQpcls2eUtYhO7tx0ivDha?=
 =?us-ascii?Q?iM8LO06/SSKUAQNITNGDYYqxpJt/9ReeZ1IAT6EjdmShukYVwPMJtWnlIYtn?=
 =?us-ascii?Q?yCgcmVYq/iyPHebI9pl9j0X3PsA9nJsFehlpL0yU0h/CfL6VLaAPwQ549bmm?=
 =?us-ascii?Q?SgEcRTbqupSPM/aZzc100mJIdCRBQYvO8Y3bcbE/xg4XtNENxzX5+McXUCgT?=
 =?us-ascii?Q?PK3z83y6dARWu4wr0EqgmVA8D3iSATwMiCale+vhkothNGW2ONJx6cQDxaQ3?=
 =?us-ascii?Q?vsu5fMpDWqegmrZKt0YsPMv77hbp4kbA4ZlgOtUwt2v+DYyDUPxttKKagNqO?=
 =?us-ascii?Q?YXNTbnQ6AvSPY0pdMQYyuR0MqCvP0wa8dvoLJdj5DZ25YLIRR6ByCB+6uzBN?=
 =?us-ascii?Q?odKkVg5p1LcrzyOEQ1p9FG4LxMQmlSv25fbLg1gtK6U06UlX3wKHTPdZvFyh?=
 =?us-ascii?Q?V8+0aYYsUb0J7DRar1gJn7ofF8g1rqXpi/0E7O+Izq1NmcP3MiQb8/GPA+l4?=
 =?us-ascii?Q?Wkw9BNQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: k6c6gFeHbiFe14wOL71DKMacmpV4AWN4yJgVvids2wD9JSJ4HRztsSI7Z/SvnS1ggzyGHqogejM9tOhI1ixAez9lbYkBJLc72R3M6euYDqblvQHxjsUe+m45vkRYfmd9YF7Ck8TQPKa4eM9PvkdQsv/YhE3py1928bymE2RVIwE0eEzavBW6+u2fWNy9Gxrl
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:jMLEnUbtu2CNJx7jA2HfLxKt3IUAXmr4vN571qng1O1DkXzJUEPe8TOjPzR8GbWNV6hPlIUjWLRT6dXOYwqSeOu4V8DCUgRgJOCUncPHjFZmbPWVTKCWoHmAWQerEkpvbMBZyx40g873RvpRtniZN+COkUPR7FjZx5pvB/TANZx/A3UaCBdFlziqGknTzYvfJlSu7ikMzJAJk2yXo0or9i7iqmoNKcgZzv8K7kZyGKBmMphF+voVwe/QO9CxDPGIvxFbnnaDWDY+vCxaIyRdbuEvy0dmjDYa4BTK+c3Y88B2rObEkaDrtpK5AZupM3NWsPBbkSRXeVyrvxnjTNppCn7J36HHdgTEqXz+xkPx+FFgzlnJrlEjyu71fKfMVxzeCSxPLZLsdZmij2x8kZdH5KtPPIdE2NUgMiocMx0IDsR6BF5YdMEC2CqJeVyt6BChf3oSuALVLB3wPqIDf3F73g==;5:F5beUvshbJ3+/PDZUjL/qcMZfGquQIEcl0/oswzVS7aVICIMLENa7Hr3sM20WM5n8OUGuk0+WAdWqZ8/TfAcAFk1+GKI/iaHEqgTKESavcXddNGMWRbRu8EOy+7l5b8UP9Ue/q+emAGNl+WCvoA8CD0hRfaHRwNzF1NxrMhFrUY=;24:lenYTn+wG1a7yd0ocVEhYFdG70083iRfqaHnMqftoKpMIwupHsh65FSBGsZAN6v3iAj3FWo2HFkOhmA1Y9AU/RMXMubafInDUHBecXtjNTU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:bQB2Lvjm+eaIUvwFPcPqXFNcDtEIS+PdZJp/PqTH9ra3oJKPUwkXWmSGWVTxpa7W9QLh+mUX1gXJb5ubKrTP+IeT26O5X/fm9RipzN2IJnx49H5sDonb247fcRCYEn6gdXnvz8HJhULeXtwG6FI2VHW2mcKSGKurlNG49lV9diOZPGTfYc2xYJNmSfD26Nezsmc1u+fFrUCNnjHJC4bgmTwE6m+4g7YPXRDBkOh51oPcy8cXhLC8HPRhNY567T4j
X-MS-Office365-Filtering-Correlation-Id: 04051fe3-56a5-4fd9-79a4-08d5b9aa8b88
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:07.5599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04051fe3-56a5-4fd9-79a4-08d5b9aa8b88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/algos/i2c-algo-bit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3df0efd69ae3..4a34f311e1ff 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -519,9 +519,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = msg->addr << 1;
-		if (flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 		if (flags & I2C_M_REV_DIR_ADDR)
 			addr ^= 1;
 		ret = try_address(i2c_adap, addr, retries);
-- 
2.11.0
