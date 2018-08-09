Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB20D21C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="JKB4RECL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20D21C17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeHIJEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:04:13 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:34612
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHIJEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffk6q0GUaa7OMXlMS8Mz8Mwnvgl+ANeeG3Oh1+dZkgc=;
 b=JKB4RECL5SXcA/7B+UkWWMRQFIRaEXEfE3Vz6J78xH/4lLGh0VvPHDTh29+t0WrjZTUjycXPMAAMUUZiEaHHBsSwMjUtBLDeGOGquLARKEzEGjAzFkFY3Mypoaxel6uGlMe3PERlUnBw/llO1+D3rISc55algDx/JZLuzjUxKCw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from localhost.localdomain.caveonetworks.com (50.233.148.155) by
 BYAPR07MB4917.namprd07.prod.outlook.com (2603:10b6:a03:55::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 06:36:55 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc:     wsa@the-dreams.de, jglauber@cavium.com, george.cherian@cavium.com
Subject: [PATCH v2] i2c: xlp9xx: Fix case where SSIF read transaction completes early
Date:   Wed,  8 Aug 2018 23:36:48 -0700
Message-Id: <1533796608-26349-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: DM3PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:0:56::32) To BYAPR07MB4917.namprd07.prod.outlook.com
 (2603:10b6:a03:55::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6212e374-d30e-4f8b-4ede-08d5fdc2806d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4917;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4917;3:2me48thWRBLhS9ov5hUviHxhYRzmvzBJxrKdDbR+/9DH42INfOBDb0hE/O5ALLXA6MwW3AGf9WuDod7vcBaVa35tAATFk2F9DO8faaJ1xG5udUBXcGtbsXLGu7KsFuLf7kDrLwto6v12smN1oYMYt3FmDq+sz9ZRzh2SWMKbV2xXYisrklheHbqa4ZsWK3ysY1823Tw26SOSCOaXcd2KslQRwd2pI04jsXUFGJ4Jm6NBkf61Q3vux1JevbsQ2akL;25:RC9qYPTmlR5Fk5vR2iabot3EqCAFJqQW8dD+Rnj7Iblod1aw1Xb/lte1J0aX9gk+HovZ9vKYTEr78lzJfx0IeSEsAkzf7o362wDaMs/DLdIlZgnA6Bx4Em7iyt7eIFeJ0bWnua4CoteXdqyuNuxeI1sGDHfrmHS/tLBIcBjxOw/qFf6v2Q/d/jGcrzPOFOX5Ogv752vOPn4AlVqiJBkcjIGJAH6rtAcG6OIzpGTMZCo40mi152atoAJss89o2cor85xfK1/B3Tm+xKMw2/dYY3ABMEu7lvVKBXv0dbKTCH90UgcNedAIlNh2tdfPasqaUArbxPejxcK0x/BTv2o+fg==;31:TnxHW0+ib11NwOCZPTFiTI4j6qUHgey4dyXYmqRrN8fMvCasxLDz1Z/AEVr6KY4qccJLtbqmt/PNnXXpaLACD+D19UTX2JfSlcIgVFMA0t8nSk7Zxyv8bffwdJoyulCtwrmFiVP6J2otsq/eGZ1gV2nb4EKJOlmrY/D7v1wh2ql8jJutvqexfDZtdLspNt9O/OTWwhfHUmdhauJfgbf420mkZQfmeyOsFQ2snqeWGEk=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4917:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4917;20:Xk1ARcJPccP6wHFqDzwp7IzZcVd79dHZhvL2uRu2DbS/E1Q1kGhL6R0KXgGYnRQlxOGqPDua7oAmvH/uYnGySc3X662oCP5zyeYSBOhaUB8RIY9BOfbAZ0cFmIb6i2S3KMjHyRmRGurabJa5rRBMlMX7irnyk0pwxKszTQwPAugwmV8+DtOS/MuDu9nAp3gHBIMoC7BYwS3nr1uETLpYzjRm9uVUh+iYUDxn+lDlrr1YHFSeXUP0kgmJHtEyUyBE5z8niLdETxY4O++Ic4fWZNUWinBNUhGW4AAI8D/LnNcDiNJDBAVu7jubybSpJCS41v6K+drUFpglKo3P5Ib4jgAo523dulZqCLgEKKqu7S2b2PdUabOPaOhPWoNdAFSlqqf2b+Z24A90uKupi75ot0OcQi/1pYiDoY+Jnz3q/Q1QIj3RgSD8uZ1GE04wngINPAhekl5XC9MyWJpvihxuYLhYGLESfl23KNEUg2kLEKHROB6lhhnCrKjW8H7W66tR;4:lWkjoarRk34tnTtg1q82TDyLQioMd/JF0qCTFDGfg2L2BqQ6EhErxKUylYGxE3TLhLhlfOMuK5KuEk31YuSH3306jp5L2OdZdgx1TlcxCmyJzSW3MM4wHZLh0CTGrsfOGBsP4cDddpTK8skXWIvLjiRCfHs3L4w7+d/GlXD3Qf/GgkQy+T/FzAwlvvoIMuwIkDJ7t/a5jj2cZ6ota6cQSK6GXSM1jwzPoPk9pOCHXawgNbFtGnYkxXLv4T5Y3OPCuCxpB2u/OpxedBeqCTscwA==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4917D6DAA1028BAE0CB7AE11F9250@BYAPR07MB4917.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4917;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4917;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(396003)(136003)(346002)(376002)(39850400004)(199004)(189003)(6666003)(2616005)(6506007)(386003)(956004)(4326008)(4720700003)(186003)(86362001)(16526019)(305945005)(26005)(5660300001)(107886003)(476003)(486006)(47776003)(66066001)(478600001)(48376002)(72206003)(7736002)(6486002)(3846002)(81166006)(105586002)(8676002)(81156014)(8936002)(551934003)(50226002)(36756003)(51416003)(52116002)(97736004)(50466002)(14444005)(6116002)(25786009)(2906002)(68736007)(6512007)(44832011)(316002)(106356001)(16586007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4917;H:localhost.localdomain.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4917;23:ix/07BcPCJiQGQcHe6SRWCYUfuf5RBvAi9krtB7k1?=
 =?us-ascii?Q?zk4hVwKFRvJihD6Q/HeBTIANHgIqGmfu4xkhHr3qxnzyNSZyuNjcektMUKrm?=
 =?us-ascii?Q?RINa7KxyfiiA6Xkocl9CTEpyoRidLnbksYnDJD6t6p8Bh9BhNejoTHtw6YUh?=
 =?us-ascii?Q?eclTWa1QmQWvWc26DoRlSIAMljHbkFD3KZIsWUTZskFHgyybLDimVQm9Hc7V?=
 =?us-ascii?Q?1p3DWTkXvwZm/GOysBWODJ2Z+7ffw4i5xik1pKXLMU7zZO6r4PQrrQSkkRbS?=
 =?us-ascii?Q?6qAUOSJDcJf+/VarCh5ZBShJMvH7zu+tXTorNmDl0XUXDC8qjf4hAtcX1BUe?=
 =?us-ascii?Q?euOL9K2y/xDxB/LB1uCg0wcu6Cixj6vBMI5Ym047FeerQInAROWGMayIPhQs?=
 =?us-ascii?Q?NfPMOQv/Ow3Co6aJUtT2ugJXnqBI1qP6Q2jT/k9/eYzkkEoYK9QXiU0XUlSV?=
 =?us-ascii?Q?zP6uP24HOMzMOm1avtAiYb9G0A3xMrY/fREtpo7bjtalBnwvx8SGREzRVL3C?=
 =?us-ascii?Q?/ROEngAfvOd6p1dZUkKzOOmQKHDPyQqZLBF5hm71tios/GApO1pkEVk3LPHT?=
 =?us-ascii?Q?cZ7zaC3tl4HjKCmWqLZ5d4y6+AAHqcIPFNQNKIx0a6FeK8u0dGZUmND7G6bh?=
 =?us-ascii?Q?RxTmL3M96hJsjrBlrOleX0tREmVnQnsI9fY4dfzmTTgHd5OuOjh6XQhQwlei?=
 =?us-ascii?Q?xZQiWQRNc2RPIKRFUTdcBnBEO8xzvdyN78Ofo/4PXXE+l/ZSERvqemeY9eUO?=
 =?us-ascii?Q?EM4oWRgGFelOz92af+h7+JG6YI/KqJ1j+rPwGEFJcdDYT/JTRHuCsMpL1bjY?=
 =?us-ascii?Q?EQ1aRSng18quMnrmRn3sezPuqFZVab2uG2sJV5OUMVmRQ9Zty1hHzFU1rGsV?=
 =?us-ascii?Q?qWuyVtWyD5OIKwx/5IRV2VxdlTWUfjYXHjeBrcXQFGSDwkbRF7HoQ39W5HIR?=
 =?us-ascii?Q?9/QaWsQqC8mMKQcTFi0FUmjXKQd/xmNAtc9mKXe5bHSGlhPDs9L9UUzXVqiU?=
 =?us-ascii?Q?9wmv2l7+sUkkIafZXqoQjEdSf2aPNcT5uIrmREmRsnEUjZ7QN4Mwd3AYaCuN?=
 =?us-ascii?Q?ta3cy69p1bV/hnsN2v2ab/PqgqAvbp23IvrIImwMkXKaGk8gISJQWIu4SKd9?=
 =?us-ascii?Q?ul+wLeBlD8rJH5A5y15FZYQHb73ieqg91CQyaen9iSg1bnxdqGtKNaA5xl6s?=
 =?us-ascii?Q?Rk2kbsVJQHdUAhkqAZj2u8gz19M1N5t7j/fVrHdXMtohgz1WQgaigVCrrwWH?=
 =?us-ascii?Q?15uE9X/xjOKhBAJTOM=3D?=
X-Microsoft-Antispam-Message-Info: sweYPF1D06OD1wpVYThHhmHmTV5tgiWGyQTBsszeZmtEv8vsdJ8hAXjelCn6rf/wNB8n6zD66ZSp9cDI07KwuOL/I32mQEvfCMm5ximOJsO0HRVN34zBC5GgQOkwQbg1Oqbs96EfbnSzcqQ57pK5SAmqf0POUOZfLcj0lrPV45tdAB9Ku55XqZVyaNAoSbACJqEii2QsUbIxi+QdaRHU0p85ldAwYePx4UD9i3LfcvyLf6H8Uou4/VWiE3wgazNBoO3RjSD8dEb1n4NrvW7BBSJrIB2CysPTh+2qQGJODjraTdrJoKIesRo0jw3CIM5+X83s9TalR3h8vC6oH6kdOzVp+J9QriP4Z8KkEqEmyt0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4917;6:qwUc7LGVDoM7AHqTf4iGxzOq32HNc+URLJiG3/huNZx5YEjT7toCaM5dO/uSfpWzvN6AtrcC01QAaFXWOfGnYgXpJOHFBWmZv2wKBORUg8CwR0Kt1r3L726T8UIfuLuDVAXlJyRwdeEgbfE5eCZ+1ugZj8M+Ws8lt/fwf9mkUxjJoHsq2k1ynqS9FXDbnhngyFHeqfHAqW9669vplPcD8s0vzPU3MQatf5ck2v8/RiZxFzBB8Oth/APcSugkPfA8Wsd/498QARYp7Gfm87rCzwCnE/31LM73hPopVsfSM3mdXrAVZObd6tliodRqhpezzz459tGqioINiKhUXt6a99EI/ertRM58r+Q+xOdyUEjJFuBHV8BzH1pACLgypZwEDbqMWeWXtbiLD9lWLMfbJHFzXW8eo6Jf7e/Yrh5Dlz9Mm3sZSYS0PJFOlFwmAZJ0rg13G/KBj65pr8gD5i8Wuw==;5:wVxrKtTqN6I0TpsjoA8m7tnUX4B/BjuTVPLzIV/wGtHCaqt/9BP5u4FeADdfDuOpstpNUrrWqI3PwpkiHUHmG9wiCK22zxyrsnir7IJVLqo06GPfng7l9LlAsNiSBIf2Hu+EX/3vbZWDZKJj8eWUr6TTASCVx/jaPB/Y9n4eSdI=;7:+h18gAIlE7gleP6F3RtkXEXDH9BZY8ZXXoQJ0qurE0yiogHOTA8r7G7CfloRHHic2icXwFgS0LyOonCJeS2GZEqKoI+ZNEBNJ3F1qiTpnDpVS2wMDi8AWLLqmxgPjyLJTyWpAZnwvHdqNB/omq1uoR55uE8gy6xRNJv1PztcKp8wOjRPqUiIqtGOlC1Cgjm7jnFuJlkKMmGMVwK/FqnHZugHErsreVJSbi+BjHxLN2NwS8u5w4Pe944wrm0E0+pe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 06:36:55.6338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212e374-d30e-4f8b-4ede-08d5fdc2806d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During ipmi stress tests we see occasional failure of transactions
at the boot time. This happens in the case of a I2C_M_RECV_LEN
transactions, when the read transfer completes (with the initial
read length of 34) before the driver gets a chance to handle interrupts.

The current driver code expects at least 2 interrupts for I2C_M_RECV_LEN
transactions. The length is updated during the first interrupt, and  the
buffer contents are only copied during subsequent interrupts. In case of
just one interrupt, we will complete the transaction without copying
out the bytes from RX fifo.

Update the code to drain the RX fifo after the length update,
so that the transaction completes correctly in all cases.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 1f41a4f..7134f72 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -191,28 +191,43 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 	if (priv->len_recv) {
 		/* read length byte */
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+		/*
+		 * We expect at least 2 interrupts for I2C_M_RECV_LEN
+		 * transactions. The length is updated during the first
+		 * interrupt, and the buffer contents are only copied
+		 * during subsequent interrupts. If in case the interrupts
+		 * get merged we would complete the transaction without
+		 * copying out the bytes from RX fifo. To avoid this now we
+		 * drain the fifo as and when data is available.
+		 * We drained the rlen byte already, decrement total length
+		 * by one.
+		 */
+
+		len--;
 		if (rlen > I2C_SMBUS_BLOCK_MAX || rlen == 0) {
 			rlen = 0;	/*abort transfer */
 			priv->msg_buf_remaining = 0;
 			priv->msg_len = 0;
-		} else {
-			*buf++ = rlen;
-			if (priv->client_pec)
-				++rlen; /* account for error check byte */
-			/* update remaining bytes and message length */
-			priv->msg_buf_remaining = rlen;
-			priv->msg_len = rlen + 1;
+			xlp9xx_i2c_update_rlen(priv);
+			return;
 		}
+
+		*buf++ = rlen;
+		if (priv->client_pec)
+			++rlen; /* account for error check byte */
+		/* update remaining bytes and message length */
+		priv->msg_buf_remaining = rlen;
+		priv->msg_len = rlen + 1;
 		xlp9xx_i2c_update_rlen(priv);
 		priv->len_recv = false;
-	} else {
-		len = min(priv->msg_buf_remaining, len);
-		for (i = 0; i < len; i++, buf++)
-			*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
-
-		priv->msg_buf_remaining -= len;
 	}
 
+	len = min(priv->msg_buf_remaining, len);
+	for (i = 0; i < len; i++, buf++)
+		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+	priv->msg_buf_remaining -= len;
 	priv->msg_buf = buf;
 
 	if (priv->msg_buf_remaining)
-- 
1.8.3.1

