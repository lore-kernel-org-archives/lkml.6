Return-Path: <linux@dominikbrodowski.net>
X-Google-Smtp-Source: AG47ELvyo2NJEo104ELtAFSqY1NbeDnpGHGZuKO0Nc+9KP9UlEZ2VOG90W9IRDsE5TjVQqYphHn4
ARC-Seal: i=1; a=rsa-sha256; t=1520765807; cv=none;
        d=google.com; s=arc-20160816;
        b=za0R8QErl/qyHRTjyZObtksVLyrOS1/X5nHQqGlsKatjPZ1frIhrCWU/ZqvKx/x37O
         KZ8jK9HrNO7USCpEMEypNvHf/VMvCmMfmmr9ljRxAb/DeBv/mkQbAUqZ4zf5ohCWX31x
         jMxY7D18+eIinuMLojiQKl/+QlpyBHY2b9AH/Y8GEWfsJed8mXTJvCjAXkZiNFYzdcRB
         IJRK5Ie62yPO8rumLg7HFdPSJ/LTSUo6YWJAHS8ZxFvcWiBbFPmRv7w+u11iySJ/lgkn
         cDO065aA2K8FbKS0dS0aeOkjwZl/FKueH5HXAOY0TZ4bW7l7FPlNx5OS/KXf0nvUtHCM
         Q/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qtUm1JXcDC0ZC2EWUMC9N4syI5bzGccCeiobSziIUtU=;
        b=UrZeO8WRUD3vHcxdhMQJOslgbN9PhIW2Ja+c1Myr6USexfabgrzJEc4S2qray3END5
         WqaoAy06UjWfGkPKUzKvtKY7LwMR3YL3Xjf0RQrPeGuDz4du9CBpsWvLEMXa0QRTuwrD
         KM/xBaOb17xYx0IEUHDyYEH+AJw57XnifyhgQCUeoPvmniPwRi6EjIZrm8u3mKPEZOUQ
         mlF72wi8K2gtmAz1R69kIe98W7mLUlqgGf1K/x+x8ePkpF7Gt09h5Vkt4esZufdddfos
         wSrRreUIJxwhlcxt7TbQq4Pj1V4AtwBz5z0h94P6O8cU6Sw0eIzJlGt4pfrjtwxLzPDR
         jKWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org,
	luto@kernel.org,
	torvalds@linux-foundation.org,
	mingo@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	x86@kernel.org
Subject: [RFC PATCH 13/35] syscalls: do not call sys_ioperm() within the kernel
Date: Sun, 11 Mar 2018 11:55:35 +0100
Message-Id: <20180311105557.20807-14-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594638526828393635?=
X-GMAIL-MSGID: =?utf-8?q?1594638526828393635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While at it, use SYSCALL_DEFINE3() instead of a hand-crafted syscall
definition.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>
CC: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/include/asm/syscalls.h | 1 +
 arch/x86/kernel/ioport.c        | 7 ++++++-
 drivers/tty/vt/vt_ioctl.c       | 6 +++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index bad25bb80679..1c0bebbd039e 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -17,6 +17,7 @@
 
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
+long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
 asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
 asmlinkage long sys_iopl(unsigned int);
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 2f723301eb58..0fe1c8782208 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -23,7 +23,7 @@
 /*
  * this changes the io permissions bitmap in the current task.
  */
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
+long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
@@ -96,6 +96,11 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	return 0;
 }
 
+SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
+{
+	return ksys_ioperm(from, num, turn_on);
+}
+
 /*
  * sys_iopl has to be used when you want to access the IO ports
  * beyond the 0x3ff range: to get the full 65536 ports bitmapped
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index d61be307256a..a78ad10a119b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -57,7 +57,7 @@ extern struct tty_driver *console_driver;
  */
 
 #ifdef CONFIG_X86
-#include <linux/syscalls.h>
+#include <asm/syscalls.h>
 #endif
 
 static void complete_change_console(struct vc_data *vc);
@@ -420,12 +420,12 @@ int vt_ioctl(struct tty_struct *tty,
 			ret = -EINVAL;
 			break;
 		}
-		ret = sys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
+		ret = ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
 		break;
 
 	case KDENABIO:
 	case KDDISABIO:
-		ret = sys_ioperm(GPFIRST, GPNUM,
+		ret = ksys_ioperm(GPFIRST, GPNUM,
 				  (cmd == KDENABIO)) ? -ENXIO : 0;
 		break;
 #endif
-- 
2.16.2
