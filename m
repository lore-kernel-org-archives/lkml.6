Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7482C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D7208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lwva8MAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1D7208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFTI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:29:13 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:7584
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753944AbeFTI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsH4lxj8iYn2N1t/mk89W7MjfD5E/4ihCTmQvwzdSW0=;
 b=lwva8MAArzXKE/HEuj3zkM3gV0zVoCVhjSiX5OiIJXRTrpCqBXjRqB+qYe8onjZNbeE8cncJhCwVWAF3Bn31hsDN6eUiUNN020Ji894lRvI4J4vZZMGaCpxStAIeyemIZ7MY8UUrKvFaRnCWzBPcLT5FVxPA3SaK+1gvLw97fos=
Received: from lti.ap.freescale.net (14.142.187.166) by
 AM0PR04MB4244.eurprd04.prod.outlook.com (2603:10a6:208:66::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Wed, 20 Jun 2018 07:44:32 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     doronrk@fb.com, tom@quantonium.net, john.fastabend@gmail.com,
        davejwatson@fb.com, netdev@vger.kernel.org, ebiggers@google.com,
        linux-kernel@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH] strparser: Don't schedule in workqueue in paused state
Date:   Wed, 20 Jun 2018 18:34:56 +0530
Message-Id: <20180620130456.9279-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BMXPR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::33) To AM0PR04MB4244.eurprd04.prod.outlook.com
 (2603:10a6:208:66::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dd611f6-e9fa-4d62-2ae4-08d5d681aa5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4244;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4244;3:aCSa5fd1W7pgnBBvYpL5ad5gBrrk6uMp+ngy+Dh8SHun/lgplhV1K7fwS//pqWnbMS0I1uR92TH5FYI+eJmIQLtsA54oxdUatyw6ho8IC1rAv6D+0Zp1AwVr8j/mwXB9p0/uv55KxpU6D3+ffeHbE1n411tLJPBjFJ5arAUu3PtyeoALkaA9M22OjH2gTrATzYaAk5C2qf7Oc3hV4mqTxhTKPCpHJ5qteifjWMZj9eL4meRp+fy+anxgdn7JvkcK;25:X2rV+VcdtFpbcflMk6cYh5BquTxU1309VttW3ChqSBknUaSsxnznl7UBvd2DA2Rl4Qg+OVI9yxlIBVq7hTfQO5wNPhrIsVl2A8E9nnsvrIyHCorR5gPeExS2ZBY9n02qvnApgpTZLCXPE6pLdyvoyzAbxob4cSRAr06lpd8IocV2Dfmt1pTUKNgsRXx0pXkrK0/tOMMS2VjZbhJ2TxAW1r2jua48jI26r6HaWLNy0Khwh3EtI6aWPuwHXffTbGkWFKW7Gk2zvPk6S50OgxpPZI1t7UN9JYdw+YB1gMLElzHvTOwEHjXleyZFIhER6iIszSxlg6TRavTyLwbNssUS5Q==;31:Yk6JGqMSFQ1nFh9kXyrTKZRMsjDo0hNdqCu+VVqhgJ+a20WCSgtnoGIQkuZcf1tICVBsMiFK8tC5GcKc0ULBczEqqP60heOORVWXb9wrYe7Q9Qii1L4ko0PoUffEVk0hiEOqz47pLx6miix2Wr2W+QwqIrjVVZn/Jookg0+vwktT+uexPgoNrvaxuUcFWKU7PY6D+i7dcjCeF2lUHt522yPS+lIrIfgX7oAQWnHaROs=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4244:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4244;20:KyjPf7E+lL6OGnOvDb9FwmWwC1pXHD82AJHnfexeTLLR359I6maNHaJyFbsYZ7F9kL77wKHolSn5Thddgsaqxp1Lr9Bn7NN+HWwo29HkNRE9BY1k5PILp/r8M0jJJlk21ulqTbYPQcamyYPctJcnP76E2wDmqalhPzKbD5r+9f8B8AJ0wZHcUTDBDZx/J19dbTXDP0cU60wiFEmMFtw6p6cxFJUGH9Psu8bX3pgSavimBbhVuNNsIyb4rG6Ft34WTaDkQVc0YtoHiRbz6cSiMvDWL5W5iUVI7x9IQRsXMmSrYP0LdKeYuWjO8pfm9Sp/J78SJqbTL/3tzk2qsg1r1RPXRcHgFqW8I2FvEOeRzP580CQJKJ2dPSbCpsYr9aKSGyfAP+E11ieylOY/EEC2oCljR3cx8JjZM1c+uEveZi9TVGvwIcH/HD6AI70l+eRiTrtS2Bv//x1EzUkO554niREk4fzT9zvr9mRVn2ojM/7ljTC4vq2ogPe8Aujyx3wA;4:OA1qp0sygkfZlJYDiaGEG3WBgpfaGgMyYXyz7TanKb7gi1uoDde675YoLocCM+zP6LD3QOkpCDZGOrus34s+fIgnHicSrxWgjeZZsBfX7mIV9uGpHV7x4FgDandwqAdXSyN0ABQscxIhM5Pd7xeuX5A74deoMnHHhzdE0qL2A3tVYe8ZT/JMEAuEAINVpiJPwNYao8tc9ftN/yrN/yYiGfxKbNUdXdjX36OhkYO01YOr2JBTZiOWUJxid5mnZgDmxI0OMRc4FhR1vn8RfffjfzlbvCrkDTT/uswZc1XLB6fHmSJ+eIqzAQ3Xdb9gNh+2
X-Microsoft-Antispam-PRVS: <AM0PR04MB4244F4EF44DB258859AA84928B770@AM0PR04MB4244.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4244;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4244;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(189003)(199004)(2616005)(1857600001)(5009440100003)(6666003)(97736004)(1076002)(47776003)(16526019)(386003)(956004)(6506007)(476003)(2906002)(51416003)(6512007)(55236004)(59450400001)(36756003)(486006)(86362001)(186003)(6486002)(44832011)(26005)(52116002)(105586002)(106356001)(25786009)(7736002)(4326008)(53936002)(8676002)(39060400002)(48376002)(50226002)(16586007)(478600001)(50466002)(68736007)(3846002)(316002)(6116002)(66066001)(6916009)(5660300001)(8936002)(2351001)(81156014)(305945005)(81166006)(2361001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4244;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4244;23:dBycW9toqXt8P1BoW5t9NyfE0pGkbsTARZscAr2eI?=
 =?us-ascii?Q?ipLLHOFLlwzw+1qdXlARpp18EPZ/RFmslKasnIX7tJgBRjKPQzFlwdRWaaSK?=
 =?us-ascii?Q?Ik8LQ8700+5ekVVwye4L5IO0dsTWgtp4XseXryiZProEl2NACb1L1kBWp4Rl?=
 =?us-ascii?Q?EC+SQnQAMsM6gJn8cCTvh3iy+imaLsIokMd70J8VKsHqlMDc9ryfBWU2LD3L?=
 =?us-ascii?Q?jmkfb+yGP+okaI0lyG31BqOjrjRTbSjQW8w4wI3WQxbKGGePNqQveX9/Nn4A?=
 =?us-ascii?Q?rIw64ucp7u5Mojizm36PN/WfMyMZFNUXydXR37/DBLYf3Ia8baVuy992wUen?=
 =?us-ascii?Q?nxbjjML2+F1eJ8HN3LWuDRIxncVYpxOa6IVf4PjZ2+MDRXawyX3J0Topxi1C?=
 =?us-ascii?Q?wWZdAmvoj/qs5KXB22B8IcGNZo49UjmMZoTdNboHJ3mxXrXIqkHyvwT1yqOb?=
 =?us-ascii?Q?Le2s60ENHMV6qtxOwC/PYyLI1cqfGvXUo8HmwzZ8r2A5a0C4W7vOqtpeiBij?=
 =?us-ascii?Q?a7iBuFNwEE2Y8Bn7WXsKXEnmjPLsTOsdXifNOlr3qfKXxY9pKLQ/+6W9vgbL?=
 =?us-ascii?Q?Bg26duHanJSveJ5K0O0kMHNpr8Hfzinif7/ps+j6RxRhePhnML8xKMpvRU/H?=
 =?us-ascii?Q?RzLkYQWbGyRIgidCb76cJiRxyQwaJOTIMjh6y3VKvBpBAlQ0jUsod5bRpSIF?=
 =?us-ascii?Q?8VJuhzLiWfL+vjCCzEGNHL64Zrfyue3Zq2k+X0KRxhaMdH0diUrzIYAZyj1I?=
 =?us-ascii?Q?DFNeyQXGXB+PwO3s+VgcX6Q1gdvAuzMMuCqpZrESlUAlEVl8nJ+x46JK/IGI?=
 =?us-ascii?Q?0jvq5R1qR8nGn29dGSqewEJx3hDloppE4wt/WvefAwO9O0jFJKaIlEfm56k0?=
 =?us-ascii?Q?7ijDx9IngrMPWP7w+nHhOT6E+hpFjJ6/R9CGhl3hvAfiun1u34UKwmw/gxnx?=
 =?us-ascii?Q?R0HC1cvOviCJVrIVOd0Xx7kP5l0zT9ExgGtfSXU28NMF1WDVaM4ogFgXsZ3D?=
 =?us-ascii?Q?uhlGJcuE36Mbu+ww6xJn702F0UZ8aj7ifnkZO5U6kO9kzARBFDiCUIKbEtJq?=
 =?us-ascii?Q?An+Gm/85OmEOhl06PsI4yBEjetV+5kbuas2aUkwLeDMYXdJEzWffq9QYTA+v?=
 =?us-ascii?Q?sxNSLy5rgRmFXgVphA/nJQZL4dXM/T2sdPEe2ubsdhlI6UaBp+49XaO0iOH1?=
 =?us-ascii?Q?evu4gn3UHSKqOKMsdg+PJR0uAnwCph24cSwHkrVCj2bUFelS3FSpq31eqnou?=
 =?us-ascii?Q?kYWpdPE8tz2tfDkS8KCKL5LUdam1VbyGdgyYFEPhmqRrZfeZhox1kT8WfgyG?=
 =?us-ascii?Q?8hxnghcUJDbRBOKOu7FXG3C//ZwJLNGxDcR+F+fbUy0rH3ybBn0Qpr0GbaU5?=
 =?us-ascii?Q?/rkYg=3D=3D?=
X-Microsoft-Antispam-Message-Info: BU1Gd06uRpxt/vpEFWDJadgf0drLrCFYcuY/jVIIyYSX0BJi8ZGxBUO6oXxU90VsJI/15j4XnH6AaFxlA7KtpQnNqa+RWrj/vHM5KuElVuteZ3im+XbtfA0wa8N3wDinhJBk2jPcneEBVql7ZX0ZU+eLT9YbYdH3jAnFFyGTIAaEhCFhNjKU3cHXcwxzv5rwayXqDcCU/S1x1JAersPJiYvoKetPibiZAbXeFngZWXL/m04WZIHXjifHj57pOMy2rhzqPCnHJLesuiiSJBi/ICIq7V9DpETNLxxIdrB9YN34qrgPl45/njD/L3D8XEp4w4cNTmFqZwqLaocYP901Iw==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4244;6:ytyiu4Lz5wjXSCzawWyDYxWe8+1D3Od/0asfp1aSiPDIA0RVIoW5n07UOJ5/C0k2TX30GEgyYsoE8vxAqGGUHu5FtD4jedqnu16dsiyDOxO8NmaviJiGYv4G8h04ZSgQJSSYsTkFWXoyh45ZUA+Zz6aRMSk5L81qghqOVQBdDkYsBQTOzuCAgee7Y4+Lj9hRn9YOqTJHkyPvtEAPZJjmFubIYQQ4igqgDlfa8lEoVcaQQ581Sr0PnWzhrksTLRhRc4VXeJejnILsFIMars/ame1VlsWX93TM0OWEktg5eVcuiqDRAS9rp+4YJgLHRMuNDbzs6k82wA0r4dfINky1upkwLMUnA33uks6/auVPE6BBvarVpV56LA7klKG5HPAorENvdZFIqVEbYGmdv4OU5VXOIemrUMHEVHOfSs1YuaH/z7zCVkvKq2wj+jbNYKAKH/0rOcxdrKpR6SLx+3e2AA==;5:mDzvwLuNJb7KujwCYIPkbaUaOjO/JNM2KihytD5TLSMSdIyJlFLUVKUFKQo20501L8biKkLwylENuN1RA/E3t19f6rlzonwJeI7QTG7A/F26+azGmigcBpfUnJstBg2iTi7DTBoslDe/GlVCkVJbCpiHcYg9S+i5bSsrRDUM8pM=;24:SNM0Zm2QOiCCCwkDa5V1KrRT7hWOzWLXy3Ai+TLdx23WmMEH9rdq0ZXfmMGgmhxfuOdqwAMRhxABngHZ7iUE/lrO/1bWotGuUlenOg0X6CY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4244;7:oMrjfP3j5/bgveU6yMDfc6NsBb7rj4GkoAVJJh73/f6IQG4YpI80U/IP44UvupS3my8zRjZUnph3wGFkQ/vNr24wvLd/KEe7NEvPWtILUbjxNaBFvg/bOxgE76eUHglVS4GBKyYuLrIPHlWkvR53QFsY7+OYNY14u2Z9moitNi8zZym5XXIhvSyJOsjPeDgHvIsM0ywjv0kyHVU/JfRGiE/hF07hH+3ynuxuxBY8zDWUJo7jXC2iAWVG70xZLtoH
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 07:44:32.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd611f6-e9fa-4d62-2ae4-08d5d681aa5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4244
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

