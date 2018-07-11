Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36654C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4CF20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaRE6o50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4CF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeGKDmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:42:16 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:27136
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732360AbeGKDmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIyxqXDFwDaW1h4m3RJGyANOIWbF3d4dEx+K0HiUYO8=;
 b=eaRE6o50PWxXRNNXKbTYfBk1DIF6W/dv6MR5PXFvWtKWGgjox2ifSzjlHsBtgwd7OCIxuEwpi/6E1k3y5R3r/0PWgC8s/ZMOKhv+pZrH8Xmb6XiqPc2qIOkXBxHqZZRtD8o8BZ9NYLavEMtFVxtsej8Hqz/4E+CF5ItMuj8qmWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 AM0PR04MB4241.eurprd04.prod.outlook.com (2603:10a6:208:66::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 03:39:57 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        borisp@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH] net/tls: Use aead_request_alloc/free for request alloc/free
Date:   Wed, 11 Jul 2018 14:29:28 +0530
Message-Id: <20180711085928.14609-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::17) To AM0PR04MB4241.eurprd04.prod.outlook.com
 (2603:10a6:208:66::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a54b31-db02-4d5e-4e5b-08d5e6dff9d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4241;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4241;3:rqg9Qmcq4n91mEUj0BGUHCUA2wie5cghiFJ22UJS8H/WWBcgMa2Jtr7LSCKiZLXT4sjm03M1aEKgvEvZ7UZv3Prc4DxHHKizlzfwPm9qOM1SPHuowqqxTo9fLDCwee8853BY/5G1cMjupK7l6gjhhzpBwgdqL0BBdWle22VOXpUZzJgdZi4cNCKeEbHoI4L3usaWrFS1gQ5DPKtN/YCrkyQDDXUkZLu3uuhrGkiZ0NV6jcVK3ejWBHYRHst1/gwG;25:tmf76Q6R9knS+e7QIremRiBE1le0QdYJtfFO48zbmkaF6x0aOBuocWnSJdDVwcDy9cNLzS0OwvTwxucyaRzJ3SCI6n11x12+iO65UOKmyrFyHS11ScIF2uxaahw1QhIBjZ2xzhAq0+Z4KgM3GhkKC3+y4+Y6SXEFfn8R/2T2gLVvRdfDABAGJQcl6JC5iIYoL/p+OP7jQZBqbTk3sFBhJ1pVuQhyMz46yl6gLtamrfJfzPNIhnhkxQ6PJVxPOkd5RuWhGRp/iJNtnDs7GNotl/8ctfuzOPoUgOqDmJEof+nZmXzv88OKBvmn5e/mwbNXV+iikfnqfWML1s+x+i/WVw==;31:UwsCHVmNKNAfUoz36lqgIZ3tygYttBG7uLe33s4B2I4z5cRlI551nn9s2DmOAj2eyVsqm+LkoeBsvTOYJj+oxN7Ei0/3r2qsT9PCtP+PKaV+xdBd5KHZBWYsat2ShRvNnqJcAo/wiMzVLl/UJJz6xdPL73IN3Tt1WGtAfvMpnpRr0fDyRFhs54sIIsamaEe82LD4G1j83huqy3coLTF98u+CWLSey1Ru4zVh++pmWSA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4241:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4241;20:TTDbCct5FhoHef7aVE1q/Ng1+GecDJmzysfHMX+9z4EaROOlR4f675PDlSsKz5ZcefiliVda9HW4pHtzv1gDNhHYgJqEahpTWmoxncLowPF7XViuOxlrj0Juf5VmrqxnzH8tjZQU4EJNVPANdWVMNILP/y7XGSKj/mRxwEmMmkDwI+YcXPMGOi7vwGyFddtNRC7dEFMELFQx3a6LLOLLsupuSrsHNlh3CpI6FbjHdgxjVeB/GR8Xy4Pe534W+suNku/qc+0eR3eqIAXDg1i3bosQAhGFtmxc45rsvpKs2bZHgbGA6ZfVQjsHBjbBJj2YZ8Myu9RUjLU8VcktUTLzAb1dH3LORd0JF/tzgKq95YI8jH0QXvEyFCadhM/x65k+g0FulcfbJeVa35TsClVcEjYW9AU16qkBvDIIEum/fP5DOhcjyTJJ/mfippvZnklSArs9dVXAO9G3sTXuWRD6yCvhU7liReKrEVXUjyt3+VMSxr9Gt/Bip+5Hp9m51843;4:4H4fbbpBveJb1/QDG0v1xg0ifkAARpa8fEuz38erD/NGtqTQ6dNPTW8RrEeE9tkEc6/gQ8D0y1AVsVzu/57gCO80kT8FmOHoWtu7TU/HhZ6B5obbK9TXIMzYpmlaZXseOp7N9t6qZ5LjP2k6NTUjuHZmXFrwEoeK/xfAX4vvypxstS3Ih8ys7qXKkUf9j4WUOejW2WSN+6Hl0FlJ5vtTmL28amNCmZKSFlpMB9T8U6FaPWhmM3kPyKf/eF2aePS61HGJE7kgwvZTsN5DRyJsgcG1kFgqgeQ8R1pqnrA0eF2JW8YurvHey9BXtY9VLVcx
X-Microsoft-Antispam-PRVS: <AM0PR04MB42413CE3D84933C0143797658B5A0@AM0PR04MB4241.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4241;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4241;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(956004)(44832011)(1857600001)(2616005)(6486002)(486006)(47776003)(66066001)(53936002)(7736002)(476003)(26005)(86362001)(305945005)(16586007)(5009440100003)(16526019)(186003)(2906002)(14444005)(50226002)(316002)(68736007)(6512007)(5660300001)(2361001)(386003)(52116002)(6506007)(25786009)(478600001)(1076002)(105586002)(51416003)(97736004)(6916009)(6666003)(106356001)(36756003)(50466002)(4326008)(2351001)(81156014)(8936002)(3846002)(6116002)(48376002)(81166006)(8676002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4241;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4241;23:I7W9ERPOsiUgtSRmn2CRPrbBjKpxORrfUhnA3Woag?=
 =?us-ascii?Q?1P5LW5nUoo2X73oBqbAYnzyAw3oXnALHrAIZZ9vePIQIWhJ0NNdMHGLL/Xhl?=
 =?us-ascii?Q?cCD2BtHVlWgLf7qO22M3oek2Y3Zj6OX/TCf/2Hm+muwLblOs2qfGstB6QQ4s?=
 =?us-ascii?Q?qHjR7JzBwM5/+DWEBEpiMKbsQG1Ocll2BUM6HZQpgl8iyU60nyTqENV5p5ZU?=
 =?us-ascii?Q?cIR62mQu/5aEpIgqXDkHa3g8x4en3wHXMPpZNfBl6EQ/epgLyGbTKni4fNX/?=
 =?us-ascii?Q?HveO11wgDXVRef2RaQwx3RgHy4dhua9fHM9STrKvU9wyiXMQmVl6u1vWK92n?=
 =?us-ascii?Q?3D1Z4AynHF3DGL8O7GgAg+FBAN+42W6YpHdNh4i0Ua+ksiVploT2d/qE4Los?=
 =?us-ascii?Q?vyU9BKbtiycPmVwj2G6M8USi9TIC537UX/vBSFpAWd1spAY2qqsMcetX/Qd2?=
 =?us-ascii?Q?YT089NBhUb6cQtrhAF3uWalbT3uZkhR5W0WisaoYNKN/alH4B+YApxRBmtve?=
 =?us-ascii?Q?iojS7OVecYAwi5XRS6NyXRPJiM30TR9HJQGsIxE2ERM7TTnSN2yYpdAhed+j?=
 =?us-ascii?Q?bi6My4ZwkAB9a4fcMUHXoC6O3e/s4tihBeJrxf9L0rVmRvrFI3nOPfnJ5q7O?=
 =?us-ascii?Q?qmP6IoEkNFGdW+86+QO76RcoytoWQGHIO/lCs5mnbxH7RqJq5O8W0qU6ZZTO?=
 =?us-ascii?Q?sM2/2n5v5t3/lIGf3el/8LwGJvqQSsxvWewdYRW/sonoQoC3Ij68zWAs3iGP?=
 =?us-ascii?Q?mV22LVSq0eCx8k3ijVsURENYvAxQyC265NHGxYgGANGs3e3zE9dt9jYAvEoe?=
 =?us-ascii?Q?ppOefTROG5A6pdGogWN/QxXnw+V0rYwAdZkmL0MC3BRmi9rAuV9dWYIf9Agh?=
 =?us-ascii?Q?NnvSQ6An8EInqckcBJOfFjtfuVV28ZLIjx232qO95+DGds5BxxjUGsjS+LnB?=
 =?us-ascii?Q?/45koNLQHhEQwqtQg0rSAf2oSzPoCSy/WivnvfeaH+zj8bZvuwd3xGxiywcL?=
 =?us-ascii?Q?hz8UsqYiikHHiUwDNG/FUMrXDeyqcKAY/7Bt6THzNMze/rSguoog4u2aJsH1?=
 =?us-ascii?Q?083KBUP5n3RhMoDdIIWUYST3jNKFBuFBv1IXtU/osdO+CJGyMKTior9679XT?=
 =?us-ascii?Q?32BOEZ5RE2zMwxU5RjsuRQFLMZQBCqnGTpQhmF1nndKQ6SfFpiTcl3MxhB4I?=
 =?us-ascii?Q?biOChtC328e5Hc9q5Zn98xrRXK/HbOznBcPkvcs0Xflk+VsEdZXHWFm2MuUq?=
 =?us-ascii?Q?iDR7tf3/oAm2vRSDCqZdaOteAsxubgdPeWbL+XveUObRUPPGLVIEspgGvISK?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 4ckSPGV6ScXnGJkLpHOi4+9Dz1x+SpaY9rPxUk15dTNxnsXBqGPyutCUuuQPM+X0yZVssZRWOfB1B/fdqdDNzYpDaC29Gk6HVg41XBHxPTzET6WxSU8tuZkruYbl4YKt/Udak5OZPL3dAF+i+WryOLR0CNLREoGCuKQjLEO0E4+c9GlXtn+vEJ5H46Mxjxum23hVrKhtZpD+SW5RN19BnxhA301WAMcTb+T4ahud4rmCaouliC2Lqcc12TpXJ5FU1mJLRxVOC/aHC3HE29AOad0Q6pDvGYVOzOQMCwZ/iYx0vexLwa6GvINgkqI/BHxbBZqTdkHnTZ+1Kpk9Z9Ku54FAXkSYvrvZ4S1SG+8X+nU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4241;6:SQfjZkNQzfAbT0NEls/qFwB5BuoP7izjVDfF2PcZcaJErc5CkUjVa1UYZLa9GPCqM5xmlHQXAQ8bjzmt1trSUgqo6mmUX8CGdaF4QqZNK9zeLkabJQWnp1LE4VylcJ9XfShC+6TWagUnB7Yq4ql3BL68U4tnZSWc5uFpAa5Odpq5DsMuAHao/OfMsea1gyvxwo0BcMWF9XYABufeCx3njkNUU9+DopXCyx04j7XHbVATiWijEQJ1peWs4EhQ4u1/M8aVSGbP3qE4f+byqCAv9Irelu3zb1K1GeSju0uTPS1wcsHZ3MP+sdlhpMgxoRl+t/rV/M5deLB5muFTPbe0N3LlZLqcqn/QnOAN8CVieKogc4oEoAkQb6KbkZlT2GUOUQrkB9PzrlhJlXgkDefi2Kqb1wM7j2TUPx5KcLIVHMqVyBgEUXeEq8dlJQHN971lDyp6siXtIBd0Vvr383KIoQ==;5:RN0UeO7BW07jHNx3wDfGW8Cdu6rjpdGjDw+h5IvF8vQ0gdfMLUzFk2boE/idltR2wh6PZi85MCOS0lHHzNNH+88Vt77RxMF1uARf9dUwRVNB0H2iibnuUxJTXHp3ThHPTOj85QRqRnmj2YR0XnZ+XOJPctFHJmu3WkRoZvgVDBI=;24:mv3+GX4VBCfFgyA4Vy7JfrkHcPHijsJWZI7uS3B00q1FMhUM4ZY1UW8byfmxG5U/Qz4YvcUdi9r5lTMVMi6Xv85Fp0Bp3GVUUVnNXfubTGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4241;7:yzsX+QcB5v5Y8tzHbb9uq+wvKcHl0nWoIIfrWGPvSH/7/7vsNP3MVxuaHku3NvuPaabAds+pp9IHky1ga9dxaiKSOIcNATJErSqvA+uI7vyAh524UhMbNGwSX7dc8hqqngPAVvQahKPgj3nh5bninNpEjSEINlM02jteh/FB/8oRpPwc49kpdn9RCtmwM2XkOOm0ljKydWQWVgsA+MYnUut4wtlCu/VWkdDcfRnusH7b6zeyI5lhUi2VanIouLmD
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 03:39:57.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a54b31-db02-4d5e-4e5b-08d5e6dff9d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of kzalloc/free for aead_request allocation and free, use
functions aead_request_alloc(), aead_request_free(). It ensures that
any sensitive crypto material held in crypto transforms is securely
erased from memory.

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 net/tls/tls_sw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 173d8b89072d..03d3eef1c17b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -57,14 +57,11 @@ static int tls_do_decryption(struct sock *sk,
 	struct aead_request *aead_req;
 
 	int ret;
-	unsigned int req_size = sizeof(struct aead_request) +
-		crypto_aead_reqsize(ctx->aead_recv);
 
-	aead_req = kzalloc(req_size, flags);
+	aead_req = aead_request_alloc(ctx->aead_recv, flags);
 	if (!aead_req)
 		return -ENOMEM;
 
-	aead_request_set_tfm(aead_req, ctx->aead_recv);
 	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
 	aead_request_set_crypt(aead_req, sgin, sgout,
 			       data_len + tls_ctx->rx.tag_size,
@@ -86,7 +83,7 @@ static int tls_do_decryption(struct sock *sk,
 	ctx->saved_data_ready(sk);
 
 out:
-	kfree(aead_req);
+	aead_request_free(aead_req);
 	return ret;
 }
 
@@ -224,8 +221,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	struct aead_request *req;
 	int rc;
 
-	req = kzalloc(sizeof(struct aead_request) +
-		      crypto_aead_reqsize(ctx->aead_send), sk->sk_allocation);
+	req = aead_request_alloc(ctx->aead_send, sk->sk_allocation);
 	if (!req)
 		return -ENOMEM;
 
@@ -267,7 +263,7 @@ static int tls_push_record(struct sock *sk, int flags,
 
 	tls_advance_record_sn(sk, &tls_ctx->tx);
 out_req:
-	kfree(req);
+	aead_request_free(req);
 	return rc;
 }
 
-- 
2.13.6

