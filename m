Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x225nC7FtbdlB8dyrpyF3E2ETLWb6Wv8QmtKnWYtYygc+8IgvvycOPL/0qleW/hyv69nGMcgQ
ARC-Seal: i=1; a=rsa-sha256; t=1518699812; cv=none;
        d=google.com; s=arc-20160816;
        b=PmrFSMG4D4NUJnvR7vBL0k2RVZAfgtQ3ZajQSn0gkV2mUwSiFGb713DfWTMEBHE0b4
         nOBtAao3n4aE0W3OELBa5VPykw869lrXJWKuB7S+yYV6xRblYXOjiwZBLGcdDXepTo/T
         +/P3tnxK+dpSJ4rXDTajsL7wsnqkQqKdMSlVSIMtfhsd5/VQgVm51ZjC7uBst80TqN+2
         l1Ah+VDP+7V3RXKa2u6zx4Iu8XC+SZH1GAad1hpThpK+gn6O3IWF/5szSJWH1TrvpdZR
         jXMfgiIhPqGajyR4bZ8NvA162h0IdyWEt+xZ6SZB6ryOYRMyk4EpACUL9yvEsURbk7hV
         7u4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=Q+avL/3/Ae/cJ2cfnXYHRi6MCDDRA5D23aYHii/qYPM=;
        b=cbS4zZH5Z5q60pHNrf4QfaR7FkUxO0PQLqVMnzlZUYYAlVxpziRbpRt/lBWQwOgJSn
         l7YRGLyi5ta2Qlqpr0VmddCtNPEjUIdV1NyxVnIYUdP+dZFcQwMq3dMmy+0hhcPeXY96
         UPDiz+ZzJW6yFo192lBuGxJjDPIaV8P8dvtakz3SiuRuYEmtdAMR/Z5tExP6aFAar7c6
         970V8KM+zUWXEENpNEwRqNS1hp+YnBLNqXCRZnGgyL2TfcHVxYlWlqLM/udrYho9CKpa
         fiduPgjltGqYrQAiwYIDYpXEUnKzW7X+yqgPQ+6HEGc3ofxNlwvuoINFzElP4OnZod4o
         N24g==
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
Subject: [PATCH Resend 1/5] hwrng: stm32 - add reset during probe
Date: Thu, 15 Feb 2018 14:03:08 +0100
Message-ID: <20180215130312.23612-2-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174661924426?=
X-GMAIL-MSGID: =?utf-8?q?1592472174661924426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid issue when probing the RNG without
reset if bad status has been detected previously

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 63d84e6f1891..83c695938a2d 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #define RNG_CR 0x00
@@ -46,6 +47,7 @@ struct stm32_rng_private {
 	struct hwrng rng;
 	void __iomem *base;
 	struct clk *clk;
+	struct reset_control *rst;
 };
 
 static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
@@ -140,6 +142,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	priv->rst = devm_reset_control_get(&ofdev->dev, NULL);
+	if (!IS_ERR(priv->rst)) {
+		reset_control_assert(priv->rst);
+		udelay(2);
+		reset_control_deassert(priv->rst);
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	priv->rng.name = dev_driver_string(dev),
-- 
2.15.1
