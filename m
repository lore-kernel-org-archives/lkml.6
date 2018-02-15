Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x224iA01df9VcnkPGHruyJmqClHoQ5Sw7amgR5EAo7oC9sIKXhhOXK12yyfLR6Gn1604J6g7m
ARC-Seal: i=1; a=rsa-sha256; t=1518699812; cv=none;
        d=google.com; s=arc-20160816;
        b=QXzZwukZiSsBAwImCYGbXZjbu6MjU6AjAG7CMC/TdTjbGTTd81j5PdBJ4+ZZYoZwrF
         G+jHJdgEK0IdVP0YMsSLFo6FEH+OzpRyk4XjZ+CfGAwMNXvJgjV222viqWlThQDn01hE
         7s/kF52TfJEyhEER9PYMtujsiFnffCUxZL2TXveI4n/GY+PLe1pnWfU5dSYBdsJplcno
         k4sm7MIoVFAcnCR1IQtLXexU5YdGSRIvPzBNfPvovZha6mN/Ijy8WJRavww+iu3R0TMw
         C36s6YmMGx3SNA3KeLoBW6PJxuhgI6dQaa2ysSW1YleQLS5Qbl4utgoCk8N4gJVqdpS4
         XLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=28jwu9ptR58kDup6IkRgBWniswFNZGh0E7m+sjmUq5w=;
        b=UFcM6gKuGw7j3SV7Zcjgo1vucopmzmm64KIU6iCjybav75o2/0otu8/Td0ZTWA10N5
         nuDpx9Ue2dLZd1orsfvIYqBWtMoNPilDh3slqzEG/j/CRkPIVcDbjZlWfBGpy1delTc7
         dRojVdwy5Ji0jlaGCJxPNQcKT18NmYQKGZTcsobm5QDEsYN8aozYmgWHadUkoyC6RbMU
         gEjDIsKq6txqNzGUesekKFfi4HYH2muCjlLYVEWPtZvgW/a3My3aOwLBZBDx+DJN/k1l
         pNgmmIWCyYHnV9zSAei0KKcBp38oPvchblPbkmuAaolaRJ2aZ219eX7TC4JCwZcReZoP
         qAqQ==
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
Subject: [PATCH Resend 3/5] hwrng: stm32 - allow disable clock error detection
Date: Thu, 15 Feb 2018 14:03:10 +0100
Message-ID: <20180215130312.23612-4-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174813637735?=
X-GMAIL-MSGID: =?utf-8?q?1592472174813637735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new property that allow to disable the clock error
detection which is required when the clock source selected
is out of specification (which is not mandatory).

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 83c695938a2d..709a8d061be3 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -26,6 +26,7 @@
 
 #define RNG_CR 0x00
 #define RNG_CR_RNGEN BIT(2)
+#define RNG_CR_CED BIT(5)
 
 #define RNG_SR 0x04
 #define RNG_SR_SEIS BIT(6)
@@ -48,6 +49,7 @@ struct stm32_rng_private {
 	void __iomem *base;
 	struct clk *clk;
 	struct reset_control *rst;
+	bool ced;
 };
 
 static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
@@ -101,7 +103,11 @@ static int stm32_rng_init(struct hwrng *rng)
 	if (err)
 		return err;
 
-	writel_relaxed(RNG_CR_RNGEN, priv->base + RNG_CR);
+	if (priv->ced)
+		writel_relaxed(RNG_CR_RNGEN, priv->base + RNG_CR);
+	else
+		writel_relaxed(RNG_CR_RNGEN | RNG_CR_CED,
+			       priv->base + RNG_CR);
 
 	/* clear error indicators */
 	writel_relaxed(0, priv->base + RNG_SR);
@@ -149,6 +155,8 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 		reset_control_deassert(priv->rst);
 	}
 
+	priv->ced = of_property_read_bool(np, "clock-error-detect");
+
 	dev_set_drvdata(dev, priv);
 
 	priv->rng.name = dev_driver_string(dev),
-- 
2.15.1
