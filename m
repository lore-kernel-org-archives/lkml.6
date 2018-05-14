Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeENOyr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:47 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:36671
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752078AbeENOym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 12/21] i2c: imx: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:21 +0200
Message-Id: <20180514145330.4857-13-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:sHYPZkc/irYcxbJvjKfs9OtDF8tnZ1Qf9+XW04+sy1Y/Mxl5bK14/iGG69TPrjsN+Vnjvz+jfFP9a5zoQmGM3I50uXKKgsP8UytNVX9BBdEwxOYflp7F0h7m0n64zdI7LVkAyp0KcfIn9gGJ4Mvclm430EdR5Wz+W1HR7nDRl8F/gxvFAXO8L7Y3xGYxO27mVVewMwHWLK6D11UH89ym6eIZZ33dZ2pusfmm/10c3Pe0kKmA+YZuybHI3c/OCkJa;25:s+ifTMeqvxoCXi8Co0AP7RCf3/6qfODh3WpUV/+fijxSo0ifz1SUfNndHWwjDTyfV/FYRXxJgLJKX6zyP1vuJBdney2JoP5bu6pTXZwrBnpWMZlaXLUmqPlYGqz8hTjf4+dfyuzi9BGAAjn916c1D6oYou0wbdNN49RYYH+yksWCJWxaMkEOj0Qd0Z94JokCPRX4Cn3Hl5398lmv+lX59as3jyvsSZqRsPRcMDIygYLLxAPa3hw1jHpT+d3U/sCzhwRxtg7/gWSwBz2UChkcq2Xurrwg57PoAszrhbSX8ZVTOpRM1RMOb+CO1h/0x9TgEjC4QZQ+/h5JcjZjAZqTiQ==;31:VboZNL4c/b03rUy4N9VeYbHau7vK+YN27T5oXt9ZSdhqv9YnpnySBwyV7VJkadjfB8ulweO9ecnciauJyfk8RyRUi4w7tUoaUZ+Q6BkNGV/Gz1Pfo9WPNv0Qr3tNS3iiAkocGsQzNXy1NjCfWV5fU2HqO++kWx32HgHTZ5heRPzsTZ5pKHXduzPIlZz42fZIYPhzFbJBIq/MbOA/xPQVkdbIYgc6/lPBpvRrI46jJdQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B47DB8C75FA431EEAE46BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:OGWlDxZbuH7zk/n6jOQnbkMvfpGBLJjFGQdu3885Cqa4sCxVRL0Pq3qdM1GkiehXqbAZXQaOCss3vp/KtIupxYktAJo1mpl2J93wJMbCcq39KeJ0W8RHi8J0L3ntxUSbu+07cj6uVak3xUEAS3yvVmB1Av1QXZ01yE5B1vIuysYTPaTmLyW0eZhXezT1TEMsOIqPdbajRq6tFgm7xHnYpS3yfVdT0NnirMT+xs7HvmgQaF5Svw7ovTemyn7x//R+GmPKs8FamMdgwEaXIpE3kQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:vyccSqvzItwCjZpyvWkDBDwHr42pLPQmD6rN5Xu?=
 =?us-ascii?Q?qrju6TZC65vigIhA6Num02Bk6qGUY5SQCklZDH30yQM2c75bb7qkD/5dMtbw?=
 =?us-ascii?Q?1tcJyF49DESag1xuruaahazdQuwSsqFYHPKmG6FNTCQLrlL+QN+5fO+VcYGZ?=
 =?us-ascii?Q?2UT0ep5xzo6+PxO3ZpdO9B6WR4KbKz0OsJijAHL/ILp7mS7v4Yf4WFOB0Epa?=
 =?us-ascii?Q?rtJ0tw80G0ZRXRmiki5nWnbje4A9LHKGh7BpF34tzN4BPn6ycUN1emhPRqsR?=
 =?us-ascii?Q?mFZ36d866v1AigZbHsp6PNKBdvYTvKxKSLH6DpVZQLXP5F6ubuTvh7U4VF5u?=
 =?us-ascii?Q?AE+tLhSVSenuWgErefxxmi0P6aTVE0oWUTABShLpCRO791amaD5m74CM4zB5?=
 =?us-ascii?Q?ZNbSLBVJNb9al1INzxy25Sk0ZpaQI+ReoCl3dFHzHJYMKKkj5fIcr7Gzi2qP?=
 =?us-ascii?Q?8eC8Dc8rwSbTzQiFyDK5lph3KsTKxVK6DtY1G0jpIviH0GnEYX4Srbl5C2Xj?=
 =?us-ascii?Q?gMAgX0F73AEQUZobywov2O3P/NjHSSvvNz/ApMtxc9b0lt6vtR97Dcs13TjF?=
 =?us-ascii?Q?dimw9R7yAXP8WGXIPYfXV+6R+meg5YOvfWttB1scTKa+lyg128fpRkvGZxmS?=
 =?us-ascii?Q?Tr5pWH+D3IHQ129Nd+pgcJMFFBbWr4vynkvZnJnaFXqZTorhvF1eHYcd1vM7?=
 =?us-ascii?Q?nFm6sDcedSzNfgYtv6n87yh9i9LX8h1czU+tLE15dd6xOKnpD1KCN26g2/Qm?=
 =?us-ascii?Q?K6GTqmyXQFlHDaaBg71+D8gJi5Um2UJz+pIy07jzONBYOj36kXPyUUBX0i5M?=
 =?us-ascii?Q?kQzaObBiPoSTYSsqukbpAweaeM4/1N7Htj8DctQo7gjYvajsGs38PDu/MZOc?=
 =?us-ascii?Q?INqX/7ln0kQ+Bs9MpmjKjT4Ic4ILrx0oru7TRAOGJaWSb0d/ZU2hd3DzoBvf?=
 =?us-ascii?Q?jR/7hwFfymItDivYCarALvuEZEiirmCRpedfVPl2IjBYDlE7fvQkxc+OMRrH?=
 =?us-ascii?Q?RiojDFryiyli/hR+bjqs+jUa2rv0y8t8chHhiXAgplGh3UzSBg4HEYaxA66z?=
 =?us-ascii?Q?cqTpJZP7aODmuLe8cWykqX4V0vFnd/WbDaBWy68gOZw071R/hGuDan+ztzKj?=
 =?us-ascii?Q?TX1uTn0tYOJPdLdm51B+cmkRNvKe+nUYB3Yf7vg9ZPZnBAM/10Se4arG3Vcp?=
 =?us-ascii?Q?1K15SRrNLnkDkFYUc1ATTPq3cBJ7DwBfrFdXoJGjUjm6hRjr4ngbPgMN51vL?=
 =?us-ascii?Q?q3tEgKJ8jBmqzJa7ly13SPpFrIJznjBZLw+YQpKWvpGlgh2vM40ETtTsT8YN?=
 =?us-ascii?Q?mVDod967ajjxhjKVD0oXdCczssJOeuUDIpNq4XL/3Boex?=
X-Microsoft-Antispam-Message-Info: 8ksIA0YbB7Op7AD6eNn0iVuHOeITp52lfY5uBL8tTiSW1neXLaHeKDRQibpaVXpRLpZbFQZ0hEr6XrdJVGM+kfbxdd2VQ/o/6QSnUTFOJ2GVf15h95LYSxKFJXsZZJz8GGEiWVr36LOzO4ADq9f2M+amFFDNxedr6ZedvdHInhakYmYkgEq5dN+9fogHTeXw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:uRYExbcrJgOdWEd5jRaswFKLOW9ylw9K1tJ8HO4nIqg9rg+5q7yhHkTfqdwt5rHXU1PPeBQ71E1cd6HolvgY3WrScHfoXYYgprp4FGyBWlvMi11jyrhdFQIW32t+0q9gK0rUVsHzm4XR90gnmD+RMjW1QlJIwUu1FZ/53Pdg/0Kvf6RkBVRSv2qZQKvcGf3fXZEyMx52qKRHlkKUTlR9n4S5HoETAqVAgi5zQJie1L88SlcnbW0w8C5L/jUoh1qbq5HSCMPMHSLCTeHOVUXyy1kS+obcX3/W2lNcMFGJI3JEG+O3oLzPddwiYNuYQ1dk6f/M4dvtYjGT8dnWDi0q4JOgUKJw8vlpJ8ZzEVk5ujRruxvig7lkLSOhI4CnnI4Ew24+BCLpD1sVEDRDfquta7BKZ4EoXW7ws5amOWQCAj7jWem9SLdd2DQltDwnBXQbbQmV+dg1pKCYgYFu953Wlw==;5:KJDT7IHaFF76yRoVkS87oj+ivGEhcY3u597eFBsmy4T9xsSh/RlFSiWnP2uaMh6wqTKhDTuGk/Tf96IA/OsAHGEtPUHDXDCQbw96XYns3gdNOy4QMp+sswFj/CxqFfHTkQT48yk0Z0j7Kp9DgjhnbmshraSX66W1Nghbnf+zEDw=;24:h7SntMkGkJRAjvSXfeObk5ryXOs50aLlh2jGQO0nqqe9Uk5f7LfK479BANLsXwpqQgMctX3g3l1XtxKhmWjNkD+R5gSLGiAkTta1HGZuas0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:zxpLTspW1jt+vfZnaZnOfBSJeR40teeC1M6v+uKceXuk8WexyAn01nx6dLVZdF+N+AzZs0B4LF7yg4mDz1wxy4+MPYd5vQgafbNh3WHRjBZOvfL/t8wyFl5vrXjp12VP0U8s+dn0nxls3NtOK/BxeoCC2nQFOX1kXdzrcuH40iR2L/EUvCIR4rf6dnqIDj+cfk2/Wu1CeRbE4X6ke6PXp/dSouEf5iYtXLmlOdPTtN78qxeFjbWnBIAIluWxXBbR
X-MS-Office365-Filtering-Correlation-Id: b66d6c9e-f533-40e4-ec03-08d5b9aa9ed6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:39.9663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66d6c9e-f533-40e4-ec03-08d5b9aa9ed6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.
i2c_imx_dma_write and i2c_imx_write are always called with a
write in msgs->flags, and i2c_imx_read with a read.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7267dd9c7bf..bcb41fc75043 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -630,7 +630,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * Write slave address.
 	 * The first byte must be transmitted by the CPU.
 	 */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
@@ -760,10 +760,10 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	int i, result;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, msgs->addr << 1);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
@@ -796,10 +796,10 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
-		__func__, (msgs->addr << 1) | 0x01);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg((msgs->addr << 1) | 0x01, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
-- 
2.11.0
