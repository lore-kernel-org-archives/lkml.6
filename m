Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+g0dweUjuQTryDlTE26RA+li1aDMfgJ56GshZbIvn9GWB+e4rEeISA6MPYXgeFwtsuWL3Z
ARC-Seal: i=1; a=rsa-sha256; t=1524406077; cv=none;
        d=google.com; s=arc-20160816;
        b=BhFubMc64RGKZ3qpxSgZmQnQJA/gt1nznS0z+xLIbXlJHjA7t7CqD9f1t5DV6ptZLU
         XOSK2ZbOQ0LL5TW2RGmNUuMNHC6ZDwMO3ZpEgB97m+Az6ZxP+4GWjh0m2X3xQoLbZGeD
         xcmpBPsnEU9DblN55BTxF/r/YZi99Er4SG+EjG6W702q1fg8fEgugHvCwarehV34yYvz
         iCOilM9pPxciqqkQExnjSL6e/Qfq7epqKA3d/o+UYMEDmSHYiAdN3Bv0uq7xZEiAkHaq
         Wv/ilSYVqutFWy2JKUoeSYpweRYVylkY4K8vMgmhQvxj9ZYEEjKYgKMPskTnapEac04k
         +Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LJWqSfOPDlPPaVj50HMV5r1yOiXNM3GibMI8JrA+n5k=;
        b=dTFX3T6LOx5yRvsEXu46GywRlaSFdX2U7NU3GJgpnVuve3oDFJCfTCQ0APiP+wvYbK
         UUWaSt0+4G6yMBniG02WFChl0LBs8oXgLiq8Q7tnhk7yaiYCJHTKLj1z5SqA4r8OX4g3
         Ogfr8ahsOCuElTl7LfUHB8WkBBRc+wDlnmVYI9Q060Wubn3vkGC5q/jtWprRK0kiW8GK
         31jCed5rgY6d8vtClRbPWUE8b0OFFM+FO0orNZstbBNSbEsgBA9OixDJnJq9KbtB1F5j
         mMwx4fXOJsIv2PbnV3QMPkdlzot6VVeA5AZKHuZsYvYh/q61UtBZZGVZJ5gQtWZJXCGe
         FWzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathieu Malaterre <malat@debian.org>,
	Alex Smith <alex.smith@imgtec.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 103/164] mmc: jz4740: Fix race condition in IRQ mask update
Date: Sun, 22 Apr 2018 15:52:50 +0200
Message-Id: <20180422135139.621177123@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455143804605814?=
X-GMAIL-MSGID: =?utf-8?q?1598455627182941118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Smith <alex.smith@imgtec.com>

commit a04f0017c22453613d5f423326b190c61e3b4f98 upstream.

A spinlock is held while updating the internal copy of the IRQ mask,
but not while writing it to the actual IMASK register. After the lock
is released, an IRQ can occur before the IMASK register is written.
If handling this IRQ causes the mask to be changed, when the handler
returns back to the middle of the first mask update, a stale value
will be written to the mask register.

If this causes an IRQ to become unmasked that cannot have its status
cleared by writing a 1 to it in the IREG register, e.g. the SDIO IRQ,
then we can end up stuck with the same IRQ repeatedly being fired but
not handled. Normally the MMC IRQ handler attempts to clear any
unexpected IRQs by writing IREG, but for those that cannot be cleared
in this way then the IRQ will just repeatedly fire.

This was resulting in lockups after a while of using Wi-Fi on the
CI20 (GitHub issue #19).

Resolve by holding the spinlock until after the IMASK register has
been updated.

Cc: stable@vger.kernel.org
Link: https://github.com/MIPS/CI20_linux/issues/19
Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/jz4740_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -362,9 +362,9 @@ static void jz4740_mmc_set_irq_enabled(s
 		host->irq_mask &= ~irq;
 	else
 		host->irq_mask |= irq;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
