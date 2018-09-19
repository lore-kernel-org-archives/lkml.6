Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD422150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="TV2pbNKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD422150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeISS4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:56:00 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:38944
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728096AbeISSz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBE2I6XPHis7MzMwKJVM3WJhq2bf27Khfe0LFubF2Rc=;
 b=TV2pbNKVjCexzl5LsgSPZgCLJ79k/ce6sTIEKkmY5kNyeL8AfNXxBiaSyQZd9DNdXQyda7tDhx+a6t65/XwKbPYxcSjBvSA6KDn/NAhDviGwwm5dQ5oRgx9lsJB4+WeOaUBm4TJNArZ8Ch8HVSem1k52oEq6jgwxWGjFn+HO3sg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:17:59 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 2/3] video: ssd1307fb: Do not hard code active-low reset sequence
Date:   Wed, 19 Sep 2018 15:17:28 +0200
Message-Id: <1537363049-48399-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
References: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0602CA0003.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::13) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:37::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18349e25-5449-4040-60fc-08d61e32527d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4666;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;3:SYRcS2SaLMcK2oCGYA6vx7oIsPqU7VfjanqChqT4f3X+X+XDyhPzz+fTBKTqexlHTkGzHAEzOgu7CFuitnpovVv9YRyEqRs9N9YjWEEXPfBJ4+Lb6x7N2sMc8ohIGZ6fOUXxbfelol6OuXrcqUCqzo9CpkdKu39ybnNgkUYkINpFrlCmf2ZPp0DGhCL50LUplmLAgqXMAzybK/3YwHdvBKQy8Gb6aj5a3MkdwvTLRL6OHBuGI+Tw26tZISYihnlq;25:Oc00Ex1/O9vJLjSkJOeFAEsaa9EJhbwOcfy/1DdLIOt9IH+fQulk16LGo1ZSqmf0oAhx45AmJjUTTj1toy33DYRwfDF0JqPdmap0SfdUTV2tR/Jtl0h+hNaovpQMzPfnq9dA27M9gIQupaTWqCM4U6prFvWR6WRjExzo59smBU8lGEk/UqAzC5BTa1DzrR6HkJl9jEqUMH35e81+JlGmeapx0BM8J3w4l/xzt4VJ+d0BZ+AkwsTWyIEc6QO7XGXI7WRTnvUdPU/yGU2roEdN3mt3kY/qk4I4WqGz+PIJAdGZFAJiPsEQf2Y+k4ZDXKmEkoLxRuqFN5s10s3/kyAiog==;31:Pbp9yQFa3T4KGjfOo2l3Bx7MEWyzBGvGZQE+nvQvgIZ8tY7xpUNzyu41jOqdtwvCo2d04DYrqfyKf6SXqSvv9uMxsdpQcYEeNDVwfAq4bi713Da8Pt09eayF1hnIE4LcBpX/xQvIlv+3Dzau4HMXtwe5eoPBqu6Z9S1XkzzALLFMz5Ga2oUjI8hB//WESPxW9aH3TNtSLEMs4v3mtPivMckwY/8OIb1Q2cWn5hyD8eY=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4666:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;20:x45gYORinD6U5HqsK5ZFpOQIgDxf0to3lU2Vfgsu0JdnNZTSxiPd/sgXqJjgDLvjnpPf7I5aHSsaK0HHhTPrdzz1O3YprN5laHRP9fcyTkH32ufATT29kOQD0bJeImTp5sgHgOphj7DbuhDjJHUsghHEB6xxxqpDpB3EgUmlagqfXh/UkRDMda1VvMNDL/Tu7TYq30oG/eh43muhmwZiHrI34D5h9GbbdrkbyspH0hlV2iAvbJQ07aLpBkvRxoHT;4:yuls9sb7XCWotCzLrjNZiZzZedkW5duio2aCux+sriDyDuOcX73QS8kMkBmj42wS8PCZpzeTuaNV3UdCwzbyB3wb7S3P5lWiE2SnWyhRt6cfh1Ig3cd4qpqORAJvkA6Ym4t3oWbLFA6G896OruIC7Irn+9T1CYyn5n4Z9FvN0rgPewUWZAag0Dza1mUcx+lAIK0EmZ3vB/DIbDnUiv6yei4GyYfDt+kt4TLkoJKoI04QEDcF57Rh8OuFdSxBLlO7cC6tUYqYpdPnZNfHVBDSbw==
X-Microsoft-Antispam-PRVS: <DB7PR04MB4666DB0E2982EC89947C0F9F9E1C0@DB7PR04MB4666.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR04MB4666;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4666;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39850400004)(199004)(189003)(3846002)(86362001)(81166006)(6116002)(47776003)(106356001)(7736002)(5660300001)(97736004)(316002)(486006)(26005)(186003)(105586002)(476003)(2616005)(446003)(956004)(107886003)(4326008)(110136005)(6666003)(23676004)(16526019)(25786009)(72206003)(478600001)(54906003)(11346002)(2906002)(6506007)(386003)(76176011)(52116002)(2870700001)(36756003)(53936002)(6512007)(8936002)(6486002)(81156014)(50226002)(305945005)(50466002)(66066001)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY2OzIzOjF1ZjhjVStXVVlnRzhnU0NGRDRvUlRlTnB0?=
 =?utf-8?B?T3dWZmM1cU11MFcyK2hudW05U0lLWUlRQWJMNUZaLzRuYWF5MnV2TzV1L0hx?=
 =?utf-8?B?WTFFWHVMaU0vY04xa3B3TzQwcm9BcTNISmw2bGxhTmtkUElMTGpQYWVKNXFJ?=
 =?utf-8?B?QTVPYkhPZlJwdW1xb1h2VEdKZGtXYzlhbUZjNEFMSCt6QmpCcnpOOTBWV3pr?=
 =?utf-8?B?U0xlNlgxcU5pZVh1akhPam9zbkQ1L0dBMTVJaFlmenhJb0Z2bkhPVUttdE5H?=
 =?utf-8?B?MUp3K2RXK3NEUjU0UFVuK1VuSi94Q3c2bzZBWElRaEpLYVhTODZIOWw0RWVI?=
 =?utf-8?B?aGl0WXcyWGVDZWFCWnRXaXhSUUYxQzRjUlhTMktqOFRXc0JoWUErdFhKQmNs?=
 =?utf-8?B?cjBCZWJabTlHbU4yQ1F3SVE5bC9KUkRJU2ZnTGMrUXd0U3RnQmJDUDRkL1dT?=
 =?utf-8?B?YVpBeXduYm53UEZjVmlvWFdOS2xmRjB0MEVoUi9FaDQ3OFExQUVZendMaHh0?=
 =?utf-8?B?RFlDUWs5RWJ1S1VsM3h3QmZJVlZTZm5jUkxiWXNsV0wrdkxjMS9SSXBPano0?=
 =?utf-8?B?cDUwYXJyM21tTjRyQkovYjFqQ1FpWnF6dHhmdnhKamxkZnphZyt1L2pSRjZF?=
 =?utf-8?B?MjJwa0E2TitHQzExV0g5TnUvSU9SWmJMclpuZytmanUrVEhmdm5IaHpqeWhB?=
 =?utf-8?B?L0Y3VTRtSFdjNHlsNjkyYzVsNjgyVkkwOWFKbGdCUXg2amFqL1doY2NhT1J5?=
 =?utf-8?B?SXFaMWNYdGZiUURSL3R0TmpiT0U3LzViTkpTeHl0MVplT0lHMzFRRjhnK1c0?=
 =?utf-8?B?MVRFUmgwa2thYUhlYkYxejhjL25OS0pKZjVyRStVYndaOHNiVEY2Y3ZZUm1u?=
 =?utf-8?B?d1NHZXYzN2tjK1lsUHhUUWF6Z09zeTNXSVlqRGhIeS9oRmlTR3lVdGhXbnpS?=
 =?utf-8?B?dDNqTlczQzRINjhNZ2xyVWJMcXNRUVkyNzkxWHNMR0d1dFU3bmt0dklKL21n?=
 =?utf-8?B?S3FCQmVaZS9jZFUvR24rcWtrYzRKVWViYWlXR0xWTlBFNTh2SG1GYVBYVDdO?=
 =?utf-8?B?eUJBdlk4QmxSOEZ1Z1VCbVBqNGg5ekxvb1ZqL1pYcmEvVnZGYkpCbEtJbW9s?=
 =?utf-8?B?aUFVZSt5dk40SnBXUkNMdXhzdU81a0h3UkZqSlpLTGUrMytaem8ycVhqMGQ5?=
 =?utf-8?B?MEtCVVZsT0RNaldKVk51OVJ5WFFzdVpoZ1FRQkZ1QnptRUhVNXJyczE5SS9j?=
 =?utf-8?B?Q1Z3VXVCUGdpcjdMdmFhUjd4WVMrY24ydTg5ZG9BQ0xhZWMzSE92TkVHa0c1?=
 =?utf-8?B?ZnBDMGJ5WE9XOXdiRVVUd0pTYmlCR3U2dGdGR1ZJbHZxNXVWZ3FNUy9IRFI5?=
 =?utf-8?B?czVUd0I1L0VSTEdRUCtndnhmMCtpZXRtekNaMThGWlJXRngrSFJSRHNEREZE?=
 =?utf-8?B?MFpwN2VDaCtNUmRiTmx5eE03Sk5LbmcrRUI4QmQyTUEydkJVbjdwOVZXWlFQ?=
 =?utf-8?B?Njd6MDFmY2s1SjQ5cDhaZlR0L3M3blJHWkNxbVkvQTFabTZzNVpJb1VsQ2xL?=
 =?utf-8?B?WUMzRmtkaUkyZ1dTSkhGVVdLS3BoaEFKNU5NS0gzbSt0TjY3QVFoZWlGY3Jh?=
 =?utf-8?B?YUxEb2UzUUQveDRBbExEczQzU3hvYVpibndTa2NlZnNKMHFFcGNsV0R3PT0=?=
X-Microsoft-Antispam-Message-Info: jfGd+4rOxUrOZKBB3Y7ICMcoopJRvrCKcJe/+lP1RHr/SfIW8zlGJYRnsT3JvEfEeIZ9oOeLoojhjhKP54tEAI8/+w2MijEeZjjeozWxIx99H7WQxW0vgyYf2bAQLjv3EKc+Og4ObpZfxuIpfFdybbM48eYzKjoPIUD1wE8Vd6RxA09BfVFWu9w+Np0tUfwz8YyMK5xXlzPf4gL2o475FIjK5ghjxwvq2POhyKZeL2jprSLyKf9212vqEylILcvpOW7VXvicb0cE1qgDGytl4YcetiLdB4cDCVS1FE4Xvf2658oieDRCwcQur9UVqbJdNYGXwATv8dbWdGMNslN4Fgp5O+mGC0W8epa5DHGFWVg=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;6:J08As5jo5v6cnHgGfJXxXDTQqirFdwFdb46DT2iwzSg89src6wr4OvXhYdBW5HJpmaUGETRVLDHzaDlj2maDs3Dm7b7Wr9jjoQYQciGfaZKTBmLY8Hwtda36ASvw5jkg+uXgJQAMaiTV4sPOgrZGww6vEu/EJsIazEb5uq0y7hzYu5UhOQADyscq4BwY7AdUWPMtfqSUHeLEq9yXuN84Ce1g5oGjjGlBIiJvD8oOQV8HV25i6pQrU88W0EFKQvDYG/XsCHd9muYCk9C1whukSoTF6/wuvK5I9XEQ8+3g3ranC5d2MvEZSxF6JqQG+UpBcZtUNIMv08R61ToiwbYjWxZ6mq6Hh6oTzOe/3tTeqFK7WKM6UyTmxiqYeMWowCMljMfQ48bsZgPuVlq76thickFoKSI3DhFsDl8NPJ32z86SLv143ep4wPs3sBU5RsBZiQLY7PLgCK/35HJebmosAw==;5:RCAntIdraw5lNG4BBy5dXMukP+4uU9MYNvxxgIbXDQ/zCMD/mv9sAsCOEPIjbu3vlPv9xMYmh/pvKDKz1809qR0CIAR6kOyDgt+COgLiiMAaLJyguvVOW7qnxhPDLHsRViQpphwv2lz0UKAah6G5gRDnVa1SEnOdGZvXmGaCAJs=;7:ifrmTXx6gaDN53ZpV6b0J6JRReTm6hXf0xBpomXRN9cH8ePV1FlUDDOSl58mAZIx8tzpzMw3zQjIuTXft7fBVSSdTP3xpwg2k+VezQSCssKV4ik+KBQ3r1NkCl3yPJR+URkwGikuDrkExaMTJS7n1rP9ylVvxwJZCEMEc9Elc1LJ47eoAmEfse8o/SEvUx43yNlXPRHb4e0YSWMkKhyk0f7gMEpvxgujn0Ln61O/OshnRlsbk81WBhyOeZIYlubq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 13:17:59.6588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18349e25-5449-4040-60fc-08d61e32527d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
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

