Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11CBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E47E214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="1URLoXje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E47E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeISO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:56:06 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:52824
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730802AbeISO4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rES/CKauT0vKNNuiCnxyajxJ4Jw/bOGMHidRei13ESU=;
 b=1URLoXje5j2+WXFDa819w2ymhHvRuUZE9Q/F75uNM3QjlDOX30yEfURw0oRvS+YWPtztGnVunFM0F9H42orCEqQ4DkrBN6xqayVzqo8B4vj/o+OHYJTGr+JjtuVlC/Tpvu2gEvdyXyNPwCbj5fEOEO1C9/UHNoRj+JZ2l0BFoU4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4658.eurprd04.prod.outlook.com (2603:10a6:208:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 09:19:01 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/2] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Date:   Wed, 19 Sep 2018 11:18:43 +0200
Message-Id: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:803:50::38) To AM0PR04MB4658.eurprd04.prod.outlook.com
 (2603:10a6:208:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9746b710-7598-4934-9d79-08d61e10f044
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4658;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;3:cQi1td2RQS1M0Gejh+zgLmLV9QwR0UM04rAk+iti8kpAJhMBy4y+XW9qtidF3Qo0KMybzeq7ovPYvVb+b66mvw2jNc/y1K+uqWMkN3mN7M/6sonw29iVcQ0I0rlGmMWHVT0XdqgqGySfkw080CW6ACZ2eZ76Y8ijEzW9vk5KbKNe1l5a5B353SsgFMTJZzv+7sHtEa2NccNT+oxo3XY0VBk/UIyon387/0sFwCzMPLLLPpoe6OlwaZtqXq87JroE;25:Mmwc1i71exHYMm9iUzKHGO12AZDlwY5ISxJqJbs+iJ0KrCgL7Y9/lXwn499P4mbMWlHH20CMXt0x01h+S23nbR9TTJZ9H5ByOVjHV6JhIJDV/XO9suSVaM/s1U1tzKz7RTX4a924C6oKxrLV6l7RTYpOH+9xG4PE/nUfRK6o6Bu7zksv//ln4aWlqF8hs5Ng9pVHgZEbR6/DUEewtNSGYKPkCa8eRfOcsQQM0Jg5wCHFewtDVxTVhA/qdgUOsxO8BYqz05PJQLqbOp7s47zoqDMQrpZEgp1Fwsf0Ixh63QtV/Cc9BffBjOt7MuEGeIXf5F8KxkdArU1DoHWOVlSITw==;31:m//6VWZ5LwMXeFOE6c6C8/3rNNZ032MN86QIGa6epMilhu7WPWw2PfVmDGd2C7qVzItKRrSew3Sv/cQEd1VEnJ/1ELJyJiwN9DBEMHKFaDOqo1Lh/lTsFc8pEq1TiQV/f+z9CELsgvFfa17YsWKHGd3G1rjnJvmvx7Wzg0y9/mtq3Vrhvqq+FWNbDi2YUcYi3+1P3HNEiqb0YOEmeLLYyo3iEeADpKy3InFxjf43Z7U=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4658:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;20:0bj0tFkCnqZtjvjMiOdOVAVKrNotwx4Zn/7YT3W9q60QeGSpQYVOB98zFHw3VcMrgZ0PgUHsXm0Swhy30Wc23ZXgFfH/SATzxtls7F5xWyysNpX3YzssYyWkcKpQ3p9Lswfj9323+1JbaccI93NU6XYkxXrT7nMAz18MQeqtFtDQG38mlgjGLj8warnSTUuLyGPSkUPDJ+xZTDHjsInYZpOiPKYXDL+Kd99Eza/8ynftDrm8W8h3uITXV7zYtZu3;4:gov+7F60ii75EuUpSKkRC0dv5ufNKVgZrq1kd5bzL+rvzHJrPsu/IJuu0v7ToEQ1OS8LpY0+atC32Xm6fdJv2SfsK8Cv0t2W8GzsAzS/4oT0OJ52v44uEkqXyzO9yNsYbVWX/D1vjPufd7G2Ol7gETySuiCYo7mlLygutnAFCQBVnZA5vo2ZfX4ZGRCHRrDHsABD8ll7fADV5w+Icgb55CtaBi89BqZdjm3nQ6/5AY7qJfvrOxO3KvCT6gw78a1VAb7TXl9gTjPSYEAmgvEQJw==
X-Microsoft-Antispam-PRVS: <AM0PR04MB465849B6855C31D2C29309CD9E1C0@AM0PR04MB4658.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4658;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4658;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39850400004)(189003)(199004)(66066001)(110136005)(50226002)(476003)(486006)(68736007)(23676004)(956004)(72206003)(2616005)(26005)(6512007)(6486002)(53936002)(54906003)(2906002)(186003)(81156014)(81166006)(6666003)(2870700001)(8676002)(7736002)(107886003)(6506007)(386003)(105586002)(36756003)(47776003)(16526019)(5660300001)(305945005)(316002)(86362001)(3846002)(50466002)(478600001)(52116002)(97736004)(25786009)(106356001)(4326008)(8936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4658;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU4OzIzOjVxMUh0RjZTSWV3cDA2cUh2dWxINS9PL3VV?=
 =?utf-8?B?NjJXRHJ4aWRDVFBGb01UYWQ5TFgwR1ROUDEzNkdyaG5mMXkzVjhwMDdrbkpn?=
 =?utf-8?B?OUd5K2JXTEFEUHNTaHBsejdidElIR0RPeTVicjNYcDdMdkVJUFZwNkl1RU13?=
 =?utf-8?B?YTVNY1JXMHZPTkVKTEt0SHJtR2pWRDFpOEhtM0RDQlBUWkxFRjZ1MHhGRStB?=
 =?utf-8?B?aHdWdVlHYWFJdHpKNHRvOUVpeFNrK2J5NWg2RTVyekhjMVJnL3psNUx1OFVr?=
 =?utf-8?B?RlZtUHA4cHp3WTEzdk1qYk93d0FMbUVQOHRXWU5UUVRmMkdScTNHUnM2aWJN?=
 =?utf-8?B?R2pkV290dFRQQlRDV3Q2VFZTUCswK0FsbmRJNCt2U2pXNUpwcG82NVg4VTh3?=
 =?utf-8?B?c1F6ZWowejVXdEpmSzRPSFlXem5aSCtyb0llcHI1dk9nSnh2MVpSc1A1RkhJ?=
 =?utf-8?B?NTFXRlRkU3V5cEt2U3YxaDVuN05aSG1hdFVpN3ZCZTk1K28rZUVGMzBUc0Zu?=
 =?utf-8?B?Q1NsbXU5QlBSWGxZY3Z3UlN6OWpncWp1NTk1ZlkxYjdndWNMYlFzN1lXTkFC?=
 =?utf-8?B?a1JzZDBybWVWN3BSK1FBaTFRWDl0Um5NNll0NXJqcWhMSGRzV1FrdkpnMU0w?=
 =?utf-8?B?dHZCTS9Dd29pemFiSlM1bVE3cFRpUFkwVmV1VTV3WGhWUXQ0b1htaHFFZllE?=
 =?utf-8?B?L3lSQllPRXlyaWF0a2FsdDBINUV6ZUJFKy9HT0xVTkRqT0t5Zkwra1VuM0Ja?=
 =?utf-8?B?ZGYvNVhXRmZUcnF4OVBZaHpDOEhzTnhyVUdGRWRTMjIrV3F3b25DeDhneVFi?=
 =?utf-8?B?UjNNOHVMUUVrRjB3TmxzTWovaHZKV1VrVkVqSkt2WGh3b3pSYS95NFdLbE9I?=
 =?utf-8?B?OElIQzYvSlh0QTR2MTFQQldTTnJDdDhuWUkvczJCemppUGJlay9DbkllUzZB?=
 =?utf-8?B?WUh5LzlES2tLdnllR1NqOUw1bFBFam9MTDl5TE1SeEZyU2hWaWV6RUdOTUtl?=
 =?utf-8?B?bktwbGJNU2J6RmZVSWFEK25pVFc3SXhYY0EwSjdvSGxBVi94ODNtbitJRnFs?=
 =?utf-8?B?WWxwaHp0RHFCVFlzRFk5eFNUTnd2OER1RHhEdWFOdDhPZE9aeFdhRnQvNmt4?=
 =?utf-8?B?VjVGRXRDVmVUSFYvVVZHTUUrQ0hvODhrK0dxUlFKMHBpYnlvbndqT0lzallp?=
 =?utf-8?B?dXJUbC9vVHFJb1pBRmd4RFZyc0JuTVZtQnBUay9IWFprcGdKN1BvRWc2ekd0?=
 =?utf-8?B?K1pyWWFFck1yenB1WVkwWXRXUis0NVBhckMvZnpEVElzSncvcnlaM1ZTT0Mx?=
 =?utf-8?B?T1B2ajJTQmNJVWhyQ2gyNEN1RlBTM0l4STFRYXpOQytGT1F4ck52M2lSNjZT?=
 =?utf-8?B?NEpZRmoyNG5HdE1iVDQ0Sm5QRGloMkdpMVlvWGI0TEpFaGIrVklzS3QvUith?=
 =?utf-8?B?cDYyS2RhSGtjdEJ2Um9vQzVQNW0rNlErOXZmSEVJbnNEaXJFLzJjeS9VT09o?=
 =?utf-8?B?eW54aWY2YjlqQWxBVjhOUUpRU291a2ZVT3JTWjUxSTZPWE1ZRHBzbS9ra1I1?=
 =?utf-8?B?bUErbFdZSm5wK1pQbzhWUDBQemVOV1E9PQ==?=
X-Microsoft-Antispam-Message-Info: tWqMIXlbHBtLb8KvkaLHM+djcJnxL+oFOUHA1dPaXRMrrUbYuQrdegHMZFLmBpZJ9qn4RJBPR+nF/mjds3xCz3v/IDDRzt0aoonwKBmxOt89o7wcsDEmRGilA19tAOcqRbSO17EnWBpCzYiawW8WHakF6HH1lZh/xDdivQBxITn7S7SdjxzHWg2j34A734TRw8sRuSb+8AwmepwPNQjcmM4N0WZeyL2TKYQlCXyHt5LpUhSJkcGCcPH5VhB3V1tqVVhGUbqjwm7vTIB1q7Wsd7j7wOvp0ZiRDJqyKSqLyjGyrUq9X4TwYwLq0m9tKf4M2BUy5eyvSy69KuYpjwUFK8wUWZshHXOO/YIV7mCanh4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;6:Re7bJhWydkD27BvdH6h0eRSECl+w67LEFQU89DJNE5IgHY6mRvym6mOcTf68+tJ1szKkMbfG2Ze4jU/8xbz+NOXldEgW5VVrjXmYYKtsc8dx5yB2QGvX3VmznUFom2TvyQgVbbPhJUlYk3j5v8V4Stevr7W/xAoNeW1u/GMGWdusOSDjlh0ElHzHLjgAUJVxmeNIwOg84iehETGawMFOS1+ec2v7GaKtuGz9zp2UgYeQrOt9triwivi0ZBm7cFm4eelRwOirR2sSdhtjxSSG1zx+iCjw6D+2tAs74gl5W3V6HrQrVWKk0mRzMGaaByWCHhpVgU0oXp+xDLal6C58rbWqzNKoQjhqqK4EwOA3sPhYDRx+b7gihiLUtr5Q7lOQddBA7LagSPgRUTG7JAPPpPd1yUnAc+eBc/JYPMXIUoiS/HZr5Sv5SQf44Hth3iBk1a7djQDIikdUBHj1sCIltA==;5:mjAQOcaXu0R8lLV+bcP3I01ltHsk0dU94zk1FTR7zMTH/A5/fk3XVznc7O6o0dJJZOV9LAWng57eoa4FZdU1u+yOzlTm3vtt60Hgaqg8vvRxkzpBBKPVOk9qq+DJKM1ouGvLNk+nPcgy/lk7K9QU6ijG6DhjyW3Ly9mF20rpA8M=;7:KO2bjK3QamUL1DtVqejhqclE3hdznER69lvDKyzvmZaGE2iBcXc5P/oEs/mcFQuXoe4+B7V6zESgRyzIoY7vpaQH7FR5JE1it0WYE43W6Y1ePeNeyJytgmhVgBpQCSIV4saNk5vX7ZXswhLWi0Bli3ok5ntHgNFT1JYD6kTRD37/D2fEnHbTGGOIZbHPBuety6J6eiIKy1fu8cOT/bvByoFThJ0eNzbISQjhxIQsrC+JgVD8tKHB/eOAXYpLWsEq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 09:19:01.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9746b710-7598-4934-9d79-08d61e10f044
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4658
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

