Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA1CBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD53208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WYjUu/uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD53208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965658AbeFOKP5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:15:57 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:10720
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965639AbeFOKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J7c+uT3QXCNm1ZbLfgL74+OGb3/IglCuqhVN6Uf/wI=;
 b=WYjUu/uTHOxhg6f8Jzi+LLvSQGUXXmG0URObaFxfL9natKjQ5ojShV2oBJgrnmRAa/FZMY/zWpSISMV59dnfpNPxCeQ5XNLPE2baXssx/Jht46XE04UZQh3Ha68pnR1Rm7EbvTxZimYuwqf+kZQMR9kdPKEsT4fWkrt3Tje8WlY=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:46 +0000
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
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 04/11] input: rohm_bu21023: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:14:59 +0200
Message-Id: <20180615101506.8012-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: babb63a6-c567-446a-c76e-08d5d2a8f667
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:GgRSdT4fQHX8dty0PLbFpnIwBSFCOMAIK/rrubvVIxVyjreyIXfsH0lcM4sON9wL5IhhxtBCmkT9AGGSj6tNzWtcGT7zkIEl2UWSkAugtx0hJ5+eL53OY250b9KecBnv3cwFRFttCq96WxM8EcRLXMZWVOjWiUP/XMr+vzIkEurXWrGdveOCnvl5cF4s8F9G183fbaEmmlYXTI1M8QNdntdvLVf+0sMrRNZlc6O7LWNr5TiJUMtX1LS9XHFCbRKE;25:lpuyL5SEu8hwiQar8zt+3qxRD5LCvTm5j3uOZbtKeb8F9kvYVhn62QMdKe7bxCeYx82sNS0/yDgIKkko0vH3B81lm++DON2g/vDOKgwqkYKyqyvunRQHRdmpeLE3/LZnOcbf/zVzKmWFU0Qoq74ihE/hXD4pPnN4uhf9tUSOD8gd6k+vLSwpNmSciWhNl9mPP2jdDzcxhYpzmFHcDxMto7hCGe4RI0dkAH0hNDAsx7d3/9r2rqj1KNSFkndnsn4HnOEcafrb71QO2fydb/UdsBH74in+smTGCjBuZC2Isn/BxwTpTQ4znJYW21NYKw267pEhs3IVmssOh5oPQAoC3w==;31:qJqkJJ5Z0v80tJW/hscrf+v+wKHIw9n8Ekmy4FiRnqYXnYDiRXRUtIqMkbynF+n8LpuO2bhMcCfs6I3pMRfBGYXIOIM3OYUwwNnvbAqN0pnlgYwjSNy5STh1lfuysefnLenjN9brceIVcHM7Bn0Bd9YQRCEIC/7jdIwLmcniSdGyDnwzpyhdsVchDGumBuU0Cx7zJBUYe9anKYoRMUM/tDeXWTBylmKIafIfvzY6teY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB246041F02890E0FA4C157B08BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:LHfOq8CFiKfIZjWOuJRecc22FKBHA/ynQXhZzdKAl4Q7+m0fHdHP4TnAamabcoQwtxvB5z8yNjWZt1Eolk4AYyT8MeJN5IyWZfmB+HXu8pFr2mfkP8RhZ5eo6K8H9Y4Fz0HqJhRGuuG4CWu9Yrt+ISF+ccTjeHRMQBX0YlzaIOYrKPyMvwYg99STytdF4tUkaDw9S1rpYuLg9JqcaoGfIq95c2Miq2qm5u0IO/UaQ9DjlVPoJQxxmNOieBfRjyD07Kigl0QaZazgGnoDzrqlQg==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:bD78xkDmWLq4VSWqtafRH2ixACWkpNkRb8NnZIr?=
 =?us-ascii?Q?J0lSnqWh1HEZ2CUMEZDDIRiI3Umo0M+gCf5y1fXWmzuJnwtmWU3irgwMVU8S?=
 =?us-ascii?Q?DcsaKh07nFKAsTUQHwqP1wIRn170OtzWrKCsqPMGFQK1Jj7nhlNKEAm0fZfO?=
 =?us-ascii?Q?nPRC6HyzWHb/mhzp7QGzvoVxSQrV39Dfyi2oRPJvgIHJoNU7SlHbzqt+he0k?=
 =?us-ascii?Q?U/LUbDvWYih4dgFwGfilyGw63JOSxQKhKLpg4PzYxM5PoESEhgchX/2z7Khv?=
 =?us-ascii?Q?RNXPArws9S3p8cQYrJXucqe8DwqILEsNmKg6S+K3aPjfEaJ9/efeJ66ZDfH+?=
 =?us-ascii?Q?o5bQ1z3WirG1py1UIAaFW50Befn5C8yDMy3o6lWVLCNDofb+A/TGPfe5B8+A?=
 =?us-ascii?Q?+djOvALcZ70TZj76WrezPo1hr+rU+vdwBPz39fTeDXIQLxmrHAho/Rphp2cL?=
 =?us-ascii?Q?T1LifA/7eZMiGzfLPn+eWIPqTRjknI9qPJBdXxIwbfZL9rdtma2AzwFHBZ1v?=
 =?us-ascii?Q?Wki8660hesYE4JTU+tIdZS3z6nUrrhE42Pb71V7CKu2swHIxA9yQyUoTtqTI?=
 =?us-ascii?Q?/fcxXG6yhU3Uh/ekty1GmhRFdMaPb5XeTj5r8IlU2zneMgGLKOuGEQiRhz43?=
 =?us-ascii?Q?Y3CVwZ7GdNwVwInfbWh8IFykqw/OvFc3Yat71SN0VKsGC0b7UjTINAMwKq5w?=
 =?us-ascii?Q?5K5d1ypTmAJT/PDGhlwnYcrc4zPmrpwLCRpRzvLMeLfaG9vPGNowsclncgA1?=
 =?us-ascii?Q?2uGx69LPFuhQ7sbk3XDrKnBYNtzAxIUFhHbuaUCAw8qQevdEF8GR8/F4QB+T?=
 =?us-ascii?Q?lVQnn0oaHGV+pwTEsr1+dAQsWHmmz2JmKfe+NFIVrbvYZLX6fq8tYioH0Jw5?=
 =?us-ascii?Q?m6HWhIt9fIJ0tT0CiY4MqwbUMOVx57jlW/rxffcUzabDoXfMZ0iE2YvJDksG?=
 =?us-ascii?Q?0j48N+1J62y9aeWE634WJQmAMQaSX/pLrqQTxLxOS8WjE7JuEV5Pn+kp2MF4?=
 =?us-ascii?Q?45U2I/WrswO5DNqtpFUg6EjTHx92HRKSQzgL1QnTNrQa9Janl8OBzmpD11aQ?=
 =?us-ascii?Q?DF/Cgxu6NEYJ0/3uBB2VXvD9FGB5vPlW8mavqErZEFAlHiwAibDYcHu9Gfg4?=
 =?us-ascii?Q?dJa6064gTxml4aJSR5A1eBhiiRIaUv64Ju3BzjsGTtRlskgJB9jwQ/x4lQjL?=
 =?us-ascii?Q?LZ37vE2eyjoGXGMsX0Td02FfotAwmxNX9/srVeawdwEnhW6uY06epCFfb5CO?=
 =?us-ascii?Q?1TYX+Bt2g9clejpfk8CCIu4VVekCa+HWBtj6+KmcBuIVWMfWe3OGq2O+hS/S?=
 =?us-ascii?Q?VkkNo5UYsysJCj+Wr/6YdYOoEcqaIwPEgze9lk1xqdw0pJQ8i3wBFAjE4KXz?=
 =?us-ascii?Q?iJN1rx5VPw+R9HN8/0BJGmU7yf8w810zzbGA02DfImqiNKMX2Hycxj3lOuIY?=
 =?us-ascii?Q?FfZ5Nn+5onfc0wLC5KNGgeBRJWmlBsyxR2q/+HNOQ507K4u94+mJn?=
X-Microsoft-Antispam-Message-Info: 7JUT+M0OhHJT4XUbntbBahhTB56Q3ECFQMBdV9zCpjVvJYam1h3JS/MDoenRhDEqrj6dOq/s+INpR5k0o+nNnVv+IgzE7Os6HPO7kI4lF7Wuwl6OhX/kR6HyizzHAOqq41cLSmTZWmxyBx6vbctSWWVAR7bwcvrHOyP7p9/LEChedPQbk1TH7z2JRqt84Sd6
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:iS+DFV3VbUX1Icowlp5OA7kssB4vUO/37CU8bMckmePEtBUInN83V+TI8F4DM2fzkLlz8gufHPzjYkf4i7PHE2rus1NAwlPxP5vFVWrhfD/oUr55Upt1EbMqWZB1s0nx13cY9MCq3lI1EXlFFr0RidNxRmpVe37Kvx0MPBFj6/ppM1nVltnyc47HAVSAYu3oTHT/AdWboLghItyjNV8r61RRZXBd1kBfypVqSW8ZJw0BwdZhaHCbRMjw00HK9U9MHwlSfktkq9A9q8qNXg2g7+SdEj33nbG4KJNrtUZygzOW5/6r4Rs4+qOb3COPVK1tJRVzNriF8zQIJXW/Vgztu/nxgenTimZCkLRwI1Ly8G/iM5GANbQmivvJUyOpn/jO8UKr9/1+PNFwjoeGZZxBPiAYJaKd/gmc7EZ7SP0iJ1EAyKC0NQdBYyHw7iIumDGGOyIF4TrZpfdsW0AS2MHuZQ==;5:ts/0rWvqUsM8854Q8RrjMJfqMgqueVNOkHqCK1r+IdTe+kk2rF8wI2RTQccrbFLBk7jj90z4X94UwJRY7s+aWonS0aISUfEp+5xKRCKUaL7ywMtQq0b1PcgOX+kE/raVGRbhAZx4ClWlSRwVjTeBJvNbsE6mKm/Jr8z3xuzsc3E=;24:ecYXmBcB++zpJ8oG0mBby4yN9TuNKOP63FLUEm8zgWqZkpMH5qlXy6HEGZ1KvZdsMJaPU7/uvVzi4MN2RdaibQuYcAk/dvQjzUK9KttRMv8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:IMoCnhRYuNLN4J9ZjvxGi3VRnrtVlX5+db3ifK8TfWJ3eF+xRwjbrQha7EYtce/ZdhWc81+/z/WEzLHNI4wZo4gKKuqB82mdmR21NP0aw8bGQpeLF8t4NfyRlE+JT91FRYG5EPoxXnU8pMRjyK/o3aN5LPXn8v5hycKS3U4Agb4I4WjaoIwFn5HpHI9sJ1O2m0Z2JtgFhZGqTixTUsXuSiAM4g5yo6iN3W66g1/0eZzzf6BpttcXcNkgLE0iWpmN
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:46.3284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: babb63a6-c567-446a-c76e-08d5d2a8f667
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index bda0500c9b57..22d79db07234 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 	msg[1].len = len;
 	msg[1].buf = buf;
 
-	i2c_lock_adapter(adap);
+	i2c_lock_segment(adap);
 
 	for (i = 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 		}
 	}
 
-	i2c_unlock_adapter(adap);
+	i2c_unlock_segment(adap);
 
 	return ret;
 }
-- 
2.11.0

