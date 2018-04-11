Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx480wlgSIwjkRFM8/kNoBcxCLeRdeMvwb7v2YcoVC1L8ImBJsEeyiQGudS75PdIwCgMrIt0G
ARC-Seal: i=1; a=rsa-sha256; t=1523473121; cv=none;
        d=google.com; s=arc-20160816;
        b=BhsdqJtK9bcTjOL4sY6qM8mRA33U0BP1UTB3lfXwbRGSenNIfVbydJEmGo+2c4MyBB
         8uteDM8kdHU9y7zmz8UDEbowsnySL8Po97cJt5Sqr5UcsPSzHafL27p0m85V+5+2QXln
         Aasg0kAurfpN6gHYA7dX9CPrMD+O9V12qQEFu6wzLNuF/aVf2YIIBYEcECd2HxQBBDhw
         48/a8H0U3NFQ2uT7F2zyk9E/R+qcBQ/GJloD0Mid8KSicKo7PpliLrzDA6U6beF9ZjX8
         pP5/RSjB1SmzWlWkIfWqM28es8g1glwFnCf4YGJdeN8tXWbehRgDon5MAv+Gm4ROX4qh
         nuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fX0V2VuJ+6Og95HDbv8Nk9U/vHaso5HapUxQRebgOqU=;
        b=XuBzfWws1tY3TdF+ybdYbFNIxsHAWI6C28zY7xQeTezNPFqJJdRxSKJY3beDD4ibph
         /3R7jetz7JUs1LbSreR0HfvX+bpkF/Hd8jaLvon5iEH4aSEWLMVLX1tXHci0Mw0rjgHe
         TVlbtIPSqw1Ep+vEaifmXMuNIi8M+OIQ6gdy78ZgVcDx/3PJ5ypkJDgIZ7b2YFRLr49z
         g4LjA4OWXz5HFw//toZF93WkNq6qwabS18c9+cFkKD3+v/rSxi98rwYhbBWNgTViGdwS
         Iwgdm+lDMuXYSn2UU/Jhj6Fo+QgjDKzxm6oYjsgmgoHcJwwU13rq1YJR9jUbb+XBEoaH
         rcMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 136/310] irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry
Date: Wed, 11 Apr 2018 20:34:35 +0200
Message-Id: <20180411183628.302581937@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477351663962568?=
X-GMAIL-MSGID: =?utf-8?q?1597477351663962568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>


[ Upstream commit ebe2f8718007d5a1238bb3cb8141b5bb2b4d5773 ]

The ACPI specification says OS shouldn't attempt to use GICC configuration
parameters if the flag ACPI_MADT_ENABLED is cleared. The ARM64-SMP code
skips the disabled GICC entries but not causing any issue. However the
current GICv3 driver probe bails out causing kernel panic() instead of
skipping the disabled GICC interfaces. This issue happens on systems
where redistributor regions are not in the always-on power domain and
one of GICC interface marked with ACPI_MADT_ENABLED=0.

This patch does the two things to fix the panic.
  - Don't return an error in gic_acpi_match_gicc() for disabled GICC entry.
  - No need to keep GICR region information for disabled GICC entry.

Observed kernel crash on QDF2400 platform GICC entry is disabled.
Kernel crash traces:
  Kernel panic - not syncing: No interrupt controller found.
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.5 #26
  [<ffff000008087770>] dump_backtrace+0x0/0x218
  [<ffff0000080879dc>] show_stack+0x14/0x20
  [<ffff00000883b078>] dump_stack+0x98/0xb8
  [<ffff0000080c5c14>] panic+0x118/0x26c
  [<ffff000008b62348>] init_IRQ+0x24/0x2c
  [<ffff000008b609fc>] start_kernel+0x230/0x394
  [<ffff000008b601e4>] __primary_switched+0x64/0x6c
  ---[ end Kernel panic - not syncing: No interrupt controller found.

Disabled GICC subtable example:
                   Subtable Type : 0B [Generic Interrupt Controller]
                          Length : 50
                        Reserved : 0000
            CPU Interface Number : 0000003D
                   Processor UID : 0000003D
           Flags (decoded below) : 00000000
               Processor Enabled : 0
 Performance Interrupt Trig Mode : 0
 Virtual GIC Interrupt Trig Mode : 0
        Parking Protocol Version : 00000000
           Performance Interrupt : 00000017
                  Parked Address : 0000000000000000
                    Base Address : 0000000000000000
        Virtual GIC Base Address : 0000000000000000
     Hypervisor GIC Base Address : 0000000000000000
           Virtual GIC Interrupt : 00000019
      Redistributor Base Address : 0000FFFF88F40000
                       ARM MPIDR : 000000000000000D
                Efficiency Class : 00
                        Reserved : 000000
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1250,6 +1250,10 @@ gic_acpi_parse_madt_gicc(struct acpi_sub
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
+	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
@@ -1299,6 +1303,13 @@ static int __init gic_acpi_match_gicc(st
 	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
 		return 0;
 
+	/*
+	 * It's perfectly valid firmware can pass disabled GICC entry, driver
+	 * should not treat as errors, skip the entry instead of probe fail.
+	 */
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
 	return -ENODEV;
 }
 
