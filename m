Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeE1P4y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:56:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939796AbeE1P4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:56:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: tegra: fix compile-testing PCI host driver
Date: Mon, 28 May 2018 17:55:29 +0200
Message-Id: <20180528155603.2897776-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:VL0cN+i7s14s8RRfQqyP4cqImwdgKXOw6aG2r/RN3dWRVsQPCEQ
 IJMzaicX/JBcSGn9xVIeoF7R0JEd2aWi1idVTkDFwQvJCsUBBGXM9QXGKCmjS3P4d5lAddq
 wkYA5A2qvqOziTDR0e0r/3VgiSeI1I4vjh6AhpoOKdq0Zs/cDFUBgy4f5zrUmxJB0j13IOu
 NSSxVYFmzTHf1wycJFCIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TbJrQkMkveM=:PFVARE1yVHq8A1ujcGu6CO
 4/KcxNMT9HEeUyoLY8px9QHOIMyuGNX8RLo8X1pbiHDq73NLfs6Rn4Cma/OWHnSdWcOG0/6ox
 MFBhcw/csplHe487FIVKGEPGUzhNIuVQif1tmrlpS+7/t9cQuXJ7iWixRnpwbRyDfP8HiA/pR
 wxJDbtpM2rJzuDbUnCRzZVD74fdU7GORaz4XeLnhXlmA3BXbEnWKUgUafizwOp34weXETfCnn
 jC1S4LVUwSdoLTbu/UVTMU7amXc4c3bdFWRAjJ+Ye9PTfHLcsGkhpYf0JaNXuRtYDtfBGj64H
 J8+Kle3mb25s/55RNpm8CIBl2qd02xOvVPbfp0lrw9TGJe8ijEsF5uM2I1AOpvHXIULklA1N5
 OixeOQvJah2oseyi1XsZC47m+eX6lukV/0Ax0lZ10WLWdoYSthUyH78TKJO6aA2V3H0dEUM8m
 dwvyBX7QYXMqJvOlgBGMxAxbgoqNzwag+8TLOGEGxTopgea2dvFEaZC1cyhg7o2CsC4dJZCgv
 sTL00llYU7yoTGHqI/G0VJLzSXZdohhs2a/pvEfjWo3fAwPUX+i7QbmBCXwe7yo8nzuEJwBE0
 96hqRyLE79ijR8gKJiJBl3DHcAqA6wQZSQYeXwX7bLSO1L8lsQTXvUEOnvlEu2eRX6REmO8MR
 Oa74mc80AalA/y3yCRhkAbrb6I34AvaW19BmGCRlvryXOWzAiGPhfaYWL/3jIO1sRAoo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra_cpuidle_pcie_irqs_in_use() function is stubbed out for non-ARM
builds, but now we can compile-test the Tegra pci driver on non-Tegra
ARM platforms as well, which results in a new link error:

drivers/pci/host/pci-tegra.o: In function `tegra_pcie_map_irq':
pci-tegra.c:(.text+0x288): undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
drivers/pci/host/pci-tegra.o: In function `tegra_msi_map':
pci-tegra.c:(.text+0xba0): undefined reference to `tegra_cpuidle_pcie_irqs_in_use'

This adapts the #ifdef statement to match the exact condition under which
the function can be called.

Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
Cc: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/soc/tegra/cpuidle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/cpuidle.h b/include/soc/tegra/cpuidle.h
index 1fae9c7800d1..b6cf32211520 100644
--- a/include/soc/tegra/cpuidle.h
+++ b/include/soc/tegra/cpuidle.h
@@ -14,7 +14,7 @@
 #ifndef __SOC_TEGRA_CPUIDLE_H__
 #define __SOC_TEGRA_CPUIDLE_H__
 
-#if defined(CONFIG_ARM) && defined(CONFIG_CPU_IDLE)
+#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA) && defined(CONFIG_CPU_IDLE)
 void tegra_cpuidle_pcie_irqs_in_use(void);
 #else
 static inline void tegra_cpuidle_pcie_irqs_in_use(void)
-- 
2.9.0
