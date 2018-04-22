Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DeFdIZ0H2AkeANPJUTHXuUFfY5NR0R+I8vzNxWFI0DUzNInvvUnPbYJQqE3zpIMAjIGy7
ARC-Seal: i=1; a=rsa-sha256; t=1524405616; cv=none;
        d=google.com; s=arc-20160816;
        b=RC/atUqqX8nATnK1Q1+KZxV/QBAZu4Finkd5pZXTQvnMopDUCYlhSOgy4LU0vA+Iep
         IzRuXLVrxJaiCmXKBUdrBeDhPdWYUKWTNw/dKaNiQgbx6DhZAcRSiO1qEuM8BemEoU91
         iRfp+xvmxjkrdK5y0Q2Yym5ihIbHUC5Nd1NiubW9zY4S43JicIKGJUbIBMsrwfBhffCG
         /7lRQSpvo3YEyszrk/ERCqmaGX+WoO0I9h/KWwkn5k3C10cQ2C0pX0xi/8i1SfT6An79
         yej5jT4qpB0hLK0aVJYXd8TU4t8BMqivc7JnzhDcQ/PqrW9Gt8h1yDOsSZ3gtOF+H6SV
         Sang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p4FT/Q9voJtHr89/ZzKLFICjWsGq6YUUDh59Pyv7AYA=;
        b=cv7c0f/ddonSDKuBvW6PdC4PI0Z80U9pMRD3KN5YiB1QPGRniDtIo92zKS5z6PKSzF
         c4yN19ZgnGO4vnBASLQIyOrZRrdq7RJ+lxHZSQoj3SBFUXBqyOY4PAv0muEySdYLPc00
         ekUBwc7LjNLwt6cvx5kB5AvDbnlDq8qFYbioeKhdkzggLAHwMvdnOTwxYZmxZXWKz9p7
         pru22wQ0L9KeUJVz2j1XrOWBe6nkoIorL3Z182YTnGVqdCExFZlHBSvUrHfLIDieRXit
         XYoqxf1PbwMFttMNSc/LKu6zcEYZMJ1fzeEtat3/+OydL1iRHepHWA8zPs4zQL87j/kL
         oYcQ==
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
Subject: [PATCH 4.16 132/196] mmc: jz4740: Fix race condition in IRQ mask update
Date: Sun, 22 Apr 2018 15:52:32 +0200
Message-Id: <20180422135111.076017437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455143804605814?=
X-GMAIL-MSGID: =?utf-8?q?1598455143804605814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
