Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B974C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BED220848
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BED220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJ3R2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:28:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3R2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:28:34 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHPVI-0002R0-Q2; Tue, 30 Oct 2018 09:36:01 +0100
Date:   Tue, 30 Oct 2018 09:35:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v2 char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
In-Reply-To: <1540226025-45092-1-git-send-email-mikelley@microsoft.com>
Message-ID: <alpine.DEB.2.21.1810300859420.5984@nanos.tec.linutronix.de>
References: <1540226025-45092-1-git-send-email-mikelley@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On Mon, 22 Oct 2018, Michael Kelley wrote:

> pit_shutdown() doesn't work on Hyper-V because of a quirk in the
> PIT emulation. After shutdown the emulated PIT continues to interrupt
> @18.2 HZ. This problem exists in all versions of Hyper-V and just
> had not previously been noticed. So replace the normal PIT shutdown
> function with an alternate version that works on Hyper-V.
> 
> The alternate shutdown function could go in the i8253.c module,
> but it seems better to keep the hack with the Hyper-V code rather
> than clutter up i8253.c with #ifdef CONFIG_HYPERV.

You can avoid the ideffery completely. Something like the uncompiled patch
(lacks comments) below keeps everything in i8253 and should just work.

Thanks,

	tglx

8<-------------------

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895542f4..9b5d2259c2e5 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/i8253.h>
 #include <linux/smp.h>
+#include <linux/hypervisor.h>
 
 /*
  * Protects access to I/O ports
@@ -109,9 +110,10 @@ static int pit_shutdown(struct clock_event_device *evt)
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
-
+	if (!hypervisor_is_mshyperv()) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
 	raw_spin_unlock(&i8253_lock);
 	return 0;
 }
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index fc08b433c856..2ab7303675f3 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -10,6 +10,7 @@
 #ifdef CONFIG_X86
 
 #include <asm/jailhouse_para.h>
+#include <asm/hypervisor.h>
 #include <asm/x86_init.h>
 
 static inline void hypervisor_pin_vcpu(int cpu)
@@ -17,6 +18,11 @@ static inline void hypervisor_pin_vcpu(int cpu)
 	x86_platform.hyper.pin_vcpu(cpu);
 }
 
+static inline bool hypervisor_is_mshyperv(void)
+{
+	return hypervisor_is_type(X86_HYPER_MS_HYPERV);
+}
+
 #else /* !CONFIG_X86 */
 
 #include <linux/of.h>
@@ -30,6 +36,11 @@ static inline bool jailhouse_paravirt(void)
 	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
 }
 
+static inline bool hypervisor_is_mshyperv(void)
+{
+	return false;
+}
+
 #endif /* !CONFIG_X86 */
 
 #endif /* __LINUX_HYPEVISOR_H */
