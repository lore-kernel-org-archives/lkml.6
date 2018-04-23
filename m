Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AIpwx4+cCgQYbr+MAyTRjt07as2pI6ELVqb3plvauhbNRSLLdURRVtOEIykE48ErMnhY/9sStBzh
ARC-Seal: i=1; a=rsa-sha256; t=1524496272; cv=none;
        d=google.com; s=arc-20160816;
        b=rYTNIWpHvMAH9rr+0QyyO6KyhJO5uq3HPmTkOuxz3onY8OP0lxK4OVAaxbHMucVTds
         oO/Tu/PPIA4RsHLOi1P7oGEKxRxpCaeath58LQsASUp84X9RkRRndnHjQ4Jtaw2iDAoQ
         HkbCNe5Xqi91juds3pQJhenHs1b8RBry10Pa5BBfoQkFug6iC7awPBvDQuYrz0A4UuOx
         c+AzUl7cuRjDSY934vOJUHM/jr6BAcnOX0OYso24Le7IWk8sLgA8sBaj2kyMR0L4gWAA
         o2G9ltB+B4ukIS1KSnwCNUg+7afDLkjewsRtlIonqH/BEvCUW6s34QgLi4N2Sgooy9Od
         X2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=o1y+mo+WLeNt+RQRMrXAIRKAsWI9V6MathBPbxoffW0=;
        b=oTbdJ83yBQqRTcY0z4HJlJvJntEKABBGzTFe4vfFgHYh4PL4KOVS2WOcUAUuzgUvmR
         mucMugcVQcJhgSM55hmoz8oEJF+ZOxjoGtCQhACrBIqWkVl+m9tQnbSyzkmEKRlUbVZJ
         xuD61rNFYxCKZRirE4/ZVJAwCPs7jlyEYLOVYmnYoXhOr5wSh7L0I7EHrA0IbxwSL311
         B82z3OXzLdM4yVP2bdKH3o7fUId2b3vdLgKDL7rDL8OQNP86AffS/v4ksnzzfCo2HJas
         lE9fh9lbgoniRL1ud3Fb+fHuUnYF1ISBAaDSfSLjFWwHUkzt7bGrGqckwsZMLYOl18kM
         uGwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
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
Subject: [PATCH 2/2] hwrng: stm32-rng - fix pm_suspend issue
Date: Mon, 23 Apr 2018 17:04:26 +0200
Message-ID: <20180423150426.22198-3-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180423150426.22198-1-lionel.debieve@st.com>
References: <20180423150426.22198-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550203365446391?=
X-GMAIL-MSGID: =?utf-8?q?1598550203365446391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When suspend is called after pm_runtime_suspend,
same callback is used and access to rng register is
freezing system. By calling the pm_runtime_force_suspend,
it first checks that runtime has been already done.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 0d2328da3b76..042860d97b15 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -187,8 +187,13 @@ static int stm32_rng_runtime_resume(struct device *dev)
 }
 #endif
 
-static UNIVERSAL_DEV_PM_OPS(stm32_rng_pm_ops, stm32_rng_runtime_suspend,
-			    stm32_rng_runtime_resume, NULL);
+static const struct dev_pm_ops stm32_rng_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_rng_runtime_suspend,
+			   stm32_rng_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 
 static const struct of_device_id stm32_rng_match[] = {
 	{
-- 
2.15.1
