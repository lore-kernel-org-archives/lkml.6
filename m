Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519380926; cv=none;
        d=google.com; s=arc-20160816;
        b=n0svCut/t4LmixPmSDkl9VCZh1m12VmbzJbmKpH+dKaz/OIseSizC2SWmKY31kUIUP
         kOp+J1sxK+gEo2p+NwkOKF5N+GOz8XshJHj7rX7HCUiUxtUNFfa4HlckGDDdh9FA802y
         B0jO0Y/BsVzJEfGNbXV+9rJXovFhayv5EbZI/eaAI/blPucsWfp5u6B4cx75S70mGg+V
         eCWvdsugBzPwJO3K+tb34dh6hfL9dDSInCnQuzi1mwju5TEd8s2Y7am79EkhkIjyzxVa
         i8yl7RWaKTt04tEqU2y3kSM7mGzvIQXDEQ5+UKMomCWS2DMzx1jtpkfCo2/dUdxyE8NM
         8Xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=E8912SBG6XsZQpSKEiXaak7O1BKvvLVklKmTpPpQdws=;
        b=yqqLYKWsLCKgXh1QwDT3lBr2tDvue+3dZSmS0UwsFHy/ogwEfkrT8bhnLkY4Bi7VZV
         QFlh/cSfeyI4VbUERptClPhlwP+BgnrO7NLsyHQi3vb2KxkLL9O6y1c5DTrW8fka77QJ
         9pHklUfmeJ2SKEGXaokkC1QkfDYEclyRoelbQyZhSMUVmCkKdtvoCBw1HI4ImnFNOKhq
         rY1kuE1//WlhqOQF+3aVkMddFWLF/ue8PjIzL+GdFtBkpb6zBVZE68Pqiq8M1rKRMwH5
         NdmGgjz7ebK1ehlTuBkE7mT+9Y2WqYgafmgk9BWMSUZbNJnsGLSHjMRKN7eiG3mQrQ67
         KDoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZIQxCk+A;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZIQxCk+A;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225D54fhA3VQlstemYCpirC9Eh05lp5hU+oyveE9eaHlqRFRggMygguiR1t7gXGGVTxtuj/ENA==
From: Seunghun Han <kkamagui@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] x86: mce: fix kernel panic when check_interval is changed
Date: Fri, 23 Feb 2018 19:13:50 +0900
Message-Id: <20180223101350.8344-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593186374882748310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I am Seunghun Han and a senior security researcher at National Security
Research Institute of South Korea.

I found a critical security issue which can make kernel panic in userspace.
After analyzing the issue carefully, I found that MCE driver in the kernel
has a problem which can be occurred in SMP environment.

The check_interval file in
/sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
global timer value for MCE polling. If it is changed by one CPU, MCE driver
in kernel calls mce_restart() function and broadcasts the event to other
CPUs to delete and restart MCE polling timer.

The __mcheck_cpu_init_timer() function which is called by mce_restart()
function initializes the mce_timer variable, and the "lock" in mce_timer is
also reinitialized. If more than one CPU write a specific value to
check_interval file concurrently, one can initialize the "lock" in mce_timer
while the others are handling "lock" in mce_timer. This problem causes some
synchronization errors such as kernel panic and kernel hang.

It is a critical security problem because the attacker can make kernel panic
by writing a value to the check_interval file in userspace, and it can be
used for Denial-of-Service (DoS) attack.

To fix this problem, I changed the __mcheck_cpu_init_timer() function to
reuse mce_timer instead of initializing it. The purpose of the function is
to restart the timer and it can be archived by calling

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3d8c573a9a27..d72f2f74f4d7 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1771,7 +1771,6 @@ static void __mcheck_cpu_init_timer(void)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
-	timer_setup(t, mce_timer_fn, TIMER_PINNED);
 	mce_start_timer(t);
 }
 
@@ -2029,8 +2028,10 @@ static void mce_enable_ce(void *all)
 		return;
 	cmci_reenable();
 	cmci_recheck();
-	if (all)
+	if (all) {
+		del_timer_sync(this_cpu_ptr(&mce_timer));
 		__mcheck_cpu_init_timer();
+	}
 }
 
 static struct bus_type mce_subsys = {
-- 
2.11.0
