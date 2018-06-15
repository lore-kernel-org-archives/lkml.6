Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1A9FEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06B3208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TiR/avjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06B3208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965681AbeFOKQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:16:01 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:10720
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936211AbeFOKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGU8WFBhUhsff8FOX5vttUSdBg83EEXhQBgkmD4dy50=;
 b=TiR/avjp2tR7x7DwJjk/0V54tAhkqTAxott9pT4syzJD7ZYX3jJHEi5USke5WvUKhyCbw1sCLr3MVFiQXRh7BVasqnIfStZqDxNJQQSRrLtg8LuLMXBME0TcuOkF3HUrUG59ZK8ZqxMdJKK9p46gwY3eC1bHBq/vwxlL4oEa4SQ=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:50 +0000
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
Subject: [PATCH 05/11] media: af9013: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:00 +0200
Message-Id: <20180615101506.8012-6-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 99ac3f9c-f48c-4b50-ad54-08d5d2a8f895
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:3qMtuMxjZfdupnPSMBf8e0NFPRda/52XBAfYCx3Pg08RETTrScbnjuXNIRLv09k0Oj8Hpw9eDgfX3hTz5zqRKihD1/rss4SGrbKZWEhNfXxpQNnG0Hy9uPcaTpNAWLitOHq3669T9jtXDlxNBKGQEkMYYFEYsJDLOw1AKYw1hlxe6PkM+/hZ0UiWefTUw1x4O9bxCkAg8FBln5BqUOPBmpKn1Y1sInq+alfWZRpsqWnScJO1c30qkVFLM/4cgwgY;25:gr2UTwNUG3dxrB7ZS198zsK5Plap/A0/IoBhcX943og1kqvBGG0IruyrN15+WjufIv4wReMLvZVLaG+1UPTkFHAuypkfEzpOlgSnhOui9Cj1Lr+bXt358xuHmUa2dYQjx79geB988IagCI+VkoBIR1chtytYTCpQ7/BJnCdIXyZ8GSyfFGP5CmKv6S5QwhRMiZJ/NhcDE05uFqdEY7F8+XWEJX6rXex2YloIeYKeA8BDHOT8gBJpkqV0WV6SJjWaDYRVroewAlHWdHtm5V5abXtLyvCWhlk4Q49ZT+fONi8vvACvcHWgWwlxzqrW+cEZpyhaYloN2W3wI35B5GxWVw==;31:aEN0WhhCXdmAtTlCDPOhbevyXt7nUBNDCcYaVKkMvBGH046RlFwweCbFms2dfJBaKXQIVAfFXOaZ3RgDTVfTebWQdpFS4QN+YGAOVgGk038VCgkaXJXIsxwRrZaZ1H+8YW6V2p83QEQ9oAh0pVEzdbZnS7grdQkyjvEj4gj4xoRUCHNkAaGae1Zpb16lhq6bK9LiUhDd4Atvqrx5kJAp1JV8Gn33gEbepz1SGPOgllE=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460126098554CE908620FE1BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:5KtftxqGeBhkZUjYnSiQGSpKvP/suZ6/g3YZPJlXWRzKNs5I6tNnwpd0g5EXzPusE7oNaMEgrXO+D0p/MV9Ch/5bkcDOV0vnISGtxS8hy/UVNu3Ei2vK1Iluyy7ge/eMB0IMDZHD3PcvI8gOz/7S3jbHLECW+8CHOR3JAnTG1ifR5ZC8czbMEDrIJq4zik5inJAtCCCuhLlFmFrO27hybj/PkC8Qd3SpJSwfHRhS3Zp0caiT5b8JYbgwXP4h2lgTlVz4B246tFatrFtC50Rlhg==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:rHaBjBbp7Sw5gyv9AM78NQTOWmWi7jWNrmTXwXs?=
 =?us-ascii?Q?JMMS24otRyrac/GfyJdkmWBgZnp27QCAqsvo9hHKIVKixK602wmN4qTXrzoX?=
 =?us-ascii?Q?tw+hT74Jig8tcwTPUOBYaysGA2xH/i1pHpp1PfxY5lZNyFpLX5KBEIa7NQS6?=
 =?us-ascii?Q?htQT595owO4QiA95x9QL14BXSL/shr9F9USBkAKOhmLNBHlYznCVb1poyPUS?=
 =?us-ascii?Q?/Boc6d4MxczSbbT+fW38VWjvvN/h34pW14gh+snHqjp4UDh88q67197NEFJc?=
 =?us-ascii?Q?E3y5QEIV4lW8tSgizJEpwSpwAu1g8EX2Nh+L2rTLA0bGapdbxqZfNyVFavHK?=
 =?us-ascii?Q?mc5i1TtL6sWBnLjFqKTSlJMx6GZQL4BcISHT8xAn6/sZWU98b2w27U+DKapl?=
 =?us-ascii?Q?VbG9D4T+H673EwDbvVrGruamUuKqgTnorYzB9EeagNjwT7r33UONglmQmdOo?=
 =?us-ascii?Q?j5x3IoMM+PJQonukXcOwv2+8cOW+pPZ2QTsS2//clvM6IhYn56bQn+WTDwCR?=
 =?us-ascii?Q?Vv1FtdmFv/dydQBjjUSjCyVtcszD8G9tmqXATVYjG+ZO7L/qETr1ctSwM1yV?=
 =?us-ascii?Q?2+ySlOp3UYAt2gx/l5stC3iHXbU/Ygx5Yau+X7ASm2Vw3uM5XTmXdXMNHRVv?=
 =?us-ascii?Q?pmnI88jeSyGw3b1cFTdbP7PstIwXkn41kkTjXRgxkICx9C74NyCsENGf5GDD?=
 =?us-ascii?Q?Zi2piTN02ff0K4ZK7L8pHEG9uzKcrwCOcCL7xWB6oIMpU4T/n+0/Jh5Vqsjl?=
 =?us-ascii?Q?cgSmsMIa910J2l6vTXaHGsqQNR4HSnxJRqOtHvMKHFqjj0omWxWlvOuViwc9?=
 =?us-ascii?Q?Thgj6KUZT+00mONqw3NZVnpdoXVpYN3PUnp4jch3Mmn4TShKnOAu+WmTlU7C?=
 =?us-ascii?Q?JhXnx+QDrmDTF1V0g4WzW9qFmYoFk/98oh4y2NQ5dQcRf/Kxzvf5atWQ0OmH?=
 =?us-ascii?Q?9esfgoU1BSqSAEpWvZdawn7dUyVKiL1le32GQONU/uqzLWnl3Y+smhVoxU7z?=
 =?us-ascii?Q?tXZBq8r7wY5KxxBmVFfHM8vbAILmz4sZOXDDRDt81NZcpi0OIkG3MeVitpnS?=
 =?us-ascii?Q?Na7JVpKBJoH5G9Wt2Cj5pnydnmC2Buv0TcdX9dSJl750BEwNvsT3N3HBpIYL?=
 =?us-ascii?Q?gjTc3KhZg4Og7kynveAULmlxWh2QVJEnsMfSWeAnAR9e8cZ6d8qYs7758MiY?=
 =?us-ascii?Q?SwCDIk1BNGX2pOEVWhSYs6MzbpBH8nZ5Jjk93O2lgRvOVWxnHAQIJOBSaoa0?=
 =?us-ascii?Q?3hf5mztJCs1wuv+RQj96/+kq6s2luNfGUG/uVvsGZEK7lHNVHttj3nn/uo53?=
 =?us-ascii?Q?G7yiPlwYGVF7cwE8touWt2TkKKKMi7rsdTYZ+K1QWRV54faalQzKp3JKoggL?=
 =?us-ascii?Q?y6rIwq0nAbXCsvY1uh5iX4omDXv2DmswbDGsCrWwV9LiHo3cciQ15eP9PlZP?=
 =?us-ascii?Q?3ByrGrffty3jVAjdCGrEEzM6LC/g7u4VVSO8BpC75lPaRvLI5xgYm?=
X-Microsoft-Antispam-Message-Info: ++JoVKrK0ArCTL8kT78nj/SuTyo1zBYcXqZOK9zu+BCQSvdH2eNMv/bhYxzQrmWqywS+mheasW2zff4RrGQOI2Zqu7GGwc6frl7RdYaTsT2cHlQyaeOV/UDvzRdvCDM35fldI99h/VaajSXcyQhMfDTqMqSfOXs/EjM1BkMmzVISwyszNf0z2CNX39eDs1Y/
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:LRrkaJBFmPeKPt+O7pbL8XFami3hIm/UkjmKwJrd7zDM3RDW3Oxy2p90fLRxJVLHeQotQsvcjr0KaZHE7WY6YSfBiPUN5OKiCKTGybV6m5jM+5vKXXuaMRjaxEUZgheSbQNsicz2OFldEy1X+lINwBMODagphSxhG63El7G1ictHc4Uuvj8zcRzwBg1CJpwoOijc3pr8FDmDv7cRmNfvLb7LkM61u31FpBagz8Jkfk4oeeza4p+dwapYZfqyKcVAaxVGfapzP9A6Z8C8po3pELbUa77NQiyprbiBHvdSyQN3Lje1F/hYfsfXZSArhZdvHfloUagw9xYEbuUQ+qr3GoaUzul+oksHe2giNB6s9fd/cJ7gyUEwnCmckVF/RiLEnNKcTYyHsMUoohpzwTmCIeLLgH1aq54+MzUAnKiDIDLNxgMg3sN5K1BDNEFPTKJsrDhy8CV/JGMhLjmw4xMyRw==;5:/ItC/L4GmTIA0eKWjQ498XMUiWRzvK2TyYp24J55/mqlyFuWvOvEvDsWvvAVmwadjvyyb4URUdpskzfJfpYLkrahXagMDhpAy3vPTi22unJVmYA9N4trJoZybZGISkqLS8BHmyEJujAzHW3FtXjbya5oIhCQQd66B2Oe617Za7o=;24:Up7mYSd6dXcBN7m0aZkFCyI0AT9/TBfR5FnlvHr5OneXSYECWH2hufH05gmhZxeDbZXlewKWj07nHOu0aOoEYj6nK8wIcoM1IDQJi1D9WRU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:eV7shTdiKOLdSwxbrVPrDtCswkHwgTh7ZjSmBIIxs+qGCncO9SVYYQ8NJnQDlvfbIQFFPbXYAVgwlKkkIfrLMjLHPSmRs8f9aw9iQJNyg1UX1nmBwNmrmrwsxyoG4qCYPnHk6WoD98oY9aHL8RRHHm6mBsH0VqV2jF+lx4neEGdx56LDg0o/tpZFSEBgoBjdSJwzweAU8Ojwc0qnwwNcXSqza+Au6gPToCUgSnOZLouotypVq7LZb2ovC1rlb9Mv
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:50.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ac3f9c-f48c-4b50-ad54-08d5d2a8f895
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
 drivers/media/dvb-frontends/af9013.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/af9013.c b/drivers/media/dvb-frontends/af9013.c
index 482bce49819a..a504697ff557 100644
--- a/drivers/media/dvb-frontends/af9013.c
+++ b/drivers/media/dvb-frontends/af9013.c
@@ -1312,10 +1312,10 @@ static int af9013_wregs(struct i2c_client *client, u8 cmd, u16 reg,
 	memcpy(&buf[3], val, len);
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_segment(client->adapter);
 	ret = __i2c_transfer(client->adapter, msg, 1);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_segment(client->adapter);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 1) {
@@ -1353,10 +1353,10 @@ static int af9013_rregs(struct i2c_client *client, u8 cmd, u16 reg,
 	buf[2] = cmd;
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_segment(client->adapter);
 	ret = __i2c_transfer(client->adapter, msg, 2);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_segment(client->adapter);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 2) {
-- 
2.11.0

