Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73020871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="P39spftQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A73020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFTFV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:21:29 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com ([104.47.1.91]:13952
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754075AbeFTFSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9JkdxWWsr9G4EkevpbHWFFTJQGKorrkQnVFYlPPGEQ=;
 b=P39spftQggrX3doZNf5TQ83TypqH0p1/InlK7rBhYEqLGr3ex1RHZGY/azJ7SJebFn++NnZnH5Wz698eu0p/XAqbCgGYiC2Bbg73V2l/k+ROnxrGQIZpH66eTCCTUijXayOX0yrWpR4dAz56xRyXZT5OJ1DDHHtZ7rv4qpj3pRg=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:37 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 05/10] media: drxk_hard: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:58 +0200
Message-Id: <20180620051803.12206-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791ce5ea-9171-436a-bc6e-08d5d66d485b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:PdC0lcPM/11Wkz7FLCBZWwpzMinYAmhZVuhNrJ3PyYs+8WoF38bwowM64JP1S40nDbwtpx6upHxzD/CRWgx9AOUtkEMUAr6bOda8Yf026R+EwuCnNYPx8yJqi6H9Wig3SYc7Kp5txXaelmjXWWaJeAToXDQ+6jjrIpE1sJOWisUqZhoqWx9qBW+0/cj3y0SOxJeGB1hYBKdCPXH0Gm8LKuS0RHy+c+vl5uvM1q1s9+k3+5bdmVaB/OUPJKvJih+m;25:rLsgNMyE94kH3XLKD9VkDDX3rdQk4J7gls6lvaoHasYL6Vre4ESRi0K0NJMRh7DfZ8mK486ZD1BPCZViIJ9UW8EdxjZgt3/iFyZ2n1sJmnsqqUyN6OpQG0u1lHSHw6jWk2eJyFAtvHx6Oj2Uqh7D5gJPhyBpvYYAFAnx1TXAZEMyY9fGrdR57Fb07wAOXLXa197MA3nfhraIxypFcXexgEqmSevk9NaipjQ0r39QSaUyQo3Nc5+5R+GqzyCnZ8wEwAdygBHU7364yt9ZLXjPDvbA8kpSV2rf2o7Qx4R6ku1eUyp2gUqADCoJDPHNM10zRTt0QlHRjh4hXe/ZiOxwfA==;31:Ysf0RNmu3RFv+YhPebE1JMlscxQ5uzuXf9RrKC0ylItk3uWKYBI85h4JRyGM6PMl/fL3qLiHRIG7EJcDhycVx3YF2mK97V+pBwynDny8OGLmFOu/beCWqYmyPSDQQV0ibvG5WhikmI1loGLiEN2iDWIHq2aH+NJtcsre6DxqMPK2Fig78mUInB8YpnbaTbOVYbkDLKyyALGlymElTi8N8eN6ZMbaykS18Wsu9j5BNHA=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245277002D292278C71C6C94BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:zOns7KU4ZYoUZvjS+U6HcFhHrkjDVgbr+8q+rKn76w2OwjjB4FrThlys7ffRunHFuAHTi//qyiogRuxNwPccYFTVbdds719juFVbZK59QyfiGcRiH4BbzOyzTa/unhnxOKvW1mLLooX58JUHWbyhVXpL4hJhem+BdXfxp9rTQKhKx+ZQI271P8JbHKBFtQwxekKu1OUatZpkl+HNBdIUxxuFK+8z+6ib1SbXSlU/ItZjUgu+wW+wb+UQDNMuqbXNdJIarpFX/2MspD0Y6/cIkA==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:iUPnVdCo6cSDyt6JexnzkBsxuo0NsbQj8Pb7+Vn?=
 =?us-ascii?Q?N1jn9mIr3uC6ks+bsgn7Lsn4DdWm8R6Ijg8LvviCd5IY21K/j2NB+yfa/vWU?=
 =?us-ascii?Q?hmGmrOyHKbgd7VrbIdV0cVQQw4A5CFev8+Y6RlyfBS/7hinzAFViK6kqPwVe?=
 =?us-ascii?Q?IyVFMUfVE0f4WlIKrJFYRxuNM1lepVGmZTAkE8uLAcw0kpkx+3tUygbd7Ptz?=
 =?us-ascii?Q?dCzB1Tzt1hbYlfpmxSAbqMhs6NVBRa0IBM0p56FcaR4KiUB4uBr6yGrcqYHE?=
 =?us-ascii?Q?qkxwMLzJh3dnGyKs04V0H6bbeKIWynWBbsvlAI6QHytiV0WPLGMod3HSn6Oc?=
 =?us-ascii?Q?QUf6Coszk07LWiUjy67f2+7H8muJqR1p2Qp5CDxki2SMB68VVjKTJIHKcYuu?=
 =?us-ascii?Q?wCzmCqGm5rqQx2bnX8AZ1lYLuN2srVFKIUX9Ji9S0/3UMmyM+6cgRPVUpZHB?=
 =?us-ascii?Q?G7XYCbnLOEVn3v8xZhwmGFyKQGHaIQdPPhXxNukvimu/C+W901dW7LTClS5X?=
 =?us-ascii?Q?OPeE4E7strKDIeVOQ8PMPkaSWEfChTI7siv7rgYfdHF4TFPsr4M3o+r9vtgm?=
 =?us-ascii?Q?h0ugPGHewwfvs/LT4ZiAHU/zqjhrNSW5uHCUTwmV/esvBQAXbD76EaPSEgGW?=
 =?us-ascii?Q?vqkWVnAaswZ+KGtQyPoE5hOifamLFsTDKYUAJIbGGA8wRMEyNK7QQfnxOc5g?=
 =?us-ascii?Q?r838VJZnInGFtkNSamOMzkXI13qF/g4XVbm6Uo6uSvV0eob0LQbt5WkkbOlz?=
 =?us-ascii?Q?4cSPWEk4cfd00Q3JFxzefDCHtsNLe1x0FweYVmvAW41UGLvtc3l+ATMwXeys?=
 =?us-ascii?Q?P+BxMwTaGKv1R9QTR9e+sIpPirpNU7fVu2eERLIUkiQ4epIAa8Buzmi63Jo5?=
 =?us-ascii?Q?gZGJq8wVjQYA75Oajky3rgDVE8WQG1F1VYcr+pY7FV1FJ/mQa82H/G/qUL3i?=
 =?us-ascii?Q?FnGoGAPVDhDIc7P6jfRL/c1FAoxcTcT7r95TN27x7fAg0Vhn+3PQKRWgKXde?=
 =?us-ascii?Q?3FI0z51l7x306YEuOV9goKJp1/rUtbaWCao7FOWTJvbAAGaNfLysro06sFXk?=
 =?us-ascii?Q?lWzRO0HMVrTcnfAT3GfgbAqs3wVkvhu8lZEWxyv563KuvRVCuPW+vzJ9hqnv?=
 =?us-ascii?Q?PnFuoeXbbH4e40Lt2zE5EjKt+YoLVu0cHr6NocEKGjJ+s1a8Can/AzonEKuP?=
 =?us-ascii?Q?WZNa4RUrfWagqc79AAd5dKsTyhlhP8F//OhXQCL487HfnGxtimtXNsqsNmZ6?=
 =?us-ascii?Q?EFngLyEXfhM0KcPavGqBe6b+02vYSp9mBrnNHdxTTlj6skThpuI8F8O4OHWJ?=
 =?us-ascii?Q?9agcs7SjYrWMVg/yaAzoKQXvahaFiJsikIEhN3U6FmF+pw7tmthyq1spIVru?=
 =?us-ascii?Q?IoIsv4tYIrhIUQ86c/iBxO7HmJBXCdsrTftJuRxYTPbeNxL5z8TZVPRhYxPr?=
 =?us-ascii?Q?YoT7TjdvFZNoI2iD/xfg5LPYtmgfpKTEJD4IuUfcOyOrhj5N1vrQX?=
X-Microsoft-Antispam-Message-Info: LYf+gqhiwvzhB39BL5zz2DrsRwh+X+F1fC8Vgc5RGvgbHP4fdvoapMb27BsEM9UFNPu1/Zx4rShYxa3vyKQKYjOjCm6wIKxih1I2e/Jk/6xmFEsFx3Ds0PEpw+hPqOeVWRb6Ybkzh/eBSjeE8DKQgOF3ZEe2u4oJM1mR/KhX23Z9NMJZD/rFKZEj+P6Z8YN1rWaeppvKX+ea3GnNbUKzzZ3R8AUszRxubRrrH/GNwQji1whi1IIw7+vws+CvbROYgB0lq7sFRShdXuZKmQE+jfysi1A04HabKStRkb4BvgLdfASnlu2fhBMKFxccedEGQjvHyJzY1Iidjz5MbhpHvQ==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:CkxZcl7kxSgdLifjYFsruIR8P1ii+npt37LJ1AVd3RlV7EGTpBiFEWEbeZ6bsNtZ6UeFzqFZ+o/waaj9SzUkmus+wcQ1yy0YUvs03wb9mtn+aZsSjvjz7tzznbl0RXKz7OvI2JCyohm6MFMl5bgoEa46cBOY2BBSDVNibeNep0+Fd+/k6N4DySphOnB7nFB5ZeyfBEu7dZl8xWc647Zimg1NB1hZZxcw8Wv25SY27hm1aSKkKrVxpM7ZSz3yoAwAgXrQnb2Lsp/Sq/RqGsfpTHaI9zkS761Y+ZCISZdmlkXhFHkdXbJ2NLIc0uYaS+9Z1yMuvRmgd4S/t+HMe7X/CqAU4H1se6i42WWtkOzaEqsbb2YiGfS6bw2IKif/zWYxTRxmLZmHJUUzl7mU6cV8VxiLMQFWFb1TvIJwiL7+Y7aR2g6I/9IM/EXxKX6OT4qCstU+0HYykGOpWz+cfAxYqg==;5:2uzrNk4RqZUpzXTQL56q6liW1kWzWondmr+ViHeFZ0ap2rm6E2crk3SJfDBAlIjyfBkVrfrn4G3tgVKIhV70rQYMa7G4seHpJGI1vKYgmiRrMuGH/lHM3kt2vLyb8CxJ/VV6CoSCYKQNWwT3+YsfxdVeTagZMr7Lfhd96/+F2FU=;24:M9a/iIqhOMbQtzDJGDCi5JMVIBZXg3RHV53RypiO2qHmfzwRk3d6uUmC3dLq4S09xgJQb3srDULPKYD69GDhlDvMbczYjIai1lcUGj91XLA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:EZfmBZi5JutMe/k6wEC4uBXdqQiUYAGMZOZxSg+2yQh+Kn1HfnRqi+klLxlQUmbewekIG9CRVUJ1qsVL3lKVfJXxREDvUbw5Fb8dcAgE7aN3FCMlAmZ25Fl9yw2d89SR+20OoLwvbTnV5mftTJHipo+QQocUeOHDaXKuqhGZf/LFkWAZVY0G+ZdCkeTGosr8jvrOx3hyFnN0HmuXU77920bJxgGfu1dhCNrNXvTejwJPdJkUxucbVIQRj4b3AvFY
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:37.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791ce5ea-9171-436a-bc6e-08d5d66d485b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/drxk_hard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 5a26ad93be10..29c36f95d624 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -213,7 +213,7 @@ static inline u32 log10times100(u32 value)
 
 static int drxk_i2c_lock(struct drxk_state *state)
 {
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_bus(state->i2c, I2C_LOCK_SEGMENT);
 	state->drxk_i2c_exclusive_lock = true;
 
 	return 0;
@@ -224,7 +224,7 @@ static void drxk_i2c_unlock(struct drxk_state *state)
 	if (!state->drxk_i2c_exclusive_lock)
 		return;
 
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_bus(state->i2c, I2C_LOCK_SEGMENT);
 	state->drxk_i2c_exclusive_lock = false;
 }
 
-- 
2.11.0

