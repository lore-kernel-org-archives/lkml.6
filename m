Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1A246C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03BB208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pbB9waTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03BB208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965712AbeFOKQM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:16:12 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965662AbeFOKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI0wWqTLkmEquHM9KrT70kmJ5dJqVWNQYwf8lvfdqAE=;
 b=pbB9waTaizVYIdqroE6YF3bNtkQwPntplAzxXTQFirrUagw91GtirWx8IBOhmUfeOUSOorRHnmI7HtmNp/URDYn1rx+u9MWIkRJ05qCLIV9Q2v7tnojn0woXhiNjC5YpY50cPz6FJ62Rko/VRCO+HJLyWhgpvfOe7Zk/wCQ/MFA=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:56 +0000
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
Subject: [PATCH 07/11] media: rtl2830: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:02 +0200
Message-Id: <20180615101506.8012-8-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: c293060b-8004-4ba9-7cfa-08d5d2a8fc94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:HzYwBSqo8HKk07GLldv8rZGIJtovmxxUh+4JYhQPoKFvmtRpgPJJiQYIwQCUw9HSwDXHfLk/ijPBo6knuWNRn1MGya/7ylRpyxjContLCsWx7JIM+5H9ht/IQHQ2AbS6uddzZTPRFZ4MdUNX72Su9uarFtWbbZCHT963xMDf6Sp1WYI1vlPPpKnxxSqpsaPOhtY0XMEelOzdxHEaQjANljh4BF15btm4BrsRp08ijI852vwqbq1PHwTf+0FJ2REx;25:f2Rlk0KNNrHAHlqYVVZKYo1+pT3ZRgG8lMVN0FBOLgVx0ve612dtI1p4I4l766s5E1ZYcVhtR/1D0yZeppTtKc4U1JmurmsYt+Lym5xGvF0V480cOzjXTibQYfnRuUW8ihB3FE+ZLqW+/qQiHNzZrN+6XoRYM8F3AQyPXiiPom1AJN/7jDzPuKX+INqfuyaC3wQKpQqKlgJSFzSR/goHRMOFfnojMJnmY9eTHbfYFqKJ8kmcsTApsIeSZV+BFMk3twsoo41sk591qfKv1Mv1FsC0iK9B4L54BZ11mDMJ+3P912g4UZZssWA2Gp7KqeylSHexSFlPYYoPqAv54qVnsw==;31:vxnEyFm7uGxBIbfkcfDw27SEae/uFBU1CrUSHRTE4OiHK7CcMn6x5aZA0mdRceykr9V0MIaHWzBsTeXmIH25dqWDJdhJsXr80TPKFzkxrHpAW3Swy97NfpSdrJmsPtSIjDv4MX5+q1mzMJD0dqJZ8xtQitrecO5+rx+h8lwwDIbqRh8xKrujhGTOr4BdEbB3k/WqdhaLt8vYK2S9SCwj1vGsN98SQj8DxMQb28se9qw=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460799129F98EC2FF96A995BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:Cu2k7YtdIp3sbamcVuYbxrMK7Z7hZYe1BpNEJwwELCi1xsX25L5fuzQXpmqrB/773XHr5IuJ6bVDLJgY+e2TC8PPW8jv/RzjOd2pJORU5woqk325zdX9CrC5E9+VhwOKavkIWTqfaWMp4TQE1Cf+QqB9nnKQvZS6sqPCefGdE0GN3kv3bfnzQID5QtTvCB4ewnpF3oHcq8mRfNhcwQ1Wrq0tP2cZ7IDON8OvpMy36oEZuemC2M06+j9LsJbfCKW+ZHMoGeTl0FUc1AhkJ59QCQ==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:dA3tGy0yo1NgqjfkEcOzk9acpN1r1n1p0r98PFF?=
 =?us-ascii?Q?B8KIe5kj1wjYdhd8UxKx1wu2e1U1eOVPa+TVt/+T6jKStEoXsMNEaoMxC72X?=
 =?us-ascii?Q?3LOu/sYd84iXWl3SsOPhFU3bRsbQWBlVCVGb4Mi40DZGJB/YDbV7JwHHB0gK?=
 =?us-ascii?Q?acLIo2DpWlA0aB3PCppa7wAadnXfdZG0fagekK5V/7XBGMF9qXGYMPYrexzN?=
 =?us-ascii?Q?1WcuapldwExgBVrp73pZ32v2rEmE3HcxuYNxObtBxhRfy51U8wjdQ00K+QSC?=
 =?us-ascii?Q?EEQM1CYBzQsuRSV/tyzQg/TEGqdORnt29TiMk+9KxTHd98IzyYBrGRMBroRw?=
 =?us-ascii?Q?MV0XTEcOUXSIAK3i9CqiKudN4VnW+JgEBWahCPRFzEfCPsRMc+xU1IgfNtdo?=
 =?us-ascii?Q?NGxOOneMwwMaiwui/Y+qZldB9VaOfkMtCPK8ISmUMuuep4dIAhhbBgFujl6n?=
 =?us-ascii?Q?ZvLX7BsHYKbcFp/txtJr9g5wVW7xsS4dcqAnEqAWgaMgz6Ce+adH8Frx2gS3?=
 =?us-ascii?Q?vQ3K2Tkf3aj5d2zvFg/UgOJP8kxrquRZ4osGa+0RTNT5TzxWcl3l4jJsfw2H?=
 =?us-ascii?Q?L5YmgCxpoCg3kbLvi7R/PK9QWYVv9GAg0Km6o/7GQ0iyhccHcs2ww0uPgTag?=
 =?us-ascii?Q?XC9IMlL0uSojZzVAIoSPE/mbDtixv7/P290SGtQAJ16VUCupEtW8izaNF0H6?=
 =?us-ascii?Q?9u2O57PiW2MXd4FAW9SQIcFWFYLI8Fmr8Q92Jf3MaLbfYIozYD4An+NBsfuU?=
 =?us-ascii?Q?qnOJWgotBFPkOGggNntpASoM6lCjVdUs2TysOePJlFeaVMyxVpWk7IAZVO01?=
 =?us-ascii?Q?kS5kemZ7kgXX5tEVqfc/E+zzFJFvY65l9A5oUcMI2oNbSBjBxCA6cziaEh7v?=
 =?us-ascii?Q?QgHvqpnzFMslVr/l0NA/nfI3bHgkt8zm0MJ7GFjfP0p+gF/NYbicKQG+pC4Z?=
 =?us-ascii?Q?QgxhmA2FMsRKCLNU7t0syRLp8R3bbS4/aLHwvZ9yekpjAi7PgUfuyt5psaX1?=
 =?us-ascii?Q?EW/1TAxpxy25QQeFvp2VADXuMi/ey+RvcwDdJ/Zyffpo92pWa81qSb0Kz5O3?=
 =?us-ascii?Q?/6vongBZKjExTUM3LrgAX/jqzRMmMaaLJZZHZ+Yg1GWzTUxkfUcd31ygyaQt?=
 =?us-ascii?Q?d4QHS1u0rPkI3K0l13ccKlYIVJnZ99IQaZ2Bh1NSSGpEb+6Brjy261G5/tBm?=
 =?us-ascii?Q?aYxYb2SqylCJrb304j//571siziigDIkYOmp4IWWEPvaIFu7MHwXNGryfvXx?=
 =?us-ascii?Q?Xax8w2YZ8dGqKLkRXEI+GBFSfze+WDdMPp60bfOA8R1DyR2wJxM628fKCC0f?=
 =?us-ascii?Q?KwoQcnmhiVlgEYQ9n4KazCxr93oDzOWRw7/ZELfgWvyFtfhvxH1YsDzO1zuQ?=
 =?us-ascii?Q?Lq1Wm+GzpPJLnzOz0L9F3TaY3LvaRkE++kMGbR0AlFKgB5khGV9FFIQBk6gA?=
 =?us-ascii?Q?/Zu8Y3FdAY7Egqpoe+XujG7gFYlPNLc54r84L1csM87yT8mFPMLST?=
X-Microsoft-Antispam-Message-Info: LeRCcSPna3cRsS41E6tFwo2wlMzo/7UhRZBvRsWMBaWa5FIQAsW74Syzx3xjY8ZJ2MSn19j7H8ckN1vQQEKIQCvFJ+eQDSExzaKUCWrsEZ9gIL3pXSfAwJ2rUKULXrTOKgLBmNDgLzp6ttDhz12XG8Kz0zl/nonbQD24RnPD45g8MH0FoqcWeRQSUjcy4cR3
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:RKUc/IzZfi6URd7/rE0uSSz/rk/pgIfR6lNGO6NEDwBDFT36HO75Anrbg0lwEByZhJPDoBR9vS/Rp8NRQwAkOGRrVdlJSS3NKeUESyhokqlK+m3F2k58atmM/UPJ5doOpQ54oTZz6+f5Mfxt5WMQAS5e3ywKTpIiK7O6eMi7dfAyZ+3N4Pobs2m5qOvmuIO+rk50gVbnl/ycZvueNkuruNDRLnvbwvXj/oKMevEOd3XA2P5nBjDpx+jQMKoUg1YW9PiZuVLYfq/D83PKIyDgl0APO0nRuAcxc0QwTV3EtqJq9kgyunM/OQy/BWPus9rEyabuNyfwRu0Q6rsJhMfKHp5GPUxGMulQ9QpHQzEmorb9LLIK6IoJY+JiTLKaUABYaQK4baM5GSjnO0/wWDWgjAQlf2GNeVJflN4Sc49kUBQLK+EPu25cb5jTqb/I8e+sRqXb1D3643zYk8HBoAbJyQ==;5:M3Ic6KNaBfzIhdxWhEaoMFulLARP8fyr2gU8ZRPppCv7DQ+KxwpEohNBiFW2dazAjS0GRBAgY40I3PtKxSU1d295sboA67KlGnX6CLvZ08Z/7FUjbzh7ku232A35WQvQOERsTKNyyvE8Ban4mvhVu2RWKZxhff2fcugFWe7IXBI=;24:RxqHWikXpOA+I+fXY8wv1+CYiNJRv8JrNhnJjWBUwTGw1trMfhTvETp6y75Y825nVK4EQOuPK/83BT+Q9J8gVc1i93MlZrh1y4Msoii9H1U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:ILV4TomBDbb0N3ej6zJoWoPbe27bizqPCz6MEsLd+BM6zOtAhk+Snmh5e46f3mOX2hJvZoNpSICXL8h7WjYo/ynajQQNehSszSg/9C6eMPCf+zPobI++ito0y3nPzm05YVGgmVcHfdobLi9avqqSAuOdgknxqcMzXCBwCsBfhOgiWogV9KJ9+VLaYtwjwFwA0aowqUM8JHDBU9vTLd9c+yfDutKKBttKGa6lA97d4tqs9G3v28rg3i2zRuSQiKN3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:56.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c293060b-8004-4ba9-7cfa-08d5d2a8fc94
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
 drivers/media/dvb-frontends/rtl2830.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index 7bbfe11d11ed..85a8a9c4d020 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -24,9 +24,9 @@ static int rtl2830_bulk_write(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_segment(client->adapter);
 	ret = regmap_bulk_write(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_segment(client->adapter);
 	return ret;
 }
 
@@ -36,9 +36,9 @@ static int rtl2830_update_bits(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_segment(client->adapter);
 	ret = regmap_update_bits(dev->regmap, reg, mask, val);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_segment(client->adapter);
 	return ret;
 }
 
@@ -48,9 +48,9 @@ static int rtl2830_bulk_read(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_segment(client->adapter);
 	ret = regmap_bulk_read(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_segment(client->adapter);
 	return ret;
 }
 
-- 
2.11.0

