Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C196C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C5F2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="E01MnV6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C5F2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeISSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:55:58 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:38944
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeISSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzzP3s4zv9uo39viQvBHereT3Xa3zHL99HdEb0Z/qJ4=;
 b=E01MnV6CMgQrPv6xJnM6ekVfdjMY594Crn37/1QaUSBMUw06sXcbG8dlVxUewygiG55hEYBKhvuw5sJHe3+jNBSZjVCh+hvn0AcX6fqb7mAVFDVMdpaKh8q5HalrSXUatuz9HRqvmAsCE36xCJfTnF6SNEbKjgZsDUyuohM2rK4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:17:58 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Date:   Wed, 19 Sep 2018 15:17:27 +0200
Message-Id: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0602CA0003.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::13) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:37::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd29e52f-2663-44f8-dbfb-08d61e325216
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4666;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;3:EuQNSg70cksnTFWcwPmOzZdjZR0fPYs0UhffV6t9/+hbX4BH6/unVRtVtvdT/9QAHXUhWNql0Z7v7um5IT4QThL0AU+Pnz/zPBCTF92mrCfBPZES2GTllC3u3WZ0l3Y0T7tRREPcrys9lMnfeVWzO3zUK3SSiYUCw9v9XdFhmOd6JV+51IlEWoeKNHtTZSnB1JUE/n07/QMSMfXy+8dpL0JhcOzcvLgAHwX00Su3CC4IKSWe8cJ6Zyq9Vacy+TWm;25:sCmMRX7+vy8sDe9OOXxPZuoBEBneJjR5YI99JEcr9P20ZIeSoGthZmFcW9atqBXUUFUoXVN0JqihfzduKfEmbvXTYtyxl5tP607GPT3dcMzcz+ZzQU9URbkmdI1bCbB/kyI5XhHbjc4g08PLu7In7SH/qMFZYD4AyHRwLMO+nI3fppVRRnqswI7DVHJhaPD1DUxMIvbggmVatfuOcaxgQXTVUQRzsvmOtfEUqxpd0SyN/ipYDbTLgKiml77IY+4zsIHWSXKGSdbsgO+zCovrEMjrg/nAempKMycmkfo0sy+0tJHOE6jEbQJOsqxnwXVNy+EuT8Y9a6m464w9aiAgiw==;31:8q7mIa7sKbs9lRAPRgI7lkEqx7xwQYHAQYD2HwiY+fRxBOdnE12SjTHPicyEGcSz9OEtQ9FDHgDWdhssHtWahoMxrXWMPu3ts6HPbo57lYXRRjK86ut8hMIwx1iopTpfqdFIPW1NVzi5GwCce/vuUL1GjJr/cXhE2DEhQvnrNRDnqwBpsYhaW2n6ryxWpvluNHxtadJlM/QmtBKnHx6YBuQ506qQeHIzuAgiIvlWP6U=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4666:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;20:bvVCRtpdEgGNcZC3aLlQPZfcooB6o9rEmVVuTR8dynr3Fndrs653UKF1agk6JI1aF1iEIdCN62W+H4IVtN5rddbWPB006be91xwgaohdgoKz80wd9kETTvJPF1LEyPSy1ETQKQl7cQDodz6SgNd3RltlL/uoamensUkr09bh4Hf70OznSISDZ6kbO16P/WwUHK9LRTv645Hn1S7wrew6hTLcL2r4vgXA0cHzuHaan/M/S1LhicqpCUoRO4+/oakq;4:PepMrHtlVimgt4UjqSSbmIW0a8Zysyc3saDU7rXp9eqlciuVzxafPiSMXgbc9msKF9oYKyxP+hZxckniBA1XLtf0NcfTimfeXDBDQb+eYG63XMO+bR+obRYvYSaVKO6ZgQxj5uSOTpYThthIizR/kSj2sLgAz+IBKnwa59QUPYJ1WZfknpnBWHjO2wCn2nkkozjNxVvofvWLQtxOtinCHfswUhj0FQwMNweIz/E7zIy2TrZ07vCAS4I80/GmYk5CjcOQ1jmCmAsCFcUntgrmXg==
X-Microsoft-Antispam-PRVS: <DB7PR04MB46668D7F8430D0452011495D9E1C0@DB7PR04MB4666.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR04MB4666;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4666;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39850400004)(199004)(189003)(3846002)(86362001)(81166006)(6116002)(47776003)(106356001)(7736002)(5660300001)(97736004)(316002)(486006)(26005)(186003)(105586002)(476003)(2616005)(956004)(107886003)(4326008)(110136005)(6666003)(23676004)(16526019)(25786009)(72206003)(478600001)(54906003)(2906002)(6506007)(386003)(52116002)(2870700001)(36756003)(53936002)(6512007)(8936002)(6486002)(81156014)(50226002)(305945005)(50466002)(66066001)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY2OzIzOmlXRmFvOHFnS3BHTmtqcmJTRWxoZHFiVzRP?=
 =?utf-8?B?bUZGcDVIRzJPK2MxSVZ3eGJCY08zWWNaaGlndHZQRjQ3SUhyZ3dCVFc2Vmhv?=
 =?utf-8?B?ckloZUdHSmNtbnNaMU1tZTZ0N2I0d29obVVMS00yUk52by9JcEs1ejVXdTN5?=
 =?utf-8?B?d2REaEwxRWdOcUVOcURFN3RodHZVSzZKcUduOHRHUmJjWFR1T0t2UXpLZXhi?=
 =?utf-8?B?YmtzVjNObDJUQ3poakxmYVUxNldDaHphMnZ2Z1lyYU93VnhJUkdOTWFOZ3Ri?=
 =?utf-8?B?SWxEZ01kUjZsN3hXR1E2U3pwK1ZMYXJYNE9wbElqbXVRa1Y4aDQxSXpqd3Ey?=
 =?utf-8?B?U1FzVlZDWVZmN0s5bGp1a1hQeVlqY2pVcXRia0JZeUdwWTZ1ZGorSjFQMC81?=
 =?utf-8?B?em1IY2VnMis0eG4rNElMS1NHU2wxUVVpN0JDVU41RFY0bzdYUnBQRjBxajQ5?=
 =?utf-8?B?M2FRSXJIZzNURzV3TmpZMUp5WFVXdGp1ZzlDa0hGTXZTV09INkw1WExhcTZ0?=
 =?utf-8?B?bTlLTjZkTXdiZXZhN2p5TWFFVzF5bjJIeHpPWGt4aEorOFh0R0dlbXRSRTRP?=
 =?utf-8?B?dDZmeDlQaGs0cVQ3RXBrVHBqL1F4SUFnVnRSQmFDMWt5dGk1VkU3REtkUTcw?=
 =?utf-8?B?SmwxTXFQQ3kwWmkzS1M5K25NNUxlc0FOcVN2WlE5QzZrR241SkZRRlNzTFRL?=
 =?utf-8?B?VzU5WTV0SkFyT0lYalhMTU9TNno1Wms3Z2prQk85RzNmbzdvRHE2WXJWc09T?=
 =?utf-8?B?dVVTejd6THdzUFdDeW8zeTl2SWNZMlYxUUF6eUZpMzd1L29CVlQyYzEyMzc2?=
 =?utf-8?B?RWY5dDlLbTJNMG5TS2s5a3hjZFZFdGFVNDEvM0VycFljUzRTTWpVdWRIeTIz?=
 =?utf-8?B?d3ZKRG5VMjIrd085dFJkdG9KK1VNdGtQdUdyUmprRTZyZnl6Vi8wT1Jxa29z?=
 =?utf-8?B?R3dxeXVaNGZWc2xXdmdhTHRmaGtqZUVvbDB1Zm0vZVlNZnNGWDJDTUlLWG12?=
 =?utf-8?B?K1RmTFlZWmNvL0hHUldXNWw1V0NHN1FwcDFSQWZCM3Qxc3hHUTkzZGgzS0Er?=
 =?utf-8?B?YnUxSFg3elZJcTJUKzFDa0Vxd1ZqZGttT2lRYVRDaHIvVUFvelRGTW5VdW1R?=
 =?utf-8?B?Q3AvUWwyQWRwMElCaWI4ZWxyb29MdzhGazJvRmtBRXRhUUVmQWhjZERUWmx5?=
 =?utf-8?B?Ujg3bUQ2MzJhQ21rdzF0bTZGRWNsRWkxbVRFZDlFVjVLQlhXUVljYjl6VUNU?=
 =?utf-8?B?ZXkxTjdZeTRDVHB2d1A3R25HaWdndGo1QlBGbHJ4T3YyMlozSkcwTWdCNkpK?=
 =?utf-8?B?RGRicThqWTRxV1psTXRGYmNicTlyQmJocFpoYWdjQVVsVy9VdmhUQVRZNFAr?=
 =?utf-8?B?M2g2bTREMnJhWWdKL014LzNSc2VXNGc4NDFoUytkS3ZRVUdab0Z2NUlKMXdZ?=
 =?utf-8?B?c093dE8vaVY3SjBYRVZIMVhqTW5qWi9JQkwrMktZaGdCQ0Y4NkRWL3VOd3ps?=
 =?utf-8?B?R0JCN1AwamRIZVNZUHJFWE1ORit2MDBTdTJFK04xalgyaTI4K2E4RVBZZzc0?=
 =?utf-8?B?eHlJT0UrWlZna0E1NjJZb3RLTmtxOXc9PQ==?=
X-Microsoft-Antispam-Message-Info: 2ZDXWjctEfaJG1ZkWoehSK3snqJiKhzwy/fSUsmo+u9fzzXVML/2o3R6I+d2vC6u15MHL207u3K5yteIg3l/WPFEBhGRE/MpDnXAK4Gd4HMhQxvbs8U4+arOr/IT9e4QiWlf5iYCglfOcrH9EEU1rokbS6DmEwYnDDUtroujxHNhU9Sv0vaDF8Q4gERCLKx9+QnAghfNIkTBAzgNt8SizcO2asLJClCbqrqMw6v/O5EG3wF0j8i99lya45Q4sgLzGixutNY5JenU60EFtz0jfaiyItjx+zHfeJCFUFWf2pYF8aUud+NHuxlC++YT3Ks4eKhQm6Ag5IMq4/MbAAYKco2HCxfHOFYhtrLEmNjJjec=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;6:cmTopGVwDvyiwA2Qmu5nmKk6djGkNHiqgpKpzsDtLHY9cVwMdRd87sX8HQuEJhfjrRMFCQuodyaHgN7gbCkKz4N4lqZGmnQvnqTz3OHv6nIMUC11jYWayzf2bcFg68yu3sUxRml7Cez1PRUc2UTJzMS8pMAcqg8w+OPi/vYRqI9zvkMzECcnHNMtzuPx1To+srsxH4U0lFJQaPRmLZaTPbr9O/nZPaYyB57pwYMFlqp2VRiSekRObYq632QsEu/65WUeOQDiVLpdLI2YC0CoEcOSgnikrD4UQFhEfY/IRRd3RGfV1UKijTGR+kbQzKkq01f5aScQVyAbGtNTKn3zQDAhj7xSY6xx1tyBif/UkEhVK7N8zcxV8vJod4TuhCAUj9hnsMFlW1Mu97xQLfhZiZSkOmb8mwdr4LOoLGZ7i/RgFXwgP5b3Bj32UsQLYO9VV4geVY5XWDtRgzbXYzJlLA==;5:6x1ierYwCfbKTARDgX/plT4lXzCfzfOqWn53sYHWzbtXCFOEZ79tPXvXCGjuB0O/4+KkH9/JgInBVZuBmBV4Y+hHYoxfUfhnoxh2b68/6BJ4BIcNt43SLPoxn6gtpP6RA1zwabvmoWbwCDxbZ5mqhtBn/BD+opVDWeFIHzcyW/8=;7:rggWoRBreWDOn8XIj8n+tWaGOWkP+Dg4wUCfBznEwctHc6nF75kY3DGPFLHnmdEHo3CQw9f5ytWV13ZQ6Tsol+v0uJfwPafkINThiuSBWAAyZeV/yfeK8PXyxovdtBTpk5g44nx7c4tJGZWWTbm68Ei/cqjQQz5Wfl/mdniCudbPSXeDW1oEqT0+JsC9BWWZmHQoSJDXv2PFcBy6IkQXLif4Fx3OHJE6m40E2K+7XaIX4qfeVeaRxZLVHt0dIEQK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 13:17:58.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29e52f-2663-44f8-dbfb-08d61e325216
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset signal can be produced by GPIO expander that can sleep.
In that case the probe function fails. Allow using GPIO expanders for
the reset signal by using the non-atomic gpiod_set_value_cansleep()
function.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v2 changes: none

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ba66c02..e7ae135 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,9 +728,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value(par->reset, 0);
+		gpiod_set_value_cansleep(par->reset, 0);
 		udelay(4);
-		gpiod_set_value(par->reset, 1);
+		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
 	}
 
-- 
2.1.4

