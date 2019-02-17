Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85700C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391F02192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfBQIo6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:44:58 -0500
Received: from mail-oln040092072023.outbound.protection.outlook.com ([40.92.72.23]:32558
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfBQIo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:44:58 -0500
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (10.152.18.58) by VE1EUR03HT012.eop-EUR03.prod.protection.outlook.com
 (10.152.18.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Sun, 17 Feb
 2019 08:44:54 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.18.59) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 17 Feb 2019 08:44:54 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.008; Sun, 17 Feb 2019
 08:44:54 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv3] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCHv3] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxp0Npbqs83BkVEynF/QYRVMIGA==
Date:   Sun, 17 Feb 2019 08:44:54 +0000
Message-ID: <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
In-Reply-To: <20190216182355.GE23000@mit.edu>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0021.eurprd04.prod.outlook.com
 (2603:10a6:209::34) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:4E45B96DF55D9A5493CD25F32AA82B58068610636B04961E18BFA0A7DEC04F4F;UpperCasedChecksum:8CAFE9057D982F23100CF3C1F69F475A1B38D6F591C949115FEA8BAD2EFC1B19;SizeAsReceived:8612;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/kkS9esFZHOVW0QV5f4LBcCCh22G58yW]
x-microsoft-original-message-id: <daaf37f8-96f9-a3e2-a8d6-e8fef6e25908@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT012;
x-ms-traffictypediagnostic: VE1EUR03HT012:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR03HT012;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR03HT012;
x-microsoft-antispam-message-info: WWI/ybk+MutXnRwVxrRoj1kCwHeXqZOVDuIj5ElFOsr6AoDynuypj3AgC4SMF52y
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C4CAF1050D2B99498E07D31BF3384938@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: fdec5c30-3360-4a26-6560-08d694b42fe1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2019 08:44:53.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT012
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
the crng is fully initialized and the blocking_pool is
also initialized which means that more than 128 bits of
entopy have been accumulated in the blocking_pool.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
The v3 version waits much longer than the v2 version,
since first 128 bits from the input_pool go into the
CRNG, the next 64 bits are only accounted 3/4 = 48 bits
in the blocking_pool, so we need in total 192 bits from
the input_pool until the blocking_pool is initialized
And another 64 bits until a select on /dev/random wakes up.

On a system with only interrupt_randomness, this
takes 128+192+64=384 random bits, about 6.5 minutes
from boot until /dev/random is readable.

Maybe this is taking too long, after the CRNG ready?

After the input_pool had already been initialized,
I wonder if feeding the next 64 bits from the input pool
to the empty blocking_pool could already be considered 
to be good enough to derive the first random byte from
the blocking_pool?

Thanks
Bernd.
---
 drivers/char/random.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1a..666102d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -476,6 +476,7 @@ struct entropy_store {
 	__u8 last_data[EXTRACT_SIZE];
 };
 
+static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 			       size_t nbytes, int min, int rsvd);
 static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
@@ -719,8 +720,16 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
 		}
 
+		if (crng_ready() && !blocking_pool.initialized &&
+			entropy_bits >= random_read_wakeup_bits) {
+			_xfer_secondary_pool(&blocking_pool, entropy_bits / 8);
+			r->entropy_total = 0;
+			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
+		}
+
 		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits &&
+		if (blocking_pool.initialized &&
+		    entropy_bits >= random_read_wakeup_bits &&
 		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -1317,7 +1326,6 @@ void add_disk_randomness(struct gendisk *disk)
  * from the primary pool to the secondary extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
 static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
 {
 	if (!r->pull ||
@@ -1661,7 +1669,7 @@ void get_random_bytes(void *buf, int nbytes)
  */
 int wait_for_random_bytes(void)
 {
-	if (likely(crng_ready()))
+	if (crng_ready())
 		return 0;
 	return wait_event_interruptible(crng_init_wait, crng_ready());
 }
@@ -1851,7 +1859,9 @@ void rand_initialize_disk(struct gendisk *disk)
 
 	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
 	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
+		n = blocking_pool.initialized
+			? extract_entropy_user(&blocking_pool, buf, nbytes)
+			: 0;
 		if (n < 0)
 			return n;
 		trace_random_read(n*8, (nbytes-n)*8,
@@ -1865,6 +1875,7 @@ void rand_initialize_disk(struct gendisk *disk)
 			return -EAGAIN;
 
 		wait_event_interruptible(random_read_wait,
+			blocking_pool.initialized &&
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1909,7 +1920,8 @@ void rand_initialize_disk(struct gendisk *disk)
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
+	if (blocking_pool.initialized &&
+		ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-- 
1.9.1
