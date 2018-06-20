Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62818C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8E520871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Kh9AYE7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8E520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeFTFTW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:19:22 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932269AbeFTFTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX1dAagkdD46misdvh5EQdvq/8pn1MypUM1zV0EW6c4=;
 b=Kh9AYE7SgX/i8ZK17hXnCq7pP/IIjUCHcDU+YBOkF+kxrjPfUvEs+nJsWl6yIqIWV8V4LMv6k87HNXsvAs0HkCGgNVImClM4ZNlIyoMwK0VhvACxXkltGHX8RAac6K1MiqBHk4blWN8VwlWxxhY9U4+EdaBm7SV9LFvfBNuHAIc=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:56 +0000
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
Subject: [PATCH v2 09/10] mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:18:02 +0200
Message-Id: <20180620051803.12206-10-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 7dcba474-87c1-4806-83bd-08d5d66d53a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:UwFeoAoBbqHytWX8XTEHFk3xgkIjcgHGOHNZ7lSrTWxwOv6XST5ompfRVnWkJITLAbUxsA6vB1IKO8oPLyjSXJycJ0fyiu+kIBcR98XSjb6V1q8DXV+qlIA6xO+IxSk2tBY3Stn8XHq5vLFWhDKZqMFFrTl6gvIlEeDYV63azZ/ZsBv45d5vaFPTx3134LaJisUaEc54UlJFaWdY1eM1dXaX2vQKWew5f/+DXtyipinRJ6Os1YeIP2uDCHEfAcr1;25:6J0JJgPUTCRIDVF1UIy8/WXyVxSr5J6QOR3h5HELfvAJNYdWotU+BkY2aWiVmHRlETeVDMSK50mZ1psHTOsY8iV/hdMvsUoCkEn0BOFgHMFZY7VuFKSZra4/8sTwTlKOygIb7xPlhCZCa8mBHJeAdzZgvQ4Cd5qTcHuHjhW3HifQLTNsA1teOq+szNcaUkscNu75nbF8NkZb7L8R6s6CqqsaYOXWahP40mdQ10nyOgrJEzrttrdYhenUi0+MSGKb0FOK6HBFhQ+6TOhOaBCDCMZumhGddhFI/w4yl8pBtxw8NhSC9c6XADCslj5Iv/qheXAtoG1+pH8H9o2IzalmNQ==;31:Y08s/UfoyjbLY2PMd5BzB9Aa2S1xqc7caZEhwTV1X0ZIkLLGd4lfsIxUHDRDhwt2aF8qWSLw//6/3kYJIDsGBM9HJCUDMB8HW0Hp3NnQHjnICn2QSoogguHmCBxYCgPsZKJ64IGttseRGpoi2LJk5FG2TCIBaCoEi0+wvbKT15OSmzcERj7702bObO3a5e10q5ihzx9/hSdERVJ1PJoPTcrQcywWFV9RSU8a5pumeBc=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452B35DE96C3208A5AFCAF3BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:tvg2bZ4fX+rCQteh/lDIFX7nUhn3TxOy3fNc88MkRggz1FpT+np6SDOrx4h1fcXKDtxqLYT64AMDf966hX9W2QCenDoRTTkIPxyygOiYrFl7ue9r5UqvujCgNdhPOx/zg6KqzjXmuqdDK3x5jSmD6CeGUsmbD3v9YDUjsx83cAAeQ1KCkfIKvWGRLmlz3aPwxT7QQwr6A31e2KAKF8CTB49nfbXQUIHfMH3ne03nPIn2HFd5xEQoA82yM+SezcjFu78PcI409znlqDNu2TA4/g==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:/s4jjCN8ZfYqQASXP+b7wj+qRN7d5WblXBp02wd?=
 =?us-ascii?Q?+uhRlrPfH9WvuQ9Lk/8cpMLrk8xKGZKERgdsvqihiqw09d+tjH4m71DVGKIU?=
 =?us-ascii?Q?JZTgZE/FNAMedVE71VphRyX9zdixASieADZI0UmO0QHZxh6n3EUt3EARaIzK?=
 =?us-ascii?Q?W1vZ6o6GyiVjIaYXCOK51+58VGuPT5IzIn0AwW2ymY5uFFbkW8l7T9uwiVHH?=
 =?us-ascii?Q?McjJXtwSUi3llvPgRBpVlKsL7dADgErgCJ7xdGlJkwYwWG2poD4W4eQr5ygo?=
 =?us-ascii?Q?eRFWY1B/bF+amH81BEVC6rk+fVGE8AhC4ATu73xjOve49eXpsefxeDFU9UbX?=
 =?us-ascii?Q?PjTZXfD1rEF5xswTDVVNJhIk/RptX15cNBNot9amK1lbBHt4RO0QCRS+RPJX?=
 =?us-ascii?Q?h1oiThR/dPijQkKY1KuePew2fbrmD+WDseyWbM/rNpyuXwpcgH2YSCWsHnoE?=
 =?us-ascii?Q?E0GPGJHRrqYx2EF4c8B9UjaNpzJfs9T/kwE8KOZtDi6XZdSofyLtFPhXlAhF?=
 =?us-ascii?Q?2hlzJeFtUfMh9lJdC1v3x4S+00GmwrJBZrc1FtaDwk4WHsFuvP9f630Wukep?=
 =?us-ascii?Q?BgpGmdXHCc5xAOzAzscGzdypBCRbHpDcuIuiIBG6RjJ9yeumuEiKTtpaYgEr?=
 =?us-ascii?Q?6Ihg4YgP/1G4ApEgR3+tQvkbm6tVfEXqkziLDxWlOpEgd0C9+ofAqj9eLeZE?=
 =?us-ascii?Q?w9T0QzDIzy2k/GEfJFcDWr0oOx0pmSWtZqovP1e57yDy86p4m6Jp7ZfSJtBT?=
 =?us-ascii?Q?ierNEF7B7S9IN64oPAJ0af9yDqGBqs+7zrL41RHkZI0Jl9b8Qf0z0iKWwLLH?=
 =?us-ascii?Q?pQS3DmQ8JfZjM3eKbdqUFAt1N8WwQv+neVIZXLHn5gHBNj4X4gGSkMIwTsAc?=
 =?us-ascii?Q?0n+fP0hzUqNYiPvGSqSHsygDHMKwFEH51gXSPinSomCf5C6i6GBglcLsZLmO?=
 =?us-ascii?Q?dkBssB46mVfY9APHEVdWy+3bQYnQW8bk9XP6UuJjK9Qq/M63tPoOH8EKVku5?=
 =?us-ascii?Q?aOu4QPceV3SEDHh0w318bKdnQVk+b/3tjE74FJ/w/4hILa+J6060kIpxgCUJ?=
 =?us-ascii?Q?+L8S1PEaNGeO8vR0vD0Ldw2cMUBuTshgF75QYWbcunInnGHkItlCLu2yreTX?=
 =?us-ascii?Q?yeW/TG1bKVPI3HSn9OL/rYZ8nLNxZsFJmhdNmiWd8INI0Jfx17nV6RILinnL?=
 =?us-ascii?Q?OX7oEKW8czRm0phWky0chTm0d63KWqRaUoN4wc4Q7gmWxqGpRt3yM3Ju53vj?=
 =?us-ascii?Q?lvSMG0zhficPSESyr4FdVIcSW8HqHZ/MrWI1InMVJp2Ua2T+MpFNoedPhGjX?=
 =?us-ascii?Q?5Mhupt3r8auEUE0EDz0uuH1AbU0JOV/TFLIMiOxCKv0NM9zeQkYdBCAvb+df?=
 =?us-ascii?Q?wc3HUfn/prJ3ghy19Lxlzu3Hz7IBHX+d9p4CFc/KLpT2Memn4SZODvhHLhqz?=
 =?us-ascii?Q?jfPyZv38p3qaZqcYnnM0pAfoLGQxuSe19xLzaMwL7JFk89nX1FW55?=
X-Microsoft-Antispam-Message-Info: ByBCNUjGOZFXe7j7fzWXowmMLtlbDPOTfHoFJXIPdLwUMWrOMcf6kIylsKbwmoMcF1MiTFGveIdWFsa/KWKSJklOKZ/Ej/E5X9IZPw5Fox5bqHptX2lKe/14Dw15bMiUMdvg6O6uvPvoj/9PQuTr+vftYGlW0u0Y6nLiMlwHzDlINuEtQPrbjGawB9kxUcAqgKrqfIGzXjy8npK0hD1MX1IlTp9W8t5YBJCO5OPk3iYkoWSo2ax953WlBHfT2O9lIpkp/ijJTXkSeW4ZtxMEB4hdtoRFU0PxeQTqs10j2RBsX/O+KsQnzAmIn/nmVrhSPQ8D1Pgz94F9bKAFeNypwg==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:EyYI8ivA4j+fOMt8XR3TleIvTWsKZ7s5Mb1sNPtuFhnqoI8F0fsyH6wkBC1xN3XNro98Bl+hhSYT3vjdsfZvo27pnpe4oJn54huTsObWw+u6124xDZxloVxWKcqWpbQqDkE5YaRquvHiYQio+NXEekSLcn+ECjxsuqFOsbSzcqdSvOaGZNKckEXq3c7LqLcdsFDfJ1UL1QDoznFFCk8v8Mn5GY/8cFEeKY0kz97bWEJ0r9u6pYaHO4J8R++6Cshq8Y5ZvGgh/ygn916qpkSzyXekGlmX5Tn50O8Zbu2jVJZN623JYUSdvJUjzZsOKiEVZdARj8Hq3wE6F03yEgAuwS6uUEcNlgk6+aEMx358sxR8uxAPZvYhuu7mAueBE2SmVnCyz89Rjhq65aT7nVBcWaNTqvZI9hWdtVfjHZ2GCNb/HhX0P/BSXdlh/o2G6l4RaFdBlkqmKusygCb4IzRaLg==;5:WSwROYjXp/jQoHedDMAKu/YEAGrtNuXopWLc4drVKnASfklOLZJXOMds6mAUnta3BHdK5jcIajfAT/OostrNwoaw4T6UQGJ/+p6mNeLG0mes3vuMqh2q9lQZYBIasm8w2YjWI4xfgxDfQXXONwZ+vtuB/D5P1PPDIKxXDNacGrM=;24:pv+h9hW+iZws+I5+/bNBl2wzSw4tHoSp3fMIz85OLni8QhcrtCKX6EqJQpXQFOq6Cf1tnAN1A9N7mnaJxMB58PqsFs9BBd+Ex/3iErK2mfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:Zzj0HQe8Vf+CHp3VKV2fInk30VcbURqwqU7k44E5aIz57pD3wA8lJNg31lumaPJARb3i5vXko32gLfLyKMKejlbDtOOXaAi0SoejA0oHlUHnDglQP2m8Hb9ljpTWhutHQoUzaiyovC5nX6eBLJ2Dh8RUdJFqvrGwQvKwnAtmblVnqRKoVf8omiUIN1bbEqg7fPM0CSOYfn5UCkCTik4ACR1VjzIDO/X/8tIX0ft4lTctugeqGvoGxE1SLIdG2zfQ
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:56.4664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcba474-87c1-4806-83bd-08d5d66d53a0
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
 drivers/mfd/88pm860x-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 84e313107233..7b9052ea7413 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 	unsigned char zero;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret = write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 	unsigned char zero = 0;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret = read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
-- 
2.11.0

