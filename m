Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bhI/i901Zlr5PzGun37Vpc2RClmbEHbEWmDMsaol2PugzeyrPnVYBYE5Xs06dkC0R9OEI
ARC-Seal: i=1; a=rsa-sha256; t=1524406932; cv=none;
        d=google.com; s=arc-20160816;
        b=ELwWrYCCk/AAiBxr1vv9IF++VGrmHUYMibD1Ic0FuJViBuukMmYiyJEegGR1tb29w+
         S3cSf1bRTQ6VnvnPk3E1/Z4AwBwcDFA1jLDVNruSZyi5VF0QBOkDcSWhhr7EH7GIzG6s
         oyOtHv/GUwjBtAB79wQoMx9QkF9RO+7DLWJv4SftTgtZzEgmZnjl4EgxADO+xF4waUZq
         Vq1Ax4zEuSzx46TRhU8k1J9fq7z95EKUTDDB/5b2wIWOK1hwA8WXGB8RO6ITTK1TtQYC
         ALRaZUbXr6BVV9PDywYbqEZY0b4B7O9sR58XObSeAWPGHr+cs7S5/GLHZMZnvQS5e52J
         wR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Z9F8fuRHYm8G7KbhzM7naaPUNWLKuHDI3ZnyO6+FVo=;
        b=SIF66z7tvTLp5SWsLpVmtQFmbutqfzLyeBdoIq2+m+qxnKtdZ0E5/NY87MOPINZ7yn
         KaR8/kOHX3M/XVtePsMNC+Fp4018AAxLuDt/Da31wUcyU4uuDtrjnIKwVl2iRfvzWa5n
         DtnUb7xZJxnTXAT3gTybgXLr6nDHzrnsFswg3A/CElrPn6v6cp6aBU5AE4hbMigFEyxm
         AcffM/E7/A3eIAadqbxX1VCWMJF7tklycvluuUY/VqcxlSFp5iBnRlvhup9Iwbfay4QW
         TEErqw7MTxdLExwVrKlknMzXHLww4GnBI+LA7YAKxeb2EpgnBJSCFJRZWPHK+f05CN2P
         OQzw==
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
Subject: [PATCH 3.18 26/52] mmc: jz4740: Fix race condition in IRQ mask update
Date: Sun, 22 Apr 2018 15:53:59 +0200
Message-Id: <20180422135316.672332055@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455143804605814?=
X-GMAIL-MSGID: =?utf-8?q?1598456523953611760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -368,9 +368,9 @@ static void jz4740_mmc_set_irq_enabled(s
 		host->irq_mask &= ~irq;
 	else
 		host->irq_mask |= irq;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
