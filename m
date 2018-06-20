Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C896208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="QIdFmk9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C896208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFTIwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:30 -0400
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:30448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933096AbeFTIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnGYNd76JOhNIAkf/I+UNnYnhPSC3AFQT8l8aUrbPDE=;
 b=QIdFmk9BO1xy47Qprin9kYBypZASEpwZ5LcbeOWctpPdSwtNt3DdDR2ZdFvtDUF5ZXmNfmX6le3Oo77yEMvKEz5eE8mk6X1o12oh8xeI5LRLCpXxFx8jaI1luP5IQIgtiQRk9377ot0D7IhTPB6eGMWcSK9ypfxaeyZAARXlkpA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:18 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date:   Wed, 20 Jun 2018 10:51:53 +0200
Message-Id: <20180620085157.30121-2-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 6db9454c-d268-4156-b9fd-08d5d68b21d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:HH+Yo+vJHZAftAX1Md445SaFE3YQlhI19Aso7C4daU35lzHom49h9B6qaQQPvOYOzhuOKC/IHzAXUCZoddo5ca4ovi+2gKuSgGCj91IujCf8nMawHYjqlaQjwOnfFql7PhjP+caSbeN7FkdmsQ5yoEaHLZVCLbuONHBdGOXSqe5/PiWkqf3R8pX/5gswnbaPW+XT8InKElm5Z7q2YSIJNqhCLElMOvEoN5AJ8oV0m+bNtSHMjxVSMdlUmS+byWYI;25:H7mrCwVOXk03PJiaZRb2I2AvoGrXTgr00d1GNqV2GhNGvrasdbnsURzaZ3Mf/2KBCwQh18fgMM8Ei5RTNfK4WvjkP9f9JYqCnb/kUx188lITwijLum5lqltskL5vO7lv7ukZX/o2oVrXe3+oi5hirHQLZHIQpuXrm+u1yKmWSMlfDrp6cCBXYOZkZgj/oJY8NqR8j+YSmTDZ3TXnDls9t6RyXSgHbXKJ0+09VA4Ra9JSMVg11kOTe32uW3AZ9SsMG5InP85rN6dQW0bqzsg5Epm6ymTWcV6/EtHBZDcJQxADBqjP22MA1kXHyExPc4dmH2t65JeBfdbTzKXdbgjXrA==;31:uh0NANg2c7/oR0pFJTw9C1ejA200t+YbdyflZxBW4vArfyJzbZlLPh0z7LvswKQik514gtekEMiCEC6WwIRGQWSTPgXuXSPy38l5NMMtpcLzOvESxxpYUOyQjwkVY62a2SZAxaL6Y4A5UJU7d2uPYZrQfF/Yn9lVgy8XEmDCXik3jiCNjrxnCHg6ovGYtIC2sYAkCYEHNSD4etABdV7Wx+a9sMPMzQCt/S+wo/vvtMw=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24641151AC5288EC18F25042BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:5NObEDmR/1SACZLWm27c4DjPd5tN3SMYtDNfdwDRq3Yly5VYH/K6zVmVMvDta6z1vB63JVJnMAPdpmYJF3FmWWsDilrlPuLw0EaNIz/3MkG4u694/mUa0PXVlKvSZLwDxlCsHquV/mP3/RxVVKDfYFJtNyc2f0124QL8UFEYjGcrORA5oW0o7edUNahgSQI7cBXO0S9V8lh1eeXfCJq8BqVfSjif3+3vw/JSOk5eL5E7HV+38trrZBbUf7TZW/vtkJ/zSWyt/E4yekPE1qn9oQ==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(39380400002)(346002)(376002)(366004)(189003)(199004)(48376002)(50466002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(81166006)(8936002)(86362001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(59450400001)(6506007)(76176011)(66066001)(476003)(486006)(446003)(11346002)(956004)(186003)(16526019)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:o6uwTEZ9CiWZjgpSJnhnxTj6gxCnBqA1UUH9yjw?=
 =?us-ascii?Q?UXyacfcz2WKkDefc1aTcbsweZxviLZzckLzxKactkK8B4/9Jml6+4393lU5S?=
 =?us-ascii?Q?twW0y6B6jnSiA3+xfeJadbqi0VEc7kTt5OdLf9/dPQHnH2u8n/r9VfvtQvIk?=
 =?us-ascii?Q?naxPs+cGDuGDTUfVMnpCQZqIiNyJ1BCDQu8ECJPBp1147amEEsZ9RKlDmqtG?=
 =?us-ascii?Q?PM9glDZhDLQC1P3MCjThI+WBjA2pz1MAYF7q1BUAL9byC5FxixT27dyotZiK?=
 =?us-ascii?Q?boL3xt/oHeOq4XdLaOps8WmYg5rgcs4J+u9TofStuGBbrB2vv9zMlGZHDomQ?=
 =?us-ascii?Q?kWeAfYWQG89fp6i4IYYMZx5l65bljuPOMUdI11FeqcprvMqIcD8ce43x/Jzj?=
 =?us-ascii?Q?5U9lITkdlmh1jD6XkA/utTg9iG7V+IRxYWYXvWOVO7RHGOhsYfD3dJ4zW2TG?=
 =?us-ascii?Q?HWnJFWldQFRx2UOYqHApF3t6Kr7t2OnKXq+pn8IWDIrjSpf4aPSxtc2kPn+k?=
 =?us-ascii?Q?4QGmLS4YAZi2RUFnkbZak8VUK5dwv9KLtL790Ft/ykRp/5/yqtwe61Twn4In?=
 =?us-ascii?Q?tBPt2mq+aTsFgCVPub+tvii2a1Cf9lKC4PuQW545zgzqyC56TIYLibL6Fns7?=
 =?us-ascii?Q?VhqtK8/tbQ/B2chmvReyU5bVEgvFqqkWXUA4X8JBn1DdcJyz38R6iAAeWG0m?=
 =?us-ascii?Q?hTrPQZ6IbRkMGFNozb4mwz9I0MWdozU55S2gSKFky0zufIwnBiFZGD3RK0Bm?=
 =?us-ascii?Q?p/eoHn/YyZxW2YrF6EVi7IqkWzwRs3xuh2YQab0Ja7zCxbUJkEdNLv0Neobo?=
 =?us-ascii?Q?N2mwpIVqA9Dg67Gi6D18K1H8VC3Uf+cAMG4MTac7iMb0eWGJ3a45CurKT9vJ?=
 =?us-ascii?Q?F63cHgydbcutxwteeFNtARL4tZD3xnXp42F2sGQf1BgqBatay89TWCSOwUv7?=
 =?us-ascii?Q?xDGlDcdjaXCDiReHce6JS11vQWYJtKDaNR+GjSXIsACUVJpX10Y+ArVEf99L?=
 =?us-ascii?Q?v/xA5byvsLN9MEA7Bm6ixUtJoCPGb9XP72yVssrlAZRNv3UROFz7rGsWrSkA?=
 =?us-ascii?Q?ko2BSCLsA/gMp4ZYjBAWx8TvYQp5L/Ach/Dy8i84VUw8Df0PIh6ZjZNsNeP0?=
 =?us-ascii?Q?cWgo84kkJpwCAK365uTfhnUhmsd2VAJ8dK/+N+vv8mA67sUlI1/14sUlvgaM?=
 =?us-ascii?Q?bjST5qg9VU5JyYHDj7StYy90G6BK8I74PnzciZVh1PUb7SPkGc9RVLu0TT2Z?=
 =?us-ascii?Q?iHDwP49vOe8Xd66+0mZUfqDSiDTNniPGZor22KJlmKvyO8DhkhKNhkXPK142?=
 =?us-ascii?Q?utpB1pLA+nRzakSSfNrGcF7UfYqZpMOc0DzP4hAPfqonrzXSIGAYW/lMS7nn?=
 =?us-ascii?Q?pM+83XWFno4jZmpiB+CQbOgoni3uoj9K9ONOFe4v/VPQ+6MVs?=
X-Microsoft-Antispam-Message-Info: TlLXmM2ar+D6rkrTU+HLWK4Q2YeEx7uizNyzI+MKHH9lUbRG+Kd2jer51IjXB4BhCu7Bfti/NJDvupPSCpqEKBWEo3E+XEVQ/LCMLlw6yVGMGBYhohBuCD1SWhJhwDk/j0AbENeD9qbbqt+bdvp245EHtW1SUncRyD3BN+OKQhcQGJiEKlmNVyesHjWw9JPuYa4odN8cZ8kAkQ5UVH424nHdzADv9Iqg2UzqVKBI4cIQhh/39dkBzT+TzBAx3AhmmDQCV6qjD86XRvxcgL/f9KcNgYDwdBR3eHkuh5kn5ugEfvrFoNOnBiIX9AwIH81zQV341D2SDGQo4o4oXeh2tQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:So7jUwaSEFTkwDMfSxtFAPbT0MAcz7rSwb368sP/XJXiKL1FUlOSMV5i6hkRAGm+idxS1KIz46Z+BsLE6dANkrWJHxhAQ1PG+iZ+Fe9zW+5D3aJP3kmILXnqm2om5cKQrB8FCm3LbfTMV+x1eduiY9iCWlFD4hBBvwRZ1+7BfHBl6ed1wXa8jhgAG+vtJpQ5IAdbz7Mm0QOpQx5Lsn0u2bLHdjkYUx/oCSa0qhVl+2XvRyK4qWxJTTEdGnF2x1j0dyk52aRfvO3gacQz7GQlRXXRTqtOs3IgGCjeIJviRONof36jPWAglOnSHYjlJIkxIdBh1C+oifZPVe4CDVE+vTI+Gk89CQkGjmS/CrcIXeXu8R1lD/XRgwYqj1zbwNxZVPaQaNC9Tm6a8Fesqyostgra5mVG8Z4EMcymbnFPhOXbFBZ9G/KGqvpFC3zTBR+P37rl1ZaG8LDHLqANlrXtjw==;5:hVx+zeGTaO0VMP4iyfGeAExjtv+xLBiManQfB1weAwIrawt1CIvVKeUnMp6/4sGGSJwEHzN/beK6iUO6irL3eQozIl6s/9gVtYS4fy+IujfVJA4FtZMFSFE2Iq7tHRCSZZNgBxTb6rPMmIyr5K8JkrdU/27pq9oja/8Ofv7QSRU=;24:DQsPD+VXiTX3k4x+4ZSZG/JbV+JyQAEikGyfVAarEzaKORL8Be5M43IH85S4MvydbUKhohlpJ7hfCka5/yWELyMOuw0F20uRqYMlStr6BTk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:E2KX6ijtCKpFSOZwPcCv49x5+nCmx7974+jlS6DFSwaV25fbtoP8CYxKZHB4p7O+s1J52iAfqtu5otvFeA4+yXIZMsGu5toIO1lAEj7BOSd8f87X2YVFM5Qp5xLUZtWTeIL1D+BJJQRfZHvII+yaMy3FR6DmN17UGC8AfUiV400F05ML1t9j+4jrxOaQ5jK3m+jXPBXGeIqe4KyzfAFkzeKTEbvWhD1fmuDxwKICs/pDLFMx66FhoF9MJZG3ZsES
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:18.9820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db9454c-d268-4156-b9fd-08d5d68b21d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes all locking from i2c_smbus_xfer and renames it to __i2c_smbus_xfer,
then adds a new i2c_smbus_xfer function that simply grabs the lock while
calling the unlocked variant.

This is not perfectly equivalent, since i2c_smbus_xfer was callable from
atomic/irq context if you happened to end up emulating SMBus with an I2C
transfer, and that is no longer the case with this patch. It is unknown
(to me) if anything depends on that quirk, but it seems fragile enough to
simply break those cases and require them to call i2c_transfer directly
instead.

While at it, for consistency rename the 2nd to last argument (size) of
the i2c_smbus_xfer declaration to protocol and remove the surplus extern
marker.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-smbus.c | 28 ++++++++++++++++++++--------
 include/linux/i2c.h          | 11 ++++++++---
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f3f683041e7f..e89956ec5e27 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -463,7 +463,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			msg[num-1].len++;
 	}
 
-	status = i2c_transfer(adapter, msg, num);
+	status = __i2c_transfer(adapter, msg, num);
 	if (status < 0)
 		return status;
 	if (status != num)
@@ -520,9 +520,24 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
  * This executes an SMBus protocol operation, and returns a negative
  * errno code else zero on success.
  */
-s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
-		   char read_write, u8 command, int protocol,
-		   union i2c_smbus_data *data)
+s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+		   unsigned short flags, char read_write,
+		   u8 command, int protocol, union i2c_smbus_data *data)
+{
+	s32 res;
+
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	res = __i2c_smbus_xfer(adapter, addr, flags, read_write,
+			       command, protocol, data);
+	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+
+	return res;
+}
+EXPORT_SYMBOL(i2c_smbus_xfer);
+
+s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+		     unsigned short flags, char read_write,
+		     u8 command, int protocol, union i2c_smbus_data *data)
 {
 	unsigned long orig_jiffies;
 	int try;
@@ -539,8 +554,6 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
 	if (adapter->algo->smbus_xfer) {
-		i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
-
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
 		for (res = 0, try = 0; try <= adapter->retries; try++) {
@@ -553,7 +566,6 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
-		i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
 
 		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
 			goto trace;
@@ -575,7 +587,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 
 	return res;
 }
-EXPORT_SYMBOL(i2c_smbus_xfer);
+EXPORT_SYMBOL(__i2c_smbus_xfer);
 
 /**
  * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 254cd34eeae2..465afb092fa7 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -140,9 +140,14 @@ extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
    and probably just as fast.
    Note that we use i2c_adapter here, because you do not need a specific
    smbus adapter to call this function. */
-extern s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
-			  unsigned short flags, char read_write, u8 command,
-			  int size, union i2c_smbus_data *data);
+s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+		   unsigned short flags, char read_write, u8 command,
+		   int protocol, union i2c_smbus_data *data);
+
+/* Unlocked flavor */
+s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+		     unsigned short flags, char read_write, u8 command,
+		     int protocol, union i2c_smbus_data *data);
 
 /* Now follow the 'nice' access routines. These also document the calling
    conventions of i2c_smbus_xfer. */
-- 
2.11.0

