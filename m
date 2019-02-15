Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57FA21934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfBOBrU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:47:20 -0500
Received: from mail-oln040092066051.outbound.protection.outlook.com ([40.92.66.51]:35718
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfBOBrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:47:20 -0500
Received: from VE1EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (10.152.2.57) by VE1EUR01HT049.eop-EUR01.prod.protection.outlook.com
 (10.152.3.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Fri, 15 Feb
 2019 01:47:17 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.2.56) by
 VE1EUR01FT035.mail.protection.outlook.com (10.152.2.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 15 Feb 2019 01:47:17 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%4]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 01:47:17 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCH] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxNBhCboXjY4dck65d31dWPtwSA==
Date:   Fri, 15 Feb 2019 01:47:16 +0000
Message-ID: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0023.eurprd07.prod.outlook.com
 (2603:10a6:203:51::33) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:60E06D6F9817C4606DE194B3933031FE922C060A979C66437534D486CA2567EE;UpperCasedChecksum:9766C34CBB3D44B4854305FCB0589FA6E01ADC4A3A540F1D30E139CBDE0840BC;SizeAsReceived:8370;Count:60
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [WdrXnHY+qOG2VdEkGn2uLEE0EqxIDfR6]
x-microsoft-original-message-id: <6919c2c2-af38-5e11-fa41-0044fe1f1490@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 60
x-eopattributedmessage: 0
x-microsoft-exchange-diagnostics: 1;VE1EUR01HT049;6:BjnvCUthfIiMlakkQQaUukakX6FO03wUf8CMe2hL8DIxCdV+o2xqG9/JpU2sCmyFSJY2amyOHNToHFlxnU7dFDUwqGr+rIBdEApdEXcq/nxWAgdBaQc5P/7bsolhwoMZi3UMTrcno6L56BjNPg9lUqNoOUvHPa6pe4p7dgkPo0x1c1aO/TTWKsmaPa2WiZeMibOl/cpAZnJhH09nfqccfG0FfwGdJuS4THdMf59StB5Al6wZ5LFrcH+lLlT8gq3+vB5B80t379/deGaTK2WPcXLC0UqmYGGeT3o4Q9v3cGxZPAhkmTQB8Qt/42pGqgjUnQIm2isfbjTWU6WXEy4ZloyphMVkyKcFKyDbUvkTxrJZ1Tx62P4CrcBZ3ecnrj1JkQaLYDWUJ6vK+kdSh4EEprkaPZ34xngwToAtiX3/d+DvYBlbAiKIsLNqxguFuZHaXcEggNjMgN+d7CZ+94qlew==;5:qU9XFZglZKxOzoRyN0sVI1a83j2wWAOwY1GTxy11D+/ct41/Qxc0RmBMGYM4MK3YcfhXyxhDUt7SwupfH0UQnPKFS1ZO4XS8Mq8hfoR5vt19Fra+sUqus7Wy9iM8Jvl+xsQhGaukTZEvYqX1kRuS4M9boezXTnFsYZACfbRcqmFsT7Q6t/2QQK6TdXdxxdSCYe1b2FLnHfkd17+lIhZ2hQ==;7:M/GVULfLQAlS9y7uv8DEaMJz/g04Dr7LgD6k1sPQJslQf/JtOuahXKVyoQHEnbde4eL0tf2+bnNXSkt8t1lXrShndXE4ndmwOE25K0mPYBTCwP8nLySQzq25XRR0c07VrzEYejPDR6cc9hamg7gAZQ==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:VE1EUR01HT049;
x-ms-traffictypediagnostic: VE1EUR01HT049:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR01HT049;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR01HT049;
x-microsoft-antispam-message-info: oHSo8nv6dPGYFoHk4btzrN4cM4sueZAsiR5vSa7cyXVbYGAdtMa+QzysDFTjdwlK
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8006F73B11220E469A0EA2455C63CB54@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9319ec-e794-4670-5743-08d692e783b9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 01:47:16.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading from /dev/random may return data while the getrandom
syscall is still blocking.

Those bytes are not yet cryptographically secure.

Make read and select for reading on /dev/random wait until
the crng is fully initialized.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 drivers/char/random.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1a..ddbc0e2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -720,7 +720,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		}
 
 		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits &&
+		if (crng_ready() && entropy_bits >= random_read_wakeup_bits &&
 		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -1851,7 +1851,9 @@ void rand_initialize_disk(struct gendisk *disk)
 
 	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
 	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
+		n = crng_ready()
+			?  extract_entropy_user(&blocking_pool, buf, nbytes)
+			: 0;
 		if (n < 0)
 			return n;
 		trace_random_read(n*8, (nbytes-n)*8,
@@ -1865,6 +1867,7 @@ void rand_initialize_disk(struct gendisk *disk)
 			return -EAGAIN;
 
 		wait_event_interruptible(random_read_wait,
+			crng_ready() &&
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1909,7 +1912,8 @@ void rand_initialize_disk(struct gendisk *disk)
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
+	if (crng_ready() &&
+		ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-- 
1.9.1
