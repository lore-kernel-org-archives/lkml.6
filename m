Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunkQvJkGYRYRbIe7rYq5+2DF84orEV+9XmL9D/uZi9o39cKyp4IxOVH9EJ2KbZXJ/kN30y
ARC-Seal: i=1; a=rsa-sha256; t=1520954958; cv=none;
        d=google.com; s=arc-20160816;
        b=pZm9ObSJUCb9tioa7gXM7teFzAh8jyK4rQnhqfeznxauzAGzkYUwo7Jxe0wmuvuU7w
         I3ApU8zDNu3GNy4STDrO8DGaU2m0ZA8FJYyPyfkgMEWp/Z0DjUSlm1rxqYu1nQcdKF3G
         tnLMt77fUoqkfg+FkgALYuaxnFsgDxqFtrtUCr2vGllGhkMtT6sqXHCeuB8cLMyZd5DG
         Zz4NXOhmw92HP931K3l0xK2OcQ08wR8JMpbAJcTZeSJiv8oT/lN7jzOMWgtiLUu8QtOY
         egqHx10MrWZz5XOi1MEJw5r/ekN2dneIWSAGRqEi7kQE/Et3f7/1IaX3dhqVb4SONOl/
         4pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1peRJdrevGxhu4qChfcHYTGQ+77AZo3DDIRUNJ3NzdU=;
        b=Dg69fOfgoEu/PMGP24Caqh31hTq/1u2gB8HE1AW3gmnfGIxH3XyUqu7VzWPn7d2qSz
         agZMt5JDIaHNtHcgQc6xxRpZHmBz+k83s2ZzwO/4lu7CQY/0FKxo7L07FeiePLqzj+06
         bbNp68J0dqjYfFZc8NpSkaRsPoZ2QR4XSvcYjjAlekC89ZCk/SxPN8F8BeETmQRnOZm9
         fEYqYumysXpK5tCiNXpdU2I7W5MeiE3QZnWRpbyrq+6n+A+RDEBz4k08mtXZ/BUoKdZW
         EaFI1h3izb9J8ZWVa88J6V0346Ee7RjWRTUmukzfNlPl06BKQRavSEQB/K0RW2YBkTNA
         GzVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Justin Chen <justinpopo6@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 040/146] MIPS: BMIPS: Do not mask IPIs during suspend
Date: Tue, 13 Mar 2018 16:23:27 +0100
Message-Id: <20180313152323.668121514@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836867198175596?=
X-GMAIL-MSGID: =?utf-8?q?1594836867198175596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justinpopo6@gmail.com>

commit 06a3f0c9f2725f5d7c63c4203839373c9bd00c28 upstream.

Commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on CPU IRQs") fixes an
issue where disable_irq did not actually disable the irq. The bug caused
our IPIs to not be disabled, which actually is the correct behavior.

With the addition of commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on
CPU IRQs"), the IPIs were getting disabled going into suspend, thus
schedule_ipi() was not being called. This caused deadlocks where
schedulable task were not being scheduled and other cpus were waiting
for them to do something.

Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called on the
IPIs during suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17385/
[jhogan@kernel.org: checkpatch: wrap long lines and fix commit refs]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp-bmips.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -168,11 +168,11 @@ static void bmips_prepare_cpus(unsigned
 		return;
 	}
 
-	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi0", NULL))
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
-	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi1", NULL))
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi1", NULL))
 		panic("Can't request IPI1 interrupt");
 }
 
