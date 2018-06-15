Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDB1DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD73208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pW/2WUTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD73208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965749AbeFOKTl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:19:41 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com ([104.47.2.122]:4422
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965553AbeFOKPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJHXgRLYqh6uLHo7ucH9UOgpQwpEpc6V7zdNhvOegSE=;
 b=pW/2WUTzflsJfn7nhExxXS20BaL3YRpg0p3Yof5MMh/vkPBrlGyCXi6LBfNZbzE+K31RAf9zDFH7fZ8WeEp8GX9pZLN8cTy6zzsCts3AIbFrpCXTRRfM80ilASgEAk6HP+Lm/C8pGpWR2OQ2Tv7al2qHOfKgL6rGKgtua/FO1y0=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:39 +0000
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
Subject: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:14:57 +0200
Message-Id: <20180615101506.8012-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: f84380e3-ae93-45c4-f7c8-08d5d2a8f268
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:Nl/P+PZmQIeGTJV93cQBCBVUw345HhyNFksYaBYJbpATbZgaea4qYpJbBLkTpZPMahLz+d0F73/NjcDWz2H1809clrj4aDlqLZpqT7RRkNWI4rLL7j/z3VH8wmqOgOxT4FLqlPgrsC+CTEXnjY+6YEDdmIqkgfRsBT5Yp69k4O3Y8B34Nko50CuYB1BqNfLj1I/oTlMfgoMl3bLnR4Z3SqV2wN1q/53jFAaaSGLvogEwj9rRp9lppSVZwNZCMijI;25:A20/dgtyk41UQ8P1Rjdt/CZLvkj2ZDVahhe+hBdRkYS2cuZ9KSLgE1RQdhU4CSYU82TnEKwZzVI0zQV3+bFUYHVqOc2voCcgdCla6TiTyb2VV+kWgcYcPSBngcj89ftMm4bEFUfMXD8ovTTgypYMg/Y8goFHUZsc/0min8S/mlaV5gcRRa4p8GWQUbWMVwEku2MbvCHreL4G9/CbWpjgwHgQnG0BaCWnq2uteyOK4mDn2bRcq5GygFSLlts3xn3u8aC4rPn25/p2wPzAvOPAK5zZnkyggfeljkcwKIC9SQFdHUzYZo9vxiFTuikPbNCMcmRUMuxIKVj5pUZNSDRMWQ==;31:HupwdTG/TmxmHwMaiPE5dJUSyTCR1d50QmZ2CJhoshH9mECEGjYRjQtmdwKMKf3sF1SNI65SDQicS8PNv7JCU4y3WScFTm8Ol0Om2eqLto1SoDdddTKAEKmaR6RX3kUargblkCEO1tEPN94omXk4kojYbxMY153a1m5kaP64LIT0udtYtf69+3zurm2BQrTV9VvSF1GQ545FJ83JW91oQVG7+tJriaALKuzzD8PRLcY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB246028F3C336571B8900A97EBC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:bxgoxSwEdnQkxoaoImqeooHpP0hR5EhpwSXrDRzrvQB3GYdP44sSaOqQ1YT+nxtbZ0m1+9BiaRKEvBsq18qAVsPznVEbyc/JjTzCVCfYNwIACUDIZ98u4aayrU1Ut+weCVo2TURzTqpI9rfQBriGMkPFLKiIIIC6Q0EaRHrtp2UTg9nKTok0yqMtsy2ys+Jq5K74HhH1Jn913vjNdM6UREJjHdlTo4Nh18v3YpmQvriTG7kVTiWmAM1S5cw3ayNuIkkvwIt7C1TIshOrCB7eKA==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39830400003)(39380400002)(43544003)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:aVVE5xSBs4RqFon3TdEPbSa/vtKl9FX+oGwF75Q?=
 =?us-ascii?Q?uTJF8vibU37IjCshfLbNm8cu8110hVfh1XWGLrqFw2QsPQRS6WbyDV6CPsBY?=
 =?us-ascii?Q?1xrYJQtWN+DfUVq7GgQ4Yl0n2YBlTBL8haryiMurCcntRtP7xcNqwgPruB3t?=
 =?us-ascii?Q?auOetpB6WBXperOChDV8akdFwWYpFSMEG1awrBb3dERkV0NJNM3SnpyBCFSG?=
 =?us-ascii?Q?nycvvR1HfkDISKN1ND3OWK0+3LPaigh2yDlv4Tw8PN7z2pOsO01IEp6drKIS?=
 =?us-ascii?Q?nDz2RUG1Q1ARTFuv3vji6oYjnT1idM7ilF2WGrOv75D7w6HI74nP//wxVg4Q?=
 =?us-ascii?Q?dfeSLyzaKtco19DUrRQgICs1Gq5TCQSXKTUCauoTzlrgLEfkNtTRE+oykhRV?=
 =?us-ascii?Q?Vf4Va35WT4LPhPmu/I/V6+yIVjzECX9w3yxrhxmCDYiCvwSfySK+dR70xplI?=
 =?us-ascii?Q?zGuNw0SwTuQGxGyulDC5ryTV3/R3WPDO2ouLaivDd1G0BEKwIitHp1rL5qSA?=
 =?us-ascii?Q?2/MnWgfuaae5//nWDcnXK/G/Hhpg5LQcp/RUozmXqP75zg0HGrbGQswY+IQq?=
 =?us-ascii?Q?IjwBisfuUUocMauU7rlnvQoSIFnkgTacQJktzb8npEZBmHRLy0Z7iAZFeeBE?=
 =?us-ascii?Q?woKl45YQ/DyN3AsJdTtMBjXi8p/4G4j4Wwfh8Y012GM2pve/Myz7LF6t9f50?=
 =?us-ascii?Q?W8vWdR7bejS7Jhxw9XGru/GOGcgBJWIG1PZxS+WNON/yPUV3Kwh4qhzhAT/4?=
 =?us-ascii?Q?xJh3s+On+n+wO5h3YX0/dgaEGmNlbdvpCL/uHm+smDiXEW664RqR+3Kk0Wm5?=
 =?us-ascii?Q?AtdCwLAnd1qXAGwnHZZ7pevPpGAiZPWc/CC+iz2eFxsRHWAgKCHXUEdKsm03?=
 =?us-ascii?Q?KzZ4yzaE5lqUQIz2t8cehfHipCta69Qjl/4tesrvhYMT9zbt+UFMiRKevG0F?=
 =?us-ascii?Q?hebfv624yE5wKWP6129+EwfhUiiyvzA/eqPedoLiaLUl3I7y73BBl/jJviDy?=
 =?us-ascii?Q?SkD08G5LSumgw0gv8XAnUABQYRb5WCfvAj95VJMN93C/xc1a8hUYsqOPkf15?=
 =?us-ascii?Q?+UJ13XiBLSPdB27Ulobq0U3Y/M5mUwsL1V0VyBv61NNVkkOJygfKRhRcPb8h?=
 =?us-ascii?Q?r856JvndYW4ZrZaPlinYiJDXJ6UkW3l6fXQJjmHEDcLPZV5bIa4dWf972vhh?=
 =?us-ascii?Q?6G9Z6F+c4nAh+RwcRtIcNqFEBb9C4z7BQgyWRh+4CTWEGEmbL8Put+0aQElw?=
 =?us-ascii?Q?pwlUJvOBJtqPp1SBUzmnBmh/JB9jQ1Hg1ra6loozY45q45m/E9YLnwTsCMty?=
 =?us-ascii?Q?lkAj/ETfUB07uPwrHZ/598mDGZxDU7KAIwv8HWU71/yIiGsHYgAyWDRp5IHw?=
 =?us-ascii?Q?rAHqUW8JBt6RZZ2r69OK+3h0GEuFzwymFFTUrp/QI7mkqm0gylcTjUzY0ca1?=
 =?us-ascii?Q?zWs0SmN1r3OD6yhP9qlJKxdDzFgQRMuosXtTyVRcViLEGNpXlfhU10pitrsb?=
 =?us-ascii?Q?R+56DEp5PnMi4Pg=3D=3D?=
X-Microsoft-Antispam-Message-Info: RlWGxqXGz395NS/9gi09F0npvupFp9BI9chJLBhLIY3iNIvjsshvnlAQV6rvt5JpFU25hBI8lEwCPkqN8RgfFMr5x7dQbwpSiy7rFFRiCDuTAcAiywmmbsz5C8wyeqq9bn2JErRbtVBD8l4jo4bnUAwQEAcJ5x+UJ9Yvgz8ooSeSZME0iI+w3W2SVXtcs3q1
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:uepYqwokY9CRbO4vEKJBWzOGKnX6yVrXxL7oikn/dCvuITvUs8xpjzBWlV/tNq9g2m5lS3+4Es5s6WNQVlfeh8RYCIbiWBQYkADdgm6qmolEeKWJXlFKuApp/YGVl6ZqVP/J/29oqwO3AtYIwzbcNHdSYGBSnypvAFln9wLcWLKTZHkJtIU0RXG7UXwVcBzLOlNrW4fw3/mQ4Vk513u08MvknI162hz2K1+Wq7V85/RDzIdFvOdcn1wPr21fFGJxH9hCNRZYWE2wHQYzC5LO2xaFRPhNM3TynHLf4mLMz230KUdQATntrjH/OFk7UCBQVMdIWTIRo7zrhA9npBWTDkyF36j6bo0wjEtS68Y80m/lq9p9TDB2N3qfPAOlmlkhxZQ9ky/gbys844wxgtVjLJ+VaccQaTeRSZEgHscjSdr+ctWA+4g8N2UbIcxmEtD0dXvMwpEk5fYkJ54dj2iENA==;5:T5/L4AGUgk13l3wL4Z57DLawBBmzoVSbqpeo2DTHmvaoWf7bwIS+y9mdg3ypKTltHAEKaGv1bAJSIDkZrQsCT30rdFltZqwXjB8De9wSwoBq+aEHN9KcSkapkUK0aYTy7HMRfM936ENOwRjxvFuRvzuk+M6ZhpMJxDKf+Drw3aI=;24:ktCFs2vuNAGNLCgqzNTabWMGtvfr8pgtQ7I+CwK7npclDDGhjaEDNC7KbGKUozdZqWuVSkEFmx3aQdqfkLykRuZJGRaWrAxng1w1MCssEjU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:mTEtfxGDmbPMkL4LCXw0Y2Gt5aSKn8zHmZGUEmNWzXmrZluHY1BDLwSWYNuF53RH8JXWtGcLiIvp6Q1X0ZVoEAyl7Pnzm0O31wEpwNCPuOeYpjLKdUhFDhkjaTVoWJgBOv2NcvYcEd1Tn6adiwfR6VduFPEZzxghyFTRlbZTd/wb13NsOAWZKRCLKh5EnLE+dP8Rf/VcdOzmqf0W9h31i3fw3NMq6O5H2vLQhFjp+qpc6UFJG7mfZNPowUSJ6dOp
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:39.5941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84380e3-ae93-45c4-f7c8-08d5d2a8f268
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
 drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 6116cd05e228..b2889405b4fa 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -117,7 +117,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_segment(tpm_dev.client->adapter);
 
 	if (tpm_dev.chip_type == SLB9645) {
 		/* use a combined read for newer chips
@@ -192,7 +192,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	}
 
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_segment(tpm_dev.client->adapter);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
@@ -224,7 +224,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_segment(tpm_dev.client->adapter);
 
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] = addr;
@@ -243,7 +243,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 		usleep_range(sleep_low, sleep_hi);
 	}
 
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_segment(tpm_dev.client->adapter);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
-- 
2.11.0

