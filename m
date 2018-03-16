Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtb8UpQXFhF2buNcbtFgDzicho+EvfvkB7oEf477Ope8m7D8lkOKQI0i+/QqO5yBRlTVN5D
ARC-Seal: i=1; a=rsa-sha256; t=1521214311; cv=none;
        d=google.com; s=arc-20160816;
        b=QVf02hrL8W3dXrEN4/zWJs/3S/P2NuOWHpqfWJpwAwKcrgkquZuUTc1Uanf81NB80Y
         Et8XjMoaIDSQdriTCNYspg7qF0EvWN1ULtpcXUEn6chMw+uNtuxbkmRLvre0B8IA7JRy
         t96yJXTJPW0V/DmfaSU477VPZO6GjKiT3d4PP+/NYpy0yyj2xk4nknvwngmLrbOR5vPj
         RkNR+l1hxkbOnJC90ujAgnMlIz+g19WkiscF/osjBmIh0N/kenB3Vb6O+tYyp5WWywVt
         vDhz/q3J8PeFqs3KgBK+++/mLyqY5hdg/H8fknKLy/SvSWRao+8fBR1Tnml9rQsc/3W1
         tawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OrROZsTqGxkG5DgU4+GC0LkaKWavhYPRfNX2sb65PU0=;
        b=O7MqMzJ4Rt3le6Yzwi6uQUotBLelmkaOeoJvKxD4o5/xP0sqhBacUtEkNx61QA70Ga
         6RRS0pPXBGVmg8s5nwzrWL67G0BC6sff+daRZ91TZbV3o+m1KjmZiLzyA7t5zQGhhNcC
         MG8si0Y5Ul1/vTIGH4/JOeXLxDTD1bKXOPhNsdil5XG4SyPF4dmhUoy+9KZi2dfcV5FB
         nNR2FzXmqeUAiDJ+aQmdAsxN5kn3DUVm6dWQkmbPCPF+juPq3dTmMvXtVa/B9pRb8eKa
         ayGZ6H1TD0GsstTwsq9EmKZVEAJMzYrcy4u1Hpmmxg4QRwXNF96jY1BEPbS03F5E4S51
         CAQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Justin Chen <justinpopo6@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 17/86] MIPS: BMIPS: Do not mask IPIs during suspend
Date: Fri, 16 Mar 2018 16:22:40 +0100
Message-Id: <20180316152318.458720113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108286989969530?=
X-GMAIL-MSGID: =?utf-8?q?1595108817387941866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -166,11 +166,11 @@ static void bmips_prepare_cpus(unsigned
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
 
