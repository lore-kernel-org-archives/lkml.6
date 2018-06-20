Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B05C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DF52083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iPoOVyFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF52083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFTFTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:19:11 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:45380
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932149AbeFTFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWFRF+4mj9TBCGO2vyygBYils7ENbNMfMlUurD/mCn4=;
 b=iPoOVyFKb+OShv9kWtGOBJ9IwhozC0oRbNdcivIT7GiELkqGOlgtmu5NQahw1/VOwytVl9zCGSCoq/Ou/8KOQs21/t7cMizdC5KVe8m8kp1nutN5Fkk4tL19oisQi3s21ZX/1BKzhoekWEgFo3pJDTe9Y9oZzIAu1KRxBsuV3eI=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:48 +0000
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
Subject: [PATCH v2 07/10] media: tda1004x: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:18:00 +0200
Message-Id: <20180620051803.12206-8-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 9f75f053-f8b1-4ba4-8cbf-08d5d66d4eae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:xrct89EG9KS6jlaErWvNOc1lH5l3QC5Mha0enImmOSYegCwHx0Ws95ECPEV9zJGAN5bzeft4xntEUhjAitqAFfyx3sc2Q4wJpx/C32G5EjTaTBljLwjbkAet/BV4nvVQ1pA7/ULUkIFfvTYpqBs6cxJRACJksd3qN9UmeniDb9E4YP8aiiw+D0h0dXPl3DYJ/PSy5Z6e1k494uPrdJ25rzfCssajxooBWhgH55WrMSsUiRguDlLqePKU+a7yFkvb;25:YrJHt80oJc3y3gt6KVyTJO03w5o88xl1+PqpkHG+RYJ2EWgs0PIPcgHi+2Nr1LgpyR78u/soWQ93V7CAsqtcEIGwFxNA7YPVmonNqypFXRQQKFzkgt9UYupl9KEfkpxDsZxMJZ/8ngl4BUnyLqKyDG7XsEtOutfew5Tq1IX+crsuJ2fV7MCcc7Zfi58ips+oeBoJzLKInvX5v09mz5ui9FGwrBgPWCSHDPJsparjOBjngVPsCkoCAqSmv3/Ndjwg3TUKRRMElS0Z574UEXD0CyjrVqDoIpSEYxRb3CV96CMmG1E7Qj4pbrKg0PgIF3gAZLxzghGckM8H0DrzaSDGrQ==;31:Ca5IQWAWQQv897sELN9kJGpSKmHLFguo+Dxf9E0fIQ5kj+oBL197TiK8CBhpEyPHUVvpcuFmxmf6n0pQ8oPd9B+0eYvS0U0lJWmSX81yikYBHtr+2uLSW+r0Qrch33CYD4DkzEcG3SnAnEOXQ9ylFYxqOTH/noS3MLPEyO10e6gp5zA6hdz20501v7wt9yciK6P11pYDS+n5WRml6/9Bt8XrxIZ1ZhZcKQk2OlVw9kQ=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24523A1CE74B87B3AA201A1CBC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:39VYiTOW7tTEVbdby0sqMjhorXLGfhayx7FhaNst3Vy9uOYNMEz2IEIaFWVxK+TX+WYYKHbgp6S8+r262AVVP9NRFjCfeclkpdi3qkh7rBai7OunJ6GYytJHjxqKVWJbixWF8DVkZpJwvckIEcm8iykW8v0CDGb2n2FFHt+sGUUV60BatU4sBn8Evt9LXaUiU4FsCLZjODxE5XQ8cfkuGgqWymvzESSroHQeeoC44sNPrRCgtwblKFofdfBRe85dzBucDz4dw6tSnxd9MQSsrg==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:sJZLCTpnRtKMbTcwayCjgX2REaZgCgbBcS6e/6j?=
 =?us-ascii?Q?zDxVnk5t85qWdZSNBnjDJB8yWECbrj4fo2T/XoasjFc965rGcAwpXc8xkZmi?=
 =?us-ascii?Q?8u21Hhvb7+vDx6f8WtDOH4JDq/JpgjD85KYDbpk9nCf9701kb9flaS2DZPY/?=
 =?us-ascii?Q?CfaUn8LIDkJT/5lVyqrkkqJX+RYB4/ErTgrhhZaPn+tS1ajK4Vb5Gvd65+eC?=
 =?us-ascii?Q?2Mm1/AkK+ElWYjOeNI4tEaHF7KxdO53fA39E73tHvM+DyAkyxhIDW+l2brc3?=
 =?us-ascii?Q?ZqOdnTDFCNldhKrlY0Jy+ctq20s9MOa3DqLqvfWiy2Br90n/jrYkrgApn1Vr?=
 =?us-ascii?Q?hHZrTLpD9gTqM+QZISOW6RFtedIhkglv8vIuHFfvFV7Y0UlJK5EB4PNouOqj?=
 =?us-ascii?Q?CTHSw9qPLxg4e6YDZwaWHYgLct/iSzMrhqhZFLA8M9GREN8CP0eEVGP0lB/R?=
 =?us-ascii?Q?H5eH63xG+a77ysKslBMsNKqLvGwVTaQmUPnrv/882SEev28cf8Oc90mqn9Gq?=
 =?us-ascii?Q?PdfqUDhmDgLwnwi50pMGHVsNuPpDl7CMqd/oeBO+qyFONXKmBU0QzdLA8W/u?=
 =?us-ascii?Q?krIfeAiZMmA915V9ozM8Lnu9I3hOaHXlVQqf3u+PMBKJKeJDdsyivkekyrzz?=
 =?us-ascii?Q?STC3iCkjvRwxBL+F0B8g+mfiH6rQ2uakNswHbGFTlPFClzi+eD6Y+Cncksio?=
 =?us-ascii?Q?PkbGRpZImq1XjlGtf0XIf2G/gUG+lPTlYeJCBpsjbweNYHa0VM/3ag7qme18?=
 =?us-ascii?Q?+d7V7ssWp6U+L2UnDmzdkqkbRoH8tH1++WJ7LLGBoXTC6khEPiSf5IggRsDr?=
 =?us-ascii?Q?cNEogashIknaopimSk4k0Tpmve9U8IkeWcl555V/r2rfMHmECB5pmm1zrNif?=
 =?us-ascii?Q?gwIswV5Pja7+2EBtjVEMNAtRjPk29y2q5A8AQRQ7X4Ky8VOPjdywzflzIQd9?=
 =?us-ascii?Q?Vi63iOdmIg48hYyLFuIFlMjsYcsubTSXcwggvzkAWrxmphTBwhgnELp1+7WA?=
 =?us-ascii?Q?pWQ6Xi09feHuTqbyduzPFaYM7vJ7gioKGYtEJJsizM9N7VPs8cZCC7j+VfWV?=
 =?us-ascii?Q?KEQcrqsVORxxEotq/1EwG1frQfnybvEunSiEyweXUNOPKKkiCJn37omd5/dw?=
 =?us-ascii?Q?ezwjObdSC+OG2rcaLzZLvcbuRm/KOLxrhBhC3Fnbn2QZ8D/WXqhNevQ1F2RQ?=
 =?us-ascii?Q?2MCAn/GumzpzAJUb2ZLtx41NwP3Aq2bgNiyjJaLnECA2Sq29WbwG2goVzDu4?=
 =?us-ascii?Q?gCJbLMlgtERrdGYpRM4Zx/0F4Bl1VV+4RtHQ4Lsf3HqRiAvHFf91JWaFheDF?=
 =?us-ascii?Q?2lNWWKVyEMuW6BzGFCg48QDDQ2eVPi4qF727yZY7/xu5zG817EoTO/RgHXvt?=
 =?us-ascii?Q?xgdb4X5bj9Nvqn72ekmnoJDbWwLN4xb4E0/GWe1JHvnuUhbGzUVCfpaWd1DU?=
 =?us-ascii?Q?cmgZs4js2EGJmpV1P4y9r0gay1+jwkmefY2Bh0poHXHNRFXZnnPbZ?=
X-Microsoft-Antispam-Message-Info: lmQ/SnlMQa3+E9eKiYi3K/kQmCPCoCToPJbSbp8mZrbfEu0jYg9aOhq/8KaopqDdAkf21K54f5Na15QR7XAZEA8IwJStNM8GyT6cGaozc6ftSFlmGskDP+yWogrfukjTDorDispb2y2M3oFpckzSM01YCvAHhP6piMM2YZaH/JV4KAHM6n2liC12vq1M9e6lSpZ6Ll8xJbKeCC8TFKyNzu5nM38j00AJMw73srAfusAOkNczzNUJ19U97ZgSxyPkrVULwd4knZOtc/RL3V/dAQTtJVbRZQhXnjc5mEYrmwiBO4PKVeDsAc4HiyiYbCyIZQBY1hj1tEfTNSywzzJ0yQ==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:kdAq9ph+Cn71gHenZ/x+ImgyC12Wi6kzlYffj6EUvmVvE7xVHRavDA+RxC0/s5rKZqwfN38LYqiOoEoA58/fAWB2XNWE7I6CrmbNUHgz9bJoLKVCCWrOePtetzIwVZcWAtPHcTgvrLoZ/fPO8Ts3bmnrXn46xTL6EB6Sf3E8FhrWAorlJKNwlckwjImThe6GAHfgcPum5gt/eRztxF2zscukTlCqRa0BXhOOAQIvYZJfhN500oPZC3i3JYNuBqr6QA2Nc3kE8EzmLLgjaWJShvAmanQuES1SiRxECrLPiZya8P5IbtURt9BGRelJUfvFxVGLXAH6BTpk1wyCQJ/5BrFBbebAtEDreBvHItSJJl9axVX8GqnhX+k5sRl5XBRoJMkMtm/PO34ztTnf4/71gLNS4BTDcJC2YGNBdsr+Fb2WG9+aE+SSODRHmfFTYy4sAAgXenZzBP4JqhHuIjd/dw==;5:D0T1erg4kXzU0mHrJou9PQAULydQSYD8GjUXBZ6niUbcwczdsuiz8PZWWnivz5hj6Rh7e/EPwpTR2A+ldsmoQ6ucurdhmgWJZgv3kjWMp+AiiQRrIYdVM+oGo4jq592ZVKdmpgQpC9oeztDFATmKgqlCszbhwtkovl2zQkG93uA=;24:/ZuOkteTgb3cu366q+gvKGZGYuoxMEpu1dVPl8jsL0vS9bPgQ6vDDWVioWVy6xeE4wBWnAFFfMGqeTJaLOSYNR+4v7bk1naw2Qul+u1vXK4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:XyU7zS8OWDtejiQOA2TrCH1czVyoVq47+tcWdNoWgr6HNoTCDZdIoRCiYlQW0wmVx8784lDSEn6wVjSD/lY4Ye1sUHV38o+DAqmRHz1/XF4qf3r8L/oejqRwNPN+R/IwUNaPkK05HfqM5BR9I2lBBzNzWI79rO2ePR1t4TRnN/OKS/sxBR90iVWkzkDGorDB/upeujUr3YdKdimwGG5i47LucgaBTccmnag0K+aJ8nCZ0Z8iklCottajGkGsCG5f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:48.1697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f75f053-f8b1-4ba4-8cbf-08d5d66d4eae
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
 drivers/media/dvb-frontends/tda1004x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda1004x.c b/drivers/media/dvb-frontends/tda1004x.c
index 7dcfb4a4b2d0..9d3261bf5090 100644
--- a/drivers/media/dvb-frontends/tda1004x.c
+++ b/drivers/media/dvb-frontends/tda1004x.c
@@ -329,7 +329,7 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 	tda1004x_write_byteI(state, dspCodeCounterReg, 0);
 	fw_msg.addr = state->config->demod_address;
 
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_bus(state->i2c, I2C_LOCK_SEGMENT);
 	buf[0] = dspCodeInReg;
 	while (pos != len) {
 		// work out how much to send this time
@@ -342,14 +342,14 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 		fw_msg.len = tx_size + 1;
 		if (__i2c_transfer(state->i2c, &fw_msg, 1) != 1) {
 			printk(KERN_ERR "tda1004x: Error during firmware upload\n");
-			i2c_unlock_adapter(state->i2c);
+			i2c_unlock_bus(state->i2c, I2C_LOCK_SEGMENT);
 			return -EIO;
 		}
 		pos += tx_size;
 
 		dprintk("%s: fw_pos=0x%x\n", __func__, pos);
 	}
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_bus(state->i2c, I2C_LOCK_SEGMENT);
 
 	/* give the DSP a chance to settle 03/10/05 Hac */
 	msleep(100);
-- 
2.11.0

