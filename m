Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtfNdObo8/KSyM4i98uMMav1PNg7fJ2nNd/wGNRDWVZWhsylt+4X82Mm1B/3sJtPcfHjd/A
ARC-Seal: i=1; a=rsa-sha256; t=1520955442; cv=none;
        d=google.com; s=arc-20160816;
        b=C/qexqQlya0/yaZlJWMvwGms17+d/6agGidJNchLSVg3X3nndxF+54VHdGlE94oy/e
         DF9XcEz4QrFw1CsGBQeZf9WGoP5du6PA/pl9C2y0syNDoH8JAxs3lElQzMDSzlpzFzdo
         A9jh4ar06FlOHMTgFa8r0vnc52lyLuacDFF1uEJrL6kYzVbWMIEo2MUmDq0+LUPwASxJ
         GvKDREnbBeuqBCnmxbo3lmCNhArkJpUySmPZNpee93hv14h97x+mdGc0dN7YoIH6yKxG
         Yg4qaf/dQ4kusw47fk8s4D+ZLKaXsvxy4iGInsv2bagACbE8i9Vn1PwTwC8LGp8SXUYF
         ahNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6WGoGS4jhrZ85uuBOnJwh56HRBxDUn6HfbxRaE5p6Js=;
        b=tOjtFDj2Q/dL76wT6cLB2s4IAUkPgwluAMv0nOuP9JU9JkFO9ghTSB/0kBx5TvuIXx
         BkjnmmrKhPJ/RwmtW1S+GIbUGSheeBP6PKmp3YJFGlHv2aEwUjN6Q3tGQSkUjrcZtVM0
         BGBCVgdsZvhAWJNN9/AnF+GV/pmnzoaRYWmOKaXN7/FeIatIsBASScYflS+ux/KuCgCK
         2P7SNPheRAjF+UQQfM6B0XA1BSA9zLHPOz3HyzuvPfB8pCgof58NwNB6GToezho5dE6E
         wfLpxDTC/okmMcFG+guK7n/AqecnjXAthd5LzYxqw8qXulKY7iNoUnBVAOVkI89z44Rg
         +dnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 051/140] regulator: stm32-vrefbuf: fix check on ready flag
Date: Tue, 13 Mar 2018 16:24:14 +0100
Message-Id: <20180313152501.694373594@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836794091924222?=
X-GMAIL-MSGID: =?utf-8?q?1594837374048210872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit f63248fac563125fd5a2f0bc780ce7a299872cab upstream.

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/stm32-vrefbuf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct r
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
