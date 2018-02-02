Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBBVlX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:41:23 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:64324 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBVlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:41:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Garnier <thgarnie@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pti: mark constant arrays as __initconst
Date: Fri,  2 Feb 2018 22:39:23 +0100
Message-Id: <20180202213959.611210-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:m4GIYtw6XtgeCXtsJbwN85wSnXgkv1RPmudxYTlGZyM9DcbInPT
 TVV2fX76GwPEudTn+17woi0Kf7IpVCfr/ALoGZsuGzP2SFTT6sapQMPE5MK1SKLeud+4drS
 +v0fJ5NNFtd32uti8ApJiTEZAaaqN4b9xILPpKWbNi5Fl5n3wBRo04NHvbnF48CurY0NO6j
 VkGj8tM1CmVdcNV433AYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1dKBqAaUn7g=:VCmDtQRbRTcR0ChFjLEO4t
 CDBVzKB1YrLdK0405FJBgZLFiqEUW0LjzkyeCMOUCWsBmtK2zAitPhud5DBCsPmal0PSEAiDM
 MbpEwSefdABDcq/bpin9VlaRiVU4lwfuVMN7J/RD4u6YdLS9V1HPXYcFnEGfeNavOyN3bWn7H
 7CsVis0a83rjGcAtwRwUw6HuV/LSxjxbOu9yQEgG5a39gFp40OJZIcN9EWpDfXrYf4ySgXZCx
 2lpizFoo7e7K/x/HnBIQI5FO6IHatGwQvvJY17PyMjnhgrHGBFvbQakLz/LTTLX9QcB8QPqvc
 Gd4opYYkwdYIAIZ0eYmHJ0BXXTU4lVAjkWpxK8H0OYv490YDZ5dxg5FSrhj1LHQHr8qFW5rsW
 FxYVJFy+5iP6TCig1WU8aH/g4jWn+W26yALxp9iXJ0ZVzRC6lTCVDGPTfccZKdyPwSYTlBVrS
 STMqDuTLXK4OR07vM1cp+V6CPET1ZX/txaXq/rx37pAAkWnEzF5i37/wLEHQdVidK2Wsk4CjN
 QDLqFaMqQrm4e7z/LAvcwVoMvjP4Q3iej/aqnsv9SOcpOJAD8ZYHDT5Hb201cXcaw5rlB/MKG
 wtXtzaH3xIie6Z7W60d4Tj+bVziDeR0eF81U4RdoAR29q+lrzsnGDG/7t/TelERzNUnaW4QZ7
 Tors2iCXfBDZ7lcBW0JAdsKhAeWEG8Ls4q8cq+YTTBD89TpGNO89OxpHabKlOVMcA++wjQocD
 wxXyBpWAFZK/oZKbhQMWkZqfxG9Pokxn/0VjBg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing build failures from the two newly introduced arrays that
are marked 'const' and '__initdata', which are mutually exclusive:

arch/x86/kernel/cpu/common.c:882:43: error: 'cpu_no_speculation' causes a section type conflict with 'e820_table_firmware_init'
arch/x86/kernel/cpu/common.c:895:43: error: 'cpu_no_meltdown' causes a section type conflict with 'e820_table_firmware_init'

The correct annotation is __initconst.

Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7c996a692fd..4c3887a09822 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -879,7 +879,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #endif
 }
 
-static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
@@ -892,7 +892,7 @@ static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
 	{}
 };
 
-static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
 	{}
 };
-- 
2.9.0
