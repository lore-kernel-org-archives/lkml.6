Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCOPj7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:39:59 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeCOPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:39:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell: avoid link error with modular ACPI_SMI
Date: Thu, 15 Mar 2018 16:39:07 +0100
Message-Id: <20180315153934.3844276-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:RALNamAAmVwPvwgJNcOs+rZ50kykAaHzVgebphk0r2RNayE402y
 XAPBYeB3rcOh3Wzg503J/GwpBVfpFyww9eSDX1iRh4bZJjEL0pxJPU8aVF+/axiYHzYY/GV
 z04G2CuApnZb3g4iUZGu+z9BN0EOgejIE+SN49VL6yCT9Z/xteOYYi1sU/uKlB9Ln2Wlf0m
 0trl2CxfDjt8K3AjtNJDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:txZdxXPxdjs=:beaYMHro9jCMtR3Me9VZ93
 RE7zURFj0lnIPJaQ8aQBpUmaFNOitxofMtvXyX/dDJywpCMUw78kVZYRwQZP1oimaqhpP1kaS
 k3pyEWNzYufr7333e8WEW1isWdGAtqEdPZGRHeksro31gkl2tMvjK8W9F2SlNhRyawcOGrD9F
 l6AWyvyuRRxkiAVJBTeS8Lx0eIekDsjG6p5xrebMx1jZOKbjZtwJ2cL0duvz1fLPTKMTE3hVg
 9J2Zbx6CPFXicrpkr+u83RqUZAv3XDM1Y4Iwir4Fo9U87kfQPqUrGsBAxbcNBAqybMI6nIsUC
 GYM457Eo3n6342oXimqGOdyaoSWIZaQtxDsfUpXStk9WfHsl2dQZsIbbBR9aYr7LFqbZGNbcj
 xSowF49ilNrau95FK+w17oWUsl1tLxKD1uaGZxCFONJv/XgH96N7GBOHJgWHBxMGr1qilMXbE
 SYzlIBRm7KgKrw7A8KJN1U3jhbL8cVPD07NrMSVq2rHhx/PthEduJotlecgilTNnBNaeZNlcW
 WS5LSwH/fZ5Tq8uRUeZUx2w1F7ArP4pe0Wp5z357kG2xtikGqAvGAcLhyNiwBpXtX5rGcnfK1
 ttmvc5Z2HGW2bVvE+k34y81vf38q2iuSmFhmlvqxIikkjZBFIO/0XNDil4/6/tNJIofnacebF
 to5qlyyBc8thcjmX7CUkvOrU8ZK/hkz5RzmGFWxWREvx/9MKITUgk3W9TtqEUeUYZ9D8gOGm6
 zQGxKzy9IDdIDCs2WJrqzYyWeQEQuOCteDhmPg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new DELL_LAPTOP dependencies allowed one configuration that should not
have been possible, with DELL_SMBIOS_WMI built-in, but ACPI_SMI as a
module:

drivers/platform/x86/dell-smbios-wmi.o: In function `run_smbios_call':
dell-smbios-wmi.c:(.text+0x47): undefined reference to `wmidev_evaluate_method'
drivers/platform/x86/dell-smbios-wmi.o: In function `dell_smbios_wmi_probe':
dell-smbios-wmi.c:(.text+0x5d0): undefined reference to `dell_wmi_get_descriptor_valid'
dell-smbios-wmi.c:(.text+0x60f): undefined reference to `dell_wmi_get_size'
dell-smbios-wmi.c:(.text+0x61f): undefined reference to `dell_wmi_get_hotfix'
dell-smbios-wmi.c:(.text+0x644): undefined reference to `set_required_buffer_size'
drivers/platform/x86/dell-smbios-wmi.o: In function `exit_dell_smbios_wmi':
dell-smbios-wmi.c:(.text+0x78e): undefined reference to `wmi_driver_unregister'

This adds an extra dependency to avoid that case.

Fixes: 41e36f2f85af ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I think the plan was to drop the change that caused it. For completeness,
this patch is the last thing that I needed to make randconfig work
reliably again.
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8383806c360f..0cced065e298 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -122,6 +122,7 @@ config DELL_SMBIOS_WMI
 	bool "Dell SMBIOS driver WMI backend"
 	default y
 	depends on ACPI_WMI
+	depends on ACPI_WMI=y || DELL_SMBIOS=m
 	select DELL_WMI_DESCRIPTOR
 	depends on DELL_SMBIOS
 	---help---
-- 
2.9.0
