Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvEm/4y3MykfaB2k4QZHOzW/mMmmYSbSenRXZQtOXeTvZJHtjePsHTi9VECiKG6AGHerJtC
ARC-Seal: i=1; a=rsa-sha256; t=1521214100; cv=none;
        d=google.com; s=arc-20160816;
        b=FQcmtjbgqbErUN9nY1+Sgh3w67eybthEjtI+t0kL6bWZoyYrxVYLFGuU4MCZaeT4KP
         HZSh1iqv3l453rTOHz5iqY4yzn+8EJ5gMC4QTMn21HoddhvKvutP3UwbzvjvQ1YX7DL2
         QSRqJYQaS6n6CtXF6HagyZXTDLOAaU9AYs1aXFH5SgCA8Gly1EEcUr/m0vcAlHG2Lw7P
         jnnsfcL80zUnbCKVwTGzt3E0ibGuRbb8JOgb22BKDEUzc41s7n+JOdbaGIj5b2BWvtUv
         FswzqakRamEu7R6H3Rux7lw9KIJzzNEQ4pXflrVPlvaydjHtgs8J+pLbES6Nxgo2ivHI
         D+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fp2lqWDbbvCkBsbcLc20//jC/YozAMkc3BVRBftfvjU=;
        b=ug+zt8iTicVhblRiZM88WfwqYqtirQm797nOmPs1NHxI0j2bKDjSqFlZKxUAnU4gyO
         kw6rceUDl29rlKuZGBTOvscy95J4MNHp7QTKKfHfonWtzgYLVKZxZ8GiVaH2m7hoFjmr
         gp5BbibbM3GBWunpqrIiRjieEXFqeCZraJwxI5VEWoaKyDaGRUXaIW164Rm2EqMjnlgy
         NJmU0dRDHP7vp8hrC6djooUNgnozzHMENHieCW7L2fCMr2YandnMOz7p7uACvvWXr2qn
         JrjTRUF1SH6kvs3jvaqW/ujjEWQpKHCHPtq4kfUni7Y/nwkjIIj3wqTDJD+8GlCpEEAN
         /PBg==
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
Subject: [PATCH 4.4 13/63] MIPS: BMIPS: Do not mask IPIs during suspend
Date: Fri, 16 Mar 2018 16:22:45 +0100
Message-Id: <20180316152301.507392406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108286989969530?=
X-GMAIL-MSGID: =?utf-8?q?1595108597161396983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
