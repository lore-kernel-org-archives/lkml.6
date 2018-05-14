Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeENOyx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:53 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:6853
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754049AbeENOyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 14/21] i2c: mxs: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:23 +0200
Message-Id: <20180514145330.4857-15-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:RRP/J/viKecvDLpeEEe6OmNu8CT7/hnB1QiS+GVnbVinCGv+zs2I0Rt2Dq40vGNto9fQSe0cwgYbOUIF7SxKBY7L58bSTcFN/77IXHXV/tpZdZAm/mjr1PIh3hLD+l6bEopd+F1JSnGZCBPiDJJdvC9RavtjSfBNlx/Z2QjlVqDr1OznPPkSb+3GXT0IOYqjstKIZ+GLZLbehnUTZ6ccm7hrFwv9oZbWwiohpSzDBV4mdhgzjZFV7/O6pjkClhqv;25:L5DlLpCrHgWRJ7PzTMrMmiwyJ42pkwomAWzwAFubNdRQl5PfYqVFTze/2jOgkK+prz0DONYAvc85L5+v9u9wAOrjmR/M1gAjZ//c+dXlhtEmbGE6uoavIrgN887k7I2vH/XYmF12SVAf02nMMfsWa+3dJre3uaZO6ZOMhqd1mz/jlB//gQgMR31G0S7dLEnuxQZigxgV5Pt7yGUXVbupxhfU+xW7mO9ajbytXpEJtJd3sUW9aJ6sA46CjSB8Q0IWfoi/zt1ZL2cIUBMKmUyqx+UbZGLZ6m/yfaFhU6ukpAceMNcSwQb5BtDstnhclngq9bniYwlRKZDOZjep9G9ISg==;31:IPBwcodiCjwRYvnZGlhezMf0XuhkiDITq+SJO6VvJoZpkgBxXTl0hQeARo0ZSDpJi/WRjQvUhmMBHzAR+aAiMrpnw9MVzg16umXaCiKJncG41WQ14J7hqDgBdW3ipOH7B6jpRrObZoE9lHLPnmkfTT1TRhvaUfviBBPU4c8Dkfhg+OA2FF7sWL6qSKRaPXwwRkL9KTND/BZB1w1XfTMGnYd3+sUiYRgVSn/KHgCzy/0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278204C9118AA7A03692B840BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:qGS3XNzm5FeolNzJsHOiLM0fk3G0xT/i0oKhAWz5S8gcZyUpFPB85sMS5mghRtFVb4DNpNL3qgCdK5iYpoO5/MmvFijqmk90pV+iRm/R+sj6M2X06RdzVEou1R+bKi76thmhtQmSgtW2tSWbFiLLz2Kp4OIdalQ7PC77giHeKUiO5pPtYNcdVSPbmixcONsifB5Du1NxMB+qoSHQFZJduAUPItZElHsgW5bxfuGgnWnOwokuYnxoIV2u5TT3cHbptaBiXEzZ7CYKMYRhDPn6Iw==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:GzWhJXiQ6h43MpO0h6PWYLebc+qJ0UzMO5ayzZX?=
 =?us-ascii?Q?iHCxOf3medN16xzmCejOF/YjraO6GbaTQjnX7x8to2dQni1fyk+KhLq1mWpp?=
 =?us-ascii?Q?H9/1mHB1KBjHn6ROVOrVaopnUqtOczpdb+GVMH3OBwnosqhA45O6m+b3Vsmr?=
 =?us-ascii?Q?K1+CDPJue0vs33ceQ6xZ2lGU8pfrU7nThVBz+e4eKLbRfuG/sTja95Po/PKv?=
 =?us-ascii?Q?KglBXLawfk4+nEghYXQqjYS5EotkS7R+oQ2NrwWvINdyGlk6jcTqQR3aAzLI?=
 =?us-ascii?Q?iskXZuAoitbP8UltcAeziRXU5RiGffSM67KimbE+9S9xXriAWmPodKGEmcbi?=
 =?us-ascii?Q?T2eBNTChuD5wzdxILmRmMCjrGFizC8oaeBWxqF6MPuAgzlKxkhTmJ0rGQ1MZ?=
 =?us-ascii?Q?/MNSqkYACWMEwzfJ8/VxhZhEna0WSCb+J4/wKyyP04m+z62YSVfDnUJqSPVI?=
 =?us-ascii?Q?SBPWOyMCBXVQlW9HD71OEOnxl4epVjt3/ewW1xPBEmXJitdTwvOZd4tvFJkp?=
 =?us-ascii?Q?yQE83HNXiLB1ZcVuhYY3hA8APTsODuvFqWXMKnPhmLXuxl1nswkTOBNSQ6mg?=
 =?us-ascii?Q?WIv7Qpz6RKh1Hex/sicP7+LPvpIhRS4ApUo3X7M8/nPcVBuaK5VgbG3CpCQo?=
 =?us-ascii?Q?R8Z00ebFBFVaRP5Mwm4aD/Ae+NUmTUgTO+E2gX7afxxHAPyjPYDfP6aYgbD2?=
 =?us-ascii?Q?zQu/u/YNn1dcsW8ctUINGAacQOtj+VBO6WH9TKZXMKf55wuyVVq4VI3LLsy+?=
 =?us-ascii?Q?RWJp3Lp8Go7u7K8lrFjxZttGf0TpUB2VB3k7rjT5zDsG/Gy5us2Nx9rLBlwh?=
 =?us-ascii?Q?SUpz9UPcW/PVsVgQmLYYZULzpxotS64Y/aO3+eDQT8E3k0cpw1IUpj2L5pgl?=
 =?us-ascii?Q?KcC4QZbQJKa1ofhPkvWVnjL6lOtnyv7ZVuAf1Yn2Up+b+4T3vydSLLFUSSep?=
 =?us-ascii?Q?TMIzkfXiEX/pJ12lvRhHU7mxB2LmpibBtGUxOyVUF8TtgBx3dzCvS+03zQZ0?=
 =?us-ascii?Q?cC72s8M5pqVDlyUmddX/sdWLTaVVPDFesVshdBcWmGRSbDYsVK5uCRfXAPt8?=
 =?us-ascii?Q?pQ5PDFFEVbGcaSPcLXrSxoNKVWxP9TfcsK/J3oksdSw+3godZsNzsQ62OKol?=
 =?us-ascii?Q?2bafw4yeGKQgLgxm8JlksBJZUMty5a1nTEJqx1nLpplg3HJ8WCJUcbKYu/+3?=
 =?us-ascii?Q?HnVy4mf9M+IUxRhM8sUuY77oDO982OuTe5dB6b0Wg7C7USy6iERxzuDN5ijn?=
 =?us-ascii?Q?U7dZKmJMLjCnrrikJOuz8qfLDPkOAUEL5z21ZxLoe9rOafZLX3Y4nlMPuL64?=
 =?us-ascii?Q?Lt9K1KRoxb0DNh7uWHmbW3zoqB28QbjgktYiC1nXLAQFB?=
X-Microsoft-Antispam-Message-Info: vytks/XiJs9R/KYuTRMYWyytgCpWdHPvBtI3mb53KI+MjQPykiQfND337nfdmQyUVcPoUL6eZDvj/VgK0WztaOc4bnPHsavYqKNYNG0hZVIGkA+NYL6qeX6adFyxKIINOdl7GKHBwav2LnPbMHrBFLG2JhJPUgoEzwviOkl/XcQAV6rXJ6ug4n539op7hc/T
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:UGzStpVveXHnGeHw21B8bHXtmU6+gTN/h+xsKfuxXyn/JijlERGc7KXA/ke03nCcqA9g0AYBoNUdrosjZ6dNHUMlRkWEoe7dVaWfpyof6ghWGASVo+P2jv672PGUUPkZe5ZmfLFtI1xcUBmoEBua4JW4KOJl6MrW3XgLkRcV+ePobQALKvD9mT0bHxlapCRYulcb+P2dd5ILttxk/VXM1eem3WJg25Ek7uM8yeooFSp212x6L2zQv7sybaIASE0y7VOr3vMiw9gRpBW6RvZE9F3zBvje0pGsG/RVsZukpv3KM/fxTuxahhbMvF2sVJshPT5lIAhszKMn+yEAeii6Y7VDe2Nk4N9aKes5UAhS+9CStd44KpB4uU2qDFq1iVxxWxiNsnfC78UK1pc35YkOT1LHKCuwCA3/u3LfYB4uCxFAI77nh/2/pgXhlnItf29GAWjgpWBugVBf+OoArojHng==;5:m1uERiJqWmb/oJnYJnK/qpyGTmdDXaFQK+cY9OsHiEWb7NDn9eeM+uVzpz30TJpPsmH6dUvZ2WfEBbQtoo4JhvsGeg7ioNtehsBVF20AyD153b+tRdLCNUj3zWg3huIU7TBJkD2Oz3FtO3DywUQRiW/IOKOozSxEu2jrdBmT9vk=;24:6gxp1sCSomhMsNnNlTKAudwvBu3FLMoB9zMg6CUKoccWjMNgDJ5SdftgwGCcO5PCq4Ku3F70lTsH9ICQyb913X1/1HtwM3yHtE49jTHuVhA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:VE2wBqXq225dR6DxpQb1Y6zvV5QYnrE6ikMYVcPnGAmkLkbBZW0WMJG1no2/F9pjE+pNsemUxok5+eJnC5j2vQwYFDRsP6rxfOayPv9yseU5H5pahMA40lisOxsNH1DukZBDa3fTFho4qgGEj5RKvieS9GkbjcqzEflsnZU0TCfFI4J8iJ0vmGTYps7yeAYcKE9p62ed2ObeN4GrX8mN3MnPRO6vdIiMBB5fEhwppPcwxbdYAgxpcVnl/EV3y5WS
X-MS-Office365-Filtering-Correlation-Id: 8a1c5a41-2781-48a2-1375-08d5b9aaa249
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:45.7320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c5a41-2781-48a2-1375-08d5b9aaa249
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-mxs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e617bd600794..f62ae3d42232 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -180,9 +180,10 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 	struct dma_async_tx_descriptor *desc;
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 
+	i2c->addr_data = i2c_8bit_addr_from_msg(msg);
+
 	if (msg->flags & I2C_M_RD) {
 		i2c->dma_read = true;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_READ;
 
 		/*
 		 * SELECT command.
@@ -240,7 +241,6 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		}
 	} else {
 		i2c->dma_read = false;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_WRITE;
 
 		/*
 		 * WRITE command.
@@ -371,7 +371,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
-	uint32_t addr_data = msg->addr << 1;
+	uint32_t addr_data = i2c_8bit_addr_from_msg(msg);
 	uint32_t data = 0;
 	int i, ret, xlen = 0, xmit = 0;
 	uint32_t start;
@@ -411,8 +411,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 */
 		BUG_ON(msg->len > 4);
 
-		addr_data |= I2C_SMBUS_READ;
-
 		/* SELECT command. */
 		mxs_i2c_pio_trigger_write_cmd(i2c, MXS_CMD_I2C_SELECT,
 					      addr_data);
@@ -450,7 +448,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 * fast enough. It is possible to transfer arbitrary amount
 		 * of data using PIO write.
 		 */
-		addr_data |= I2C_SMBUS_WRITE;
 
 		/*
 		 * The LSB of data buffer is the first byte blasted across
-- 
2.11.0
