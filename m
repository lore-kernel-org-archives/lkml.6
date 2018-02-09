Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeBIMHv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:07:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:48211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeBIMHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:07:47 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 1/4] powerpc: wii: Explicitly configure GPIO owner for poweroff pin
Date: Fri,  9 Feb 2018 13:07:28 +0100
Message-Id: <20180209120732.17863-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209120732.17863-1-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:dwLhG+vJnBnKptY5IqOxTJLwj5v5as+LNQrGxAQmMFa8W0gxhXA
 9d4RQxrXNzt6agQEOfVuBMpJGgJAL+FqsxPr/lq6rZxSFNIkzOiknh74b90v0OAwae2x5Ep
 tWTGmomrYFdne9lpvStGMXb0KX+wWxBd+tMkMWJ3iPSyQ6YCpdBw9MPSlrwvKhFWp2uUJsF
 UTALXubE03ifHL2ZucqSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bdFSbI8cPuw=:UuMsvnPwtgza2lb819+o6Q
 aMYKEaLtpAzybytfGVEnzxPxzNQBeuDoksU7PvkF79aQbVdZr9bxrP3hAC41SkK2UwJ3KkcRY
 +1E9UbF2O5w+7IvzwpsEPX2kujZ1AIUoUcHsZgg0u2CCZwFj8L1TPWFX/I3szMVeMLSkH4Yi1
 jXhoyG42p+cJOmkrfIaP1nvxi+BrBe0EAH38idvMmNjhtPbgv/+K1Q/VspKvB1sydKP6qoJtg
 7ugAEA476uuguViBwVTQEfl5sAEIH99wmrMk3G5WCvggNTMfX2gQmOdwRQdC1YT7Y6GBq1/D1
 Y3tMGj04eOwQFhc8RoDllnjJV7xABXW0TFJXn+2VnyH+9iNXjO6KzsFaUJfgbagMs9lSAvhgu
 9idu4UW0ylf0GC7/+nxzBytVVGFqQM9/8UcFiCvbiE39cEg0PpotAzEg0C6Nro5Y/342JntLD
 IQ2jj0wi7F3+UJwaL/OB4572FuY6OtrO7QT7gU2Lr2n0cNKGor3KNioFB9/XcNslKStVS/HPo
 nvo021BhTrTXsF8C+esqbMHbnC0MsjnP8mTkd+M1PCrDqmuDs0CezjWEZrAbVJRPFX+bLzi6q
 kN0mAs2PkhGGkrwCLp0TN454h7eRgGI+ifbn1uppCGIAkxobh9hN+rZGzI9jsknxP+8AEH4VP
 UXnglk4gxxYin83JxMM22anJfiJMT+iQjboig/OI41PvcMa5pZd/Bk/oCHl7hMA63Eo51obAL
 MLEifCkTKOSRSyHbD05NpkFgww8EDbJEcRm7HikW8dqPKAVzDwlgKNiUD1hlrJcorydGZyaYP
 Cp3lu2u5Q9XnKdvYcJYNQ/pHtAmbBn0XulWIwGiRx9rdphMZZw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hollywood chipset's GPIO controller has two sets of registers: One
for access by the PowerPC CPU, and one for access by the ARM coprocessor
(but both are accessible from the PPC because the memory firewall
(AHBPROT) is usually disabled when booting Linux, today).

The wii_power_off function currently assumes that the poweroff GPIO pin
is configured for use via the ARM side, but the upcoming GPIO driver
configures all pins for use via the PPC side, breaking poweroff.

Configure the owner register explicitly in wii_power_off to make
wii_power_off work with and without the new GPIO driver.

I think the Wii can be switched to the generic gpio-poweroff driver,
after the GPIO driver is merged.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2, v3:
- no change
---
 arch/powerpc/platforms/embedded6xx/wii.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 160fa09533ba..4682327f76a9 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -45,6 +45,7 @@
 #define HW_GPIO_BASE(idx)	(idx * 0x20)
 #define HW_GPIO_OUT(idx)	(HW_GPIO_BASE(idx) + 0)
 #define HW_GPIO_DIR(idx)	(HW_GPIO_BASE(idx) + 4)
+#define HW_GPIO_OWNER		(HW_GPIO_BASE(1) + 0x1c)
 
 #define HW_GPIO_SHUTDOWN	(1<<1)
 #define HW_GPIO_SLOT_LED	(1<<5)
@@ -177,6 +178,12 @@ static void wii_power_off(void)
 	local_irq_disable();
 
 	if (hw_gpio) {
+		/*
+		 * set the owner of the shutdown pin to ARM, because it is
+		 * accessed through the registers for the ARM, below
+		 */
+		clrbits32(hw_gpio + HW_GPIO_OWNER, HW_GPIO_SHUTDOWN);
+
 		/* make sure that the poweroff GPIO is configured as output */
 		setbits32(hw_gpio + HW_GPIO_DIR(1), HW_GPIO_SHUTDOWN);
 
-- 
2.15.1
