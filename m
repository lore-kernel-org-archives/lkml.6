Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x226EXXoCxGiKh8VnzAAkq6//XwDq6kGr/YtGS7CpnGfRBAgij0pYpsKOp7Ce9IUUsNov2kL0
ARC-Seal: i=1; a=rsa-sha256; t=1518699812; cv=none;
        d=google.com; s=arc-20160816;
        b=WchSTojdZnXDdSGe+y4PfTxl4iSbgxLigBjzzIquupqIl9CXQAloy7Nh0vBLF7x/O7
         B0Td1psjLpltTYoxKApyjFzQGxsPgXvN6vpAciNMl5oG7dlKm0iRwSrpL4HD7b0BUmij
         JpT3s7FegY0BuMi7JyPOtui/omk6blUrjMH6JyYCj/xcfGe10qvDz7skfRQutJU/SoLo
         +8QQbnnwMIGrz6R5e5+p0Q9dGdUDSa9WDIaXcYqkKsXLeUKSFQOAaqqKAdX+b5EpySnU
         UspzhrCb1UiZ2zd0j28RE2YnTCi/jA1tzfHKnhpPuN3bO0zgNW47jIdABh1WYb0WSFgh
         vfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=P5GtPZLkD+IfQTqviWVbl7tAqg+3waZ4rz0wxgbJCpc=;
        b=NG4vPXql/i3ky/bFeL2tgft8/qYqDhQx27f3B/F/ibOEXIUt6c5G9PomXxwi0533CS
         SSErLuubxqkpXLMQyi/CAsWY5NJtm0XKoLjNlxPwru8Y2z7iM8otZuDAoS/JfhLHmFCC
         5irjvrbR1ZAe2uxzuWhkRQaE4wThEZbqTl1SR3wEcpJOKw9UUjos9FIqWRmyLt8C4GVa
         Q1y8R607s/I7ktfCBlIwx7SZxEDk4sc23G16NVEkaGXi3FvXE8uRGkOHhc1/JmH2FFQ6
         eU4vSaFhyly9ZF/CnNfJfVdfFldkkz4P3EpM/k5e5m++4aU4QwHQ6gcgTY4rNYTZJW9J
         sP8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
From: Lionel Debieve <lionel.debieve@st.com>
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring
	<rob.herring@linaro.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ludovic Barre
	<ludovic.barre@st.com>
Subject: [PATCH Resend 5/5] hwrng: stm32 - rework read timeout calculation
Date: Thu, 15 Feb 2018 14:03:12 +0100
Message-ID: <20180215130312.23612-6-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174932258572?=
X-GMAIL-MSGID: =?utf-8?q?1592472174932258572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Increase timeout delay to support longer timing linked
to rng initialization. Measurement is based on timer instead
of instructions per iteration which is not powerful on all
targets.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 709a8d061be3..0d2328da3b76 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -35,15 +36,6 @@
 
 #define RNG_DR 0x08
 
-/*
- * It takes 40 cycles @ 48MHz to generate each random number (e.g. <1us).
- * At the time of writing STM32 parts max out at ~200MHz meaning a timeout
- * of 500 leaves us a very comfortable margin for error. The loop to which
- * the timeout applies takes at least 4 instructions per iteration so the
- * timeout is enough to take us up to multi-GHz parts!
- */
-#define RNG_TIMEOUT 500
-
 struct stm32_rng_private {
 	struct hwrng rng;
 	void __iomem *base;
@@ -63,13 +55,16 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 	while (max > sizeof(u32)) {
 		sr = readl_relaxed(priv->base + RNG_SR);
+		/* Manage timeout which is based on timer and take */
+		/* care of initial delay time when enabling rng	*/
 		if (!sr && wait) {
-			unsigned int timeout = RNG_TIMEOUT;
-
-			do {
-				cpu_relax();
-				sr = readl_relaxed(priv->base + RNG_SR);
-			} while (!sr && --timeout);
+			retval = readl_relaxed_poll_timeout_atomic(priv->base
+								   + RNG_SR,
+								   sr, sr,
+								   10, 50000);
+			if (retval)
+				dev_err((struct device *)priv->rng.priv,
+					"%s: timeout %x!\n", __func__, sr);
 		}
 
 		/* If error detected or data not ready... */
-- 
2.15.1
