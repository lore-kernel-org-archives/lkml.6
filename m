Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4747FC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD97C2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZLdIKonK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD97C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeFTFUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:20:01 -0400
Received: from mail-he1eur01on0117.outbound.protection.outlook.com ([104.47.0.117]:35376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932299AbeFTFTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQhH4oEJlacRC/JH/z+qy/sEnv5/nyg2mM+LqMDfgX0=;
 b=ZLdIKonK3A7bD7m6g9HRCLybshknE0Mv81Fp16aW9KMPQ2Z0nDRRj/Yy9Y6sGR6PO//CPvjM/w+EGYQ/pVysWWH0PuwNhN0jGLAqevDUWkpn2ni+NmNwy4my8HCrwkWm5FfwWvj116E4SLroUHkJzng2A3B0kscY3XNh2oRAP0Y=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:19:00 +0000
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
Subject: [PATCH v2 10/10] i2c: remove i2c_lock_adapter and use i2c_lock_bus directly
Date:   Wed, 20 Jun 2018 07:18:03 +0200
Message-Id: <20180620051803.12206-11-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: eb81598e-df08-4416-65bb-08d5d66d55ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:Qb13SE2SLYHgQIkDf6DAU1PGPsLifgWIXa2s5Lcywcb/iveyJwFElX44NsaEvK6zpXGOfmJsDS0Cr5JJk+GsSQw7r7pFfvhPi7Zde3BrfwCq8/jmKGMmdA0OC126x6EU+z7svGnK3SoXs2hNZBikxal/XNzANwI97nS4rKXIp3s7q0U/BVxCp7YhA45on5Gf8K3ufZZdUYOtZFsNvb9rCnRNfWj9Q/YOjYw75eLqYE7Xij0Q22oQx5fteQXeN5Ca;25:V24YSS1Rhg2jgDZllVgcXKjuWUtfifW0jR0T7zAWlzPR2Lql7bVW4mfY5pDNEZcBX5upoGJqnOeiDHajFQ5TZA9p/RaBWuzDQy9fR2in6YHRYm0G+ChXYq7rwV7oBvmWZbemEZUWT1PBjnNuh0VPaarstRO35RAMg5Jo9/rd6Elkty/ZXc+RSdEiTWDKXkepBekrBZjEBPo910TvvIvcWj2Oftr/aqDHb0aTbcIWfV04p3grltzSadwjHBi6d8c05OsAOvjyDG683FvxvSTkYElJKkSDqKL4vw2OWO70QH2QJppG9nO4KxOCkIn4tHIRAAjxnCgKAicnkvlh6ToF1g==;31:OfxgV1g9nBad810qoGFlO11tbrxK1FhZ5Jfz+3WTV0KmjLAJ+ADlU+2wQK9Y4MOMkAdN6g2tXfHYVTdC2Br6yqSMmS3Mti8blsJLSG4zqFVtxZb0tvTPhk89DzOn1CZb21qsyBmO2pD1N5Q6NGQ07vyC2sGUYbDLDTsyBmmpMPcVbf6R3ZjxXhLwROoGc4NOx9Ix7qE6Faw4gm9EUcLKY+PYVKKW++3szwLBEn8BCk4=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452E41B41C58CE972FD4D07BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:2qo48ul+MPhWXzwV2I1fUWFoXd8l1KGAJQwMEj4TqIQwPv9Cq5V+qVx9LvEryEENnkNdFKMoruhBNLbvseBi4qENUPOtWuGsa4uCGKKn4eQ+ybvZhrIW5TfzmDYLTv+UG+Zqx9kQWsZ9Nx3m02WKYODqGCHqNXbg6Lmq33dx8ilLMmWO6haKRtabBHJLVcIjY0Jj2/aQPpTrqUlMYxpFMNEptNU9hAaUZtcXLAISsWqFziCKRT7/2BvDK5+RtufBrUT72NGr/7bO9XH7shfxBg==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:NmXE/eVgYjSrVQm5X6S4m45FV5D44X+L9ON8XB7?=
 =?us-ascii?Q?Z1YM/IMdngN4DQjF8131PI2DG3DIfw1w8uTMrMi94HvwOccnNaYSfVhe2Dus?=
 =?us-ascii?Q?3F5WzLSQ/dLTBJ+Dlgmnq1RfW0PYGYs/Go5LLQgye705WhTcTcMnN8AKHu/Z?=
 =?us-ascii?Q?095jiNbAyucAmYJq+QyNfdJvXPbD8EObP1whvy0EsrcBpX9XKzzX1quA9iOL?=
 =?us-ascii?Q?ZzaxdIq2CVYR8PSYsW48wPn/0jPUXgFiaGokqnitAiin5Bu/WX0r5plOUQ/Z?=
 =?us-ascii?Q?XSdNfUjqM1Q4moipW9/qKSnKlOK4L+LGK7Bh/sO/TINoRl3zQzRhlJMAE9uV?=
 =?us-ascii?Q?3Y9bojbdi6j69zcahA8WMw6/g1halZEQMIqxVjxOR8nFebZDz0hLwqPBf7I4?=
 =?us-ascii?Q?8zPhQa+5ffeCGJQUq0xHg/CxRmK2PTY52INgkA91cTjoO5fklPGjxMNfrdnK?=
 =?us-ascii?Q?Q8hODTlZCseW7eYng+/3GcsZ/hZQSdDHLSWOz2FE/oy3/uCObt7E2EoUp8/q?=
 =?us-ascii?Q?wEulZMEWWZe9Gk2JRGLekZ9/Bv0gxa9MRYErv7eUixRRZ4o+K7lZFjHpJHMP?=
 =?us-ascii?Q?V5qtj1MEYoj7ZdehIXJcZB93U2U4w3hxMLyCQm2M4U0ANHKVnXoGYYWkBJJ1?=
 =?us-ascii?Q?G4FCCnoSH0QyNr5mDlSMA3w/Sgf+B+G2GR0B/WW1zA1b+4mLJqPGwsp0xOwa?=
 =?us-ascii?Q?lp6ZLwjUQX2GHjFwTICE0J/NqdWJbamkAgjqcnvXemZKt7oycWJTZZsRZSL4?=
 =?us-ascii?Q?v/5HoT+CIO0HDCg8+ZqXzjFcWG2hN4yhnh8gw1DJI8Qp794yJeCk0fFiFXDe?=
 =?us-ascii?Q?gHrB51ImhHqY68XeXUt+o0uE9kFCQQiSo/adFYLOr7KiBDH9hJW616ATiGua?=
 =?us-ascii?Q?p7U2X27ExCKXjor7t5oJ7wpQib229fWJHRDDI8XGrZKNrN85LChqCbsXOh6F?=
 =?us-ascii?Q?uU8xMDx78rwD1Ymd+RpKnV5slX+0h4Y1K58i5I8O9XK9lmwFWrfY0ddaSIeu?=
 =?us-ascii?Q?pHTLYMlrEvgCTqkdatzsEszm4YFiiB+vraKGdzW2eIyAitx0nIF9cd1iwpPJ?=
 =?us-ascii?Q?hOTY7pdqUUSr4fYXJwm00EcrzHWXAz5QJY7tG/4MUMT8PpV6zL2b0IKT8DPP?=
 =?us-ascii?Q?4RG78v3A7L7asCMVuSc+zbH8GmmcbC/7SAd+7vSrjq3cqBc0SIrjkbQut47y?=
 =?us-ascii?Q?I5CsV3ClEHavBifG4vk6+Ni0Tv3ueQXDGuXtt+xvZC4emNkKgr3xKiJ8s8HS?=
 =?us-ascii?Q?vjMBUjAYxv7fxNLzqTmqOyOEjgVCGMiRnrfaBqVwbiEgL5Mdp5DYykIvpoGr?=
 =?us-ascii?Q?iklywUe0NmKRSbYpUVZvcwdDXzKX0JMxOR/zlJ9hR5amFp95PbTBDSdb1sXV?=
 =?us-ascii?Q?fDoZQcrQqlT73VJ4sqCRyQwanrTarEhRVyMnh1UutN+9/aSUNr1oFh70hw6I?=
 =?us-ascii?Q?jQ/DsjxlZ52XOGxZqQUWYNjtaoK0P+o4=3D?=
X-Microsoft-Antispam-Message-Info: RBUpt/PlSbqQx+zrYT6F/hWpIZNPqabzBKXxus6I4F57Rj/bJo6qELBtDYCQlQ6lzQ7DZsfTjS4K2S4pNwjVkCIeUkfrBUTYNJiGV2ky90zZiwS/EzZSKOSurjRx8yAX1Lu0/nsq9mjFyNew8kGtXteAK5DG9SShnAMf0g7i95QTNpSVfoqyo9S8dHU646Z4qYf2lVhGq24ocRgt4CCRCM2+8bKaMyUh9iZIOHtAVjjHxV6KiUy+QeGuFPKfYef2atsJNUno6A1teHzB0KHLKdjXB/X0S4k3zra8ORTDos0svLLBSyXS+2DyqNRLNm8fIjxyl8k2sKENkC85I3EpHQ==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:QVagM9KgDUnIfYft0tWYywkQA4zkPEp5DA5BqTZdR0N+B050OklU6pmBYsgGcrYiHGOdfurZLgbC10puU0bOv2tQbC5sWRPzAKCxjEu9LbW5EWJ9aQmlGO9Wo/cH/M9NG0uJYOahlhW24/9qYT0h3oVW9i3GlOyitnKz+LQ6l45QF5vtsV9BUbzNM/FDfFZ+/LPDZp3I7Om9KAS4CVzuKFNbsX1OqgfO7ixNVwAa0TgBJemFiO+XJhOieh5oAqFKkc9JCmZKyYb/b+MODITvJs23SN+YxHWQM77jJcebOuWUHeD5mKk/w6HRXaurvtREp0xHgsYx8hcL70MAiMNfjDCbjKIVsVE1VvyVwULoxqENKsJq0WVq90zv/n1eNlRDrI0lssZosczrJK3qPLg6SLwk7l5u0hI4Zv38JcOxbC5hBPSH58+p6qf/n4IZ5Oy0gy8VuKWUswzUnf0YF1KuCA==;5:SJQWzhTRb0LyacVEPWc8w3jepcpTVPwrHK19O5nRBI5RJSY/33WE1Iapzou2lT7iRw6368C7S/MquwLjixmwd2+AoWwuQDvcnGer9c/bIY+72HevGPfBsDPnba86RMiqffl1QQrUJZ/HahbU3PwuVbBMf2+Ba2cJzKOUDGUcGag=;24:PJyMsUuJIHq9j0uOOsZaCCqMLRuH/MZa3UU/aQLJ+Le8s3X55QJOI+V9tP4IU/wmRfhX/Z8kJwxQbiktNLYv4HyahqNcx3EpBFLlwWFBv84=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:qeAKKvtez+wojorVVlbRvW52SfZY2SocDVj0PcuemlobThMlAakwtgnOGn7lq0i/MI60kr/lFq2f836c1NiICIBWyfYr5LujmfLu4xbasHaGuLG/N/cUHNTLYTSv3UFzqer3B/xBodUgdCzw2ooLdbJ7oRGr4PovcjDdYhS0VdwhOK143cTltsL7yisLTLZFGFjneYhapdyaSXNRFgF7tU9FJU4sfnIsWiUx1mqSqhkFOcRvuGTAPZk9yCiuekql
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:19:00.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb81598e-df08-4416-65bb-08d5d66d55ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_lock_adapter name is ambiguous since it is unclear if it
refers to the root adapter or the adapter you name in the argument.
The natural interpretation is the adapter you name in the argument,
but there are historical reasons for that not being the case; it
in fact locks the root adapter. Just remove the function and force
users to spell out the I2C_LOCK_ROOT_ADAPTER name to indicate what
is really going on. Also remove i2c_unlock_adapter, of course.

This patch was generated with

git grep -l 'i2c_\(un\)\?lock_adapter' \
| xargs sed -i 's/i2c_\(un\)\?lock_adapter(\([^)]*\))/'\
'i2c_\1lock_bus(\2, I2C_LOCK_ROOT_ADAPTER)/g'

followed by white-space touch-up.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-brcmstb.c   |  8 ++++----
 drivers/i2c/busses/i2c-davinci.c   |  4 ++--
 drivers/i2c/busses/i2c-gpio.c      | 40 +++++++++++++++++++-------------------
 drivers/i2c/busses/i2c-s3c2410.c   |  4 ++--
 drivers/i2c/busses/i2c-sprd.c      |  8 ++++----
 drivers/i2c/i2c-core-slave.c       |  8 ++++----
 drivers/iio/temperature/mlx90614.c |  4 ++--
 include/linux/i2c.h                | 12 ------------
 8 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 78792b4d6437..826d32049996 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -689,9 +689,9 @@ static int brcmstb_i2c_suspend(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	return 0;
 }
@@ -700,10 +700,10 @@ static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
 	i2c_dev->is_suspended = false;
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 75d6ab177055..d945a2654c2f 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -714,14 +714,14 @@ static int i2c_davinci_cpufreq_transition(struct notifier_block *nb,
 
 	dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
 
-	i2c_lock_adapter(&dev->adapter);
+	i2c_lock_bus(&dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	if (val == CPUFREQ_PRECHANGE) {
 		davinci_i2c_reset_ctrl(dev, 0);
 	} else if (val == CPUFREQ_POSTCHANGE) {
 		i2c_davinci_calc_clk_dividers(dev);
 		davinci_i2c_reset_ctrl(dev, 1);
 	}
-	i2c_unlock_adapter(&dev->adapter);
+	i2c_unlock_bus(&dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 005e6e0330c2..9d63337efa82 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -78,24 +78,24 @@ static struct dentry *i2c_gpio_debug_dir;
 #define getscl(bd)	((bd)->getscl((bd)->data))
 
 #define WIRE_ATTRIBUTE(wire) \
-static int fops_##wire##_get(void *data, u64 *val)	\
-{							\
-	struct i2c_gpio_private_data *priv = data;	\
-							\
-	i2c_lock_adapter(&priv->adap);			\
-	*val = get##wire(&priv->bit_data);		\
-	i2c_unlock_adapter(&priv->adap);		\
-	return 0;					\
-}							\
-static int fops_##wire##_set(void *data, u64 val)	\
-{							\
-	struct i2c_gpio_private_data *priv = data;	\
-							\
-	i2c_lock_adapter(&priv->adap);			\
-	set##wire(&priv->bit_data, val);		\
-	i2c_unlock_adapter(&priv->adap);		\
-	return 0;					\
-}							\
+static int fops_##wire##_get(void *data, u64 *val)		\
+{								\
+	struct i2c_gpio_private_data *priv = data;		\
+								\
+	i2c_lock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);	\
+	*val = get##wire(&priv->bit_data);			\
+	i2c_unlock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);	\
+	return 0;						\
+}								\
+static int fops_##wire##_set(void *data, u64 val)		\
+{								\
+	struct i2c_gpio_private_data *priv = data;		\
+								\
+	i2c_lock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);	\
+	set##wire(&priv->bit_data, val);			\
+	i2c_unlock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);	\
+	return 0;						\
+}								\
 DEFINE_DEBUGFS_ATTRIBUTE(fops_##wire, fops_##wire##_get, fops_##wire##_set, "%llu\n")
 
 WIRE_ATTRIBUTE(scl);
@@ -113,7 +113,7 @@ static int fops_incomplete_transfer_set(void *data, u64 addr)
 	/* ADDR (7 bit) + RD (1 bit) + SDA hi (1 bit) */
 	pattern = (addr << 2) | 3;
 
-	i2c_lock_adapter(&priv->adap);
+	i2c_lock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);
 
 	/* START condition */
 	setsda(bit_data, 0);
@@ -129,7 +129,7 @@ static int fops_incomplete_transfer_set(void *data, u64 addr)
 		udelay(bit_data->udelay);
 	}
 
-	i2c_unlock_adapter(&priv->adap);
+	i2c_unlock_bus(&priv->adap, I2C_LOCK_ROOT_ADAPTER);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 9fe2b6951895..2f2e28d60ef5 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -919,9 +919,9 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
 
 	if ((val == CPUFREQ_POSTCHANGE && delta_f < 0) ||
 	    (val == CPUFREQ_PRECHANGE && delta_f > 0)) {
-		i2c_lock_adapter(&i2c->adap);
+		i2c_lock_bus(&i2c->adap, I2C_LOCK_ROOT_ADAPTER);
 		ret = s3c24xx_i2c_clockrate(i2c, &got);
-		i2c_unlock_adapter(&i2c->adap);
+		i2c_unlock_bus(&i2c->adap, I2C_LOCK_ROOT_ADAPTER);
 
 		if (ret < 0)
 			dev_err(i2c->dev, "cannot find frequency (%d)\n", ret);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 4053259bccb8..a94e724f51dc 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -590,9 +590,9 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
 
-	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adap);
+	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
 	return pm_runtime_force_suspend(pdev);
 }
@@ -601,9 +601,9 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
 
-	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = false;
-	i2c_unlock_adapter(&i2c_dev->adap);
+	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
 	return pm_runtime_force_resume(pdev);
 }
diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65e9971..47a9f70a24a9 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -47,9 +47,9 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 
 	client->slave_cb = slave_cb;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_ROOT_ADAPTER);
 	ret = client->adapter->algo->reg_slave(client);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	if (ret) {
 		client->slave_cb = NULL;
@@ -69,9 +69,9 @@ int i2c_slave_unregister(struct i2c_client *client)
 		return -EOPNOTSUPP;
 	}
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_ROOT_ADAPTER);
 	ret = client->adapter->algo->unreg_slave(client);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	if (ret == 0)
 		client->slave_cb = NULL;
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index d619e8634a00..13a4cec64ea8 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -433,11 +433,11 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 
 	dev_dbg(&data->client->dev, "Requesting wake-up");
 
-	i2c_lock_adapter(data->client->adapter);
+	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 	gpiod_direction_output(data->wakeup_gpio, 0);
 	msleep(MLX90614_TIMING_WAKEUP);
 	gpiod_direction_input(data->wakeup_gpio);
-	i2c_unlock_adapter(data->client->adapter);
+	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	data->ready_timestamp = jiffies +
 			msecs_to_jiffies(MLX90614_TIMING_STARTUP);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 254cd34eeae2..795e3a860afe 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -754,18 +754,6 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
-static inline void
-i2c_lock_adapter(struct i2c_adapter *adapter)
-{
-	i2c_lock_bus(adapter, I2C_LOCK_ROOT_ADAPTER);
-}
-
-static inline void
-i2c_unlock_adapter(struct i2c_adapter *adapter)
-{
-	i2c_unlock_bus(adapter, I2C_LOCK_ROOT_ADAPTER);
-}
-
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
-- 
2.11.0

