Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27141C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616620676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDvzsk3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A616620676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeI1WnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:43:20 -0400
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:19904
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbeI1WnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVJtdgQdaIS1lmiqZ843v6NgzKKPr7mymocEwXzeMMU=;
 b=oDvzsk3wUHwgeuDdLr0pzbp1RQRnF1wmypIY47+lc30eKTa2xPULwC4zeDWybXiMz4Z2yM9c/laXvtHDDOQtx3xRzgrIsl9CZQh4CQqUZnEerUBCd0JH16mOGqfYlBkvZKi7B/cfzOYLAWwEm7DyeZncVMLw6nI5MVlB4JCiyfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.143.30.134) by
 AM0PR04MB4243.eurprd04.prod.outlook.com (2603:10a6:208:66::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 28 Sep 2018 16:18:41 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     netdev@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, davejwatson@fb.com, davem@davemloft.net,
        doronrk@fb.com, Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net-next] selftests/tls: Fix recv(MSG_PEEK) & splice() test cases
Date:   Fri, 28 Sep 2018 21:48:08 +0530
Message-Id: <20180928161808.10363-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To AM0PR04MB4243.eurprd04.prod.outlook.com
 (2603:10a6:208:66::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79a33dda-f244-4536-aa3d-08d6255e0f5d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4243;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4243;3:c1um3I9j89E8Go8s42s2fBh+ZtPNUffaqe9cyv2LWAdDzsvlGo55jntizFEVbs5ZVzCE8PgV7GSu90pRMoHVzypxHV7scUyxP9Ch+q0Sw+3A3ofIMIsEQMtZz6WkgMNPBuJfzHCj6haFMc2OD/jb4dMZYKdIWO6OjBKTKrQkXqFbWPnOxMccZf7uLhTLVUmq3An3C5/zbmxMGeuKZCjh3sHoV+CgtnqK0uzcrA7HyXjHT0pkt1DlQ/cYS2PeUuor;25:1g+cKkNFt5kJFrCmtRuTBk6CcNzKdjvQVi+xYmhEL5U+fNltqgzDQqEfX6PQp1hZeQ1l85zgWk7l4AhhRsNPPaderjM1yRyQ69SJfMAXnCQz6PLWoFc4CguhDazvshwXlW/Ribu3Gv5q54WUHVyDNyey/CAT9Iuig8vR/UH6hDx3YbBSWcAsuK4MCr7N3MWybgFdgoxP+S3u7vG2LYPUka4OdDyVVz7aDJmA45fsP7If6dm+Q6HlONF5ZmvMU1lEZlHRxmbsXq4ubbtQwITRCEa6iql0UyNmowiCdtIg14i2vwIlXJLBvUDi6SPMICx0lIJs99JX9AThvQrTht+wWQ==;31:SWALOxMbDgWVAacXyYfpaDQdliO8RUd1JrzN9NkbgQskzJ5hj9cKHPMpCceaIiiYOd5AVv1OWle/D3gYyRm97Pj+D9phhPiExOxrYqDFmSmj/qgTGVJzLa+hpd5zEYOKaSN+MoagrhdGAKwDx7CcPEMXqLGSHsVbLf4n1ydOMl390ho21H1kG9Iuw3XK3gMS9clfr32rK/dg1NF3C3OZS7N2WsRxIQTpRjpJHEwjVKc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4243:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4243;20:RZMwsBhDZFvOcW6RYN6cqqbEg1V02EiOyzC3FseFa2V6ERrdYy0droL3K3DjspCGxdGKhs+bXYqC0NpM9/F7kCwIECKETqaY+BCdRZzYftWt7WWGamb3Zih1UMFqgxs3L7ouGSAii6Dg4MKF3jNH7blNcg91uKtEokVtnwpzKkkQVhOEe3iDHRnCby8VztTVB0QZyavFaYNX0Ew79qUuNfoDreLtPPnHb16RSnM9sdpNxOykcRLU7jghL4N6Kil9ed/iBMlmQbAeBco77mdw0pi6Tj+GCKPDOI72Q1URIp9ScjDGTLwMKM8GloxPXWiE1odo91emnNZHGJwpvoYeUNp42NR8xrNktGz2GA9vAKkgh8hSh6+ss/FB5W3tFvhCSGCcjJjUwK234kO60qouTMq6eItbsmABEmVjntCDa+yBNxpvK1dI7oAXlFjl6mm1dg+oqGMgTVxRlqgV6uYImd7GyGK0DJZMrOFTcj9C39/hcLdy/HeVcNNknOQNAwRa;4:zvKzPiQP5XT2rUHS+UMP/viSx/KZTRUiQRwwDhWck9okCYIR7FiMsykxh4gBk9l4dFACHZEt9wZu/N/LZJrwrDYS3oylIlvfrpQHIwzMs+olHBOwuxIfEIswKmmellj9BeaFiaVtvkL46rh/cZP7JnZLDi/9BLv1imJ+VgtdbDgbiNf74APESjl8NjbM6oRlWcHC2sSvL2scfjzj2iNXcYCnKtdJiRS/yUxRhKCM0JEnxdojUk/ehp3Ts9E+YFP8tbmzznBfHDAsCAcRUxv+6yvragreDh4OTDLdXsV8YA0GY+6RrW455+DNiJfcAyuZ
X-Microsoft-Antispam-PRVS: <AM0PR04MB424352AD3542910BA6ADC7AA8BEC0@AM0PR04MB4243.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4243;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4243;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(956004)(106356001)(105586002)(52116002)(6116002)(3846002)(486006)(44832011)(36756003)(5660300001)(476003)(2351001)(6666003)(4326008)(53936002)(2616005)(97736004)(6512007)(6916009)(6486002)(51416003)(5009440100003)(50466002)(25786009)(48376002)(1076002)(316002)(16586007)(186003)(16526019)(50226002)(8676002)(2361001)(8936002)(81156014)(68736007)(47776003)(26005)(6506007)(86362001)(305945005)(2906002)(478600001)(34290500001)(386003)(81166006)(7736002)(66066001)(55236004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4243;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4243;23:o0lwBmuMKezhLJIxQrrdrYcqJK/RbrsGSAzs7rvJ5?=
 =?us-ascii?Q?rk1I5qUC+jAjvn/HqRzs+H7bKrzTOEVLGCGmGz6Qe+VJLCSVtYnq8QIrsigJ?=
 =?us-ascii?Q?tIE9CT5ZNDMbHwmJY8N30NpwtfaiEipLF77t/nGbyMjaC0F0mtkCd0SEo66R?=
 =?us-ascii?Q?Xj2CFnsWA6dO8jPThkFAYVYRSm/uhwwcKKYPVQOpTokIjPKB3TaRUb7ge0+u?=
 =?us-ascii?Q?2nYru28uorBihWO2dTWwzxh4LIqiNHsa3tGMj8ZoItGjwK7fkiPG7TyZOzhp?=
 =?us-ascii?Q?DXhKsK8Qqnji8cgtNn+AeIxSRRoDH/pw8GQHDILtClu7HunzT/6J4n6x8uHO?=
 =?us-ascii?Q?DcpS9DFKlzrUG5U0mOSfLqvx1S4Un3NlujprHjEE5XRGpL1rZd9Oh3Y136so?=
 =?us-ascii?Q?ZpLrcDCOQ57mBjUHNwJd3LCwKXvElK/NL6Cw32eRWvfrGOedMD5J+NsHQZPw?=
 =?us-ascii?Q?d3ZM0QD17tknXlzaJTmemeqHguCxv5uxz7aby6a6fx52mixLW39Nw2m5lr7K?=
 =?us-ascii?Q?5NiTnDMWpjqem0KIvkBxBz0HInk7aOHATluvI4TqiomNTqnPOrSvpqnhZdWJ?=
 =?us-ascii?Q?d+/Ch8j4KtiIr+RV7bfDQl2pyrynxuSyUeOTdwQmGxzbexgmqKuvAPMtevq4?=
 =?us-ascii?Q?lJOwB1gmuV3R5a02XnBO8NEIJbrriaqnyFv6yP20iqaQSeRw3GY0mp1a/GF4?=
 =?us-ascii?Q?pCwE7GdfGBR/94+KTqgH1zNx3njmP8z8NC7aRUtj26Di8SY4udR6s51mrcqn?=
 =?us-ascii?Q?roG6XkOUI6YKnPBYFCx0C9LEu7bI41HSv5JaaMJmN5Gi9pKjp4KEYmwHy+RH?=
 =?us-ascii?Q?1/iI7yAAONruhGhDNdVUjVNWDDVg/DUYyvVphAQSiDsX4IeXNCn6+AJ2nCeG?=
 =?us-ascii?Q?q0pX9GrfhFhOTv+XDQ+2RJauBjYUKSFEm7t/VDRmv5CLUpGYxDaJMuqjxtH0?=
 =?us-ascii?Q?4xf0af4boq9j8kpoCEmvxzfUUBWu/H11eP10gG2P38DlYh9UKyudZzxg8acP?=
 =?us-ascii?Q?vMlNt38zUEDP2iF11VOPPBoNCe4ycgqpNtiiAf3v4IpA9vDotCQiJFfim07s?=
 =?us-ascii?Q?54UVNlUgIsqXkQTDWpvcmeUJCUTxK20ROVjGRqVqE9w+763va6fNNHldBHaO?=
 =?us-ascii?Q?kKVpc0XxOQHKx6mPnesC29CMTMf6j/BWFmWwoJpYikeGtvBlB5E5HjQtVLsO?=
 =?us-ascii?Q?vQ5dkD3L33N8a5dPn8OwLe/usHdIYtZ0TRo/sXRncwjBdf19opzVsJlF+E/S?=
 =?us-ascii?Q?sh2bWp+1FH8RSqLYrsMuzKLWwS7CjbwOA3LZnA4Ezg2w5Qw86QABO84najmc?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 7k9VxErQWLiaHj01TuAwqYz7JO65SuE+VcnmeA3gfZhTDYCM8iBD0/eqYylIgPlA026oE80tkX1yi7SkkBQVWFO2QF9aOYzgzo9qv3hs9jw81wXscw/a8mQC8X8P0IXHrVeLS2RUV61R70CJQlrcDK61U692scqGXDcmGkJGG5lDzjauiJaXp/sGKa9aUET8kMmeoFUmyniu2FRXVtxSFhiwhYvHVwWLA0Mzqsj4aEXWgGZqkRED/pUC34s7mJOKwfc8sKEAdJgQE8EvogaWahQuZmwGydYuv4/qnXIcc6uqGdZMv03X1pRPQq4yf3Uf2g8uZl2jkbMTBP1dO+SRO8BCh3vUZZPobZVJ1bpaCzg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4243;6:ChMBSYXtbbUfZQnENLPP4+UrR3MA1zvgB8vdRBr2FIG6Nh0kT6uLYvRfqYVRglJGzx5qEauVrYOlSkos1EotqnAStfeSb75Qk+TQ3/QrhawHKrW7SYp7gz794pCGui28kaF6VYyXct9avX4iFxRNGS3pBQPgwu7MmKZsb3abJ1ruPDPSzKaLg3lwOse9e0vS/OlnA314SFQziuAsMwB1Ro1v7mXlPWKGf/JZ8m8CvZQDN/eTM5R+zF8ToUPoVyowUsj+eobHUNSCtcL2FjXj8DfYV7bmhlxKwtnfcvczQLX/ANFGv7uUb3dTC2bl2NEth/Fr+24Ea7LfAGyXDe57JTEFW18mTUyBC3DLjdI8Ckh/159PYWWFsDqLHPIdFjgt1w1NE51aKvGERd+4Myk5k/EZmcjTO3nbNtXhDvr3PurwmizVlEMIZEMpTxRp1rPv1b23ddEdVK0dgKeZPJ/JRg==;5:e4A3Mb4CVvdtlQRNZ/dRpvAyyOBbK4lUrI6iDhzvWVw3rqSOQVi+pHU/bs+stg+pV6efCOJa2ZGTeqGnETG/JaQG1giLfJ4uVr9z+JmtIDiHf4Fm2kwhHEcwO1zfIsKMGoYGdWqEg/9IDoB7pkRZ6LFW5Dxs5v3/eD7XS1sfl9k=;7:vk9+eo4Rc5mG628Prdchzi9zn4CxHzF/RrznyKSU3ckcn4+jQ1tiWdyNiBgQRu0seOWZYaNLfUCAoKGo7BeMXY/VtKON3ZPGDGjlYJQboCEhXF00a7qWeA97KFU08pvedcgJA3XKyxNKYjXqfFQLwiOW8JKKkrSqr0OFW2KY2jFz7A11th6czUr9vHLIqsQEPj7ALM3IbQXDTq31EUp1U2OfN0L0r+y8pjsInNehsr2S1i+h77vyF03sWtZ4RT4p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 16:18:41.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a33dda-f244-4536-aa3d-08d6255e0f5d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLS test cases splice_from_pipe, send_and_splice &
recv_peek_multiple_records expect to receive a given nummber of bytes
and then compare them against the number of bytes which were sent.
Therefore, system call recv() must not return before receiving the
requested number of bytes, otherwise the subsequent memcmp() fails.
This patch passes MSG_WAITALL flag to recv() so that it does not return
prematurely before requested number of bytes are copied to receive
buffer.

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 tools/testing/selftests/net/tls.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 11d54c36ae49..fac68d710f35 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -288,7 +288,7 @@ TEST_F(tls, splice_from_pipe)
 	ASSERT_GE(pipe(p), 0);
 	EXPECT_GE(write(p[1], mem_send, send_len), 0);
 	EXPECT_GE(splice(p[0], NULL, self->fd, NULL, send_len, 0), 0);
-	EXPECT_GE(recv(self->cfd, mem_recv, send_len, 0), 0);
+	EXPECT_EQ(recv(self->cfd, mem_recv, send_len, MSG_WAITALL), send_len);
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
@@ -322,13 +322,13 @@ TEST_F(tls, send_and_splice)
 
 	ASSERT_GE(pipe(p), 0);
 	EXPECT_EQ(send(self->fd, test_str, send_len2, 0), send_len2);
-	EXPECT_NE(recv(self->cfd, buf, send_len2, 0), -1);
+	EXPECT_EQ(recv(self->cfd, buf, send_len2, MSG_WAITALL), send_len2);
 	EXPECT_EQ(memcmp(test_str, buf, send_len2), 0);
 
 	EXPECT_GE(write(p[1], mem_send, send_len), send_len);
 	EXPECT_GE(splice(p[0], NULL, self->fd, NULL, send_len, 0), send_len);
 
-	EXPECT_GE(recv(self->cfd, mem_recv, send_len, 0), 0);
+	EXPECT_EQ(recv(self->cfd, mem_recv, send_len, MSG_WAITALL), send_len);
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
@@ -516,17 +516,17 @@ TEST_F(tls, recv_peek_multiple_records)
 	len = strlen(test_str_second) + 1;
 	EXPECT_EQ(send(self->fd, test_str_second, len, 0), len);
 
-	len = sizeof(buf);
+	len = strlen(test_str_first);
 	memset(buf, 0, len);
-	EXPECT_NE(recv(self->cfd, buf, len, MSG_PEEK), -1);
+	EXPECT_EQ(recv(self->cfd, buf, len, MSG_PEEK | MSG_WAITALL), len);
 
 	/* MSG_PEEK can only peek into the current record. */
-	len = strlen(test_str_first) + 1;
+	len = strlen(test_str_first);
 	EXPECT_EQ(memcmp(test_str_first, buf, len), 0);
 
-	len = sizeof(buf);
+	len = strlen(test_str) + 1;
 	memset(buf, 0, len);
-	EXPECT_NE(recv(self->cfd, buf, len, 0), -1);
+	EXPECT_EQ(recv(self->cfd, buf, len, MSG_WAITALL), len);
 
 	/* Non-MSG_PEEK will advance strparser (and therefore record)
 	 * however.
@@ -543,9 +543,9 @@ TEST_F(tls, recv_peek_multiple_records)
 	len = strlen(test_str_second) + 1;
 	EXPECT_EQ(send(self->fd, test_str_second, len, 0), len);
 
-	len = sizeof(buf);
+	len = strlen(test_str) + 1;
 	memset(buf, 0, len);
-	EXPECT_NE(recv(self->cfd, buf, len, MSG_PEEK), -1);
+	EXPECT_EQ(recv(self->cfd, buf, len, MSG_PEEK | MSG_WAITALL), len);
 
 	len = strlen(test_str) + 1;
 	EXPECT_EQ(memcmp(test_str, buf, len), 0);
-- 
2.13.6

