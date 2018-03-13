Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt12gc/Csvj3O0OPHOgmN5Q6OE7JO9SA+rNZW6FZRugZVfMRiJLAhITqRyEO5WL7uCzx8O/
ARC-Seal: i=1; a=rsa-sha256; t=1520955532; cv=none;
        d=google.com; s=arc-20160816;
        b=e2WM2R+7mbcGPS+DAABmnmvWTLWkOujB4rAvYfiaGmumoB36JRR8yVsiX0ypOajCsD
         cTN0wnHdTdaPjScz43jTmdRupjVb4+P9S81owo5mMlXiAuKULFdRGRTbaYBKnvr6ggLe
         ahcH9sPa+YsHpDSd/AmqS4BSjf6ECw5AcmKK5OwbrINPhzyGSbxw9ulCyEAwMFr3Unjq
         Xmb0SQriYhsImsBT1b7Wd2TMoDtflXrImEaWvveYeXj7PQCdHB12jGZ6cmewF+8C0Qsl
         XgfzMUOZ40pCXQS19MpemVu6OcmgFj9AqDwEyd/Fdt7ghcEW8QHJyL/Eppy7e5Ff7H0u
         SPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+8xFpde2mBouwcTbMpS+i2eo7IA8KZg8mE92Z/ZXgJk=;
        b=tbudRx/N9fF6cDkcJE6895ux+iUouWf0BFN7jrIBvPgtltK++WHtrS/Yv5tnkMvike
         /yJbMB/E380yGiaWVp0Jlf1noAejVa22g2kohELrVqBOE0xoP84msVwn/T41bSGXsYHy
         SZ37BuwNCX59UdIt26k7pBytuVRfTm4GLo0YpFUGLYEKdZ7pMZNDa3Wv6HIYUT+eU8MD
         vBWcVljW6Wlw2QGpSR6rYLlST0qtYaruwekhT6NVeMEwCTgdp8wgx/m8XCwWDpPFBElY
         K72fezsuY0bLjWeHHY+mkIdvNMWQqgvI4FAK5tCr3f6Ct7u/zp+Sb7rGfMetI9HxsKks
         +SFQ==
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
Subject: [PATCH 4.14 078/140] MIPS: BMIPS: Do not mask IPIs during suspend
Date: Tue, 13 Mar 2018 16:24:41 +0100
Message-Id: <20180313152503.380862971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836867198175596?=
X-GMAIL-MSGID: =?utf-8?q?1594837468732798858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
