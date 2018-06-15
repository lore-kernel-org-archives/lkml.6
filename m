Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0A66C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317C208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Fj0G//CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7317C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936323AbeFOKRj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:17:39 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936247AbeFOKQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dplyepfIktNvSZ3KE1vrmgvBJsW1PLg48qQFeZ3xzkI=;
 b=Fj0G//CXrfTRm2XzsVjXT+w6M4chfKJjqwfpBMYk2vy+KDPWtr0qSzutQCkYdX8u4gXTcLSFTRfJVCdmCZdSGUj8eMIHv77Eop2D/X6d9mYZEKkA8sXHRuvkuQwXpShx8bSIYIIVJiNUEGUNfqChsCCCMjgzb5IjMyK+bVJFV50=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:16:02 +0000
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
Subject: [PATCH 09/11] media: tda18271: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:04 +0200
Message-Id: <20180615101506.8012-10-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 9feb9c36-cb80-4c89-3cfa-08d5d2a90042
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:BmqH0xEaFYUWc3pj5It+5jJjDr8ZdB+P7honN0vb1YnEyCEuGDqwv26NBHDzGU83w5GEolSGl7EbhxKLnK/tCWLRJxHUhxgfgRrQvISenDur2NCbjc+3/C+7ckEf9So8/TTZioEUPgIw3DNsuXesGNZ5VLmZ0xczBv7OcBiNWTRe7E3OFkbUtwJbL0AoXQLS5NcB9dp0AIz9nZSMNRY3y/3rJjxBqPOAYXGtt8hbhvT/sieZXIkXp1b+HfWJNLSm;25:GTSP2G7dGIKaPNAS3fvIqB6ZLjTJcR7crke2yVI33E2Qj/IYgZJP8OrtD5iHj7jZy+DALMn8bDeGo7uic9JkYGIHQRnP81ubBrqHDbWrSgzGbznkrti8J7I49OEd+vGKcncQO70nFrAauolHrgPShF1lZFwYCyIsyTUmlu23jafHRKGF1sltzx6gQdLEPnpBFJLCapf9v3Ar1huCGJYhJ86F/CWSSrOovqz/YlUxZPGNo7tGL1Y4SY6CBlueZVebFCY/P0rv4Qo5j9ay+2hM93OPmN7oi5b3wt3Zc19ELsb0NFmLG6dLnCf4C48XcCTQIQBbsLcsB6HQ8hp7tI1uIg==;31:qG6xiuD0D1fMnBc5YNXGxW3Eb1By9YkBj58XfQKPTn5RIEnxNwT37F3kHJDewJT3iuNULcWkKcIHK+Ak+0c7sAIXrDO+2emvVLTmX0hYFDrsAUNlV29jggjiuH35JvTGpN3ofn+pJza0VA7AmdVNyeTBY4aWxzZYoBpt91uKVgOOKeTo0YyP3Y3JGYDm2KM8Dw7fxkpr6tQwKPAhRaEA54uNAggYX6rE9J59wecTrto=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24606AE891A22ECEA7BC3087BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:lb7hm006M6aXy79+Kz0xFBoftXDu2QJ75tPX3X0pSGQw/kJ+w90yeyhcq8jOcZvTQkfI6ImBLxh5V9u+L2aBApTI4vTFkZqgmXXKiLRuIuY59HGB75nJlMq3TDG5QzyJTHAFtsX+Hy0uh0EqecpYZg2rUQiLlarC/9Y4mbKIdgow7ITIYgbwhahmDehDJin5eksqbPkf0GQcWfiAtu90IZF/kDLEiTWo2CKz/uGs0Xz/U7zr+AVlFuBKFd/bZy6fTSeMIkSy1RjSsOx3BIdrjA==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:8hz3GweGJHstjFC+yUrEjge9U1VbZVrVQX2RV55?=
 =?us-ascii?Q?67B5JpaTXN6MA3RfwDChhc+qWHONRDwDK8RL8NY1GEJhXc1ZjG487fOQPf/w?=
 =?us-ascii?Q?mcmoShisjWg9ywSVMjpOSnOT5t1l4TbaX5SdyK+nUsZql2jSx31k4PTO7W/Z?=
 =?us-ascii?Q?+C6YgiwYqQ/+w8M9Jr5Jqbr6sAcmFpKg8dvYXQ3pS0keEvBlsr65yQHb3G29?=
 =?us-ascii?Q?hlvyjBO74IenU1zjAkUH+/uHXkzIFjR2m3QFxlx+WKoyqqwuY1ZspBacHdzN?=
 =?us-ascii?Q?wtjbeHhRzfeWlgfcZFHk40f6L23DAdjXG/805GYvk4FWXJYV1aJhlbpmxO2q?=
 =?us-ascii?Q?qZaedMzy8wVekcA5ApG/HXJ5I9NXXaLce46jcXIK+AfvcIw02UfCEpafH0lL?=
 =?us-ascii?Q?GQTI91sKNQNo+0gBxPovpV/8EfYxWiAY6dSvG225CKYBK5WL/gMHi4/D7Dc6?=
 =?us-ascii?Q?o6EuiQoKknBiLvhvHJQ9sy8jEXRQ/hXjCCKC+PGtMPz/oe0bOzEA6jACS5Kz?=
 =?us-ascii?Q?OTIHIU7xm6HChJ2u2XmhUq8AufYZBhXRI6jxh7nOt9FYT9HMiV/a3pBGWgOX?=
 =?us-ascii?Q?42kVNi7XJQ+0z+xKw2FvRq9aBG57mAh26dJkGlrsu5IQTJQrdaYHeun7Hu0h?=
 =?us-ascii?Q?cgFWnx/dVHyD6ekTcxHVyiCStmDDAahFNGlzeBWEntc10cuO5RdZWUs1s/o/?=
 =?us-ascii?Q?MrCC8oW17OKaAakbexnD3Jo28LnMnJ4OX0l56/FNuaG13Sy1B7SFD6opIqrj?=
 =?us-ascii?Q?HGOMYLebxO7oIUW4Ft63DD36JmTecUoMx+lYVodosMEx+S/K89HgZx3+FCks?=
 =?us-ascii?Q?OZ71f0enrb8rG7lkV1dhtXOWmknLPl7hczbEgW9gld3XG4sW6IT9eRGAL8FP?=
 =?us-ascii?Q?y+UeZDdbhtpenLOeKOzgiXsq8XE/1Pc7ji6kBKivDayIG3hUyc4EgeI86TmO?=
 =?us-ascii?Q?yUApw7gnUV3kEcuF3gOl5qZURAUfbw/HZRiTSmPnKmeBv9JJuYHAFCzZ5Q9z?=
 =?us-ascii?Q?YLtfbRXkUkmYgX72Yx1SwOXm9yML52vAwHM4ZO8ZxtL32jDK6mKMuRhLfYPL?=
 =?us-ascii?Q?d1VswRHrScPZSVOaJlslzMpsFYuVkElAwPdblo56tAd0Rx42FmDrPRqB9dCc?=
 =?us-ascii?Q?m4w5dJpfJ+pEKrHrE7+22A+VQV834oQCMjJwSBZuT+366JzA5iA3mElaRpGv?=
 =?us-ascii?Q?/UcVVObAw6ykMnUymzu4dA+WNwop2RRqcmRHAQb/dYbojetwy9/nGEAcsgMo?=
 =?us-ascii?Q?eIOtTe2H9D5/WR3eLTQn5vJpz56v/M9ovvEHTzCUOZfZXF6QXoWfE4dqBVMv?=
 =?us-ascii?Q?eNL/NgI4iCISP9LP7tK08IVk+ezq2AuK3mAVOzuIezU1dn3P8kjq8gZPe/zX?=
 =?us-ascii?Q?UAyU57fHYGWHPQvQby8AzudByEcXGpOjtCbHxkoCLMnZ2tHxD0Pa5PkSwtFI?=
 =?us-ascii?Q?ZiQWrbiniaeZQWMLC5YAuLNjN8Jcbuzs=3D?=
X-Microsoft-Antispam-Message-Info: aTOWoKID7aQ7hmz96eYwBdMjWgJxzZl2blGeHL6NkhbSZM7AbZLwUwadQEhSD2G+rwmoMCPkL7+JUBlP8KknzL4zJIOeeP9zysx9u42+jhoizzGshAfKUwLcENpmyLaso2KfOBQoLWSl3l5d6ySlLgWZLfMdeLQuF7SmdnEtdF2W/+SFrCjy1qmcfzXjrpQE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:fJXvfgwhmY9WNSo4crvhhcpr+LChIst7t78cXSywd5TRwEIC8Epyo59ZyBi13/8arhe7Z0EEeZf7XsZSY84+rlGFNfTRo83qTJg8ABnWrRdzjhzi04g+HNUsWt4BEdKDv/3gZJrjtl93+R3svFEThLf1vxB2Aaz/oT91zwD2x8wEQOQwJKU/ewAm7qbNc4JVOH81AsEtgIawvoMyVOj+rUKR3Y7UWpKE2YCkTAxzcGF6Kboc1hqwUSef4/Wab0hR/dvo031a8vpKULV7/eRbK9lW2BjQBJfFDPMnXTe+eke7iz2yVh+oHqLG+mZaqiBIYalXzCV7HdFX2tbsrOxbbeOOJdXuw2OuQ8d9KrtdH50DsmiQtEYxr5v6vToPRdGWsaP1r4DrIxEMGtfVjToF4Jy0SacQk/uerNiA5pC6xXht24nhEfxxmNQgW6Hxznv/5pEcDIhloGKVOZR3UPLYJQ==;5:1NHFiKTyLZunRZNRYNtj7/yjTM07Tre1Ef41Y8oIButHAB74rXa9BTpA7P5JpHNZ4xTMMiz/iy7HjfBGRLYrEnH9GsC13V169Bnl7YFHglM4Pev4ufZ27tASoMJOwmtNUcvDG8VulaizotThrWTKpCNW9gWJxdvBK2C+21H/+1c=;24:6UicqmhuFvmWQhvM2AKKH0KOe24fln4CZ7Y2mec4epnUqG1RVhrO6dupNRe/Ene2QlI1N3KM0iOB92bRQAkA9VdWtQ3TlG67zSr50qTAA6o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:cBEqgp9u8sGHT2Di1RCAPjPHJNo54YMP/aib4XwR4KgxXUZw0nms2iMTMaBbfjBHQ6W9mWhzFI+AYLaobOGHMM4b+0Ezzpo4mJ1Vj/vp528gokL35wtl7pTrOm8fgX8JlV1UlnhzKYbsVm/U4j75WdL5eLfsQEfCsHdeUa+fMSJQ7/qqhANQqX84GInHVEovruAuepjTjdwPxrzadcT2OOwnAFtupN0ul3nHe+wWTD8cBlyHKbYh8BEbL/AD0XZL
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:16:02.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feb9c36-cb80-4c89-3cfa-08d5d2a90042
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
 drivers/media/tuners/tda18271-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/tuners/tda18271-common.c b/drivers/media/tuners/tda18271-common.c
index 7e81cd887c13..93cce2bcd601 100644
--- a/drivers/media/tuners/tda18271-common.c
+++ b/drivers/media/tuners/tda18271-common.c
@@ -225,7 +225,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 	 */
 	if (lock_i2c) {
 		tda18271_i2c_gate_ctrl(fe, 1);
-		i2c_lock_adapter(priv->i2c_props.adap);
+		i2c_lock_segment(priv->i2c_props.adap);
 	}
 	while (len) {
 		if (max > len)
@@ -246,7 +246,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 		len -= max;
 	}
 	if (lock_i2c) {
-		i2c_unlock_adapter(priv->i2c_props.adap);
+		i2c_unlock_segment(priv->i2c_props.adap);
 		tda18271_i2c_gate_ctrl(fe, 0);
 	}
 
@@ -300,7 +300,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	 * as those could cause bad things
 	 */
 	tda18271_i2c_gate_ctrl(fe, 1);
-	i2c_lock_adapter(priv->i2c_props.adap);
+	i2c_lock_segment(priv->i2c_props.adap);
 
 	/* initialize registers */
 	switch (priv->id) {
@@ -516,7 +516,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	/* synchronize */
 	__tda18271_write_regs(fe, R_EP1, 1, false);
 
-	i2c_unlock_adapter(priv->i2c_props.adap);
+	i2c_unlock_segment(priv->i2c_props.adap);
 	tda18271_i2c_gate_ctrl(fe, 0);
 
 	return 0;
-- 
2.11.0

