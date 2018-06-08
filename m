Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cQJ4JjAYGltafQAAmS7hNA
	; Fri, 08 Jun 2018 05:46:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9239A608BA; Fri,  8 Jun 2018 05:46:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MlAiGcN3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EE0DA607DC;
	Fri,  8 Jun 2018 05:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE0DA607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHFqh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:46:37 -0400
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:28736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750823AbeFHFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6U2EdMmlFFL16dY3XAuIHlhG/PmYNzM7kHHI4QFYAo=;
 b=MlAiGcN3KM61Yc6fTDrjzEd4fV6M2R9ALZOb0yMO0XjYZPAr3CHhwCF7V51wqpPuL1PKXfDhMhb9kbDgO/44zM++jW/gV61wzTFKULZBbCnH0JKKBEirvZXLeLkJpgYqS9GC86LG+gA9gDGP0lEGo9hIVGuAHHbrInfupMVBVf4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:49 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 3/5] dmaengine: imx-sdma: remove usless lock
Date: Fri,  8 Jun 2018 21:44:48 +0800
Message-Id: <1528465490-19684-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:BRR3/BE2qYJcBNK4/z0vRUya2SW20W4YoLpWr5MOOYE8pJFIdPUmAPk4UqHLXGrFQvAvDFW3nmckEFrU0Y6l+36ACgEL+GCB+kgxUwxMuRCcgcZl67WhM96CEUpBiY39ly2GURNG7kvR/QrJc7ZDmkLzD+FCryCIwfqO8nxbJeAqLzyrgKZSthzRQstr9g/h0eHjHuf4vVKSaXKG8JirfjW1Gm+COnvmEE7KiMjsG7H73QtKs6M8w74zMZ7LjRlK;25:Ze6cXKgmjOsNdBQHQEfyTIKuLPsZa9ti5OOlXTj2J9vcrwAZyfTCRdFUr/EzagZ/flaAakvW8+gODyEWgxFAnFBt6eJIVEsopKcrs2/79poPZVfjPBDa7GdlwA58KqKwUzLcpsVpOUWnyorsnPjCvprpYxtzc1N9hnuwgbCGcpcBwtuRoxJRiw12bK5rhDfqO9luADqc9nn0k8o9FMl0QLTW72so91aX0sGjoMs5vRVRs3U2iZFs4ig9JEI2AEyi9WQBWxEaKMZK8YqOA8NKTx8FZ70UyoYyMM2KVGlpAaBmBr8sVziPxCQFFPZ5tLFcJ4/oj8Kfq5taCm4q0oifBQ==;31:Yk8XahoWjlZDNmjXCviWU+mbIDs4liOuyiDfE5uIfKeX6BDXO3Rud8oO0rMWtMeocXSR4MhDpmQloVfVCbMNCU4gYKToyysWnthvo0/Oiz5sPUrS40XI4z8rsnmPscS0wJU1vQh9WjjNaPtpKAihfKX4oHiEB1mfkpR9BdB5voS66avTuYl4FFLrQ/W/tH0lF8CNlQP32UTQPAT6VtXGwBmf6pSQyrTBmOQZHMm3nAI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:BAcE8PSIX1rbBB9n/EsgFx6zJ95rWSLqd1l0oQRYE4ef10fFgKc8ds9TLSJp5dnXDL45HsPvvHjigzuTVufK7mJ905Jc5TAFpSsR8hHQgDj5Ai/v7CpEkW5vObjlM6b1Z0JLdfZIl/3cVIsr8rcvO5dDCaK0oxCORh8CveEAr//hdLiEhzMbAMYdMwqL9McFArvW1xXSBdV9aqyzcvEp1KksXeu60a9eWtsu7UVif0J4tAPoCN5ibmxnJ3+G0C0hmfq62/6Hhqaii60IrwUnNKmMByGivxgo3mSF/pPEV2mi45HtnMIOiMsg82BkKQ4BF5Gkh2yVtQCjaEvhGonErQZ4T/W/wOkv6yO5exFz1d4V4BXtYDpNxCSooq4+OK2fn0RQiN6lTDolz5RK3ZqTg/UQdht90UOm5sfTWnbs5iQj3ZRUEqVDqcZK1YsgTAlSZqazLKNq/XZ3yhixEC9ZXcSWLY+u+y66nrKBcVyktbswSRHB1ozIX7vZFSnslG9e;4:iD7XInR07N2qDydz3vJ9mADjR7CemAGuSavlvvHoemq4HqdkSllXVhzwCg3MCehsNmcwkzSFpUQ98PkS7F4HZgpUcaj52KCsUQudeStaA8GoTDDkMkDsZIp1aNRYRRz2KaJE6A3Xjloux8OXarQtSUYU26VgWQwripPhrVK7BP5J6mIOQPtGomJ2bs8WQoT4CmIL4Ef3robWECvGNQ7uC1+J3Bf7F7UqGI2uJqIFTaN0MiF4nMR+HXm5VndgyyZr62lQnEcNzAb6lzBXev9rGdNlY7OwmV5wiMisEpbtMVpEDVaEcePryqN6PHPHMNNj
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232A1207272F0B6C7872F9D897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(11346002)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(76176011)(86362001)(25786009)(51416003)(26005)(59450400001)(316002)(4326008)(81156014)(2616005)(956004)(446003)(476003)(50226002)(486006)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:iwcEx9us/UM4pwdzYyrVWuxCYcSyvutY3zir52Eo8?=
 =?us-ascii?Q?n2yki1oEq1MyGLKPva/NY33/uZl1q1ABKulFfnyPuBdobYgChyvOpd7BSKos?=
 =?us-ascii?Q?wbU5D8Y/XJp8ViZuQfMW5nJj+w8Bnzw8sJhR+dS0HFXm+mbqncKBhpjLFtOm?=
 =?us-ascii?Q?ucDVsR4rFJOS/wcYwgY6hVkcuIO7638pvqjMLt0DvF89yJZlp30K41JsIOqS?=
 =?us-ascii?Q?VP6mFdLzxbjHUyXNSD7D56SYhvTqLwYu7/ZIWB6i/DyVO+JYlI/1EMBp4rdC?=
 =?us-ascii?Q?K3mXSXRV8UpNZG2bnP1MdPsJ1ya/G2X5YuNs/feMCigftZRYiK0UiSh24Rco?=
 =?us-ascii?Q?0qEOeFjoRuKRN9JiL73jPBuq/X9glWv4dVpOApOR2+Krn4OQrlCjGCISGKuL?=
 =?us-ascii?Q?Uv4OfJBn/Cwnmq3PzTkg8HtBc7xXrF7qakyyymu0JoKYsBnfh5b/rUeK2pAU?=
 =?us-ascii?Q?lRNNIL0+tJD7Th9cSVsbs0RgO3OUj1Q/H/z/ABTdH1sPZTc+OtRmzXKEvomB?=
 =?us-ascii?Q?a3lrypqkyuMA/kb5tQbg1QCENfvEq7HsHfoaNbUYVAsPXGQLFbLnGNXDHL2X?=
 =?us-ascii?Q?1Hb+XkROg6Mj12zradxHtVr6LEHZZerfByRuTnGn6tn3FQ5IG/KCBy4/buwn?=
 =?us-ascii?Q?WOIsg2ASJw0J1mSsNrw9yE5tnWYjH6ldaz8v+eWMTUd1wRYXgKIuOD1TNTuH?=
 =?us-ascii?Q?40ODILLjJ7uokcjepxuCqLAHsmnQekbBV2p6kUvhrMh0j4qKbofPTCRFi5gk?=
 =?us-ascii?Q?oMnNO26bt3/9UHtAAZ7vpdNRu0mNRSmK1EiPnpns2iL+c79D8ZRSCSNCXN3x?=
 =?us-ascii?Q?VAVL4B3nCong/x4en/KAL1HARmSxq4RDaVTIZ5Aa6u8+Mue55ki+mXG5KoUw?=
 =?us-ascii?Q?jU2RFId3cTgBiyMwutRHpd/pfmR/59TkSiiHWG2w7gtbR9L3xQRZS6Dw0nGB?=
 =?us-ascii?Q?2baGGWS6H4KaCqZOwgWz6s5MRblr+XVHzUWOBBID4JWfudI4LapaTJ94/cnn?=
 =?us-ascii?Q?EoC+3vy4PXowgptc38JeudOEAJ9GeSZqUwm7qlzAWxbPwRGgHoS120DjnxTh?=
 =?us-ascii?Q?jCETzG08AzQSyi2N+FpQyvLLhBH3zj7JaY0Kzs2oWYIJCzeNORCJU1RW8t74?=
 =?us-ascii?Q?MBxveX0LjTpPiOzm+r6Dd37bzMO4Bgxoy81jW6mDU21CpBc2rm+AQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: IsjoIAUM//evNUC40lWmk3PN5vQ31HmcJSYgChPvJtDG2e88ggfJHxuHMZj2fZSgvPjo/Tw7ttdywuDkdI5Oy8kKAaB16qmIwv0ye/sgFpzFIHSlB9CTz5Lc8zJz3eEA8m1H0gP/h0KnH/mJFhzU/QQ5ZQvgh4oVZK7lcUwJwfwJib2DMfbHXmOOAyX4aAw9
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:xz2RO2heKAGYqzUjrgFufmY6pAsgr7ZzmP5HrRmv5xZ4XRKfBkp9Fx9KFx8ULCw/HBJ3rmX/HtPYii3qcVXU+Z7erk4Yj4OZ0CAxGBq6zvyEzZZl3o40OXSQifppwE7LS8tCdcNngUt8u3iBDwFYP4x0VUdooVZ9XldtJXprdsGRg7MCM4KYny7tv9/m9kKbXI7xfVoCJ36T6WWxUU29wHeF8hxlGa34JLuoUM+E62pF/0oWSnjoy+uDqRlcrLxWmGSei/ZpPJrkVR3QqXMJcsq3Oe3j9UGmR7rMXjf7AsXHYjDu7wb4pkF1lWShW7PPrfKAg11j/qLFovsLym+7tserxVnzX0MYw+92WoujWp2cSxfS7K00jcFaTwo+Wst5fzoVupcYqaqFlQQApv4EgoZfhdNgq2FFBdO5b9xcGyTCj02TZmn6lzxhjHN29M0GTC+jaOyM4VCb7R4smIy7Qg==;5:DlhkRTO025SbUcRIA3mkPUqQLn7DNSU/VMS23hWV7uNeXMQa/pGXFWmfG29t39mF2KxCezA61QxbDEi8nEUEkZtc56meL8p55WWxjorM6VaIzd8LFOitU4b6Ew392KJiK6TcQO1TZKWz0TubVH92n9O/6SH6q6N5bMMrXpJ1YlE=;24:/SSIWZAyBAlOHCaDilpXKMY0Jolf5OwWPUwgq3sPkcr6tcMsE4cCVPuDt3CEA5TnFifHUpVnwhrgQRaN2ypJxqVhjVxjz/RUniYSsQ2z2RQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:S7PPI8Rz20DpBDIX/Uzkk2zfIYfMBHTBLSx/l3MH/IA1OGWEf22l+dQq7TW4FTn55inW6ihyD5Cby+aTUBJbPcJ5qT0jX7bCdesSm5vXbfPoJpZ7qPqZqprwx+Hrj9X2mpDTP4+GIsiPOKvskcS8PGMCMJdFQ0t7HTJlXBCSxkHnToSuVSSZ91E0ddiq27ilzgBWgl183NJ8YstoJG9DuX//DdapGs0pP7oHN0y6Q4aIZBT8wAAOraauwA8oEprP
X-MS-Office365-Filtering-Correlation-Id: 2afcbf2d-fe12-4893-99a4-08d5cd0318a0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:49.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afcbf2d-fe12-4893-99a4-08d5cd0318a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need anymore for 'lock' now since virtual dma will provide
the common lock instead.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d93b58f..6faec89 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -349,7 +349,6 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	spinlock_t			lock;
 	enum dma_status			status;
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
@@ -1908,7 +1907,6 @@ static int sdma_probe(struct platform_device *pdev)
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
 		sdmac->sdma = sdma;
-		spin_lock_init(&sdmac->lock);
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
-- 
2.7.4
