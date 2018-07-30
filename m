Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094016256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E9520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KIfo7Cww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E9520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3Sgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:36:45 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:1367
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbeG3Sgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdS880G+cmmzVJcHPwxqvCGj6lTTjzMSbCkYUcAJ010=;
 b=KIfo7CwwreELyvJbSa49JvQmsXdwC/qJ9RnPIa92x8T3B3epnKwGUIxLnUzGPgoYOu5ik4X76YUGpxxM+j2tku3+ZZbLyVnhYxLcT1u+BLMKc0l7BXqCdWnT8PocvCC1QsbaPgWMJSD0W3WEAmgAnSrG9fURT1JlgGjy2KMOQkM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1323.eurprd04.prod.outlook.com (2a01:111:e400:5889::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Mon, 30 Jul
 2018 17:00:43 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com, nitin.garg@nxp.com
Subject: [PATCH] thermal: of-thermal: disable passive polling when thermal zone is disabled
Date:   Tue, 31 Jul 2018 00:56:49 +0800
Message-Id: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:36::30) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d2f37b-0488-4b54-3354-08d5f63dfe11
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:EqHTq0S0TzTJHvrziUG+CxE+2V1NLO4ETLDR/jGSZek7GEoq4H5hs8QPL+dazC96w/qaFxUkf+XBLBQEbGvINRHtMCX70lCjdHUsucZ2ZsjEcSBz+BoWR/qnnJUd/mISgO/GBTnPsLvlEZoU3dWIJcescNl2mobtM4ap+Z9K+wGt5aEzHgZ4/f9l69umKshF4HX3tis3cdJhopktEf5A7CctEgxF8bbA17aP2RvcwClbnXNpcCiunuZgEn/jBOJB;25:2vg7tsJsQdoym3qw/m6ALNkmwWwLBlNCrSdx5u3op1wSFUMLJVjuJWGIzSgCLocSthjWYFjIoGgDGSr7Y1fQAa27E0wk/FtjZrIvRBYLQahFo2RalHN+LE816m82t+XECXL2160qg6N7+5UkpFyeeaFH+3OojKRn2TrwHliw1G4JDWM9VLjlAw3y/MqvIA4WCdStJZDyuUaRikXyYZzAm4F2hWjrpJ3MTdZ34EbxRbKHyVHdrwz+CJdxekT38nrOCxDX0F0wc2ENbIsXMNizGpsHw25hvyK3ocH74bbwuIJFB29FmOBqnhKbuS4ijk7nXTggkLR5ysM7YxsvvV41MQ==;31:A3VDxivnxse7tjxSU9K5Yd2RrX9w5Qsu6PSiM/uW1Rdbi7pqqE1j2peOSe7/Yu2W9pVquPsgWBBB0ilm+9721wlTvHAAQ4t8poz+HlA3jfTrV9lay2n3EfcCAIIF86LePd3Dfbuc+3rmOFtbmJB+XpmwS/us1aMXvn3Z0z7dJKVgJhooCplTmLRl3ibCqIoUpcq4epkVSz+H8wdZahCeEl6JEcAHQ7oLhAPape0bC0A=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:S1Ulm6lJKaaBndB7bFr1ljP736WhNwyAMGLL3DOpw25639ehPutr5YjalpUK4JYOz2UrGOwjqUwmq7CN6p/uBeTt1WGPWBEmLn+WhJldeqE3V27BihyZVmmJVkVFQyAwmhjHebIR2udgiAwH4L8sckUjyf6SRxSfPgd20u/lh614jjzR15RaFdIvxEYpNo9OsKYGdjcVJcFgkfXCDwsNEAXP91bQZQsxSz6wy3RWw95utDfaMbZx+hxbHfSe663HmEDjEUzTshpKdxVQfW58fWz+6dFGz7WH8tgMyhe2DCfdaGK8AT9u8VjBedd87MJ02gpvCTNeWdHbraLNsUXCgAAc/SJ+n9Ub+rXqqn74Iner0pbPf6s7rLoL1/Uj27jU6wB265aps1RWcrul+Ca6TyImfY0lTdio3SDXkqthDbTcBfNALfws67QcueGpWia2OD7samCCcmGq68GuZaXQtrx2rv03eXCFGpJxzvDdh5QZdAHpTwmL5qIep/skSNX+;4:OaPi9atHtoW0SrAGkfq0B0NTM8dp6lKfQxYMcoXWM4zWsJS4W85vC3nI8uKIcfB+o3bI2QhaFCb3L/b5WB5+PFI9y16B2yIP4oJG41ccEIggIUogNRKjoFGcMijNCp4lZ1IKqqARYyKYZa9Vx6uEZOC88KTY/NS743zlqyL7DWe06+sP7iUiEfNC4gBjiJq5s/yqz/X5OLJ+8nQoe3NSqJBgZdL0Rf8vEItEX2asuZ5nB5Ril7rZ8lcuOaoGo5B8p01Qz2BfRltDstIfJu0fRB/Yjl9ZQIbgOx0+sYFWzFYFMXLRIpQq5G2JHB6uWfGZ
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323DBA220233DC4D25FE66CF52F0@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(36756003)(47776003)(68736007)(2906002)(50226002)(86362001)(48376002)(6506007)(386003)(97736004)(16586007)(106356001)(50466002)(14444005)(52116002)(8936002)(26005)(486006)(81166006)(81156014)(1857600001)(53936002)(4326008)(316002)(39060400002)(51416003)(25786009)(478600001)(5660300001)(6116002)(3846002)(66066001)(956004)(8676002)(2616005)(7736002)(105586002)(16526019)(476003)(6486002)(305945005)(6512007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:rtZtP7kdd6HA3TdyJUCVfNmXpY/ZB+G4pQyQzH1Mc?=
 =?us-ascii?Q?gA8Acvgj7Moiw5Mxq4eF2IXujWwLIA5AiVZ0xC7byU4coqhH6p5b693UuyH8?=
 =?us-ascii?Q?kZL3KlOFF3+VIdzq8Ef0d6cACVxb0tDbdTpCgg8SpbecJ3EMIOo5oYSArNdt?=
 =?us-ascii?Q?PLReaIZgd6IYENUi5qmqnNe7FK/7MZzJQ/xJ8NO6+vzei6Aa1ZSz9MC21nWS?=
 =?us-ascii?Q?tx2LAAdQ8erIhgGqergiBCCO+utGPKhCycbrVPwdYUeNVttFC7YFkrUoYkHn?=
 =?us-ascii?Q?Bpc94IOfJuY0laCQySyyFX8ReZ9aq7qEMS/Ll+C+Zh3SBg7HZjo4rPOP6c8l?=
 =?us-ascii?Q?P3Ix4LKhCvFHk3LgRkx4TISDR+f/cGiFOn643uLH339cbGHF87WPhxKAVDcC?=
 =?us-ascii?Q?WTPGTsWeaTxZ7+14l9s0iMMRd47HRomv6p5pSYeLlK5lFpZKsFdNqbDndKn1?=
 =?us-ascii?Q?DWPXDSXlkqPMRszDxaVtvW52w6x/wYnCeRPU8JBj5RBU6yXeoHhHaaQ3bA4B?=
 =?us-ascii?Q?+teTI7NJvBgXAOLQrkZYA9LY0RTXFNYOxyb/AcpSYry0G5dKNakRMOtmRuex?=
 =?us-ascii?Q?flvJw4W4ThxNTXHrn3FpHT5pPVCjtP/8fxKvovFK4QEqeJ9wXCxdTa89jKfp?=
 =?us-ascii?Q?/VBU3Cn8jDiE1rgesyglXRDP84x923fc2DPQC2UesQLbu7nJvGBayPgQpmY5?=
 =?us-ascii?Q?loXt0QpL6k7Pm22rruEQZJA+3Qn/fhp2hutAdeIwZmRWonZfy7Cmr8URCjiZ?=
 =?us-ascii?Q?qiMBQN1lnGrsfcEBrlOZ3RtctfgNosgmMcAD1TWMF93gOBbYaYT/MigN+NE6?=
 =?us-ascii?Q?X2Zu1DgFD7yTpps36e9BBvcT7MtgGubbCtcDfvnc6jJgyKt0SvypQiv3KfTL?=
 =?us-ascii?Q?QeSc+rvk1KNoHn9qn2+0BQy0a/K4X1ytgJD0TmgzSaFiNSRV5rDqtox0trbO?=
 =?us-ascii?Q?dfopOgv72roLS74aTUbhlO8ymjXZAxAWgBGjaRvLYp+Vbb0xX2IiG0Pqj8eV?=
 =?us-ascii?Q?GplsA5iq+B1fu4f+Oge2QtnqWsh1ObMip712TgieJcK9zc6NEON3fPIRcJtQ?=
 =?us-ascii?Q?Y4H6Yn1a10wpIKruUKW7MnF06NOZNh+FJZ8SynF/i0hyVrw6m29XpMvGwsBg?=
 =?us-ascii?Q?98+vCHD9Dhi99TrXRJh0AAam9bdyPXA?=
X-Microsoft-Antispam-Message-Info: fdw0ysXcAXDySH1akGEftv0Ok5ErzD7YuvY9Gir/PvIdEMWCPOeqN6Zny9CDdfkgDyHQu+VCaeOjm2L4n867M50wJu8hj0qquhVXUfzN9jMtKtFS0FOQ9r6vZyYvF9C0KMzf3YIf1qVHNXdEOfhO7ky4wxkSLVujhG44o66pwEK95HcBYwbRtZQfZvuKheXT5a1AQvxGYLd4ZW7uGBFYUU12MzVdPw67ZvNJ5M7t/E+xedthNr8/6WvvFYO8W4VRgos4jlhg+vQMghEv0R9Rrbcbh+IwBC6Ez4lCy3yJG1VTlGtQHxbYXhriUqpSjcHTU/pGAN802xOdgSpaYR8MK8fmAuZquVkgkNjsCAj/7hg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:usF/h0NJ0igU9n0XVH+iXPMj2trph4jpzfsGPGuzaUSMlmbI2vJ+5tP2rEFonOXFs/kFkzlqnpOeXcvfzdlcDEO3ypXviwGArkg9y1U+5fGzHAwWkUJoKR0fUkxC7F8cXMrVYIvtsq6B06EJykXTwsfmuQ9qHBLKGfax+gwi23Jm1vf3OtsNZJdgKCtHHHPdouXf8zEYlU5KgGM+7LlNSY5Yj/DeFifEhEzNOEBrAJUYLjgrhxOSAFPCvFVqZCEO3i5pBJSAYMFOueuBhXMtWThUt8uFExBEcbJq+HAB6DbzcaFAYxMbq62U7+8CavbV1vzm51fXWXz0TvA2bVBRGtHtPoJG5IApZDwNAlGOu3uz6OXucCNqn9ehW4x+dmtMEVgf080yuULOC1ggatq3mkykGiCYbNbrijHAqmS7r/kB0n1Yd0WvTBvM3QIss0LotpLVgV5BV5QK8VnZfoTn0w==;5:fQsQD2JRfLcNM0qOxKH6X96j118T04OfcX/jSTfZB1GxzyvA2uoK5An1QFKyHor1a1dDO1jymKi2mVGfWjpmqp+VdT++lElE0mLVegqGCfdH2yAfb5NlY5ZpMhIC7AbX0MWWpG53qJ7oXhlxkd3bVg8tMDC6jyNJHVBVJaTtTIc=;7:ohun7d0vPSM6TBcXg9ey9GjaF2NbXWUpiEdmTdRqK/lmYmT3dewGh5IVVKzxfXrq0Coe7WVf/TU80rKmPezxKxwWnqNC49lj8X9wHUB3gPD9JBO2s92p9LBMGJ9RHt9rqdvsLyLbcmfwQLmXZc7NzBa2CTS5Smz+E79UptU8ET7ES2fGFmMFRT6mR582GzAxPqgKe1sbZUhvT+w4UFVARp47aAk9Ze1s2DdBNHanvzWk4dYYG6CE5aCIMFdnorq6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 17:00:43.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d2f37b-0488-4b54-3354-08d5f63dfe11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When thermal zone is in passive mode, disabling its mode from
sysfs is NOT taking effect at all, it is still polling the
temperature of the disabled thermal zone and handling all thermal
trips, it makes user confused. The disabling operation should
disable the thermal zone behavior completely, for both active and
passive mode, this patch clears the passive_delay when thermal
zone is disabled and restores it when it is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/of-thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a830..4f28165 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -260,10 +260,13 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 
 	mutex_lock(&tz->lock);
 
-	if (mode == THERMAL_DEVICE_ENABLED)
+	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = data->polling_delay;
-	else
+		tz->passive_delay = data->passive_delay;
+	} else {
 		tz->polling_delay = 0;
+		tz->passive_delay = 0;
+	}
 
 	mutex_unlock(&tz->lock);
 
-- 
2.7.4

