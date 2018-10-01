Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFF6213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="YTZ91v5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFF6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeJAU6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:16 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:42264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729496AbeJAU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4WpLoYFGh3+O1tIs9fwPAsNirbxGRcpPCs8xFqOTHI=;
 b=YTZ91v5+rZlB+jr24xdEXO0hQ882GSnFL2HSHF+zR6YM+DojnsmdK8SwO/X4EUZbRgrZbxXq+5HT1oiQXsp/rtZdMbMfM4gSK+w5OAxuhH6SVhDz3Ic8EbZTZTj7tqbHw4fQUWAtIHMVKrwKibwzQwyZTSrA+v5XSoFN3q5WT4Y=
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (2603:10a6:208:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 14:20:00 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 3/3] pwm: imx: Implement get_state() function for hardware readout
Date:   Mon,  1 Oct 2018 16:19:48 +0200
Message-Id: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:50::19) To AM0PR04MB4659.eurprd04.prod.outlook.com
 (2603:10a6:208:75::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf55130-912a-49f7-2755-08d627a8f933
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4659;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;3:KWnIfWLzffn/jqNt0oHdqR64XHJ6lAnwplgqALaTiqxvfDmNdpTdbYTy1QpzboX+ZVRJQP4c7uYBEKh5B4dzk95Xg3yydu+sGuMkWQOl0JGa83LMbAYPZXn1ciQ+Pey6B02kiD4cAiIrrKoFZb9kDgIfYNo4lT3FgY+Pzt2V8I7mwnvW15D9FKzEzcWo6q+XDVKL6grYiFzv/4dRrpaI9ENPDgWWaBhOphLdd1qXqDFzaWts24afK1Tom3ftdCH+;25:u3apLlDa9POzpKsWr7rw8SDx8Gd+D1gNuO6fSp0fsUwEEQdAnfZfQ9U/SDgYQB79WRNO7nFpXfdAlk2Pu43BNG+CgW5nTBhV59P5rCYJU2kCIRt8BqdiPE197a0cBvhux17QbL5UYRZ0NX3Gj6xJnltP4zzXVPagI1bfYxPiBwLu0d7uiF2WSTYLxVUeIaciZEilwTvv/u40fEEwnCDan1le9UDCuvF5X65W0+2u80junJvFiTrFNkwY/JUtnD4eGlCei5u4t3G9+4xwvWUC8kJezLndnbWL9r2HtSvUBeWmSTGbGADccOB3xyZdqNsdTbNbZ4YG2+CzAhmH/DuExg==;31:uKsvvpy4JF1dqyhlLv7zhZgmqvq0LOBcRGHvt/yJ3kwfs0erqnVevSj1u9058QdDfTcDjXWsxmzr6uJNqSHn0F8WzphigkPwMaPSYXitTQIKunejnXh5bPq1W69x1iGEyQl6AterCAJxiku9gUZs425OmDnfl1gCCRmm2XkrRSw3hKk5QMhmuM1FFpfeA3gdzslrAAJ2Iw9OfBr7YJuUONrUdC2VpHMnwZ6Q6nQO2CQ=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4659:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;20:EgEkInByUYkw6KcVF3H9sGcJlog3J7ZSMsGNBnl1s+lSvdkDV+Zee39zMtg95aeDhzNuZp8ORqyO/JTSKWrTsTUonOLqSZg6RVtmE+bFfhxkUrjSxC58IdTl1s2z7ClzTjsjudLsFUrgqkw3He5H4n1JTyy9Twim8PHLBDp618vpZp/fcCd02vLpJoLMRKqfqde7Tw1qJD+VIvTsjIjafmqBzLQxAsi0BpNhwwi0VmPu9IAw7ay3XDbkv1+tJHzq;4:Bt49ulKmmWjmGHD8yMVPqSc17aJVSK33AsO8SVpx1lMBZ/K4x20/dsZd02fGyHrBnfk3cOlA8POKwd6e2PIGgSQ1mIoWCX2M3eyWUVsfGh18x0jxogL+dIYhb8q37sQrHQp5Og2CHt19ZNuDSDf5Iya/YaUfU/3lIrKyQtF7EEofRZIcl42yW4d6SYdnt/J+nrXuhjE2RKI0sJ/2eZsC1yIJmngjMPDz5QojqgPkvUtlp3uZ1x7uyUVkXxbzsX/Wjw0LPAKkOORG8OY8C8/6GA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4659C3C8EC8B65F63470F53F9EEF0@AM0PR04MB4659.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4659;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4659;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(6506007)(386003)(6512007)(316002)(36756003)(3846002)(6116002)(53936002)(34290500001)(23676004)(86362001)(52116002)(6486002)(76176011)(11346002)(6916009)(476003)(2616005)(956004)(6666003)(50226002)(68736007)(2906002)(8936002)(5660300001)(446003)(81166006)(8676002)(81156014)(486006)(97736004)(105586002)(106356001)(478600001)(72206003)(25786009)(4326008)(39060400002)(186003)(16526019)(6346003)(26005)(14444005)(7736002)(305945005)(2870700001)(107886003)(50466002)(47776003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU5OzIzOnUwa1hPY29xN0dFZktpOWdBTzg1dmlHTnlD?=
 =?utf-8?B?MHEzN2Jpa2RNV1R6KzA1TzN2eWxLd0lCNG1TUmd5KzRVN0xQaCtPTWlMaWp3?=
 =?utf-8?B?T25INVl3ZFFlMy9OUWVlblIyVld6Q21hTml1Q0F0NVArMlkvN0RMMUJqRW5U?=
 =?utf-8?B?QTVTY0FJMDh1d2x4WDJnNThPKy9hUEdpbFpDQWNKN3VCVWFwb0JieDgzakht?=
 =?utf-8?B?c21mOURFVXdtb1NXVnNMS2NVYmdwQ1FjNWozZUdmUjNaaUJ5S2YvdldZU0Fp?=
 =?utf-8?B?Wk9scFFMcGNNR0dOMHJqZHQycVB3VjgyTCs2OWROSUZYU2Npby8xQVpYYkJW?=
 =?utf-8?B?MlEwNmZ6WGJnNjFjMnNCa0FEcnNna3JTcEx1eFJ5d29HaHpMRVhCY21xcHRD?=
 =?utf-8?B?MExhSDZlYkV1S01qM05vMmZYQUxIdmI4Z0wySm1yVFh4bzg5YTg3V2oxenp3?=
 =?utf-8?B?azVOQlUvblZpbVNkeTBUaWYwOGFhY0NJRUJ6VENJemIrU1pRV003NlhZSVRh?=
 =?utf-8?B?cDhsTU84QXFvVG8vTFhjS0lOSlBpWGhwRFlDOXh1ZUpncElHQ1NyTVUzREJj?=
 =?utf-8?B?elcyemlObWU3eUZHZVJNTXJRSEx6ZmVzQS9yc2VQYWFrMi9iRVNWN3gxanlr?=
 =?utf-8?B?bkVsd0k0WXBkSnkvejc0Rm5OVWRFMXZDeVNrUzZKcGJ0U0E0RFpKbndKLzEy?=
 =?utf-8?B?YlpUSUlnZnVJYW0zbVExdHNXd1VpenhVNVBRZGJZK3lpY3c2MnViS0ZhcW95?=
 =?utf-8?B?UnBVS09DRERqTHJJZkw5YXRDT0lsdXNDcGZXL1J1Y2tHbDFMd01pTWZTZFZz?=
 =?utf-8?B?M3JkS1A4L3lJY2F1b1RTTCtQQjYzUXFXQkhBUE5WSTdPMW9LT2p3Y2d0ZkNq?=
 =?utf-8?B?ODFPZlpmSlZnVks4UmJHRkNUVVFIYzEzYUM1WkxkMVNSVHovS01HNEtMbTYr?=
 =?utf-8?B?d0hEejJXc0lZMjdHZ0E2bURpNnFqcmVxV3NhUSsxVFhtd2greGtCQ0R2MXZ5?=
 =?utf-8?B?Y0pTOVBocU43Wk5FS0U1eWZ6QTdJTHNQVkpRcXFnaG1pKzYvdjd2Y2c5Y1V1?=
 =?utf-8?B?RVpiVEJ1eDZ4QytvQzFnN1d1NWpnRUl5dVBHeTZ2OUgvNTJyWnRjRkFtU1Za?=
 =?utf-8?B?bXVTVmNaL01aMEF2dUZZS2VOMDlaYVhaMEw5a1lBUTQyMStQZ0dIMlVFaG9h?=
 =?utf-8?B?WVRia0pFNlFPRXEydUI3QzRvcW5MN3hXNTJYeGkxbTlQTGJUdlpkVTllMnIz?=
 =?utf-8?B?Y0V2VzNOMzRYV3FheHcrbnI5YkIyMWM4bkN3cTkrWU9xSERGY1hTKy84T3Bz?=
 =?utf-8?B?bGF0ZEc5cFJneG5JOTRBVU1ER2dMREtFQzdtMVdJekh4N1lQTFlpUk5VOENx?=
 =?utf-8?B?MFlqcCtZMmxOMlRQWVZsUmtESkxEY3FoSlBmTURpTlJ3RGo3akNqMXExcDhL?=
 =?utf-8?B?a3E0bHJ5LzlGby9oNXYwYWljeE1PbXIzVkFtUEdWMXgvb0xueXhqcTFRZUVY?=
 =?utf-8?B?RjNCaElzNVNrOXRkbGJOeUZjOUlSU0daWFZESEdDdEpGaTV3bTllM21lVmI4?=
 =?utf-8?B?Y3l0ckNQYVdKTFZkQnZXVzNkc0hlbEh0cDRkME1uT3dHQ2t5WkhSRTVucFgw?=
 =?utf-8?B?ODNMb2VVRXdQY3RZVjJGQmxmRjhWU3N0Smd0UmFGZ2g4aU1tb1FBdy9JblhN?=
 =?utf-8?B?eWxDZUFHSnc5T3hvMWpUd296d2hEOVhBRVM4UENISDVRWHZtT00vR3pOUk5N?=
 =?utf-8?B?WlRlK0hjSzNVdGhDWURNdz09?=
X-Microsoft-Antispam-Message-Info: XIyNYGUAORSoUkOVRpKsKDKXH2MsRbgOOmS12gwBXqyWfa5SJaR7IugP5tQGCzDe/YSDKlCk893TUKvOEoIm/ReYRvAVaEUanINRFVpZmVfTHkLqd1Gn5JqhF8K5WLGOx73pkhc2GM8WHgWQj37hv2VdbB8ezhmJAoAnCbK+qUvAjeuel0Yf5D/mWpwAtwUkC3DLqzZc3w0bYTF7KtnAcK+VKJe/h6vILb4TLcLwRaKefDro0Jm7mxvzHUV2EyI8321+Or91OZTtue0z3eiP5EWrHlwDLZ9qOb4zX8I7dIi9eK1me+sSuLOhCj3f5NNs5Q5t5Zp212GV4gpfRz8TMAdqJnl6J9xqvkIlVEyuQ8k=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;6:zJPCFckMsxQhl8nNHTwSxCjQMrhbNoYwFHiVot0YJ1ydr3m7O/QXzcZOHyrASO+hMUs3vg9eQ4CEMzGnOmb7nQrTsVQKNd2j4uL0mSToybd8VLkUeQ27nxbsD472oy7NrJQiZTzcNXccjcl9BUM3AJqj5oHhvt0gCv8A4EblIwRmSHb0zaQRgmcHpF2JZtQRyXz1ayfS4IZPbwx+d8yZMkFqAQtM6US1sFr8iYp34HiJquDLY6bJX6vfsCA2LYS3PaN2niFp01IPqkNwBAiNnUjmvZvu6qYyN41onYBfYVw8fcmYHfzIYdFhn8Z8GDFC6nObiYTkCMnCGzvBewrxlC7djXEkiYPK2yKtzbbpQ8Hhq5EsqeFEnlYnVRNuz3NrZmA76mTVylmfXUS8bKbLgTJlVlWTPFS8hgftjqhidRmNf8yfMn1r2DJ4owxkvUkIiOoI+BxesHd9MFipkzydNg==;5:5rLNKW3WFyGGglN1ZXqaY3lUGvyy44y3P64gbTH/OJywhl0FmoRymnCwxFpqBktnAfEiJ6NXTzCg/xybUNhEGSMkm1J5ToJCzTWrf0A35+O9T2SJwwpiSs/DdFp7Qn/jG4djsfpRadyApSk9ByelmYA1Fs4voOuDJZqyONSq/9s=;7:jX83CtraiCxmOdIm1jJoEx0/K2b39rdE6S/Mx81ZNR+yxAfLhuIUbt9OFfiMuY4utm+p29EriCxshZe6/21CDFLvpj1iPVJwirTC/3ppLXWIR8fEQRT5i9WQUpWh2RlWz/HdHaaSccV+8l+MKMY3bbLvVGFjNoWXGUXr7s+5OEB2S0iSQ1qEiK8/cbaZAOK3j2uYTFnmhnA3o62+6YCbSZ1EnOi76RlEGuDFYcMxXbxXt0MpnZV0W1eupAM7NGwD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:20:00.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf55130-912a-49f7-2755-08d627a8f933
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the get_state() function and set the initial state to reflect
real state of the hardware. This allows to keep the PWM running if it was
enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
set as output in bootloader keep the same setting in Linux unless it is
reconfigured.

If we find the PWM block enabled we need to prepare and enable its source
clock otherwise the clock will be disabled late in the boot as unused.
That will leave the PWM in enabled state but with disabled clock. That has
a side effect that the PWM output is left at its current level at which
the clock was disabled. It is totally non-deterministic and it may be LOW
or HIGH.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 7a4907b..6cd3b72 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -83,6 +83,9 @@
 
 #define MX3_PWM_SWR_LOOP		5
 
+/* PWMPR register value of 0xffff has the same effect as 0xfffe */
+#define MX3_PWMPR_MAX			0xfffe
+
 struct imx_chip {
 	struct clk	*clk_per;
 
@@ -93,6 +96,55 @@ struct imx_chip {
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
 
+static void imx_pwm_get_state(struct pwm_chip *chip,
+		struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 period, prescaler, pwm_clk, ret, val;
+	u64 tmp;
+
+	val = readl(imx->mmio_base + MX3_PWMCR);
+
+	if (val & MX3_PWMCR_EN) {
+		state->enabled = true;
+		ret = clk_prepare_enable(imx->clk_per);
+		if (ret)
+			return;
+	} else {
+		state->enabled = false;
+	}
+
+	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
+	case MX3_PWMCR_POUTC_NORMAL:
+		state->polarity = PWM_POLARITY_NORMAL;
+		break;
+	case MX3_PWMCR_POUTC_INVERTED:
+		state->polarity = PWM_POLARITY_INVERSED;
+		break;
+	default:
+		dev_warn(chip->dev, "can't set polarity, output disconnected");
+	}
+
+	prescaler = MX3_PWMCR_PRESCALER_GET(val);
+	pwm_clk = clk_get_rate(imx->clk_per);
+	pwm_clk = DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
+	val = readl(imx->mmio_base + MX3_PWMPR);
+	period = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
+
+	/* PWMOUT (Hz) = PWMCLK / (PWMPR + 2) */
+	tmp = NSEC_PER_SEC * (u64)(period + 2);
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+
+	/* PWMSAR can be read only if PWM is enabled */
+	if (state->enabled) {
+		val = readl(imx->mmio_base + MX3_PWMSAR);
+		tmp = NSEC_PER_SEC * (u64)(val);
+		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+	} else {
+		state->duty_cycle = 0;
+	}
+}
+
 static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -272,6 +324,7 @@ static const struct pwm_ops imx_pwm_ops_v1 = {
 
 static const struct pwm_ops imx_pwm_ops_v2 = {
 	.apply = imx_pwm_apply_v2,
+	.get_state = imx_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.1.4

