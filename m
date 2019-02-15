Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C569C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FDA218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfBON6Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:58:24 -0500
Received: from mail-oln040092069078.outbound.protection.outlook.com ([40.92.69.78]:63568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389179AbfBON6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:58:24 -0500
Received: from VE1EUR02FT048.eop-EUR02.prod.protection.outlook.com
 (10.152.12.57) by VE1EUR02HT004.eop-EUR02.prod.protection.outlook.com
 (10.152.12.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Fri, 15 Feb
 2019 13:58:21 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.12.51) by
 VE1EUR02FT048.mail.protection.outlook.com (10.152.13.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 15 Feb 2019 13:58:21 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%4]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 13:58:21 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCHv2] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxTaCraRKyzzTqEeNDzUOb6MJSA==
Date:   Fri, 15 Feb 2019 13:58:20 +0000
Message-ID: <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::41) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:518EC2E4920B5CE4E54595EE7F9D75BB0C5CB5B5CC1B25C77F3A8B5C16E8CD37;UpperCasedChecksum:92D2516CABA04D84F283EBD246AADF0C5AE2723ECAA6F1BE5CE9940748AFF645;SizeAsReceived:8568;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CUwzH2k5aV1a+EuzE4UNK9l9YFq4Tu5c]
x-microsoft-original-message-id: <e7f69f6a-79f9-775a-4eea-630f5fe31386@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT004;
x-ms-traffictypediagnostic: VE1EUR02HT004:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR02HT004;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT004;
x-microsoft-antispam-message-info: 1VZM3GpJrOQPS4i+UR3ZeIh4mD1sPa8DAACnLahM1Ip24LFQD73NvBv/8kU1piri
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6BD5007BEADE9D469EFDCBABE8987754@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef8b67-a072-4a0f-a06c-08d6934da4b8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 13:58:20.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading from /dev/random may return data while the getrandom
syscall is still blocking.

Those bytes are not yet cryptographically secure.

The first byte from /dev/random can have as little
as 8 bits entropy estimation.  Once a read blocks, it will
block until /proc/sys/kernel/random/read_wakeup_threshold
bits are available, which is usually 64 bits, but can be
configured as low as 8 bits.  A select will wake up when
at least read_wakeup_threshold bits are available.
Also when constantly reading bytes out of /dev/random
it will prevent the crng init done event forever.

Fixed by making read and select on /dev/random wait until
the crng is fully initialized.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
v2: Fixed one white space in the code.
    Also added some more details about the problem
    to the commit message.
---
 drivers/char/random.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bd449ad..c8f16f0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -721,7 +721,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		}
 
 		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits &&
+		if (crng_ready() && entropy_bits >= random_read_wakeup_bits &&
 		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -1826,7 +1826,9 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 
 	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
 	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
+		n = crng_ready()
+			? extract_entropy_user(&blocking_pool, buf, nbytes)
+			: 0;
 		if (n < 0)
 			return n;
 		trace_random_read(n*8, (nbytes-n)*8,
@@ -1840,6 +1842,7 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 			return -EAGAIN;
 
 		wait_event_interruptible(random_read_wait,
+			crng_ready() &&
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1884,7 +1887,8 @@ random_poll(struct file *file, poll_table * wait)
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
2.7.4
