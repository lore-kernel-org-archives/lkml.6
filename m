Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430FFECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC46B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xEu7zYZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC46B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeIPJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 05:56:34 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:61360
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeIPJ4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 05:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwSwqULIbt+lQgOzuxltg053Ezp6z6YVzB45BhEwyzQ=;
 b=xEu7zYZRp9mmkpl677fDalUzlOJUEuRlLtstPjPnbPMnOYt1s4RFRaAWg5FwC/ExSZngsfGvpvsz784hSsCDVR8UvEfC+rkEH8my6j4e93iIt2mw1dreoIsuM62X/muOoBEOb/BMyiJQeCl374on3SYTgdNDiVT1T89uUmwXdLs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4250.eurprd04.prod.outlook.com (2603:10a6:5:27::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Sun, 16 Sep 2018 04:34:53 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     netdev@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, davejwatson@fb.com, davem@davemloft.net,
        doronrk@fb.com, Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net-next] selftests/tls: Add MSG_WAITALL in recv() syscall
Date:   Sun, 16 Sep 2018 10:04:28 +0530
Message-Id: <20180916043428.24329-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To DB7PR04MB4250.eurprd04.prod.outlook.com
 (2603:10a6:5:27::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ed286e-79d1-4e99-4976-08d61b8dc050
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4250;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4250;3:6dHzcxD1FL330xhBqWbQq4uaJ6x0mNOH1IJN+S/Nua3ItpyCgojZrTf6NoC7guCiBSt4MtbGVue7bz6Z8KCODJME87ZNeFgjfgPnkxkc92n8F7kS9YmbbyE334/Nj0XGFZ5lA5+40PHUeazOYg3/4+jvY/KR1RyhXpVZAMFSvz1hPnyuPPawZKuCifWUCI3twgqwNlJxC7By5fAynWF9fxWOsTAvQ+P01i5Z0g8LhYSAG9vj4+vIrrcItpOVshB6;25:X+ijHP8f/z3r4TjdwesuYKLNMaBJbCc9Dku5CUyDg0AYb33cqcpvHgUpcmhZmGII2LGDQHy2saP09QQqYVUTRMufDX0LxSdGlcndVFNDDvksntwuRESJ7jAoILEt4ZlT42mYPnVaXRkKY1GmulVaaa8QyTy7fgU8Ku5hohlfD3f1txsgE2CCLhZOfei0ZqFpIYnLizH2/V4rr2fQjZslIkt6zGsfg5ZR61F39q6ve2BMGp6R9Q8dgGTT7f+I0ywLgD3wrEyzQyCeYaO+wkTSymYrVDzQ8q0GxxP1Zc0swraXsxWuiHLr25F+F/LabI3ZFC/SqRdmYaU39pWouOP45Q==;31:SkOO6SON8of07QHXut5MjoR696dO5Ch000Vk1fLgR2EDco5KRUtgXvS04JfPDae4gl7M+fNhe2RBXPRW2+pKJz/xECFlCaUptouZ6JceLY0Qxqx+TmikUM5R2EY4WplbPrwccvGAQ/z7MltoLrJO5sahVU2s3FobNSKSYtOr+3LPDLkDrkUdOPBUQdkTGnRzQSg8VN5Pi0SlX7Bb/RLCm4Yd46KdPjCsN27XtKWdx7M=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4250:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4250;20:6BUybBUHnel4UiTRXV/hTXqMH/BJXCNdaUs14XtNQuVSXPdjdQSiP3rnEubSPYau8H+p/gN8rT8vm0tIuxJ777TqhxtOXIBYz2vs1EnuFOVpmId4ASIrtjBNwfK3ksKJ2kuz88atWv/vI2EAh8As9yYWcXRfDgBWNnbyLK7i0qzvi19K3KgsO4LPudyl+STYTKqJSDafzdV7ay50Vq8u9LXqBwWjFwjwK43RuHb6RaDByyYNYodUki4aJp2995BzzabOsYExmKpa8OkTgPkbI34KRqNBc6X0XCy+UF7s2SDJ/oPYvHMsZhQQqEGvMCkL43dXN4GPd0J2DdtjVTT+PfJbyFYyiwooGzYjE+UUcon8snrRL4YL3G3YiD2tb+r9ypFSZjTPgZcIqML+8qUm52H4aRHLwdW5Cw17fVbFKaAHACaSyjA6UYa3hzXBWnyI5MRzul02xhYrhHnzhea56tGAysxmTgD1xcsdHjRvDKv90H1DNJ3RTvULD1DKND1k;4:QlgmGRcRJB/dYu30eW0dPahvdyC5NhKpXovMJ0odKF9fROHFDionmgKMhtJfkxg744Up7TKtRxAmz5KLnVkgBNPuYmxnyi0xRuOPCGUPM1otsYuxZfCeW8likv5WWAv26SW4jKnRK7KUEASCrlS2PSYYThGeakXEYII1jQVM4CWqKrf85MiBbUUXHpr9fX5vPJOWwakfbBxtL7fLyEVhe4QdNBL/foSlQU/xMdltsmMQog4wl1+gFPVvYyYHFz5Y8HigUkJvHzCk6Pq9yI6zXZzbekCFAgDyn0kMChQ3I1fg4lfMLnDNVCjklbHaE0Z0
X-Microsoft-Antispam-PRVS: <DB7PR04MB42504A937FEE0792E435AC1E8B1F0@DB7PR04MB4250.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR04MB4250;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4250;
X-Forefront-PRVS: 079756C6B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(105586002)(106356001)(14444005)(2351001)(2361001)(6486002)(81156014)(81166006)(8936002)(5009440100003)(51416003)(8676002)(97736004)(50226002)(47776003)(1076002)(6666003)(6916009)(3846002)(6116002)(36756003)(5660300001)(16586007)(476003)(2616005)(956004)(66066001)(305945005)(16526019)(186003)(486006)(478600001)(68736007)(6506007)(386003)(44832011)(53936002)(7736002)(316002)(50466002)(25786009)(86362001)(2906002)(6512007)(4326008)(48376002)(26005)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4250;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4250;23:XQBqVllB1F7LRJDss3txmkxyUmmE7DjC2gnOwGp0E?=
 =?us-ascii?Q?cPJJJuO45kOpKuM6BJ2GEoRcYP8AVP4lCyzG9zsZsEzFtvH44hwQ6oXNicAD?=
 =?us-ascii?Q?agaGCCxQHpN+lx/IGj5ElPg/HIy5iycAdAhZo2ROKf2ebpNlD74I9js1FStI?=
 =?us-ascii?Q?Dv0bZd5sIay/1Yucx7J62d/H5bYGQJof5wuP8SshxMGpVybfCcs8+aSIe1K1?=
 =?us-ascii?Q?buAvS0qXq4NGmZTXZRECBGp3g0nYKUTPhg5dX0lYFrWe9m77sc9TDnMQBKFb?=
 =?us-ascii?Q?/xA1CxRZgGmHFx8LKscPz2VtsZkIC1wWc7uBUDKiPsLDuEUMKsXbscxYmVdC?=
 =?us-ascii?Q?k8Wyo0mz1+4CMYWH9TvUkc3/j9AbnLU3Ol05WNZhUQkCaH/u1WNGnGlACcMA?=
 =?us-ascii?Q?j7hNQennVBnP7SiVPc75rBLRBGvOLWZRJ05jYqBfKgFY5E/XslPl7n2SFiHM?=
 =?us-ascii?Q?LP6wThxMtxtKJX16e18PX5rHlQOdrQsFL7d5flLl91pVueQTqCwEy0wjDfEZ?=
 =?us-ascii?Q?mdp2vCMHNrXzGaNnl9AzADMtgHHTuNl1Jf8ISUO+e9iiPxSBpGK1V2+MrYY6?=
 =?us-ascii?Q?Tl8nBze/kAiFIZ2SXcRPueKOKD5JVU5DQR2Xk/Pis7hmT0SZ+HXUbXyP9YGW?=
 =?us-ascii?Q?NqXpyJVp1juPzF27I1rB4CepjS7kGfyvIo0n+RJXiIMPLnU+aoZ0+8volwb4?=
 =?us-ascii?Q?9bFvv16yToo+SPsH/m/+/GWWtO4JfMc15Bcwt8BpEw3Pq3R+jXiD2M64fk9N?=
 =?us-ascii?Q?RpxYzf9BQgpG86cPRtkFQbhoVPJARLYYhz22BuIdK/RM3Q+bBEDQGoEcel1k?=
 =?us-ascii?Q?7XykDT+wtTgYXILztEJ/jE17ZVqXGiDKI9EJApuwlX3YXuuznQxYnxu0igcG?=
 =?us-ascii?Q?fSR145pPaiZaMeg0PGq1Gk2YL4jaDmaO773EAZjvjVdY1Jtd7dIc6zM+Youz?=
 =?us-ascii?Q?rYW5dWL9SDlZ5z/2IOjcbDtWtkV9hDsT5B1LMxEZE7wN0u91UhB8ZYTFLlxw?=
 =?us-ascii?Q?pgSxjXa1AM7w4f5T0XJRk+DkTEoqW5HjPcvz5UdLOssMazs6ZJo1nRKalAjJ?=
 =?us-ascii?Q?uJfiYaDMs3MO2GGQjO9lK+3NEHWamZlBgkuC2Togv0qcJramYac/VoxhqaXZ?=
 =?us-ascii?Q?WK8xs46d42pAUuIsG7GcK/N/MGRflPRb5navwz9p58KcJAQn/hTgM4Q6uUsC?=
 =?us-ascii?Q?GqS9l8Ol8QSuV0YfhJt5AyztfmFd8NzwiEiV3jbWzMn4nXAAiIHskOm4nV9c?=
 =?us-ascii?Q?KCAvlig1oPqejkCSsGdLw6h74Ah/sFPgxJvcWhI?=
X-Microsoft-Antispam-Message-Info: iZWVWpMkbkEeNf4SfyF7USix//vW5za1CsvRI5QlaD786Q9IqAA2nmhVwAtdzzmTxqXwKxV02Dy1E0POtHWPdx1L9SnAwUtvCvvivcDZHOzsLveMtAQYVkb9CM5sgzFNqBU+Mp29YfzRxVjNjNF6K/EQdSYtyM1fghLJuio2vAoJCRlajQrpzxhFk2cCjuJglh5BCPe4qCxiZ4HT/vwRQaYSMH43dIP6PXTT21IHDr+urRMWJQjVDn8AYeBiWOMENdMLAgUZIy2+Uj8oWorK93PKJVZBPt+d2JeTRafVM384fa8HmoNx7es12iCFIGg2rBQL+IPq09ibbB839iRhlPXQD2/MFgEaAJa2L76sudM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4250;6:rjo9Fa4YPZtCB9lr5qEPdy6Zx3c/WFi3RJp+HItSHLIYkDZmnPiOJekY9dLN817OMqneBqindfljwvPTkzUlmfs7vDmBe89xiRXKXYUGXsh7ZJK+emMwK02z9eTEuHhFSkjvrFQtK1J4fzjfGlig+yOhTu+g9TQ0zuQ+3pKn+e6AszA0qeQCqJagqjsgnGVtjDjhV6WTrFE1QpITevCjvYYe1gTD85aj9CWZJHpg1F6/s+cKK+Fsw0aBxXwY1jo9FTYTH8S1VZoChoX2WZODX6OEkIBHVT+bKeZ313S9W4v1+iYY42HUQ7OjFciK+woQXAFgIxf14QJU1NYJzVIJ0RbqlAl63/ZF3Us4P6d7VqI2F0q4XWRy94TIo0JqAxrWRazEG931euNv2y2LjDIwSY9JwmNAdBe9tco2OR0VpFsQgvcDb2exr9+90tFmrekS1BOiY7vS/8p2kd2RVAiVew==;5:xZ12A3E7pK2VOBeNvE2TBu/bg6Er2SS9ZrIlAoqBtY6o7qIEW/Ap1gsjl6sukGsDjS01HCd4CP+1bU1YosdmWwluQyBVwd9ijXD8O/OlWeCG3kb0mZpbxtndxs2yfuS9oHKam18ApV0GqDIY5xqDYo5u/vnu9xIIEGtoFr052Lc=;7:XE+BhunI4ZEDt45HXCr2FZF6iRucJ7meXVYAXXQcHojBAqJYYM+kL/Y5YP5qbnwjVvV9Ebb28qLZifoWrxuOfLlH5xh8onKaUXloprdf5/xuRUGQDZ3nJqEcYY/Wja8ASuk8YB20uMBXb2GlFgLGiK61Xpj7AFYsJ4PnQxs1pvfVAARSjhpUxGpQwCBTcS4ihb5TzxbzbTyVIrDmQcJQTtYBHSvtR9ApjfMxLue4ys3CwQwbQQEv/St8Dsf4a7YG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2018 04:34:53.4529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ed286e-79d1-4e99-4976-08d61b8dc050
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of tls selftests rely upon recv() to return an exact number of
data bytes. When tls record crypto is done using an async accelerator,
it is possible that recv() returns lesser than expected number bytes.
This leads to failure of many test cases. To fix it, MSG_WAITALL has
been used in flags passed to recv() syscall.

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 tools/testing/selftests/net/tls.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 07daff076ce0..96fc6fe70293 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -121,11 +121,11 @@ TEST_F(tls, send_then_sendfile)
 	buf = (char *)malloc(st.st_size);
 
 	EXPECT_EQ(send(self->fd, test_str, to_send, 0), to_send);
-	EXPECT_EQ(recv(self->cfd, recv_buf, to_send, 0), to_send);
+	EXPECT_EQ(recv(self->cfd, recv_buf, to_send, MSG_WAITALL), to_send);
 	EXPECT_EQ(memcmp(test_str, recv_buf, to_send), 0);
 
 	EXPECT_GE(sendfile(self->fd, filefd, 0, st.st_size), 0);
-	EXPECT_EQ(recv(self->cfd, buf, st.st_size, 0), st.st_size);
+	EXPECT_EQ(recv(self->cfd, buf, st.st_size, MSG_WAITALL), st.st_size);
 }
 
 TEST_F(tls, recv_max)
@@ -160,7 +160,7 @@ TEST_F(tls, msg_more)
 	EXPECT_EQ(send(self->fd, test_str, send_len, MSG_MORE), send_len);
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_DONTWAIT), -1);
 	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
-	EXPECT_EQ(recv(self->cfd, buf, send_len * 2, MSG_DONTWAIT),
+	EXPECT_EQ(recv(self->cfd, buf, send_len * 2, MSG_WAITALL),
 		  send_len * 2);
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
@@ -180,7 +180,7 @@ TEST_F(tls, sendmsg_single)
 	msg.msg_iov = &vec;
 	msg.msg_iovlen = 1;
 	EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
-	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
@@ -306,7 +306,7 @@ TEST_F(tls, splice_from_pipe2)
 	EXPECT_GE(splice(p[0], NULL, self->fd, NULL, 8000, 0), 0);
 	EXPECT_GE(write(p2[1], mem_send + 8000, 8000), 0);
 	EXPECT_GE(splice(p2[0], NULL, self->fd, NULL, 8000, 0), 0);
-	EXPECT_GE(recv(self->cfd, mem_recv, send_len, 0), 0);
+	EXPECT_EQ(recv(self->cfd, mem_recv, send_len, MSG_WAITALL), send_len);
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
@@ -436,7 +436,7 @@ TEST_F(tls, multiple_send_single_recv)
 	EXPECT_GE(send(self->fd, send_mem, send_len, 0), 0);
 	EXPECT_GE(send(self->fd, send_mem, send_len, 0), 0);
 	memset(recv_mem, 0, total_len);
-	EXPECT_EQ(recv(self->cfd, recv_mem, total_len, 0), total_len);
+	EXPECT_EQ(recv(self->cfd, recv_mem, total_len, MSG_WAITALL), total_len);
 
 	EXPECT_EQ(memcmp(send_mem, recv_mem, send_len), 0);
 	EXPECT_EQ(memcmp(send_mem, recv_mem + send_len, send_len), 0);
@@ -537,7 +537,7 @@ TEST_F(tls, pollin)
 
 	EXPECT_EQ(poll(&fd, 1, 20), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
-	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	/* Test timing out */
 	EXPECT_EQ(poll(&fd, 1, 20), 0);
 }
@@ -555,7 +555,7 @@ TEST_F(tls, poll_wait)
 	/* Set timeout to inf. secs */
 	EXPECT_EQ(poll(&fd, 1, -1), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
-	EXPECT_EQ(recv(self->cfd, recv_mem, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, recv_mem, send_len, MSG_WAITALL), send_len);
 }
 
 TEST_F(tls, blocking)
@@ -701,7 +701,7 @@ TEST_F(tls, control_msg)
 	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
 
 	vec.iov_base = buf;
-	EXPECT_EQ(recvmsg(self->cfd, &msg, 0), send_len);
+	EXPECT_EQ(recvmsg(self->cfd, &msg, MSG_WAITALL), send_len);
 	cmsg = CMSG_FIRSTHDR(&msg);
 	EXPECT_NE(cmsg, NULL);
 	EXPECT_EQ(cmsg->cmsg_level, SOL_TLS);
-- 
2.13.6

