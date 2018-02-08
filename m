Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AH8x227PuNsB5bRlgVOxmEijb4NXJPoE/041VNm9et61lVGxODXENkHFAwWcMYWIsHTzoPDlKQpL
ARC-Seal: i=1; a=rsa-sha256; t=1518115987; cv=none;
        d=google.com; s=arc-20160816;
        b=VwVtdjF0bkNB8N9JDlFUCQVBPI8xibdr7kVVDF6XeptTnE9Sasml0Erdnq+6kQikvd
         RNsAnQaF+URl9iSpaOhm6dwyDRjtpHgMXIFTmNr1v+BcqXNPuzUiH+QBjc6/QotiyjJU
         wSgZTskrFhlySHWjbZGPJzv8g8mRkMy18P9gpCINP07t2YdYaMy+vez3b/k9iX76RAwL
         +vFMXS+gfSXMnSGRkn9tw+n90mqOO2zpF1d879EP4BnqH2R6EUpiZ2bXCYI1UfFFC+kb
         e1JxpqLJt7ITGYfTz3lJEfLZFFh6udZjMPWyYJSzEC6XetON+qNfwCsODim+WBR4CITD
         3mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:arc-authentication-results;
        bh=VaE09KPuDPjXSWYIrMBInnDiWHdHsn1lf/vq24HAUfk=;
        b=FV0kOPcRwtDv0zImmeYGs2Vk7JU4oYzLvOf/+1snUKraQ8hYroy618GSJYEklZIG7m
         Akmx6VwAxQ7bN1e/V8swhYiiNog8PabB0wdJXn0Rb5LCvQyKgdsY4gOh1DYPkLRYAe0o
         F5amE16KFU2AANdHLZoyaM8OOxcbtLut+nsar1x/YYYISs5+AE/taUF5od91LhcbhYX4
         CQ4u7JBAPFgD9siAXQjGI3WePY82+6DG4O6675yJVdCqBrypGalkYhzS9+Nnm5uFAgwL
         wcS2XfC7n17cJKls1DaVHfv/yYrCDh0SltmMZq6IooZpPTz6LqM0WIlX8yaEcOtqgzKn
         GvLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,480,1511856000";
   d="scan'208";a="172793742"
From: Ashok Raj <ashok.raj@intel.com>
To: ashok.raj@intel.com,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] x86/microcode: Check if any new features are present after a microcode reload.
Date: Thu,  8 Feb 2018 10:53:06 -0800
Message-Id: <1518115986-158190-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591859989696630713?=
X-GMAIL-MSGID: =?utf-8?q?1591859989696630713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When microcode is loaded later after system boot, new microcode could enumerate
new features. It might not be possible to use these new features unless they are
loaded during early boot via initrd or from the BIOS in some cases.

This patch attempts to simply check if there are any differences in feature set
and warns user to use early microcode load before using the new features.

Suggested-by: Andi Kleen <andi.kleen@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/intel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f7c55b0..0e07035 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
 #include <asm/msr.h>
+#include "../kernel/cpu/cpu.h" /* get_cpu_cap() */
 
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
@@ -776,7 +777,7 @@ static int apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
+	struct cpuinfo_x86 *c, new_cpuinfo;
 	static int prev_rev;
 	u32 rev;
 
@@ -804,17 +805,23 @@ static int apply_microcode_intel(int cpu)
 		return -1;
 	}
 
+	c = &cpu_data(cpu);
 	if (rev != prev_rev) {
 		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
 			rev,
 			mc->hdr.date & 0xffff,
 			mc->hdr.date >> 24,
 			(mc->hdr.date >> 16) & 0xff);
+		memset(&new_cpuinfo, 0, sizeof (struct cpuinfo_x86));
+		get_cpu_cap(&new_cpuinfo);
+		if (memcmp(&c->x86_capability, &new_cpuinfo.x86_capability,
+			sizeof(new_cpuinfo.x86_capability))) {
+				pr_warn_once("New features found in loaded microcode, but will be ignored\n");
+				pr_warn_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
+		}
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-- 
2.7.4
