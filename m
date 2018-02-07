Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeBGKjK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:39:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36379 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeBGKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:39:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180207103900euoutp0265072c89cd387b3ef640a564c5b6b280~RBOdBK1Wc3044530445euoutp02X
X-AuditID: cbfec7f4-f790c6d0000075d3-5a-5a7ad743d4b5
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: [PATCH v2] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
Message-id: <64a5e903-c6c1-28f4-8af4-dbbd7bef17ef@partner.samsung.com>
Date: Wed, 07 Feb 2018 11:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rO16uiDBZt1LLYOGM9q8Wc8y0s
        Ft2vZCzOn9/AbnH/3k8mi8u75rBZzDi/j8li3cZb7BZrj9xlt/j/q5nZgctjy8qbTB47Z91l
        99h2QNVj06pONo9/C6ewePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG4sntLAUXxSte3nrA
        1sB4UbiLkZNDQsBE4vX1ZewQtpjEhXvr2boYuTiEBJYySjS0zGCGcD4zSvx/8ZoJpuP5tU2s
        EIlljBKH/t0CSwgJPGOUOLjFFcQWEdCRWPlyMSuIzSzwhUmi+UoYiM0mYC7xaPsZoHoODmEB
        N4ndX1RAwrxA5o5/78GuYBFQldhy5QYbiC0qECGxcOpTRogaQYkfk++xQIzUlHjxZRKULS7R
        3HoTypaX2LzmLdjREgKP2SS2fYRISAi4SMz6+YQRwhaWeHV8C9TLMhKdHQeZIBr6GSWW3zjF
        DuFMYZQ4Pu0q1MvWEoePX4T6hk9i0rbpzCAfSAjwSnS0CUGUeEg8WboMapmjxIeO7+yQQImV
        uLy8i30Co9wsJE/MQvLELCRPzELyxAJGllWMIqmlxbnpqcUmesWJucWleel6yfm5mxiB6ef0
        v+NfdjAuPmZ1iFGAg1GJh9dgQ2WUEGtiWXFl7iFGCQ5mJRHenyurooR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInz2ka1RQoJpCeWpGanphakFsFkmTg4pRoYlx5dLThHZNeBapUY4aPKT5nUJBV+
        a1pZGP1Sdz8TV6NrJ9Zz8I6HjbzzuxcFnBsVwncta9SxfCl13HVWJc/JEMZrCc8Dl2/jeKDm
        29yYfSiQfY9vh+Kv6Va3BXXTFm+P8JnjHlN5/8y3O599Ji0OvNIxe3bzhI/RIdvdnk8+71sm
        83ubT8AlJZbijERDLeai4kQAl1zQvTsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xy7rO16uiDL6eYLfYOGM9q8Wc8y0s
        Ft2vZCzOn9/AbnH/3k8mi8u75rBZzDi/j8li3cZb7BZrj9xlt/j/q5nZgctjy8qbTB47Z91l
        99h2QNVj06pONo9/C6ewePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG4sntLAUXxSte3nrA
        1sB4UbiLkZNDQsBE4vm1TawQtpjEhXvr2boYuTiEBJYwSmzd2sYO4TxjlLg69QZYlYiAjsTK
        l4tZQRLMAp+YJA7NXMAIkmATMJd4tP0MUxcjB4ewgJvE7i8qIGFeIHPHv/fsIDaLgKrElis3
        2EBsUYEIic6V81kgagQlfky+xwLSyiygLjFlSi5ImFlAXKK59SYLhC0vsXnNW+YJjPyzkHTM
        QuiYhaRjFpKOBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjYduxn5t3MF7aGHyIUYCD
        UYmH12BDZZQQa2JZcWXuIUYJDmYlEd6fK6uihHhTEiurUovy44tKc1KLDzFKc7AoifOeNwCq
        FkhPLEnNTk0tSC2CyTJxcEo1MEZdL3x1e8u2J9on2TVPTuyzPHfgefcn4zc8TwrWCvF/272m
        Uk+jKuSZjSeP2kKVaV0W6yLymmbfeNDKvDstnalksbOIiAZH7O4PjqoPerjjzpQdE3g9+fby
        Odpvo/54qJ9qVL2jxNG18vnmPmH5eMOOpncT/2223XyZ7dtGldn7GzX7/C6q/1FiKc5INNRi
        LipOBAAeODDUgwIAAA==
X-CMS-MailID: 20180207103859eucas1p13385c140fe1874645ee3ae5127d0e232
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180207103859eucas1p13385c140fe1874645ee3ae5127d0e232
X-RootMTR: 20180207103859eucas1p13385c140fe1874645ee3ae5127d0e232
References: <CGME20180207103859eucas1p13385c140fe1874645ee3ae5127d0e232@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AES-ECB mode crypt is done with key only, so any use of IV
can cause kernel Oops. Use IV only in AES-CBC and AES-CTR.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 8f9702aad138 ("crypto: s5p-sss - validate iv before memcpy")

---
version 2:
Change commit message.

Tested on Odroid XU4/HC1, kernel 4.15 with following command:

fallocate -l 128MiB /tmp/test.bin
dd if=/dev/urandom of=/tmp/testkey.key bs=128 count=1
sync
cryptsetup luksFormat --debug -q -d /tmp/testkey.key \
  --cipher aes-cbc-essiv:sha256 -h sha256 -s 128 /tmp/test.bin

The original report by Anand Moon:
https://www.spinics.net/lists/linux-crypto/msg31180.html

Oops reproduced with cryptsetup 2.0.0, kernel 4.15,
in .config in crypto API ECB support was turned off, and s5p-sss AES driver on.

cryptsetup is using aes-ecb and has req->info in aes_ctx set to 0x10,
which caused Oops:

[ 2078.683779] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[ 2078.689148] Modules linked in: algif_skcipher af_alg sd_mod sg
evdev uas usb_storage scsi_mod gpio_keys fbtft(C) spidev spi_s3c64xx
ipv6
[ 2078.701377] CPU: 1 PID: 15 Comm: ksoftirqd/1 Tainted: G         C
    4.15.0-rc9-xu4krck #1
[ 2078.709861] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[ 2078.715932] PC is at memcpy+0x80/0x330
[ 2078.719652] LR is at s5p_tasklet_cb+0x19c/0x328


 drivers/crypto/s5p-sss.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 142c6020cec7..5c0496d1ed41 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1926,15 +1926,21 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	uint32_t aes_control;
 	unsigned long flags;
 	int err;
+	u8 *iv;
 
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
 
-	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC)
+	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
-	else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR)
+		iv = req->info;
+	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
+		iv = req->info;
+	} else {
+		iv = NULL; /* AES_ECB */
+	}
 
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
 		aes_control |= SSS_AES_KEY_SIZE_192;
@@ -1965,7 +1971,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
-- 
2.16.0
