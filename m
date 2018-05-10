Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeEJV77 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:59:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:45089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752698AbeEJV7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:59:54 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] powerpc: hlwd-pic: Prevent interrupts from being handled by Starlet
Date: Thu, 10 May 2018 23:59:19 +0200
Message-Id: <20180510215919.27808-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510215919.27808-1-j.neuschaefer@gmx.net>
References: <20180510215919.27808-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1QIMz60H6Rk4js3dUDr52t5ndFzeeog7sTfiei+EQb0IyomljYO
 CplNJQFtdEW7AF432PGndTeRtioYmIw+9Z8meaF0Y6B56w+fOLey3nxfSfHLd4g47Fee9GD
 0pcCKeqmVymKQHd+PqhkbHuG9FsaFZGyL+mffdwmj33PK3YPf8AifWPABWKru87jOMNGKvI
 +H1hjmkpGqKM50Ai4B2Qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6P2l+/0PbSU=:+kWDgM1GaUr09an/dIT63c
 6cmX9zz0r80ptUvYpfb6UPq8m2iXybuhTsm3VXqlFU4rAfoVVgLI10JkXvCRDdWDVM/l+O4QE
 i/NKJyTZ7DOFbhK53rJoyMnipz/PmNZP4QQl0RWEieK3apHhDJXTOEWt62SswaYA7yKIWgAHk
 WjL1kq4qd628dkTkew92CiXTSxp23XVz2chLWieBASUU/h50HIn8yquMKyla09R7S8p5Cfees
 XO7cbWFJNHsI+yWkARopqd7UG7LsBpyACB9P/h6UnH/8CpZyK2J5tQVM2AjFcUHBytmGvt/aO
 BiNxkrhiIR5rOL0rfZXbmkQxPNf+Bjeo4WX0xKBC4QsFH9jyziDGIz7zDhkfadQcG4DSCdh72
 XRyHq8LxPGaNHnnru5B9izzYBU5wV10m2ZNanez1+04BeeD5dn9yatQTpPIXzX3c/+lEMoJwm
 TsnOdNAvyzCCBm9ICRt7BWUSQMb29MEWp1F+6gPEBB8ecv7LTXt5jxRJKO8duJ4kyweFIpaOF
 U96l+dBoK8wdYD9NvRcLH9JhDplZl0ufIg7tE1tWcL/9D9vgrrfjn7HXcp5NISQPDsy7tWTNI
 fZzT4ShXfl6KFzC/IMZoMyWJl1j6nSLFg7R8I5uHUwyKMoEMZVTj7t33R95USVmSya3lXb7Dc
 sbWL7o3wYstF67G9UocJ8t9XN0xMNW+/XgLpfeecoLa5Mw4MSir2Ig+cEyKqwzKJMcK0p00tw
 L6FzD2m4H3zCdhuwdAK3lpLsHTQTnEYISamSKb5hBZdqLYwtFzXSSktUV1G1s4lyiKoU1PcP0
 LOTn0aq
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt controller inside the Wii's Hollywood chip is connected to
two masters, the "Broadway" PowerPC and the "Starlet" ARM926, each with
their own interrupt status and mask registers.

When booting the Wii with mini[1], interrupts from the SD card
controller (IRQ 7) are handled by the ARM, because mini provides SD
access over IPC. Linux however can't currently use or disable this IPC
service, so both sides try to handle IRQ 7 without coordination.

Let's instead make sure that all interrupts that are unmasked on the PPC
side are masked on the ARM side; this will also make sure that Linux can
properly talk to the SD card controller (and potentially other devices).

If access to a device through IPC is desired in the future, interrupts
from that device should not be handled by Linux directly.

[1]: https://github.com/lewurm/mini

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index e3e3af73e9d8..8112b39879d6 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -35,6 +35,8 @@
  */
 #define HW_BROADWAY_ICR		0x00
 #define HW_BROADWAY_IMR		0x04
+#define HW_STARLET_ICR		0x08
+#define HW_STARLET_IMR		0x0c
 
 
 /*
@@ -74,6 +76,9 @@ static void hlwd_pic_unmask(struct irq_data *d)
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+
+	/* Make sure the ARM (aka. Starlet) doesn't handle this interrupt. */
+	clrbits32(io_base + HW_STARLET_IMR, 1 << irq);
 }
 
 
-- 
2.17.0
