Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QYR4oV5uc2yTcOgS8P7AykPz7z+3PKiFEWAA3s5u3KQhf9LKjVUx8F9REdmksph3DktLj
ARC-Seal: i=1; a=rsa-sha256; t=1517591682; cv=none;
        d=google.com; s=arc-20160816;
        b=MRJ+pfAypS8MsQ2G2Kj8Km7pfK5tFbY/K2gfPAYxbptgqsBc7wMe66U3BjGLStbxyS
         0hitQPTr4Uv6knfFCBBW7MH5J0KM1COoHsqw+GtC3NJS/Q8gMcFwBtfnPKxqlbDZFjIQ
         wByJRW4IQzvFu7mOKIgcZgT1znOBYf+wXHr9yxV9qcPkI39Rr7F65BPsYHiW/oOOTYIU
         gEKcs5j7r2UbIxTZhevGoWqKenQ43ugscE1Ko0nsyOyVrkfcpOjK1Sjl0hVhbB9EN7WH
         VkkQeY7hB5UFLZVnF2ZfEcG4xewifiIG8oB0pRo4nnTJkL8VEYlPGSDs/3om0KALKuS0
         ILsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=50ZbtwsparD1jBRcBrDBu7kcYX/jLBx8D4qEgoJaZwY=;
        b=z7/q8/4XiRZscWMDNibuysP4rgq0BPRvlIdR0FI/TxeNjM87l4bXTL2UnnZvn2vkul
         aclo0wR6fEFfMILLC+D19JtX4+kiIe1ito1IN27lVdxe6rQOaSMsZO9qkdV706/I0zeI
         VYcOFVow109I950B5suldiBzeGofA28Agk1e7cQqmQ4wQ4HVRxBH3ZfUWFc2XAciquxF
         h+dhtxle/64KeY7FknYoY50TMqGlfQxFuBwaylWXG1oEVYKgiHmeTt/GeoBayniuUs7x
         v9oJPWT/UspmpDTUDsuceykQrxHUSEFJ6eLsMJSwq0065JNVGgGR19VcgrnqygHRpjAs
         dzpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gilad Ben-Yossef <gilad@benyossef.com>
Subject: [PATCH 4.14 131/156] staging: ccree: fix fips event irq handling build
Date: Fri,  2 Feb 2018 17:58:32 +0100
Message-Id: <20180202140846.301644626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310215763975115?=
X-GMAIL-MSGID: =?utf-8?q?1591310215763975115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit dc5591dc9c03e4cd22d3f0c3659196cc34668452 upstream.

When moving from internal for kernel FIPS infrastructure the FIPS event irq
handling code was left with the old ifdef by mistake. Fix it.

Fixes: b7e607bf33a2 ("staging: ccree: move FIPS support to kernel infrastructure")
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/ccree/ssi_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/ccree/ssi_driver.c
+++ b/drivers/staging/ccree/ssi_driver.c
@@ -141,7 +141,7 @@ static irqreturn_t cc_isr(int irq, void
 		irr &= ~SSI_COMP_IRQ_MASK;
 		complete_request(drvdata);
 	}
-#ifdef CC_SUPPORT_FIPS
+#ifdef CONFIG_CRYPTO_FIPS
 	/* TEE FIPS interrupt */
 	if (likely((irr & SSI_GPR0_IRQ_MASK) != 0)) {
 		/* Mask interrupt - will be unmasked in Deferred service handler */
