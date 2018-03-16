Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsHoK9FtMLCBGP3XwvYtqbzUl6AW16GwoXG8DhINpD3jYcub30TPyuje5lmwgR3T20yf491
ARC-Seal: i=1; a=rsa-sha256; t=1521214749; cv=none;
        d=google.com; s=arc-20160816;
        b=JwWBQSaU9/yyLsIGbbIXOPHRCYGljyp6BqKh8w8Oq9CE89CAPmezlwVWXC8q5H0qoY
         56jOA0O+hiRx4eG4YGqLauZG0l9ir3hjMnKwi7o70mZEzdPEiB98rcGbNTl05EDhYl6o
         mFIS51iWdgSYImWK4jI0RStJP6dbUWfwQ+ZMtoqcwLPVGhwm2F0tFR8QJohcrLG9ZwSm
         U3AcBU5hy8OT8i8WyMP9DEuvXEtWKLnq3sjeik56S2SjPF8pKKWnVwEz9JZgIqlypG54
         hqQPtF+Iqn9i+gxBAfEZaoDWbikTQut1MBydxjfzS53eGrPcuyNdmrOWDz44FzaAywMX
         +C2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=urA3f7pS8Z/ZZyLtadXe9CFv7orjvgbaLUdNcRF/XrI=;
        b=OJHL/3cCTsLwfRsGY4XpE070pvVW5YWU8BpWhgQ3XookRAWCpLyNvYy6Zq65EbCfet
         SKRYCNEvXKEwQI/yq0ZTQ6VpoTOgXIDmfokoTik/JfVgqPPHMFwBs6HaDe92sOAVa1YI
         UkDJPuEQxEI3C2TZ+heZp4kfzV/J6yfSEBEuZxAHhXLsn093v6prfZUwLtQJyXPsxirI
         IbADBUfqEa/a6UBNmwogwQCNk9Au0Li/yZqyxSZzs1O+eV62oaA8uBeKchYNKsi4pQb5
         y5Jl7FxviZvnYpoEcEYnyya9HiDMsq+5VGzFUJoc4H+PKeJq7GGlQEP4UV+fWAF/frSd
         94sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 108/109] dmaengine: qcom_hidma: check pending interrupts
Date: Fri, 16 Mar 2018 16:24:17 +0100
Message-Id: <20180316152335.715008179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109277054772044?=
X-GMAIL-MSGID: =?utf-8?q?1595109277054772044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sinan Kaya <okaya@codeaurora.org>


[ Upstream commit 38680bc6b1e3592bc9e18adc1d6e259667df27ce ]

Driver is missing the interrupts if two requests are queued up at the same
time as the interrupt handler is servicing a request that was just
delivered.

The ISR clears the interrupt at the end but it could be clearing the
interrupt for an outstanding event. Therefore, second interrupt never
arrives.

Clear the interrupt first and then check for completions.

Also, make sure that request start and interrupt clear do not overlap in
time by using a spinlock.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/qcom/hidma_ll.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -393,6 +393,8 @@ static int hidma_ll_reset(struct hidma_l
  */
 static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 {
+	unsigned long irqflags;
+
 	if (cause & HIDMA_ERR_INT_MASK) {
 		dev_err(lldev->dev, "error 0x%x, disabling...\n",
 				cause);
@@ -410,6 +412,10 @@ static void hidma_ll_int_handler_interna
 		return;
 	}
 
+	spin_lock_irqsave(&lldev->lock, irqflags);
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	spin_unlock_irqrestore(&lldev->lock, irqflags);
+
 	/*
 	 * Fine tuned for this HW...
 	 *
@@ -421,9 +427,6 @@ static void hidma_ll_int_handler_interna
 	 * Try to consume as many EVREs as possible.
 	 */
 	hidma_handle_tre_completion(lldev);
-
-	/* We consumed TREs or there are pending TREs or EVREs. */
-	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 }
 
 irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
