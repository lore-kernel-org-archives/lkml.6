Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeBTWB1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:01:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeBTWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/7] ARM: disallow combining XIP and LTO
Date: Tue, 20 Feb 2018 22:59:48 +0100
Message-Id: <20180220215954.4092811-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:68CP8D5zJQFwnlFrJ/irQ54USuaEt6O5wK4lDMNIAyakOc7alQ2
 eQ/4aC76leERsEA1T/DOpfDW3K4PVo1T2mnzXFqPQcRtehbPZ7cWo+lyDWD5TrH/jpHm+Al
 O6rfVaM83JPtqeAt8Y1P20vq4NwFY3JVBIAMLaLrP9sKNDGE4tUB89fgY/kzu4Uojy46pnm
 NXE7vMpvOdbTDISlPrJpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rR8Kc8pDCKk=:ndfU5F6i9ZigA1mfZqMVBF
 Q38QVPhjLkB5CoVuApUGOAk8hNVq0HX3eZQ4eXGL85WY2OT4Q6gw8hBfSzdUDhYy/sCtb7qMn
 A0K4SkY5VbnEmYfmKklZUeQraieZ4JSysqCxIVSf3WyPAtWRTMvbTQBY47fIxU1iQ4TfUbHyH
 3juU7cLJ6mufH6oO0RYg1CwNGeE5l0tsLR2vOwBEHWlnEwqTWGC06u7OqlQrWXg9Iqp7mFC4o
 CZRqfG2SIYwgzrk108RSK0vdTvID7/eVM0Vaqcw47y6gTVN9WyXraD6ljkT0pHh5RfYxSsHDV
 ZsTHCXDKOFRhX4nMatMPgVVwQPfhQ9R7hh1B+kXDsuRf5tRvnmq6KGzfhZHhsD4aRyKS1xg33
 p6wz2dKp6K/mL1ettGP13zC7VGN5fO/yD/qKPswkW6pXxjGGKCG7WeBxBNZk7Y9XSxlyo/6AU
 0ej7nm9URsuhYBW0zXfV0J1FSSmQ/8e4VNSOIAY4jcpJbZT0nVXaCOsp2UJegvcndGsUXY3CK
 N5j1PLqE1XOE7njy+UDgyOgPtPHb5oJMZMNMhVPKY3myyqIrBx9w4+HTcbngUeOET7UbcbPbC
 d436lrCgQ5N9Q25jMRcihWbaZZGVG0rmgF2cu0ykrTrvaVZbUGt+KQo1Tuj6QP62AfuUwtDtg
 oRxmud2e67XgFnW+RJ1TsUyJ3NBfqroVPyYzV0AoXSoUVSLB6nvLjg9w1PowK9MWxrR7HpJYn
 CXjbSqmozplKYfGX3crpAsbom6YEhMt+p8yX/w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fails during deflate_xip_data.sh

  /home/arnd/cross-gcc/bin/arm-linux-gnueabi-objcopy -O binary -R .comment -S  vmlinux arch/arm/boot/xipImage && /bin/bash -c '/git/arm-soc/arch/arm/boot/deflate_xip_data.sh vmlinux arch/arm/boot/xipImage || { rm -f arch/arm/boot/xipImage; false; }'
make -f /git/arm-soc/scripts/Makefile.modpost
+ sym_val __data_loc
+ sed -n / __data_loc$/{s/ .*$//p;q}
+ /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
/home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
+ local val=ac74c0f4
+ [ ac74c0f4 ]
+ echo 2893332724
+ __data_loc=2893332724
+ sym_val _edata_loc
+ /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
+ sed -n / _edata_loc$/{s/ .*$//p;q}
/home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
+ local val=ac7b8744
+ [ ac7b8744 ]
+ echo 2893776708
+ _edata_loc=2893776708
+ sym_val _xiprom
+ sed -n / _xiprom$/{s/ .*$//p;q}
+ /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
/home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]

Obviously we want to make the combination work, no idea why it doesn't.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 823e397ee0f3..8ed0f664f86f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1976,6 +1976,7 @@ endchoice
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !LTO
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
2.9.0
