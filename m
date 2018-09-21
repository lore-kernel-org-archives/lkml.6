Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD524C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4514721532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w6dYINZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4514721532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbeIUUxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:53:02 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:53408
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbeIUUxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gpp5xuOTUa8RzA4hW2haBbydKm5zyJuZJbeZBcnk78=;
 b=w6dYINZH+YQFQf+koeRcXeJ6FsNtaxAAXA6iG3w4t2jJmEeSjj1J5DnWlfg2ZXRO46i5y/W6G5GTJO/PzBlLhFhYrEzDQu20anW78B/LKIy0ech/5GFcv/mSN8MJpmmUPgtRWzG+My53mB0wEwGIK6zQAHcspy61ziBy9TJ+1Zs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 15:03:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller " <davem@davemloft.net>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-crypto@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: mxs-dcp - Fix wait logic on chan threads
Date:   Fri, 21 Sep 2018 18:03:18 +0300
Message-Id: <163d1af7d51bfa330f4cc685c5c493cd38aa584b.1537541211.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: CWXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::22) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 336d5045-83fe-4ddf-f47d-08d61fd36b04
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:50uOR9DX7KWeHPUlwoPP1d3HcQX788wjZmfyn6CMkvLeEMO1e6/WFVDIG+LJT3BfjaqgdHY7D+SCFTzP2gTFu7/G65rW5nPIVdrrW7L2WBDIxluR/uhOaY+6e30oa+Hwxo7kmZ35zAP1zWMsPNu4s3P4RXqrL/cP54nxcQqjCyrB2XcrEhoME5JQX7hRqZymYdqG19V3nqh2MKubTaXxfumhcBgYTqICHht3NfcVp24MYPlwPoq0VtZr2XjYyB7v;25:iYdF7wUST+ZcOvQ2lQ4YQL+kevtmgXKxnz2F+51lsraTNsJO0fOdgyNXyEWdVmmDywl+IIInDgBKxvMR7FBYb2bBin99l6jmtjBwK4hAFcMxnTfiZw9E5W1XIreSOVIJQ77WdQD8hwwAK7CEOSgZSUnKvW3Zb7463jsZj0AN2e6hUePynjoNl5N7ojQDLfBIQv1/cVrLGesy4mvHlsFLvKKOfQXHXxg8b1BXIdvWYxrUvmjnEDtaKoPuA0Xazqrpo8+3vGWM86zrBYmF3OXG9lNnzFznbb8sA7ILMGKWSZMEq3Y694eShE9ln3KNg6uBs6uDDEHldFclWTx8rLIPjg==;31:F9yqznpenICTdHNw8ULoOr6ro7UGD+Ihow0Djxyj1VHK7KY7i7X/PP3FCbSJrILif2L0vPLrGkUvuW6WoSUGvyagwhqqf3xdljKM0GhvbFjZ5Xlbs09/tBhxTb8u5U3quthzg4Am61S6pniOJy8vr+LfqFcH7u3BceuayQIU9grFom7kWw7rCoRnYSzhZfkj9A15dw4hU7ZTZJ5fRK2QcYShn+9B/B4F5J88p5GbN8o=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:dd7FZqTov2aQKb38/eI4hE4U2RNZa0+SfpCuJ3HOw9O6iptBRDVkba4tOtJswK7+rVQF+fSOLRqwvyOllVVmiFtSZ6u4h5CL+w80Nth72ld0tqcJxtkukNlAbXrnmunVmw3Aansze9zxsCOkJK/6n09OPHfMV3TyiIss4NVSnFWZxcvFxg7tZXq0gJM+OmWYnEH77LGTMUHi2eh+cXo8K7dzJBePZ4cjPsLkbigOOUxWYjOiImBvXQ0ac/ApniNM/ZAq5tdy263jpyvLwQlXgP52z8RW0ZyS+H2aZ8q9ezJyTU46A1Bi1Duk2QDPrGhN2lRRJgj63Ag6rfZ5a1dIHI7SZ0cbiP3+tl36yYwlQ1LqHXpgNOoLlSy/ybBUft5l4S5n0IOxIkOwubb7Sx8+MjCww54+ySyZD0sBkmf25Xg8W+5gqhJh35cwKFG3vaE7G1Wa5onXAjmMuDMdVVI5DtvHglldCxL0HbkZMig2ze6stG/q2MqN0eHgIyh246RR;4:PShN1mA3SdgnFbIIhsZ8v48KSU2GfsTECiISpI+5NtP0HgYFAZ6h6rg5rtzkGTByL1tBxiwTz+aSK2GXsbMre71SY/+//Q+2VhKFzq5dqYKK6qk8teFtXv+Gf1Ymi0UZVv/kdklSAh+vZbVQSY5CJTEJiXAbTZW+E3U3rIToMVonE8aZJ/mYd0WHZpLd1KGRdjp4MkmO+uFGknvVPTdeBU9FSUerW9YSYN8KSMHqIf/qGzY3iFDAM8Bw6sM3shDXTgaqXQhtWz43JYiwvB4gWwaTXCDh6mrBwQquDkJLx32wsjTKeATiBQETzf4O9rp9
X-Microsoft-Antispam-PRVS: <AM6PR04MB4295803CF9BAF6824D6FB7ABEE120@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(6512007)(14444005)(68736007)(36756003)(53936002)(6666003)(8676002)(3846002)(6116002)(118296001)(66066001)(476003)(478600001)(966005)(51416003)(6306002)(2616005)(956004)(48376002)(50466002)(4326008)(1857600001)(52116002)(486006)(7736002)(305945005)(47776003)(110136005)(54906003)(25786009)(316002)(39060400002)(6486002)(16586007)(186003)(81166006)(81156014)(2906002)(106356001)(26005)(86362001)(50226002)(69590400006)(5660300001)(97736004)(575784001)(105586002)(8936002)(16526019)(386003)(44832011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:Ozu3L8f6Oi39d2GyD1xzt9vXydFMZqjRvMkjRxrSZ?=
 =?us-ascii?Q?WzwBNFIsgckG825Aoi8zp5Cr6sJDyv7VQ25kvoVyIebF72ejktsUONehSxZq?=
 =?us-ascii?Q?wNv9at1goi//nEdxbV9XjtxFEXuv+bNDq1jtDneQhFZ6Md1JRkmT7BU734ow?=
 =?us-ascii?Q?XRGtI4Qv68Kl+CjMOkLdR/7wbC+CunDCXknRPBnYKoSrOjXDWS2zYwh6JwWq?=
 =?us-ascii?Q?5NZ5y7z1p22C4w1Uia1JzXAvXY0gnSZFfNUZxaMTUaciEBNqeLwpelZtPxQi?=
 =?us-ascii?Q?o8zMQelY8/dzElkyDPfLKsJ4f298byzseSTuREqpvN1nEU8kmGFwV56Pwi+G?=
 =?us-ascii?Q?dQxicYJFiXoLpME71OIP6ghUrTC5mwZO/51J4JYe+GADzls5KKPRN9rnjPTk?=
 =?us-ascii?Q?BIq14H7wzPWAr2SPWYWOQZ3ovsUCIZoPtBQs5VXYZkxvUhZxrJf48oFfuZiy?=
 =?us-ascii?Q?B5RmmbZ+D4pHxaJuLDELOAPRFXuJZ0sbzvN5YAkFCEQZZqjmTjP3kbNDPGro?=
 =?us-ascii?Q?BwpS9CgtVvvVk0ffD957Fp8LoXVLFo5pgUWu5NFtroTHffNpyG+87fFtZkyT?=
 =?us-ascii?Q?YZ40GLxr1scobRQoi+xLdJ8Psp7zcHK6ezji61oDXbxIT9hW+7FtgBxRaA7F?=
 =?us-ascii?Q?4DaXjtLxw95VeooMEyKpVLMV0HafC/aiIBJ1lQgNsLOZ/5EKSCLWQcflftrY?=
 =?us-ascii?Q?WGTcYqNf7MkGFM9GuTgITjpkQTwCKp+rYdc83dYPkTpyh1q+fopp4AvQpT1b?=
 =?us-ascii?Q?UxZqIH4j1Q2E/H2A8ZX08VQ2C5p9MPuMQpMMNMHExqMbvPuNlJKZQoJ4/GEb?=
 =?us-ascii?Q?l0SgIloBGMTnL7eMH9y9JeSw37yt4zWVKJG5phzQImtK3SDVkddv/+cPOGdB?=
 =?us-ascii?Q?Rix/uGsxrfs1H1WhxGDS/Wkb7ldpPCVzn1+jMRyv3Sp7dmzND+u4/lEGToIb?=
 =?us-ascii?Q?Q5n6C2n8zvx8wmZS1MpSp7mmfvJ7a4VhPF/gvrKZiXeBgKkCTgoVQYZF2qb1?=
 =?us-ascii?Q?vjhoiqPlyngicerUQuiI3LUrARVXTqPtEOlmG60B/Xq2dAxs5pywKOwe9BpN?=
 =?us-ascii?Q?lHxRSOVeTO97HGmCuvn8W3c6KeG0Ru+TFdEXYibveVHlWHxiT0uzaC+ixgFD?=
 =?us-ascii?Q?pldgZn1pO3qpvWhFhJD+qlPCtLRfTiw8FSKdnU6RSt9PmMnRXX5zS0U6jhMZ?=
 =?us-ascii?Q?LRYPnj66q7aKyI7f+v0/MVWhGOQa5ZIYn2k9MfyROXMT24aStXimL048Tzsx?=
 =?us-ascii?Q?acExrcdP89RUUybi6K8ZjLNCFp7gr4tKmINL7cq7p/woT96sDbsWxfs7GvCZ?=
 =?us-ascii?Q?zusUeyKRvsLKzCEre7CdkKhLT9aKcQUAkCwCRJSC2VkyeZ3gKE7+qL5RHk2q?=
 =?us-ascii?Q?TtuKg=3D=3D?=
X-Microsoft-Antispam-Message-Info: GyyA5aWd5wcQZUxAqHIqWjhZjgpWhJLah/lp9X8NgIXhbM2Vj1NewsD5PDtqsTW6t3Y2OdOxN0BBu1y11BF0/tFtRTRrQt5dT8ROVSrlJ90gcnadyQ2NSzNK/Q9sWdRfojvvN/wWvB8GFuzlLdWBYTrD9uq++tpYYO9WeY97vd7cSEq3Ac6zB2rQrgycPWs8eB4PYQytPILQnB2QmuSZ9A9mvXyarq5ZbBWjLsINbnTO7VNeKNfkV9ogv9v6HuTrgId0mOkBJkVZphiF0Wv1jiUqpElmh7znuuXKV4f5y0DqsJLXP70ub2a+Oo6MHn5Z6I6G90VhQJJEGoBhZ/m1oQW0hPo8kR8FMWwZKBQ3v+c=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:R+Z9g6wQFNI9PtvJMNbJk5DKgKW1zokhQiVVqAzAG6vL4+6gbc5F6kr4TZICniGr54WFtwnsLrvULm8PoKEc0ZCka5kS1PT/9Q3iCywg8kiZ+yfn7xSFLkmrmR7cD/DsXzHsJwH90slwyFzAitiohs4rMtGkA12N2XEuRLAB8Xovg6Ym5MSnCBXBMEOpBeIiWWHYX3EF0g2m3g+xO/bHgRj3wLQab79RPpvOoR5+Fm47rutJIcrWb6ga1gDeD1RGwegfZc1GVpMY7LISAnOvovTAQPyuoVYD7bAXnQu/+xUSuIB1roRkXdn6JXq493iYkYKncrT1UWyOoZnqlfaJkgOF7YU4AGGt6pundPEsNCqrqfLoMJJzKFmXiIm4FtT/oxy0SlYnhbay0wKKBKhNSR2eIgwYc3UariNgXelJPNz/UeLkEzHJ9JtJcqlXiqnxpUjPTW1HQNZ138HGEov3sg==;5:7l4dbZV8gQOa6D2IzGdw3lolX0vE2l+FwoWGJWeS7sb9FaiB1GL99xAkEMkN0iPrzL4chtox9JLUj4OrA11yqQ/6ECMt5/dqUi2rWCMped+7/UFvioHhpNDirzx+qZdzULlP2zPxu5W6GAAZuFde4plwakU6eh5ob7Bja8B+kz8=;7:NVmYcK4mB+eJMCKJvsXJgLpE077DEaqQfHe010tBTRJ9PswUMmtrMwa7hN3njDt1gC0NI4EW7fZxa9RLSIFZH0PWVvIRknJlzUvooQDf1PhG5GQDMTHLrK9saGlxgWpA9vDOVcyFZFor2yG9IzFlhnNZcKGcwYOQDB8v72RKJfCq98xQS51isHL19Dk6Rd6Gic23p+e15P71tXT1eHVbHV4D+mn3QxcayJukZ0Q29OYnBjaqXmJNELBAEG0VxWJT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 15:03:40.6036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336d5045-83fe-4ddf-f47d-08d61fd36b04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with CONFIG_DEBUG_ATOMIC_SLEEP=y the mxs-dcp driver
prints warnings such as:

WARNING: CPU: 0 PID: 120 at kernel/sched/core.c:7736 __might_sleep+0x98/0x9c
do not call blocking ops when !TASK_RUNNING; state=1 set at [<8081978c>] dcp_chan_thread_sha+0x3c/0x2ec

The problem is that blocking ops will manipulate current->state
themselves so it is not allowed to call them between
set_current_state(TASK_INTERRUPTIBLE) and schedule().

Fix this by converting the per-chan mutex to a spinlock (it only
protects tiny list ops anyway) and rearranging the wait logic so that
callbacks are called current->state as TASK_RUNNING. Those callbacks
will indeed call blocking ops themselves so this is required.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/crypto/mxs-dcp.c | 53 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

Some interesting info on this warning: https://lwn.net/Articles/628628/

The sahara driver likely suffers from the same issue, code seems to be
very similar. Maybe some crypto helpers could be used instead?

There are multiple other issues with the mxs-dcp driver and additional
patches are required to get it working well but they're not related to
this queue waiting logic.

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index f0df3da71c7a..73015038fc25 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -78,11 +78,11 @@ struct dcp {
 	uint32_t			caps;
 
 	struct dcp_coherent_block	*coh;
 
 	struct completion		completion[DCP_MAX_CHANS];
-	struct mutex			mutex[DCP_MAX_CHANS];
+	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
 	struct clk *dcp_clk;
 };
 
@@ -393,29 +393,33 @@ static int dcp_chan_thread_aes(void *data)
 	struct crypto_async_request *backlog;
 	struct crypto_async_request *arq;
 
 	int ret;
 
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog = crypto_get_backlog(&sdcp->queue[chan]);
 		arq = crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
 
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
 
 		if (arq) {
 			ret = mxs_dcp_aes_block_crypt(arq);
 			arq->complete(arq, ret);
-			continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
 
 	return 0;
 }
 
 static int mxs_dcp_block_fallback(struct ablkcipher_request *req, int enc)
@@ -453,13 +457,13 @@ static int mxs_dcp_aes_enqueue(struct ablkcipher_request *req, int enc, int ecb)
 
 	rctx->enc = enc;
 	rctx->ecb = ecb;
 	actx->chan = DCP_CHAN_CRYPTO;
 
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret = crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
 
 	wake_up_process(sdcp->thread[actx->chan]);
 
 	return -EINPROGRESS;
 }
@@ -695,17 +699,24 @@ static int dcp_chan_thread_sha(void *data)
 	struct dcp_sha_req_ctx *rctx;
 
 	struct ahash_request *req;
 	int ret, fini;
 
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog = crypto_get_backlog(&sdcp->queue[chan]);
 		arq = crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
 
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
 
 		if (arq) {
@@ -713,16 +724,12 @@ static int dcp_chan_thread_sha(void *data)
 			rctx = ahash_request_ctx(req);
 
 			ret = dcp_sha_req_to_buf(arq);
 			fini = rctx->fini;
 			arq->complete(arq, ret);
-			if (!fini)
-				continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
 
 	return 0;
 }
 
 static int dcp_sha_init(struct ahash_request *req)
@@ -776,13 +783,13 @@ static int dcp_sha_update_fx(struct ahash_request *req, int fini)
 	if (!actx->hot) {
 		actx->hot = 1;
 		rctx->init = 1;
 	}
 
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret = crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
 
 	wake_up_process(sdcp->thread[actx->chan]);
 	mutex_unlock(&actx->mutex);
 
 	return -EINPROGRESS;
@@ -1086,11 +1093,11 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	global_sdcp = sdcp;
 
 	platform_set_drvdata(pdev, sdcp);
 
 	for (i = 0; i < DCP_MAX_CHANS; i++) {
-		mutex_init(&sdcp->mutex[i]);
+		spin_lock_init(&sdcp->lock[i]);
 		init_completion(&sdcp->completion[i]);
 		crypto_init_queue(&sdcp->queue[i], 50);
 	}
 
 	/* Create the SHA and AES handler threads. */
-- 
2.17.1

