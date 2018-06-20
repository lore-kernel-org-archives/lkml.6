Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E7BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810ED20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dxlE7mej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810ED20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeFTFTA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:19:00 -0400
Received: from mail-ve1eur01on0114.outbound.protection.outlook.com ([104.47.1.114]:17318
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753879AbeFTFSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV58Sd8YF+pNU9ABk/utiMotiOqOQ+bGP0pBn0L9C5M=;
 b=dxlE7mejLoyZfoDyaHF+VUONmt/A3nvZL+GU95Ui1g9YBKc4vbS3TI+7klrzaJBZrP5hCSPir4Wi+l3E1V2WWwglWga/rns1Nc0M5Mi57/JuNYl+lHxJsemfRTOfi0IUdCarm29X+JfPt7STLaEGTqelBab8/kCRkPyGhsWCm7w=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:33 +0000
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
Subject: [PATCH v2 04/10] media: af9013: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:57 +0200
Message-Id: <20180620051803.12206-5-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: ff8ce800-54e8-4643-1c6b-08d5d66d45ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:8Q8oRJG6rhuzTrcFW17jBVelo1R6qSqKH8VPEG4acweetib3ZTKNirFc6SrYlj5yV3HYesDKl1PiWVa4uAoRTHj7gqxotxBn7UjuNVBIsB3bP/Kau9HZYr5USE+/iQmiJYdHUabJIokRDkjZbrbabCtSSJDCSqUeJ752EOp5ZQcOKKQJ0LN2VDleOcnhU2SKvCNvmC96AnYKTggvbrOHPe3lHaYrQxlxwiSI+gKkkfHhqdM49ZsSPdOY+PVHNlff;25:57+KS/Audnw3Dk7jWG5vuaKJr1USnobtu5MJa2EBk0RY3Dc79l9CWzXPhEEIibHNQSU4nEqD5fX3oJP7rM7urwjphgDDew1PeTP71p51EUrFKxEh4GoberwW0ZJwtEaSfNp87us+xjxZIUzNJ7rvwbzc9GFJ8dyKpKqAWQNDns/GF+nbXIx7hHRCnlpoNrk6rjbBFTs97teYDjCPQ7xa+3CnkN2urydP95QSzDKCa25WfdmehqG1um8rGQvYNKIJsw1ugXrjjftWQWtAjTSqJwAvcPrJgZU2A5LS9N4GdIUIDVT8I04+2y1xnjsS1VHdjgs3/Th/LhgzWjHqNgov7g==;31:UzUyCYkUWwzUjjsMjCoKci1BK0NdGw1v7I45C9LOeZeihlW4Gm5uvKPz0PXOOjW8fI7NcZj5ziywr+kRsUOp4F40tCsFw7XV076UbeO9s06UdfduLutsOi2J/zZwqDZLz5Y+1AVT0WItecy9H1Ue8pkz8L0ycH2LrsyPO6HcuZvBxI9+6YuCSG9WgNCEDMYzBDw0sKlR1IeruqQivz2OeG0Qi7dNIJ36YI5lzjjOaqw=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24522EC69C48E34264C356C5BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:qwHyw0IdE1UAyBfA3hmrGwbIn7vD6rkQQRoAxAs6mKx6v+XCtwfcqjJfEEOH3eMnMMW3GRna8GEHy/bNh8jmjRtAqRXBGBtLwkj/NeVzdQONFclTMkr2M0wmRhrjEWqpktdxUiLRk971C/6uc6BoIc5lc2eLLA726XJp42N325RFPzLNAcrZydYZ8a/FaZfQhA+wmq5uxCS+czv3Im2y3DpHvBOpBMsaibMqXQHCr9PGE9C1zliPIpQu1gLTRFV/Z69kszwa19tNLgtDbpTwDw==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:b2Zr2FCcAyG3huy6AIg58qGUx/3cnMEfJb7eQoK?=
 =?us-ascii?Q?tbTxNV9Snt61BKfTPOLlSy4c0yn0JAb+HSSXYBkXpCiCHDd3Eiq+U7fCLx8+?=
 =?us-ascii?Q?6hBdOtn06qTIA2OGvPfpgXkAGhNGTb56hXln2CUypE4PsR7zpa8vUq0wlpOx?=
 =?us-ascii?Q?MH+EBQXtfJad9V+ZZc5gQoUCtfqKs9fywSo9IOMXpeQZqryyKRPcbmH0BMDJ?=
 =?us-ascii?Q?86RyG6Ium9B4dIgVwzn9K7AAq97KAjPs7yecH5w3EKfCrbn8ndz7xzzo8WWw?=
 =?us-ascii?Q?8OTBFJMaT0dHw6kP+3VnbqzOux/6HlwTJT9HzVdn+eLJvSyLPKKAMUD8NL7j?=
 =?us-ascii?Q?ttPIgzZbsPt7D9RZMioleWq3YRbXac9aPx+BIZCy4MzFHgeTpUWf2WxYe3DW?=
 =?us-ascii?Q?Nyg0jeASCuq3JeZFCnMVVM9PeSIWvzybUn+YzIaMRZtPNt6VLRpLU+pQJ02z?=
 =?us-ascii?Q?1OeQ0s5LRfOH10nOQvK29A8Z3haCr0UtvKdNaaBCJwApHg3ok4CEzj7XWgbi?=
 =?us-ascii?Q?E8GlhiSQSgJCCGAQvpmAb00F/AXTxl00E+sOzOY7F6o6zhN5H8B59AHxw+fY?=
 =?us-ascii?Q?LsollpEt8l3ZC8TrxPjI3lSAMokyTMN6Q19dGk2McrgFg0gRUeNyMZXopeFO?=
 =?us-ascii?Q?/fghAQh040Te9skxMCMkA8Y6e/ZsTxcEJ3I8gc9jkkCeJA0U2x3cDeXqeKBE?=
 =?us-ascii?Q?t7Py/QGdvjEXDtsLZk+FOWuG2Q6YuLMuyVAIZswmXmETgeL6Mr8oZ/4E4oZX?=
 =?us-ascii?Q?Bp1L34cxE9Xi4V/HzYlpSJEc7g+jGJKw11UxcRHVkYbMCc5hP2jdlEEHxT6O?=
 =?us-ascii?Q?y7QVAEvk/Cv+fRpBaRrRceRDhnofGWLYCyA1PViyEv0BwJZUYdluM4jyahTd?=
 =?us-ascii?Q?Mr9kN2WHb6Adkh/2bmoyugEI1eHlIQieI48XEYqJN91YPEWmBokF+azmo8Tj?=
 =?us-ascii?Q?+PG/1Imo7O7dapW6/rwOW8ytKfmFIgY80Q3H7D5ZsqfGhbVQvEMgxu7rDO4T?=
 =?us-ascii?Q?zDaDZA+IBbkzGKGMlqmjuDAyc9UxCny4UMWbdtNjDbwBRbJJAdHZ3FuW64sd?=
 =?us-ascii?Q?bTZ9t9h9WT4jqYZvXFcXAj7RK+JFpp6yYYlOQr5bePhrRMoq3z3UwrgehDtF?=
 =?us-ascii?Q?nyoR1vfPgE/mtSBPLAP8cNYOh5ggleNv9aJKGX6ZD00Yce5x4Xe0f74nAMDi?=
 =?us-ascii?Q?gl8dnd5ayaNCitGKKN5p2jFe695sD5f4kDcsmRt/3g7rs4ECBdtu87KFxPlP?=
 =?us-ascii?Q?ZWE5UQrb9UTc0AjwvL6FwLmdpaIjdBblPxJ690/YQqwJcjDEOBQhaXNu28p7?=
 =?us-ascii?Q?2+GaSA+er7J0D+h3GOXmqAJ6PhU/z+ZI2HnnmzUQT1wHnu10QTRmH/oeKz+g?=
 =?us-ascii?Q?/I88am1sAHr7ojDQwA+xUcnockeITmPg9aNUY/6NVua26VoUzoSnnZsI+Mzf?=
 =?us-ascii?Q?MHrC7Xnc38sFFqNnmUzPr7+r6uDemwg3sYB/UyvMywC6jOcbp05ea?=
X-Microsoft-Antispam-Message-Info: W4EY5PxFkyTMJOwrHTs3jTIYudcjHCG2sSJbtd6KTQIvPC3AryBTzPXxjA8sAknbsDFj3oku1gdaPmQuThsiV5cGPaZqeVLmJtcVuK4xJeIvOgL8SMgQZMXfda7ec30P0T161RSweL5sBYKBPbe+PBz8MxvNcJmCyfVaPSwA2La9wMJU+PsyRYswLmTLCa/WUzt533+b7EhFX3iit2pRmt0K0FvanyceFy7DnC5O9fWQ3S0l2cHLZq7zHQcVCUmjJMGKjP0kLLhEZV+KYwST+FkE6ejt9sc73mfIqff8XSmTEtcNwiAFsZ+OWMvS38jJAiwI0vw2noDhEn7be+ZsSw==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:kH1mX1nrbAA2L0D+TmUgdq6qBCqpdPZ8b+FqOo+51/YQdUxgNFaV0s9zSgw1thDPdWgTKjOj7izako2cwmpYfGf1SJP6Ch4YKDturIkMt6oZmgojd4Z34H0ZrE3ybV9hVrsgVBRb5uZr9nbfaFObqg9obP+6DcPOwtoGcSvkcyc40ehOqS5/NmSA0zTwicvSVqD4EWdhIiWsMJgsFDGMF1aaNBh5T5/mXX18YC+bee7Ufz3t7YbveUXFrNLu0M2mni9GGMhjGrpCcP8p8QD2rUg1BNKl60kreKhK690DOm9ZkrxQiX+nNhKeDph9KVegjSUCUZgsVXl7fULoSiGx75DZvurrOtDvaUXOSZDXLl+CQJIXLgxZj64n1Q2nZ4jeQ/ZgrgTL47hEdze8a8epldCPwZTKzt9jSotGojTCWnK2TyZsDcHqcQyeog4BhH3xNYk9sOCQDIl0uiMcBEPd2w==;5:O2DbC9n0WAFxurqA6aaDJPHXuss1isWA11y8B73mEbDHJLjN8VyUXUOPI8du5iYFBau5UbcWXozzeuLjDPRl+UNKvkB67aK0np9NQ4bzPSyjPRx7GMiycz1QgYZvX15sRl3Xt1qb/b0ty3nL796xfQUHEJTBK4Oh2vEAXgKPMxc=;24:UU/SsZVbJvEpIr7EEDO8O5I/85tf3eQFV+292c/L4hs/CvgR1ys8Jru6npD9jMKtp2uZiEqHUbcxjQrVvFPzQAjXInnU8jWL/H4Ku+3G+Ts=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:U8CwjjM00X5u9zOeBdz1b0ZVP1aD0oc3Hzcw8yUpOlP4xh0HXuh1MirVMzsBlrPpEdwBo+dYunxN8XKGARaw5ET69PQESBHwArJ1ous7GQqUg9Wa5h9f0zPkXKVKBf+BmYc1NjUOOa7sX2nhUCVMZ9xIZToa1Sx8ACdyQv4jJe8QPGgNcTX1uVVz9qr8FvcmXd+W6c6xTErzHcpSk8OX0N4cz+QtcffIw5o2qKsy/OMORywgWf5CmmomimxbGKNK
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:33.0608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8ce800-54e8-4643-1c6b-08d5d66d45ad
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
 drivers/media/dvb-frontends/af9013.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/af9013.c b/drivers/media/dvb-frontends/af9013.c
index 482bce49819a..99361c113bca 100644
--- a/drivers/media/dvb-frontends/af9013.c
+++ b/drivers/media/dvb-frontends/af9013.c
@@ -1312,10 +1312,10 @@ static int af9013_wregs(struct i2c_client *client, u8 cmd, u16 reg,
 	memcpy(&buf[3], val, len);
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 1);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 1) {
@@ -1353,10 +1353,10 @@ static int af9013_rregs(struct i2c_client *client, u8 cmd, u16 reg,
 	buf[2] = cmd;
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 2);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 2) {
-- 
2.11.0

