Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPsVyx3q9PPHg7ntUuHcMmKVJPR9aoHL8tGj+yBm/yGDXDGByiNdyoj2qxU6ycVzp7Q+XC
ARC-Seal: i=1; a=rsa-sha256; t=1519676660; cv=none;
        d=google.com; s=arc-20160816;
        b=VRp/QYi7vn274LMrM1czR7V+BNy4S5dAKmj11DTQlo8bqihxE0kTNR2QKqEnSwqAvM
         HNNlYfj0BIXYcYkU/mAIWtDVkhRqLNaqsJQngriXj9QJvey121sMETFLzsKiwoi7HuZH
         8HQKbAX0YVZSj/e64rTeWeNtVOF8wvZrmZCTx7zcm8Vr3FUlA2mRq8wYLERHbmfryBlP
         BuVpthThEUmYa3CwLwb4x22KY+kTJn329NYrgi9uEkj423v9QKS2r21nVxpxj06T5wWs
         fItqHf5FS3zah/+iiCQ7NHyiQnLZcPZMpF2//YJW7vMevXOs6tA80tbJI8dJW2g2lhk+
         zkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yV6O+AJOhdKDGNjk/JGcnb8wHHzAgM6hwEkAIiISzN4=;
        b=yJqtC/FPg2l7B5Vd7oLJtB/Va6tjPe8cQX/Wc5fOXuD/7lml8o+w6l/1RjXjNAE/sQ
         muoI7r6zmIdpMTPGMgIKUtCSEHT2crJJcpROc47IARoWRmbIAueCIUev1TIZ11DHLxZX
         LqyiUTPhxm1jtyhP4VWdZyc7+LbCUt0YdgsUx4ID9ZrrVZv18MJYcMuKilGu+ICZuDOa
         H9vMWvRdBhA0g0I3t0zHuYxIv67njUR/Y5Eskzppd1nMSHN3q5zRyesPUPaJlIF0STbd
         GwZIVoTr9ozMgTo/N7hiPVuLEKJ+6vQa5BS9QxrznXI03H2xXwY5xFV+OE7Ybo6JnoUh
         N9rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Redfearn <matt.redfearn@mips.com>,
	Paul Burton <paul.burton@mips.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 29/54] irqchip/mips-gic: Avoid spuriously handling masked interrupts
Date: Mon, 26 Feb 2018 21:22:06 +0100
Message-Id: <20180226202145.841357438@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496473140760275?=
X-GMAIL-MSGID: =?utf-8?q?1593496473140760275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 285cb4f62319737e6538252cf1a67ce9da5cf3d5 upstream.

Commit 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading
GIC_SH_MASK*") removed the read of the hardware mask register when
handling shared interrupts, instead using the driver's shadow pcpu_masks
entry as the effective mask. Unfortunately this did not take account of
the write to pcpu_masks during gic_shared_irq_domain_map, which
effectively unmasks the interrupt early. If an interrupt is asserted,
gic_handle_shared_int decodes and processes the interrupt even though it
has not yet been unmasked via gic_unmask_irq, which also sets the
appropriate bit in pcpu_masks.

On the MIPS Boston board, when a console command line of
"console=ttyS0,115200n8r" is passed, the modem status IRQ is enabled in
the UART, which is immediately raised to the GIC. The interrupt has been
mapped, but no handler has yet been registered, nor is it expected to be
unmasked. However, the write to pcpu_masks in gic_shared_irq_domain_map
has effectively unmasked it, resulting in endless reports of:

[    5.058454] irq 13, desc: ffffffff80a7ad80, depth: 1, count: 0, unhandled: 0
[    5.062057] ->handle_irq():  ffffffff801b1838,
[    5.062175] handle_bad_irq+0x0/0x2c0

Where IRQ 13 is the UART interrupt.

To fix this, just remove the write to pcpu_masks in
gic_shared_irq_domain_map. The existing write in gic_unmask_irq is the
correct place for what is now the effective unmasking.

Cc: stable@vger.kernel.org
Fixes: 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -427,8 +427,6 @@ static int gic_shared_irq_domain_map(str
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	gic_clear_pcpu_masks(intr);
-	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	spin_unlock_irqrestore(&gic_lock, flags);
 
