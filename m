Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE36C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCE820878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/fW9uJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCE820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeGKDo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:44:59 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:13842
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732337AbeGKDo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIyxqXDFwDaW1h4m3RJGyANOIWbF3d4dEx+K0HiUYO8=;
 b=M/fW9uJd3223XwXzH/oJgWiaBxAIrptTWw2440I5vI6RXJiSRlqeLfXdWbs0yDFE5pOpRvfGbhCMQY9Tn6twuLFxJWIdU/NGsO/QRngpBpvixYy1AvEc5llZoqT0yFsxxdHbahVYiiw2islGLnBLBiHc++oASTCVpCXGbzmEIwQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 AM6PR04MB4246.eurprd04.prod.outlook.com (2603:10a6:209:4f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 03:42:40 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        borisp@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net-next][RESEND] net/tls: Use aead_request_alloc/free for request alloc/free
Date:   Wed, 11 Jul 2018 14:32:20 +0530
Message-Id: <20180711090220.14697-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::33) To AM6PR04MB4246.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f05bdfb0-8364-43fc-814b-08d5e6e05b17
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4246;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;3:UJWmgFebmywmQprgZug5bTROgnfYEMD3qMRDxCPfIGyT4xBoY4Eg5K6fB0DiSv/7YZvLjQpVWSR0Frl7pgeYI2q+Q4CtRDbz6CcGuBYzTD3ttopYFU9ZCpDH1yOYdQYMn9L6HAvaAJ2VN+ZxFRM/nPTxsPFvy7t8imunoLwERYzwmRxXYDMo5f/LMJXUYo2rygCdyhS2eIov2U8PCI+ytWwiVutrIHcQhh23y+5DvJ+FxruObCNeKzGRzmVeKh4g;25:xUa39XmU1cSa/V+iuZ60hR+pTLh9WPt7dZBRn7e/qQTjoI1kCUAJTPRDifmbyLImA0E/dMTSZublycirK5KsfzO62+9ZyXuFK+gl0CpPl6vamIEUO3TYNDgkYkGwRfGPZqmmDyEBoDJacj+Lem+IESXvK4iHH3cSvNNnDI3j+cE0n0EXYskn6Pmqx9AyNIie3+LqmoqUz38L0ByUwg/lbz6Z4Oqs0bbqboEDJpTqYShqDnwwWsG8mLtLxJcqaF7qSXfLWPsy8LWpqOX8rchG6gZzxofDC57NsSkLAw2mGsMGXkfPhxgLQvy0f7TRq3UbXESy/hPsL7MHEdZ1dq6U3w==;31:iU2BW34l8/3aWRxQ5gKtwl8RtmzH25bmQ1f/KIyNUelw9gE7E82FU4oTeal2OaWUmMlUiIpTpDER8uEtsIf0Q/TA9l+2tCaTmGSypN65+Lel9gP5LQ6ZoNlSzkrprnANDXFT+YUBirXaRSX1ijVSSkzOxygBo3Y7LAuu68qf8GTZpRMy2q2brlaf7mcaPGE9PjLPeQBwxgTNolUCZ3zbm63i+r7o6YSullBEYBZChVk=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4246:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;20:LO0KYLt4Xe0ol4g4Nf9lD4buE3FDGgckNtMZSvHa11aSC8j/rKmtXdLaRzVwvMLnyDKEgXctQgdG/btm55AkzVGyY0MIncuCspvxYwfsnvlcwJmQ/1PS/iC8LpcZZiC8bUTJcUsX+rQasik7k3jZ0aG2jt6BX3r5sOefM+EdypVu0HY3MEJsGmTZRZAgiLtmHic/mPfKqChOWR5Jt53Gck7Z/vIFH98fm9u8Ub0nLEpXNEDvm3o+PcarHUAJsuGZOLbFxxJ4GPKxiVClQPTBHmVacDJ2DcvTuZAMcPU0mWGAnqut+QHDl09j1oSwSjSZdg64oIZqaurjnUVPigAYI78VjRT7TjCTkIPnBb+cFSr1oshruz0eauGqwZI5129On1zQ/llQQUbI6espXUBL+U3IyHLr3TerNSaVjOSi+VwurYLGS4vfIRkNhgGS23oM28V6mj6nCT/CUNgXRz7btL85LlWX87bHfwsv3Y94knnVZ2G0AsUa4+fzWK+7b6zT;4:nwnOtqQWiFebMR9sDYFTJrdoDTmOeqxksX0mS3eBb1mJOE+6z0iUYW5czSt3mQh1G7wB1mRhZwz/hYkZ3qO4DRuLEzmUpKSV63F68SZzoe9TtrIJnl2bM0fUKgcOXbewPVAubS04gNb1ZMFZArU7TgazneEtCoI7CDCoBqnjUSv239AD4LPouDAwBHwh21PhEVurRU18LwIX9faaFSESiYEHvZ+1A9u8nvUW2evyXXJ1SdZWLIyTJmS5bywYq7QcXJFtC+kKFfg/QCbMTFIEt2tsG2mLunDi/K0w7sNCPJFrZKvEff5zm6UapNd4CtGA
X-Microsoft-Antispam-PRVS: <AM6PR04MB42464BC3C5E3FD44D1D9A3128B5A0@AM6PR04MB4246.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4246;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4246;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(189003)(199004)(476003)(44832011)(5660300001)(478600001)(2361001)(48376002)(305945005)(50466002)(956004)(50226002)(7736002)(2616005)(486006)(14444005)(1076002)(6116002)(2906002)(3846002)(5009440100003)(81166006)(8676002)(81156014)(68736007)(8936002)(36756003)(6666003)(52116002)(51416003)(25786009)(105586002)(26005)(2351001)(86362001)(386003)(106356001)(6506007)(16526019)(66066001)(53936002)(4326008)(47776003)(16586007)(316002)(186003)(55236004)(97736004)(6512007)(6916009)(6486002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4246;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4246;23:Yl+V2Io1/o2KzQEtig4X/pAclyJzzvAhyowNgz8Ye?=
 =?us-ascii?Q?+YNRfXYX8mS6YXdaOyfB20b7uiSP0bzDLFZsF77F7KdTlhRcG4wmnmVGmAm6?=
 =?us-ascii?Q?Ap0BwNIgPqH4eBpjcSglxRglNtB5U08zBOedhIjJWrJLEZ876CcksinZmLSd?=
 =?us-ascii?Q?NFHMfZKwitZNYfEJCbFXx8untRm97wSzrsw3IcQDyBBAoSLBtTpr4E3tbhPp?=
 =?us-ascii?Q?MWATfLATCCkz2xYkJtZwtChpRP4xF2nAWeESC/EFfJkSq4EWTvxIXzp0FTpX?=
 =?us-ascii?Q?4Cr+1UzNITAwlUVdzPAg0qu3v0dmjQxZxubL37Kx4K/KgJohE00Ryvtxq6bj?=
 =?us-ascii?Q?dKQc9Nr7ZxmID+LnyoZA1sVwty8s7ooWnd/hJI6IaoafnxY3s0Jev0kenQYC?=
 =?us-ascii?Q?e752rMcFwWDhUeb8cDyY8UOzMlmF8ixIDULSjz75JOro4aShf+wpqxPW/AfP?=
 =?us-ascii?Q?cA27pk73stjUmtz4eIToyqi7sJg0x/PwPJHlZCTQZ4wI152Pw7s4LZ+9WGqI?=
 =?us-ascii?Q?57SlL9LMy4RlLrh/JFG3Zzjg9B+A4bNqj0/pwUjtF0uDY8yCEU/SPWdvzSnp?=
 =?us-ascii?Q?2t3rUQIvoxGr8DfTK1f+FHlStzNMUnu6lN9n+qCrOd48SFFKjV9iUEge7IOR?=
 =?us-ascii?Q?WCB4Wv73LXR8SKL3aQbERmO4vNeC3Qmhu5tzBnca7+SQxrc+lVlbZJuvlvcn?=
 =?us-ascii?Q?L0qQqYcd4GtxheXXecLXqOGwgEbCME4Gd82QVB3yv5vRu8cj1ILVXN3UZgoI?=
 =?us-ascii?Q?8Mhp2mZPTXakvJOPBfmQlOfsM6GNoY6Lq3Nba7vDHHBwzdnuOPWt6ljg2Y2v?=
 =?us-ascii?Q?QMtW4JNDzHHzNYF1G5L6q6Jzs/i/8JdVY4f+d547Gj4DeQFATUNgKilcaaUU?=
 =?us-ascii?Q?5/gcLJtplYakSBEm+qiWjU7aiCciPfX3egaftO0xZzJdmvaXyhD2ol4TRTgX?=
 =?us-ascii?Q?6oblpc/3rLYrlNtVNA4D0AHBXV/O0EVYnaSDb5firZK57FOX5/rUMrUHam2g?=
 =?us-ascii?Q?wKeULF/tWIXOTYdAw70bGs3niN8yh8D0Uwo/65gs7aLVJkPOdB9dBwWsvgbu?=
 =?us-ascii?Q?GoSy8nW7Kcq9Ced0swM/9YPcG201GNX7bGvn2l5BM2CkDaN8qJMqjZXJ8hgi?=
 =?us-ascii?Q?Vk5kDIQB/f8JMsF1EAw4QeFQVFPCl9NEeoLT4CuIVM8mKWw9urfwIv1V5X6Z?=
 =?us-ascii?Q?3OVTz51wZVOqSLyiMPjjxHoYn1X0y8bUARFz2A2gspEquGxKXv4swyLgZ+lo?=
 =?us-ascii?Q?zLAHNrY43O1kcz7czntrdmR3NMDbGwYOCGWDFE/hKQ0WVW/eFKBX6q9+m1Yj?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: UjwXzFsYw/fFMZXbyovzlxYkukdwzWfzYRwypomqDtrbVUR7sIHgHMKxe0YvGD0r29YG5UfGWaym9706Dc8dMCKhycxN7QR7V93aYE5Y0yCMVx90pUtPN8ywhZ6yP7HiUGCD52C/AVXaQz6HESCVzpgKxlr+OwWYh8s0dNXxJwUs/aOdzBYrPYgy84Xev8YVHVdaje+ajKocHOPl3ov61csJoLXNNf2jj44u5UbpCmp++tjY2zQ8/2ODkaZGEqJNlE6iBhvEAFMdHizmq994Xif85vtASRB53j1kzbSR7CwTKrMtIrCE5eQnQ4kFD766aTiIRg5bUNFYrnCeVp3MZwfMetN3sm4kfqBGd+mctbI=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;6:lVhAsFmoE8KlmELzl3oJ3LkiU5YEgKS3n0bnofGvTcHZeUvS5vN4aBbT19c1byTahscDsa1cmB/4gx7E4J3nhbq7CNMqbdj8HFb+Ct67mgMsqjL7mZl4U77fmHRPP/DVBq1NSW5emmc+8KZm2Ci3zo8LJi1uiU54fSha2X4wFkagPK2kUyAnNdkgO/iT5dt/Rs8On+TDZR3HdvXhHATj9rKLI4w83Q/vJe6VH2nC8BYn8dXpBR3Lp+HIfoglpybNE9blTvFWl/2rJIiDtb3MtIZgTwqgAjk+0ioxK3M/AEe7OAHEOSYDhpDlrid0oiDvDkC/MjMWtKxc/TtiRk/ufveSHB2tJUikQ8lz0jNY7XYKSkcQ5WJNCq0q3BpOPtCOColgPhYyvZ5G4Dm6qhMLi++bFZFsvMmVhJ8zYdnyYFRZxcfcXdQVWxrQqPY/wZiiN2vnnw2lbGgxY/IwUGmTog==;5:XY91bqxRvjNIpyqNeWf1MWzJyQNFBad5QsQSQpev3+lOkfaPk0K9hD43kciPDoBsMPjfL9kmu2jBITg/bIKPfvUFNqqMujZD6Y7mE1BXfKQZQPVAp1/788c3bf2g5o0ANT3Nmye/wr4dBwcEOkYoYwsZyTgpaQd9k11bh3SQpxE=;24:LZE4R62Wvb+rychX+mhilA29wj1zwFrCHHwldWDwjZPOxLlgAVeDKfjaajef1387wzAtBay7AbwXepCd5c570dHw1QtXZGqMlHcsTE1kmCI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;7:BZFT+PuCO0glkA9M0RVLv4QAv+zE1nuQr3V9B18F8fvAI1xPCUdhAufdRj7t2dOZHTFp/jJ+zaewAVzTtfRyQJSfIeZKEv562PoLstEgrnClzNYxUt/QEF7EyIA9OJFYT3vCyDscLhpbe1j2PbN3itRE7DG9PAQ+rkGpfvuiwuNbIVIZsL9ToybAjfTF8FUcdfSHgX5M7XkbdODZNk3kppEOCKISOpvei10VrBYZ3LeojC52RhbN04SxXhtLJKaA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 03:42:40.4933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05bdfb0-8364-43fc-814b-08d5e6e05b17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4246
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

