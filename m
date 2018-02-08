Return-Path: <rolf.neugebauer@docker.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518107159; cv=none;
        d=google.com; s=arc-20160816;
        b=OU6nq5YoUrL/Zt7Q+3UOA9kB6u7m0832q7MfcRCoNJumrkLCdtQSivj7GD1IL6b7kq
         iAOud6rxfuANzFderez/rVoJnVh0WdpYFMPgN9xBA6vm31pN9lDmLVch9XoEwNlUEL4V
         8PVKLO5VZx8eppu5QR5RQ8NW45mA5+ftUtDYriJJqNjN2QKV+8sa5nFwHLryrcHwBbQM
         9AHv6JiPuh/JcoU4TZKYpLeoZeRMHKhuLxsG2V2rFsZB7tkJOcNQyfk6J20xjGSdZmrt
         N6PyNy4VPc4ylBdz6pz8IUxaiH3xwbIEFfDudUfQKdlF37wm8ZiTP4/DyDy2Djb37qWK
         j3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=utblBRV+7MV5DMSvgNg+e0RYl8nzOTvKQEKbmDIJGuQ=;
        b=B7HifoJLqhCoE+X6BxHCUYa13sPMcY3rnUeo7aU2TMkSQAVcJA4V5wgImk+c0rtcpU
         GqNPz+xTGtyjC1PP0w5CN/pG+tQDpghsHRl/QnH53YGPFJQyjNLNlad6Jwm4m49/9XMo
         VbCZLkLkS691N2FgzRHjG9wBvY/ij1/qqKRBIGWwtH3SS6jMQD+Onmif4YPOgWHwtbJx
         svsU1hLY8tAwyoC43W4FKBDtrErOX2uBxkZxGNoCbclKI7UbFdeaHAddUNQLXUc+a5hK
         JbZbIqv8JzxUnIiy+pbme9EkQ4PNI5pzTKfX7GyzU+LVUq2tFIOIyCwiDeH6iHz7TD64
         ZFFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=e0I2VHf5;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=e0I2VHf5;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
X-Google-Smtp-Source: AH8x225qOP0uzfDFZff3NYCti0sxwhaH8yRdgM8/rlCgewe7mB0IYC5hDM/2uF7FM4HbdkQ3JEYRjuquuFdg0rvf5i8=
MIME-Version: 1.0
In-Reply-To: <20180208145348.GC7964@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic> <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
 <20180207181254.GC8698@pd.tnic> <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
 <20180208145348.GC7964@pd.tnic>
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
Date: Thu, 8 Feb 2018 16:25:58 +0000
Message-ID: <CA+pO-2c1WPr7UTtqMQBCzOzKr5ex=mu4URm=d=Of1+bn-jHJUA@mail.gmail.com>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
To: Borislav Petkov <bp@alien8.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591850731887700792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 2:53 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Feb 08, 2018 at 01:55:48PM +0000, Rolf Neugebauer wrote:
>> On the 4.4 kernel, 1f161f67a272c ("x86/microcode: Do the family check
>> first") does not apply cleanly. Looks like it relies on 309aac77768c0
>> ("x86/microcode: Decrease CPUID use") and 7a93a40be23e5
>> ("x86/microcode: Remove local vendor variable") as well. These don't
>> apply cleanly either.
>
> It figures. The backporting game is hm, well, a fun one. :-)
>
>> Should I just manually backport the functionality of 1f161f67a272c?
>
> Yeah, try that first.

Here it is below (same disclaimer about crappy mail client). If Boris
is fine with the changes, Greg, I can send it properly with "git
send-email" if needed.

Rolf

>From 397a76b8403f0b4a73222a031e52d72da94af2f6 Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Thu, 12 Oct 2017 13:23:16 +0200
Subject: [PATCH 2/2] x86/microcode: Do the family check first

commit 1f161f67a272cc4f29f27934dd3f74cb657eb5c4 upstream with adjustments.

On CPUs like AMD's Geode, for example, we shouldn't even try to load
microcode because they do not support the modern microcode loading
interface.

However, we do the family check *after* the other checks whether the
loader has been disabled on the command line or whether we're running in
a guest.

So move the family checks first in order to exit early if we're being
loaded on an unsupported family.

Reported-and-tested-by: Sven Glodowski <glodi1@arcor.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.11..
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://bugzilla.suse.com/show_bug.cgi?id=1061396
Link: http://lkml.kernel.org/r/20171012112316.977-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c
b/arch/x86/kernel/cpu/microcode/core.c
index 1b3e0aa4c511..ce5f8a2e7ae6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -94,9 +94,6 @@ static bool __init check_loader_disabled_bsp(void)
        bool *res = &dis_ucode_ldr;
 #endif

-       if (!have_cpuid_p())
-               return *res;
-
        a = 1;
        c = 0;
        native_cpuid(&a, &b, &c, &d);
@@ -138,8 +135,9 @@ void __init load_ucode_bsp(void)
 {
        int vendor;
        unsigned int family;
+       bool intel = true;

-       if (check_loader_disabled_bsp())
+       if (!have_cpuid_p())
                return;

        vendor = x86_vendor();
@@ -147,16 +145,27 @@ void __init load_ucode_bsp(void)

        switch (vendor) {
        case X86_VENDOR_INTEL:
-               if (family >= 6)
-                       load_ucode_intel_bsp();
+               if (family < 6)
+                       return;
                break;
+
        case X86_VENDOR_AMD:
-               if (family >= 0x10)
-                       load_ucode_amd_bsp(family);
+               if (family < 0x10)
+                       return;
+               intel = false;
                break;
+
        default:
-               break;
+               return;
        }
+
+       if (check_loader_disabled_bsp())
+               return;
+
+       if (intel)
+               load_ucode_intel_bsp();
+       else
+               load_ucode_amd_bsp(family);
 }

 static bool check_loader_disabled_ap(void)
--
2.16.0

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
