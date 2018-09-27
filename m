Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A971C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C449E2150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="VCQABh+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C449E2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeI0PpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:45:02 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:48730
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbeI0PpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBE2I6XPHis7MzMwKJVM3WJhq2bf27Khfe0LFubF2Rc=;
 b=VCQABh+lPIciosIVcwxSy2zqr3/ChXi9R1H7v7J8jQHGyDItqAtOqARJ/ZIwmTE5faRxgJM6wX9PgeRilZfay/BBTAwXiDd36lOuy4FPyUff/6qbn1h9LGf/vdnQwRbFMgoZwxN2LxY0UJa1Rpw3O2VzTVtxU6ivF+Rsv75apog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4660.eurprd04.prod.outlook.com (2603:10a6:208:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 27 Sep 2018 09:27:31 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RESEND PATCH v2 2/3] video: ssd1307fb: Do not hard code active-low reset sequence
Date:   Thu, 27 Sep 2018 11:24:40 +0200
Message-Id: <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR05CA0360.eurprd05.prod.outlook.com
 (2603:10a6:7:94::19) To AM0PR04MB4660.eurprd04.prod.outlook.com
 (2603:10a6:208:75::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f79f50a-21a7-4261-3c02-08d6245b7411
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4660;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;3:HXnIlSDFGCXVxYFx9h+lKf+DBFUrg3AXN7I1dC/ySr1KZsBpMV8jHdAzno31KpiCgoNbwTLJ3yVopxFlS2hYIJy6kpEPxRJTNtobXt6yg8G/MuMJdDNcFVkUmBz7dA63tna3JIS1nYrds/Wi+vxqXHGTTdOJEJCXEqVEx0LOglgoZTKEGS74Qc5MtKTqoT+e40TvELmlEOnQYdCmtd7nufiaBz3llCHwGDr8FgOAxTy+RJZIi5hD94z2Q8YXo7I3;25:+mHc2IbBQh3AeIf/44eyAub3tLtUheqVwhSlqkG5rmFSR6HBK/gjLqQH4ocVE9kIYMhIs27k5VGRno4a1Ksat+m+LaBrDXzDgkQaR4ZewJ9dmcPpfvzlrYoHWzTIPpbZ5XOC/blNuJ1dz2/gdGfgN6LwlM7zTyyoqvuxIMpAqYpYMe3Av5nXuW2IK9VB4vUp7hOVPx4/tY4qY/1f+jfOKOX9byyDDx1fniaISjqoZA9O5ssdd3ijl24XrREbcMMIi3p2Ayv4yc+4AQPtZexoIni68aEO6UVOQcRT3xLiYPclPdVnHpfPHi7fvgnOf9NNvh9vJng5lXgR+ogLechsZw==;31:j68QhDSdJvx1x7uQ9/O/7P2PK188AHojGfFwS69wrwdxWLq4dqEYXfdZJyCMySSTAxxPp1pPS+TcxLc2BXost8HtbHXHTmt0WsbsR3QXCg6c6yf+hSokJlSNG3qt8bubLKYv4NHoBlYuERSDxuuY6v/wHtUvLRFtHOPVnx529PMelBqzoMOuYNPVsn+vN+mmcqGpEdPyCq2NuBQU8AeAqcVoSBCQagYaVIQ7DtTUopg=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4660:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;20:BDbZp0pFJffRyjyOFr0Uj6y46XdBdTvEbAS3i04EvRAHeDOoFMXgBqI+Fl6RsgTT/kAcoZsf9brAQS29fZCqk0XJxaJM5NP+JvuG09bcZmpoovd4pb3Sn1fuPOpdJP1Oe93MEevpYV9njJRczMB+7lOLXvydEaxO43mN9eleE6eadSah4zUqNNmyNDa9SzlFwq9E0by4zky86EgMEV29Oz2W13c8FacrIxj/aUuqsIrJMAQRPGJmnrGxWgSxDVpM;4:ao8HQwUwMRfM3AHxrFi6l6QJNH/V+I6zXA56CNdKoprD4pNm5HVU8X3guCviA71/JSt6v6CBKN01C0b031IsOvmqwwKyoE2Wui++aPDtEm+uaO4NWAoLRTrZYhsrb8+7Fqg2zOWkPm3LPvdklSfBxciNezc754px9zs3Dv0n6S2z67ve4bj3Ir+MIxK3GjusXR1cyzXaaFkpl9MbVvYO/8Aqc8Ad4GkqsYySsafZjVe1oXEKKivaxADQWUjc3wKzx+fGV6ICtCkNH8N81iFQ9A==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4660B33A16258AD8382358299E140@AM0PR04MB4660.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4660;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4660;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(446003)(6116002)(3846002)(26005)(476003)(97736004)(2870700001)(81166006)(81156014)(8676002)(486006)(86362001)(316002)(8936002)(72206003)(50226002)(2616005)(186003)(11346002)(956004)(36756003)(16526019)(53936002)(2906002)(52116002)(6512007)(23676004)(47776003)(305945005)(76176011)(217873002)(50466002)(478600001)(6506007)(386003)(6666003)(107886003)(5660300001)(106356001)(66066001)(54906003)(110136005)(4326008)(25786009)(7736002)(34290500001)(105586002)(68736007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4660;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjYwOzIzOmIzdzRnRzZKTGczcnF2OXZNakFJVm5tWjh2?=
 =?utf-8?B?MHl0NW1HYSt5dTZaSXZZdTc0a1JvZnplbWI0U1ovclZHWGZiWE5zSnBUQUNV?=
 =?utf-8?B?ejhkaGNHOXpmWjAxMVFtUHlLcDhHZVUwcUpjYndSSlAyVFdkR1RmRlNlQkJP?=
 =?utf-8?B?OXZKYmQreUhsT05wOCtxbzBwaXJYNjMybURuRTYzeWdVRzIvU3JkbWR4Skpo?=
 =?utf-8?B?Rkp5Y3l3TUhlNWQ1aWVycEJMZjRhODVYWkdDNXFxc2dqVmRqRjBzMlc1dkRV?=
 =?utf-8?B?QWZhbDRiT1ZaQkhaTTl6bVlhbDQrRnpFaEZXUFFOUGV1RWlWNEh2V1VZU3Jq?=
 =?utf-8?B?N0tPa2cxc0dQc3dxTkE0T29CcmRlcXp6UFRueWpQN0pCUDdwd2RITHFJcGJ5?=
 =?utf-8?B?TjI4RXhscE5tZFdyWmxsSHEwK0FMTzZiUjBZNGl6cWhHVDlzOEJiMURtUnVl?=
 =?utf-8?B?b056NjNUdkxoOWZDWFZWOTFqMXBDZ1hxaWFPcGlFaHhYWm94Q0RleHYyMGtJ?=
 =?utf-8?B?aC9oQStyTVpHaG9xdEhlaVlOZXcwZHdqb2UxWGZWSUgwN0J6MmthbGRoRnlO?=
 =?utf-8?B?Vk1IMXZ6ZTczR1dFZytweGJvRkx3bWZIamNMYUxsd2tNUEJUckk0M25zYS9t?=
 =?utf-8?B?ZzhDMEU5VUQyZ1FscXduL3lyNnRvU0p5dytGZVBCMTlCdm0wdUJNUXdERC94?=
 =?utf-8?B?aDFJVmZ4ei9YT25SeDk0T0lUTmlHcVJFZGdrVE1VYnI4b090NW8vMDB3QjdH?=
 =?utf-8?B?M0dmTFF1YzVOc1pORHJuQjNGUk5MbWxLMHlNSGIycU51SzRHK1U5T0RXd0Yx?=
 =?utf-8?B?NHVxWjMvV0wrTEp6ZUxiNXE4dkVTZ3orNXlIeFpxZzdUZFNMQlNORktYbnov?=
 =?utf-8?B?a1BjakpKSXhiSHc4WUJCNmlnYU1SZmx5bkdwVjVLcUErYzliZnkvejlPbHVx?=
 =?utf-8?B?RVZBcUQwU2MzYVArNDhIQ1JXbDlQYUYvSHB0VnozdGt1QjY0U1NGYTZ2Y0Zx?=
 =?utf-8?B?OWhSVUliN3VMUXBwUTlwV2ErN1IwZmplb09ObmJNSjZ0SnVkUWUwRWROZDBh?=
 =?utf-8?B?VlN2WFJZRlg3eE1mbkNDOUwxbWliWlJFSXJqMWxyeDRkVUdNcmhKVnhwS0dt?=
 =?utf-8?B?U29aV2hrczFDSCt1b2lmdU1qTEhDYmFnMzhiVHJFZDltdkFYZXU5c0lYU3p3?=
 =?utf-8?B?OFBmVmM3UUUwSUJsRE9qMVhxOXBqRjdVdHRoLzJkeXJ1V0NwaWp1dG92Vkdx?=
 =?utf-8?B?MG1jUjdQOTN3SjNrNHlqZzRFNThUWmpweWdTOU1reTdSalAvWFg1U0xDVmJZ?=
 =?utf-8?B?MXBPK3R4ZmhCa01vSytVVHgzZGNxMmJxOVFta3BtZjBPNWo0VjdSU045RHZR?=
 =?utf-8?B?NUFzZjV3YktwQ0hlQ2phenFBb21rYzlIKzlXVjJQc0NqT3NwNmdKSVhyM3pq?=
 =?utf-8?B?ZmVzaHFEdlVKOUpmQUsreEVlanFQY3V1d3VobXRtN1hsN2VBa055TVg2TFRE?=
 =?utf-8?B?NTNZQmphTFRJWWtQc293OVNEcStVUEFobFoyb0hlRzZGaHBkNHQ1WTRLNHBv?=
 =?utf-8?B?KzBYeGZvWWFsNFZnS04vcVFxL3hJSlcxVS9IQXJMWjJxL0FLVDN5SDJDNFpz?=
 =?utf-8?B?MnNtZ3d1RFhROUZHVnVoZldKb2s0WUI1ejk5cUJYK1lrUnE0YWlQaVN3Mk1q?=
 =?utf-8?Q?U5GBdLte+cCPSr/5d6YY4vNn3UWCkIq6D4FF4TY?=
X-Microsoft-Antispam-Message-Info: QOEIpJTXM8vU9ntMUkK3tE74s2pJ+RXMATyDuNCWDq2VTDqR+3O++fI2NW0+1OFtpQhg3O4n/QB5UA0C1Ll3icTSFeAWwDbnsbKgeaDRI4YXvAOdlQ1mBNZnFK6IY5GZtrmS0n5oXNu0F59pGkohKCD2OU7nkEoASRfeVLI4SrI66KWWazRDaFrIjAggD1zvp4bbekUneS2LIOkNGbM8oPBIL80G5dywEB7XXq06SfyFa66D47MF/eBLBBOX23e6MqQeyr7h78UF7fKvI5nAZnVFcnmQuoG8m0WXw8+Pl1pmQ89RxbsDtWlLY+Q0oMsGnZfZALDqkz9eZf0yA5ZQgRs2OgPn376rhtmqa+d09rE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;6:EzRH+oV7Xq4C2V0Nj28wwEX0T9PlbkOsWeIJmthwgo0B/ocIXzBn1cWedWCbXVC7/tjXY4+nNxAFDtTYKczDVzi8gf7dmvlvGYsmtqO/js2c9pI2L3Gffdvpbze7B+XWDHMggvyRIp9oS6+FCHk50hrht1l1wOOm48SR13HgTAbmKD5eory8S+97hJG0j2be36db8g+Qy9qS5yl0tEH+mlGywcv0E0OJLQyq7ZAu+vJ1WI9062xo/3bFBxj9nxKCYgaqWI2HxoRGvxBya0FP9eunwk8dBZ8+L+jbC6ke2UwxdvX4OZbdpvRLefhbta5E2y5X9zJNdIMQbtP3DIgemwe6j7MlBHAHFxb9/Rl22JwcPWYUljCCWmYIZXQGbcQvGk8SW4P9VvRNWAb204VeYEvQuOyjoNl9PFXOWgihh400DLrmWHaE6XQDJ+zjfHgMaSuz7oZMQ98VQ97UXYRG1g==;5:DC5+bwN0uDi1e0mPeAnSaAhPWhTEiIng4P9341oGkqxv3lcURA+0OcCc/7PElnrVl4PzIFWkAAd8JwmcsYH1AI8/JmhycG+b+/7aQgkOsG3cgtDPiE8kpH4Jt4iFiOdPqU4xP+nZByiVgBf6SUUKbDlhmopLSNaUJfP6TElQfj4=;7:DiElf3MrZNHLlV35lsgTs2DF1X6W/Q8LEQ2qZPVetE0nbSs70+376EszVxoDawH+4lUEJIbutIQ+eBTkISZAePbL+F3bxDBpgSkf3cVZd5qL0lskoYl/2+ZXhYbOZ6GNQyZA0sYT4ykiR+e8Bv5tkZsUP4ot6GPxaapyF12J2r8ByLiurhaF/h8rLwl4xeEc/XM1/jIJKBelGmoSzhkW1v+iOOQPl7NKoy4/SIE+Y8/pkMBgdMyUdMC5NFcfLpf1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 09:27:31.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f79f50a-21a7-4261-3c02-08d6245b7411
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSD130x OLED display reset signal is active low. Now the reset
sequence is implemented in such a way that users are forced to
define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.

Do not hard code the active-low sequence into the driver but instead
allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
the real world.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v2 changes: Split the DT changes into separate patch.

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index e7ae135..7b5bc42 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,10 +728,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value_cansleep(par->reset, 0);
-		udelay(4);
 		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
+		gpiod_set_value_cansleep(par->reset, 0);
+		udelay(4);
 	}
 
 	if (par->vbat_reg) {
-- 
2.1.4

