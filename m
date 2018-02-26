Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtHWoL7PQABtY/UvZ+Fn/KLYo8SrtfQm1ucpUDOoi0LTIEnhX2HRBoeL7FnGISUL6U4YSM2
ARC-Seal: i=1; a=rsa-sha256; t=1519676942; cv=none;
        d=google.com; s=arc-20160816;
        b=j6bUPmt3PvOvpjrSR6vOqyQryrL+/QfKjGntXb0KvwVLoSycODafi1EiUkzILnwnfa
         jhDgAXYd+DG2pf0V9M6dMeoPEkqimiE74iIR3CT9uV4guCZ/IKCu/wpZ2YO9lD4GFk5t
         aVAdvbeBz9M3b96ZlXmKapHNv0lPuq31LppBVu7oEctc4QneYozDwKLFMUKZBgkmcHj8
         QKMTrSyy1zirpyQMYe9kIQbtuEr5309mhKCLBLmoov+5HZAEH7Nu52sNERNe3F4gl+AB
         7uJ2SJFRWxiFb1Baq+Md2CNsSRTpMBtwzPKbJjWC9IkIMgmbjeOFUKLVkwGBiCs1xiHd
         OL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kYvuiOrEF6EEj3qJfhf4TOqsUuwzyN4qY5QtHQ8uoTw=;
        b=be23/HHA006mhhImL41idAX8mbhJeApSjWbHVmN3ujLLEJJmTWAcmX0CmmNFfTUl7A
         4m+2hANGzVWcsL4bbxRNAzqH4ic7A6uliDedpgu+Tgqu/50vxptNvOuY1HAI9mwurS/k
         DaQN0UoeLmp/9grzyT/abfQ0G95zQnuVXegQ5uAR9ELGWf2gN/a0zdLa6aMewg3GzVSk
         4HoDnP48oKsTYOymaKohfA1CYRK5VNrUVMna4x+JJERRn2c9V4bIhFXzCvMl5STWwJtC
         TNCVYw3mDqFm1ZxvOA4NVzqyVzvKqL/tYPgE2CSmQHIeTXHpAB0ySO8RorDnl9crnIc+
         D7FA==
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
Subject: [PATCH 4.15 33/64] irqchip/mips-gic: Avoid spuriously handling masked interrupts
Date: Mon, 26 Feb 2018 21:22:10 +0100
Message-Id: <20180226202154.875616039@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496473140760275?=
X-GMAIL-MSGID: =?utf-8?q?1593496769390880953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -424,8 +424,6 @@ static int gic_shared_irq_domain_map(str
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	gic_clear_pcpu_masks(intr);
-	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	spin_unlock_irqrestore(&gic_lock, flags);
 
