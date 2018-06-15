Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9B972C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9C208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EB794euX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936305AbeFOKQ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:16:57 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965689AbeFOKQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrvteudMpe9VkNJGtOP/zxWVtYGc6W8ERvRGM/g36pQ=;
 b=EB794euXjukgSFFBD31+6fAjq0CATu3lKeVZyNLSjIYTL2+LjvZ9sNJXO+g6SxBZmn9G6lvADRAB1dI51uC2Q+N/dkmXU/ZvaXrCsaB7p2a0z6W1nhSCzdWDNhX6clcfi9xv1/Cg1cK6tjo76RzDjiD3OI+stfTZtP6RDTqmNKw=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:16:06 +0000
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
Subject: [PATCH 10/11] mfd: 88pm860x-i2c: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:05 +0200
Message-Id: <20180615101506.8012-11-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 53f672ae-cb92-45a3-fe7a-08d5d2a9022a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:ahCtgQ8a9V42tpcjRo8ZyVBTkn+XsV/hE6u6mcKWJaLItckrE5FqpJrYsJSpToO2g5ymDKOCuE0woUhi4vRP6EDAimK4wLDlqq5LA4hy2FGB/mcYjBz2VOHAW87Xzn5GZMfm2D+I/TpMMfKjZEoUk59mjgMoFCBVqJtojPnPGnXePPhj/IEfaymCLPQUWycqCqfFmLRM+MlCz8QgFVibc2taRbTrLYqnz0NdTYxqkPdv8IoMuWRw1PKYhukLuwIx;25:qigJRsDesBhkREYZNjYEAxUjDCDMN/CfWs2MF9yCBxzVcSv2OLj8xexIGGG5Q9A1x+B9bPV5w5vUzLcCABXHlilFV0+KvBurB1xzJ2B49TesoNrp+5KEeSxuOgFjyzYohuG/OhEAU4UBBbKttKIWyvLUZFnLAHPTHTikcKp5hMA1g3pUD7BYW0U2YFWNgujBcCekDyjbe9Pc8Owtv1efpeROaftHuNf81yD5tc+orLLkuLxzRDlHkyQEvcAkHcBI6u+v5uqojC1C2378Vc9E5HYgPzfhaB8Fj7xP9/Ntne/V3fbI9YgE6hPklIPFkMdowmc/smhaMhLc2roReFiTzw==;31:ivrGfIkZJMpb27kvQph8hOLus4qJ2qRttYQhmMIWO08Q+XTU+Ul4kXZmBfZARnlvFkLquOwpSUDoMyY36f5OpupQPstGLF2cvCsBeMxd/lDgxxGTp4TXHO56cN8d+28C4jbR9rhLKDk5UF1Lzkz16tx5Byc+rtd0MqxvSULJn3VayT+/RYMZ4NjLsXad7H77BZlS4XJchmsLRPYml9MqWmP2FbMsBUx8belNNB8nCF8=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460FD9D5E0FCAABF1DEEF9ABC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:ViZu45CIKg4hDzlYppAqqjjuwJdZKXAQyxV9m51iJWWoPYsfmjJLLFADwAoGIOjy2KnqkZ93SUzMD4anipg3FpVh/yOFIYY8L82iXYohsGNH3hUZCrSoxDkaGFSjfdNB0MwdQ+pLSmOFWmmv6R77P2Kq0OC+D9LxiF8/ShDiEShOcalbv8NgJNXpSfx+nCMULr0NbzZbXp+i3xHAs8C4LITWiT1dmEUO6qmY1ceOHTuBPmYW+9FwM7kZRXbloA11tYTFdgUG3VOh2IMVTQX82g==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:JAJKWQB7rHWzgba6Ro4kNIyCujGCOENvG9Q3Mua?=
 =?us-ascii?Q?pDQHab00IOsAMvm3J/8k+xtce+GjvN43l7cTAJ2BP/51S58CeN2jP1GKB/Ti?=
 =?us-ascii?Q?Be/I9u/k0n4JUp7PbmK1pvZbSYFEVWxAydb0rpCVcDfppBzcJHgDAHistRaV?=
 =?us-ascii?Q?+nnz9w4dcB4ltpSuPz/WnNrl+ZijaLJb/q5SC0TNGMkVxmq5o+/q6zRF1zOG?=
 =?us-ascii?Q?W8UhnzeiSaZahyiAwQK/5y5qegGHA7lzHz7Trv7BoFV/9WRU4xAxNz4fBEDB?=
 =?us-ascii?Q?j7elO1Kziu9lLyl76Fv9OQ028FYLlrD3YtpxYfoKkcv7gzleqOEogUnsw38P?=
 =?us-ascii?Q?z8qMABXEj7SFDGublcTK8CAuY7uFyUw3xgjsQ5+/TXjhw68xOTALeax+UoSY?=
 =?us-ascii?Q?NdOE3KONn9SfidK2S7z7E1inXsH3rD/t1Zs0LS8PUNVsIflqrBasLXoV2MHD?=
 =?us-ascii?Q?pWP0HOJO46U/bAjlVwKY9Y0wiHGX5rTD4siBudIQr143DnmCuFza5xPTLqOZ?=
 =?us-ascii?Q?mgdAKlysqsg/djVU8Av3mFpX/53VL/vdcAWt7ExWXpi5MTKLOYTDAl81Mj3N?=
 =?us-ascii?Q?F6fgsE+MYAHBJChbaAYyACotwXz+PwHZnWpO/EftoEEyNEYdWk7x2Vn7eCqM?=
 =?us-ascii?Q?IoO90bsXLqO2UTI5foPCjs2TNXTXAC0lFZzj61+/sYJSkuwfKWvOwpEcsHF7?=
 =?us-ascii?Q?zv2gT4yL1KrFF3s2F1XHB4kL759Hc+mdWSo4bw4eeTqe3Nza0L/HZ6n9R97K?=
 =?us-ascii?Q?vr1h0ObPBOZUqf0VQd4Q3bJ+xYqxX11VWgadDad1DoEXUMPo0gwOPIKj5L2I?=
 =?us-ascii?Q?f/wDgDJZXeeMNE/rGpOb+xNqrOaSbJqEGVDLL4OOqk+4cljGfTBNoZK4xKRa?=
 =?us-ascii?Q?7jQ7dQ2H48+GsegbCQ1XCtLdeoH3hUYxaYhjFSuX0B2pZr63H2qnotk7iuDY?=
 =?us-ascii?Q?6/e8CB4YCz8hWYdDp7/PPkBgxNXNW0sWKFPL9ehZr1fqqV4vqTfeQlB1ZI8f?=
 =?us-ascii?Q?wYu7YWPVytH6fLTMnNCsONMotLuasLmUY6fgXG8Vy3krixyCOvXLQBa1THuY?=
 =?us-ascii?Q?GSEextQoIaOfLlJuh7ekXprqTG208Uv2FEcE9Pc4pZPRlPE/uTAMKQVNMmAq?=
 =?us-ascii?Q?7ub88bJ/28c2RAx6vcGTtw/BRAudznTR6eTr6u8zNHbPgTvMtFKYTovEdxLu?=
 =?us-ascii?Q?86K510uBNYS5NnzbIdgyAGGfTiOlPyo6NjsvTBQy6hmG2SEsNKWaDVGYgjy7?=
 =?us-ascii?Q?uHKkG8v2AFps2WZxcKu39j5GduaL3gTLEr97P50P9AParq7XWmJH8sqLos24?=
 =?us-ascii?Q?UhIJahURv6OqSqujsBHU62J5h5NYRWuMp3KcqjoHeM6piKoAOdEnSa7BYpwZ?=
 =?us-ascii?Q?zwfMMAsgea6qYapn1fwaStyQnpryoIbctAs7IXmH4ZYYECdslkgcyqINMlLz?=
 =?us-ascii?Q?TUo4Rk7g5KYxB7Ip8U63ngIOT/sEri5Q=3D?=
X-Microsoft-Antispam-Message-Info: A2qv84j2l15lZv5RN2GczS2X2i+/NeY7jKZzg94sGhUyZfRzHvvTXVrDVAY9P8eeQfRVA93YU3CE+EUs/URre5bRHZDY8PfyE0Ge7PUOucZcQlzr7UHX/EtwUTWQ9eaPe60NmZUM4dbSjm7UHp0rp5ZKzOcpTFet1kwMKtmOxNcA/00NMYp9908tZL4Hsgz5
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:g3pVowYMZ8rHnpz7+wZXyBen75o/ZTdRdQh9yV8bfbapUEP1xk4mEI5gjkoMh1d1SUMvaFOdRt8w4aRpNGMVnELkwLPFsEFwEmf8wVmAXHdUotQfeyp/OysDjp87vrj4QPP43D4X9XXxAss11DcJxdFQRvIeWpStD/fySMO1r7Qgefyc8F60iT0PrK/1EK5mJB9ZfXbHQAROU2LHtQVpT9eP5hVfO8Jy4fJGKs3/Wm1zVAbCh6hs6LXcClJY1bpkofccCm1+Qn8eGtbeRCWgJoyfgq9iNjJbPfc/Dy3TU7HqRyRhiX9dQCPpSS2swG+F3v85JKYVW8AvetYkVZw6rm5cP7Cbq8SkTn61iVDi4M6QvbkGs6tx1FcVdEajpTDNaACg4d+MlB12XkjuEQXgS6pfVkzafI/Guktqii8syXKRQ980RqXdSQsviSxigApPxKIsHCQpAKD4wgEUqrRQEg==;5:Z8yFlMPgFnUzluFj4hRbKOpKT+aF70O+l6F/3s9jMPHhZ3HH5U1J0IqI1bLFiTQ0SBErOR5rl8CUkmrN9v2ksLAMym8ecHDZ0tQB3wr8Eg5SqGNtmrR/NBIqTmP3oRXXxnLeaCYydjeSzErnXJZzpHBbXDUFpy8wyMjv2hZbWk8=;24:9K8YYGjh397KANh9/abEQyhwpofQpU/HUQ+8MvUFEmXibyv9/eZJucTD1MIWaFmBhJ8+rJq7nP9/YTGT1JlOLYF4NKiz+iJ1kGRhNqmYXSY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:4YWahaqWYiVWOu90i9Aq77reXgQyOrNvcS6+Kn+P41wMnnW+kheP8CojaxOvGYWc+F6RwybVRNyiSuX77V9bVlxT0wpuHciVGmwCoKu3oy/LHEg6D70JauIOl8Ao653L9ZQyrJyI95HEwP9Xa+h0RnStxRUNfzwzyUWadxiYmjnFMnH3euus6aBswFkE+ilfr7aYBWJPxAXeZ+Jyyw9aC2LRttz2MJEmm16Mn2W+h9fC9KJPBLe1rtmfAARI+xno
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:16:06.0783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f672ae-cb92-45a3-fe7a-08d5d2a9022a
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
 drivers/mfd/88pm860x-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 84e313107233..8e54fc2dc29c 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 	unsigned char zero;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_segment(i2c->adapter);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret = write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_segment(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 	unsigned char zero = 0;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_segment(i2c->adapter);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret = read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_segment(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
-- 
2.11.0

