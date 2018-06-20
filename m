Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9BC20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="qfkYDm7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9BC20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeFTFSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:18:53 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:31456
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754050AbeFTFSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQCSNQL/37dY3ejcySXVopWlAnzUddsyuB4HyPiR5Os=;
 b=qfkYDm7EMlSrWTYPKsnLThga4I+sJu8VM2fMu2aIhjO4ixPbzuaWlJADNF01RsapQ7lUyo4oam98SLCADezWjUshhXNu08wCHa9qtsuMwIG8OejorOknQX8nnJz3RRHQN5eYNwMJj5tIp6hBJdtwYNsziRWnVZ4joeDnrp7bZNI=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:27 +0000
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
Subject: [PATCH v2 03/10] input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:56 +0200
Message-Id: <20180620051803.12206-4-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: c4bd7941-c7bb-48a5-e3c2-08d5d66d42a3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:kQoNo0PSavTSlbSpdGyzquXjxWDc/DTPgx+y6F0XmECRoDIIhkscbU4dNt7mtiZw6eh71RTov+Q4tDKTo8L2MqfboNJq9kKpfNVcbb54V47YHWtEbm2wrTYsJ9xCGrkTQxhJrPIjNIk4Ygc2uAJKhOeCIqhF1dfDc3SwWtdpaFfoFyOjBHksV9gHJyz/Xt+uhFpDfTBKu2yBq5ukMfdjJLU2B2AIl0pxIDZ3g/01eVjnqtqjU17yL4s5cCe3YA2W;25:u2S6Nus8pccKsbxxFdPMHEh9ymRzov1FDbOlZdW/Z8q2RnPSHnYzjOkhkLaZaNRBqcInYbn9vHeAeiCMWBWTaJeUdeu5saUAwcQk6drzKPZynl9465Jr6YsXeocNOW76uSQUkArHFGQNup2t4/xU2cW+FZ0LX5Zbq/YBB27fPqgkOapo8lA8h9TFFPsiWxBE5bASwQ0BPMp79I1Fj9KGQFD0eaVBZe7cIxsAh7bCwkZZ8h1UIM38FmnldAk9tdZl4l/09OgQ05wOpFbayKZONjKoSalFTNQKsFiXedCO4Gk2N3ts12LKwwb9DCbZHjglVKTFv6A4di1DC3zMo6uMeA==;31:yY47wniyxLDS/AeKjgFkyPRVUaXoGlDx6iX3LzQQYHbC408wtcL87L5s04A3J6BsZEQmohQWgzM6RURtpKTGw5jaHe7s56ufV8tRA3hd+1qAxTHDesFUdzZEMR+O9uM03ikn4TCOHFaQM/EXY8NOANpqR5VnZ8HSi76AutkWHUWwULprN6QTth3YmWnbuRz6BmqT+R62SVfRiIcQWMQmRPh3qWESQF4vtt8dPDcGt6I=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452372E5A247C5AA174274ABC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:dtKrfwPpMR13RZzl0/mjhlQ2hA+cllRetuJt1LgqrUe3Ks0Vy4lOHvxiQ+KgPFvuIXE+mFN1nwPyq+NCEteSF8EvFbmnwxBWJlRyO8KVNTXYWvNyObA9u4yMKTbqKfl/oEnLSjiozeijrZPAbg5l8PTzL8C3fw4uX4QPq6ChyijqjQzb8mLBGmAJCLpRoZRUIhq7FJez8SN09n0USr+9hjKCH3CVS2mxzIM1UXu2ZkdIi7CE+ibYUSR3k0LuwIDjB899bfbL0tXPzidUnz5haw==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:8PPR58CYxl2Pk3Aa4eaDKjEzysT6Yu7JtQmzehO?=
 =?us-ascii?Q?9zoslype1oOFiBp+WagfqrKGqPBT+Z7muYgqKe/OSGLMSgWNUBCrEAg51cUn?=
 =?us-ascii?Q?MkfeVrqmZ22BiqkoiaBWW7VSFz1DZuvP8FxIY99RLgR7htVoWk4TJB78Htr+?=
 =?us-ascii?Q?SWbxP8rqJ7XNZRWqjC2zJoa6FFq/WUMZyro50OxPBT5TcQCwjEuRU6qNMi/T?=
 =?us-ascii?Q?LNNBI/F6l8jig8/2XCq4CYoz+wzC4lVUee2+39upFYvLHAb8DShggcZiURUr?=
 =?us-ascii?Q?wWyihPuwKYbWKHFbmuH8nlEx9XRLmkyMdiz2VBQCwvKwmjkfdSv6bAt8l0+p?=
 =?us-ascii?Q?m/qY/2qVYS4ivmO1ry0d+FyQaJxDD7oIVnPsic4QisyYYGn+koEtMQHZywVS?=
 =?us-ascii?Q?W90OVkUYO8UEDQAlmbqUrlyGB46cmQg/JiRbybQt5o3V2+rTTCmVirxCBN/i?=
 =?us-ascii?Q?R0LLP7Mpli3r68u7ZnMF9IG0/XkP1NjdsaE2PmN0vqLTmc5Ye02ECofQrsH7?=
 =?us-ascii?Q?g5KlCW8lwYEfFOxKywTFEvauYOaggxaq+muuOmPxDsmISWOzIKtfb9SnnHvT?=
 =?us-ascii?Q?V++MNNcZp85tfF7ZCrFDLzwb4wY2cGMgH8Q6G7V0r7eAt0NpDV2C1dSXRrxF?=
 =?us-ascii?Q?G7rlva3PvkyKlMkYzozSTgSBoLdpIjeXbZ5SG69wVljV3fnCmqOlykur54Dl?=
 =?us-ascii?Q?vaFd9TJIqa0Aby5aXDabWv0vwKHB0/gacwd3k4zPG2/jQH4Cktqmuoj+DDxy?=
 =?us-ascii?Q?02A+A9qe16HshK5w2FC+pvs2zzPGns05HKmcej76031x30wuIhVOH3HGbcit?=
 =?us-ascii?Q?DQUH38bmLYOGzY5hhutPf9j6L3KPm4/+qJJgq52OH6e/GtDY1orgCRFOYNPE?=
 =?us-ascii?Q?aKLe5bpPJWZ9iIXs6lqpPLppEXtPHED1xyRzeyROph2wmh18b9WOCHvhT5Ns?=
 =?us-ascii?Q?tDJgyYjzQ0aWqDB2hvijhdWmXpQBVTK7nb8Yu3zfutioX4TpRXmJzcOTi8ZX?=
 =?us-ascii?Q?BeXZMviPJTMuSQkEUOfQwrSgN2aRkeMbGdiGSelEKifY00W18Z8dlslr+Y4t?=
 =?us-ascii?Q?/yKOFkVS8Zk36dl28l9MMJxHCfMD69QToNheo7ZW3GXBh3AuMm36EKLS7wuC?=
 =?us-ascii?Q?Pe0ez0VsSERsCzqwJezRdQ7L3j1ittzPyiKGVVlsN3ofvMeY31MYvvKu4/85?=
 =?us-ascii?Q?86QM09OQSJU5eUOzE9YmTIlxnXGFOfmFP0TBBLRvpb4r1MoO9sPCOuLPlqat?=
 =?us-ascii?Q?hvReVhIOCN9zkZmfXZaqMdkKKiiDi55jnXoHmRDJnzBgfbfau/Hq6w7Ddw5p?=
 =?us-ascii?Q?PWe1SiHTM+kIMriF7Lla40j+RPFnVs0rMECZOZqUskJ2b5ibLR9Mj+suc9Cf?=
 =?us-ascii?Q?/WE2zhMxGTxnnTacQSagCp5wddc/nlKDnMSnCtJIQMR2Y2rsf+ZHCdCqMPU5?=
 =?us-ascii?Q?NJwzU0rAaAhVX8Bqduht30w/lSY7TbLw=3D?=
X-Microsoft-Antispam-Message-Info: F3aOupz9g4ogVdmEFgiohAhhaNc1hxCK+YOxBi5nFFKYSDnvn4WBRhR6+NsZLbeImabobCYAb0F2iNNu6jvRgLB9Xy2F4qFhMvYEHV98CLLp9bDZXSL2Et9hPby7dmJrbVOeNY6WRBge/9QYmy+SjPdHRlB45gNpo2GQ/fXmFvKPtSX1sL9Bf5O5Ga1/EfOL17iMhNsnug3nEwj0FIzbhedMSoFNa2E2XtihjYqfUfKXiNTEgajPPTzz+rkmDCwcMBuGcsu1RQtoO9putDhL6huY1lGcfuEGL/sCwLJwtAztTZNRoSphc5rRPpI89TmS4gMIr5VOJfQpVGEV0kNweg==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:RX4qBzsup9zDZavxnABls7iodhN4b+mwHgacoJ8siazaQZuSrnfkAr8o/dWhsgDTitxAcEaeOH+GnJkTT0Kf/sebhq/nWyxE7FbTB84JXOtgVVq0k83862pKhlxWQIu3x55w47yV52jNsL7GGN0GO9VU0YzJHrPUYdrbV4VeZWSN1/7RN2YFUSjkFeuJ4Pdf0DEZE9OL0PbGfFozUnaMgMVLttqEpmYG8ytkeYYbXjocMEZdcCIT0ad2EaU0eIicyHL1H8ddS0n/PlgyBMwylbbVV4WUYof4bpsE0xm7H9Qx30+vjythnoShrf8J+hAJ3J68PpSCkCE90JIrJWPO7NM+7obBIwM25itYjM7TviljcqTXw5Vz3CL8933k2VdvKzp+zPpeS/bCXZpjzIVOqTNA6iUVvog1iLB0YPuJtp+tKToLWQ/oN77kcGf+IX8yrvdAPQBLpt5fOe59pVu/4Q==;5:nIak8/4ZOpERk92LAOvVJYyxizzorb+3zqyUUnUtxDVkSSvuEmvCaNAF6w10c/gMslLeWKUz2wYV8y4HhEIaZWtDUmPCM+kiD8Dxhb+CO8cF8Bcxm8FFOKHxh6DrHRgtlfdX1AL9/AlO1LNQLrlyAAb9HeSTmatXKwEpfuJzj1g=;24:eCgGN8jFMIs+L0NI+Vlf4FdEOW+/HzTWXLWlcTb5F1mVzK6SJBlrexQUsIAeodzPNH32ZP4wAEueEop/YUqUUsOw9ND975Z6j/nH3hI3x/E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:uLIjqAZatDGiT9djw/AMGsIdWh789aFubRcLQAq0nVPQ8plhtQorH5LmmdOwfbMRZ7SNibI6V7uo2FS3ZtI2IgVHdbTTOc7lLC3K1Xr4YK5V8+MSOq2ox/p+zkki36eh3rDPnGoXe8NgfVxfy5nwk5PVuXKxIAAv6/MCfI3ST0XWrSIr/N2i0W0NRPWOCuv7HWLq4Qizlomym/TA0ooVQoJ6GwbqZokVgbfZyRzmWokJJqnh/CfddDuylRpWGGg0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:27.9516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bd7941-c7bb-48a5-e3c2-08d5d66d42a3
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
 drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index bda0500c9b57..714affdd742f 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 	msg[1].len = len;
 	msg[1].buf = buf;
 
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 
 	for (i = 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 		}
 	}
 
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	return ret;
 }
-- 
2.11.0

