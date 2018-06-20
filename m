Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78DC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BA620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bILUKDD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BA620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeFTQjZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:39:25 -0400
Received: from mail-db5eur01on0052.outbound.protection.outlook.com ([104.47.2.52]:36192
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932232AbeFTQjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsH4lxj8iYn2N1t/mk89W7MjfD5E/4ihCTmQvwzdSW0=;
 b=bILUKDD4x/g5TWY3O4AZ7JbW37t7vzMlu8emVe3eB9WnK+g5ybppgaqSlA9WdXdnZzOEm11HgZDwNhlh39YAMpKs+t254kv8XwdW0KuIS1rD+TwpC/8Gv++8auwqwAuDF+V7mAPCXSTvDP8UP/YUm9MALiRjkzGwh6b8O0FBwg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 AM0PR04MB4242.eurprd04.prod.outlook.com (2603:10a6:208:66::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 16:39:17 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     doronrk@fb.com, tom@quantonium.net, john.fastabend@gmail.com,
        davejwatson@fb.com, netdev@vger.kernel.org, ebiggers@google.com,
        linux-kernel@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net][RESEND] strparser: Don't schedule in workqueue in paused state
Date:   Thu, 21 Jun 2018 03:29:49 +0530
Message-Id: <20180620215949.32334-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::34) To AM0PR04MB4242.eurprd04.prod.outlook.com
 (2603:10a6:208:66::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc01bfb-785c-427f-f517-08d5d6cc5ed4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4242;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4242;3:Ey75O+WuDRGN63GZ7/R0hXfWhBi/AsgwVm6kmv7HW/+C3sxb7tGvtZ3+GWuE3tuRqPKd9rvjksBWVkN3ZNsjLf5WUIVMXebC8QacNsBOuMqouOFkHIbXIoxcX90ay8fb3PJ4sFz2pMAeH/enHu8AlMU6vI27BbldAGeSAMKQMj4hgg7TliKlxNRRH9ExSAZKuZiLGskvXg+Nepmh3KU1agXiolpTM+QEzUQdzBNRQELnAJ/RajwaOXZ12Z2k7MNC;25:qzFkJlTh8S53WOBrqdqM5Hgve7cAJmAbx71gj+Evq6f45e/ztls9rXXt8M2U/zdE4LmaOr5yfsU665tk7LmtpyNHAgpGY+cKoWk2sKi/zPsk0jAMRnaavK5Yh4VVqkwLljd03ndAyKJgTx9673gnMjxAE5EQ8E7NBiUmKWnRwvcwm6L7AMoP2z4sKYi5QOrSNXZtMQRk9tAufqDKulVXEwlJHVCjwU82mP0K1u4zxDlAr9ypuuqpr01Yd/bOCpyVjhzpXbG+J2xil+3T/3j3alM7O0u4M5tbWIavaXPyVDLoTkJqtWBN2mOBziP5gVsh3Crb5v6PpCpFyrbxtwz8Zg==;31:oo9wWw+p1HvRWHk93l24TctLfgvs9xQz4fteD7X9g7mXOrXxlu5cLLu1C7No3u7yKHOtBck/F6v6/Uy4kGZfLBkt0nJAWQyf1/+It0opTjfe3PA/JJRpz5y17Ih7HkGPmEWfDFYbT1mK5Zv2JqCF9AKnF43riJOhzevHaHcYJVl11ySaUaZQlu773eXySh+6GpiwQnKP5rmer3GbKCPl2ub6TgbfGh21G/uM4md/TrI=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4242:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4242;20:CUL0gUjhq9hYwNSN4vCCE4NkA6DsNUTbSOISHvwcYhzCEbSrFZme/AnVfesF/kGmzZJWPPMmxz0ahP/9xUEMoP6PlkSXfP5Jz2YfIPC02ZOQz2WP9myGbEdv9nwpNj4Uyblujv/Ef0QYXRRRp+Ze4Km22m5iMU1KCLRkzKUI6lc0ADmznh7SINFaUACdukz5y4fo2GIxAIMDKmUWX59Ljr8OC2MLxdTmITi4OIghTttqlgm6dp8gbwQd789QlQ2j9QCLzppLSwBlguDubmL1Gz2cYziw9uU6RNVU5OVObynpSX0aRBnzWyzunMbccoHpMSjPwH6/2JjryGFKiGBUE6l3Ekjj77uCFThB3uRiAWXKW1Ha6+2saJQ60pE59CXZMgDMzPj9xK8ECMBiD0U06EOMqGBEcnj7kDLj4lnr3FmPvtGt4o7kR46IXZfjWtBlDrA/AN3A6cUhqHlYRlwlzQpEEfnAN6LR4dTHRtwhzwGu5QKbkp1LZR7DO0BinpUW;4:FLYqZqlVH4NussIKRwZsLKCqIY0qxALoMQyfTXh/Z1+vE/5sH64xsal+x6mMFZJPAmVLOIVhXzpkGl2qPo4+KktncrFatHcG22Amwnk6zJEWyltiyqc9E9iZbFBXkV8f9vhwHQkQ77s8UtEZMGgY7unastOOf9gvfkfjtvJQ9vHUj3jmkHsdb83yEphriOp9OLLuhDEMcZEH+pHNdcS2+Iqt/Uevp5Lw9SikrxoiRgAomRQDmGaKg0ishd3oQ0v4xsukUFRfyE6NorM95cwI/6vAiyXos+n6JnkJDWlnKjTJZhyDK6jmUGzcgTDPMT5Q
X-Microsoft-Antispam-PRVS: <AM0PR04MB424244FB15686517CC5FC62B8B770@AM0PR04MB4242.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4242;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4242;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(396003)(39860400002)(189003)(199004)(6116002)(2351001)(1076002)(39060400002)(68736007)(105586002)(50226002)(2361001)(8936002)(106356001)(316002)(86362001)(48376002)(486006)(81166006)(476003)(956004)(8676002)(25786009)(81156014)(2616005)(47776003)(6512007)(4326008)(478600001)(3846002)(50466002)(16586007)(66066001)(44832011)(53936002)(186003)(55236004)(5660300001)(36756003)(52116002)(6916009)(6506007)(51416003)(386003)(2906002)(16526019)(59450400001)(6666003)(26005)(5009440100003)(6486002)(97736004)(7736002)(305945005)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4242;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4242;23:FvJrYanGc4nzVh32N9sGiPWUWfFepMnYqD+tH5oZG?=
 =?us-ascii?Q?wM+Qpcf9UVpdiCtDyV4aecv0/vIyzaIo0SbHIurA9s9KEhv0+VnmeLbd90hZ?=
 =?us-ascii?Q?qyEkN9FCPXFR/VuD/SFe1AOL8xXD9VOeNeju/PFgRMaQIp0224gsvO7cPEte?=
 =?us-ascii?Q?Xr18CkyI2s1WO3bAAXX9N3EURGZJ5lGoc9oRSZw/XPDI7Wv1htglw93Aeo7G?=
 =?us-ascii?Q?zfwFKOFxxQnCeWk/XgXnHq6P8EptF5TYyZLVleFto28ydYeyMbycNpJGRhsR?=
 =?us-ascii?Q?H6sJRQyAjVlGlgvOrhzy3Ck0fxd4ECqy0HmgFj7rlHnDLCcNA6qpzoEiX4/q?=
 =?us-ascii?Q?mz3aEY9FaRCXJJrdw5MgXLJ94Bvek2pSpIyAx86ix+47ZIKMG0noxXLSiYGQ?=
 =?us-ascii?Q?CZUKXxKYx2dB3ipbyaXfl78n+2/ly1ksVzVRN7p9zNUL2F/0ajHOXGPJKbyg?=
 =?us-ascii?Q?M55nvlnvguywTrLgFznIvQDb9e4sxZwnLGuMElkXxXuZr//AOK/+PyJuQx8N?=
 =?us-ascii?Q?n+bcn6K3uxlPyB94JVAavL4KtP+7GPpo6+ToxQxmbn4dH/QZfLkJmBxlSxwG?=
 =?us-ascii?Q?4bN0ACOKTWhyUrhxRXTJN/PhA/XbDPfwFaIOzyiFhNi8+gX0OAiSOSqo1pIr?=
 =?us-ascii?Q?2Ef8svCGlgn16JiQKHKc5fU5nDbwfQFZlVGmKqQz5TderUzmGv6UZVyGf9ug?=
 =?us-ascii?Q?En4pShyr7CGPw+nqzcw7H57b3CeFRmvAXCJTRYCJc7C/DkNtthfd6QeBtqT8?=
 =?us-ascii?Q?ed/Fdc9+pkFNEv6YDt2qY5nXSaj/WzuCz/qu0lCJOz7wAvcQvucWVbHdJTgs?=
 =?us-ascii?Q?OLu4YHkK6exMV/DerA+lTz8vtzzicGJ14JjXN1nqiCmmIM5bWEQfdUk7k5JM?=
 =?us-ascii?Q?KiGhG7AUMaoQgPra7EiUGz6SUgYz6PUfivfQ9iLdkvqiPr0nZS3UGwy2/A2E?=
 =?us-ascii?Q?4tSAIM691TNBodmfDoBw5A1ak8VjjQ45CQB6EQcPNldIEm4pk/EudvN8ExxP?=
 =?us-ascii?Q?LQVtvKHqZazZ8nLJxSgMb1P6uNjsZittkx47T1Y6CH2SoZlB3JPQgdrAdP5S?=
 =?us-ascii?Q?OMk5BUofrDtgR89ulJh4i9+RzXWM4ViM3QqAgYbVgdTAwRBMQebhUtrlp4+I?=
 =?us-ascii?Q?132otujlFL7fU4CuZsnFC+fMaZsJeFZ06XoZUSOueB6AZS0JSfqo1HrZ5GhG?=
 =?us-ascii?Q?BDZwXou/VL9fycZvH1PRw7dBtEcsRTmf72m67W/76IFq9QcyETpx968W2GVM?=
 =?us-ascii?Q?35f+uyJDteyq5I/y+mXPnp12qjqqzs6KzQfSgPE19/YLjpiJKyua9/erjKhM?=
 =?us-ascii?Q?D8foIG3AD+aQLKCTvjGKFf/8OIs8bDQajHIykhORbuQ?=
X-Microsoft-Antispam-Message-Info: 2i0Ha6f37X4WXUkEDxauSerwJ6PBdT1va0TESSBVbcvj1XIC+n7tBseA6WUXeuOmHug9mOQ3TZjZwjDOVSta2qJtSj1UK24jLTSR0thPPL3WKLDWTcLuAu7xXGrDDTorl/9U7w2/rAguf4E5Pquu95rrffOGK/NR4+QnNiMotWCeJqx8c6VcOnMw/6/I30PCXM7FCHKpab71QWUyW/itA6yWFgxyO+EUypdS3/B9s0DLnjNgYU9b0BVJIyU7PsHTEoypc+WscDiO5CSgWklx0M2IExwahTvVx7C3R2NpTMinlwimvXC1r2ByOMuLlENMEya4qXId/8sEihSTaqnaUA==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4242;6:ZqAGISJKlE+CkQ+OAV8KM2uzXMHvIANtWndVrvM6yKJLuRQ+Ls5uNaObeVoRvrE3WtKZt4BmJP9HyDBecjGz84g2+0skL9qyK3dYWZuQV+3UcTM30NobeTTZ2bBxf+R0pN3G48uiBgaadqcZDU6tsKffxV6brLkkeF+ioCpSe05Mr6FxxPv9xMghdtxq98x+Hby4pD9DVg+8mR1Vl14JUuuFZo6Cg9vQ+CcyqDF3vhlRW0Fi+jUkDVshG6kKWK+4h/BYu8Ot1EZG20xUOJetaPlQy0toTcDiryGO4FCsBUYLS2lZUdHl9juN6vHk9MeI/HJSKBJulPVrdqE661oBv38ZCwL0YrxXFSYusxgLZIw83hmip5eiZ2TY1HIxq/c86awgSWUx8doidB62yY7x2qxHC+O9wlLsMIh+x656mLockb9hhK7bL7scCFAZ+34XJ9W+HkZbkAhqK2Z9PhXWxQ==;5:9JhLhEWsRNxpreTI51cmtwFzQjg+ve7b26fILR/drtFmwOwJLPNgZr2yKayFPF2uJymAkww/XhAE9dUdQ/zwWCXrM7+990rnYxdUBGUxF07ohgJlmzLXn1TXUywa1y8A+hGp5V0kAKyhORfXZL+0jB7oLsXQdYOTcwfhGNwgVDs=;24:gkDIy3/RqLrTE3YQoTW8OZbEGBOxW5o9yzvHiw1XkNYujlU7bUNG7YJS0skXstrJwAdBtZN85cPawMVL2udFjqGRU3x4iIpYAOT4PArQVtc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4242;7:qE+32GHtn+2sVy6R8+ID9q+igxi3EqLzRyDuOlTKZY/tDHq7UEGu0LbvMGd7sff8j5nmYHsQ9thYYH+rDBrJKTciVtNdm+nIKI322u2ZvC4cB2b3aX+KSLdqlpZTBgaUPdaN+glukn8w1paxFlCoyu8f37CvDSdxMYdhr62q8k5w3n7Tq4kmK5v5ZuklLpvU6ZroDx1PTZ/c4pntfhLiQKKpcTQpnccAmnWD7IxgQXwFY78pb4N2W5Hth2AQILmh
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 16:39:17.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc01bfb-785c-427f-f517-08d5d6cc5ed4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function strp_data_ready(), it is useless to call queue_work if
the state of strparser is already paused. The state checking should
be done before calling queue_work. The change reduces the context
switches and improves the ktls-rx throughput by approx 20% (measured
on cortex-a53 based platform).

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 net/strparser/strparser.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 1a9695183599..373836615c57 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -392,7 +392,7 @@ static int strp_read_sock(struct strparser *strp)
 /* Lower sock lock held */
 void strp_data_ready(struct strparser *strp)
 {
-	if (unlikely(strp->stopped))
+	if (unlikely(strp->stopped) || strp->paused)
 		return;
 
 	/* This check is needed to synchronize with do_strp_work.
@@ -407,9 +407,6 @@ void strp_data_ready(struct strparser *strp)
 		return;
 	}
 
-	if (strp->paused)
-		return;
-
 	if (strp->need_bytes) {
 		if (strp_peek_len(strp) < strp->need_bytes)
 			return;
-- 
2.13.6

