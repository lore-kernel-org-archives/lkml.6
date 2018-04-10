Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+uk1Ullcbp14XT+Ga5X3QKs8QgF+tGvOLfy755Fb3VvglLZ58axtRH2bFE8+ENVbW1h8ib
ARC-Seal: i=1; a=rsa-sha256; t=1523399448; cv=none;
        d=google.com; s=arc-20160816;
        b=tB1B26XBDGtqTY6ttGO8rSpCr8E+9yzGGLJh2cOA56FUxVnNyzAfrC73aKHFjzJZw9
         4n55oLY9aEvcBM4Ovp8riOGlVVdKz6hMfHIPQntaIVlxtlOWMQ9wFa4aoCCfD9z7juNw
         j9uCpQaNlAOrRWf3SpGTh+A+H23OFPHADNG5CSoAHYA+cRcbICumKzDYgGSRpwwe1s0j
         yijcVKUzqpeRIT+f52J1eYlnM0L/aaN5N8yQIgeudRYJQBPJFhE9iEsrDpJeYAl3nyhq
         5OS10EE5dRAlyT08ELbhnaU6hOnJSy3ZTgWllTYSrSFY30ttct4BGeKcOkQBTjOkxwAw
         giew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fmB2rC8sX6BiD4Aq8WUwqed+p6K/VXwhoN4ogj9dl9k=;
        b=ook/5Fm5YD9LJoQCP8zKJ2O4SsOv5LAA3gS9Jh6d3bsRVBBpUT0JosQoaraZC180Sg
         Qomt/0PZAKuSue8C5KnDSFfp98dpCw3mWLGcJ4NinMEzQuUIi3YFDhEP0f4mnRFe33dT
         l/Tqh7nyA8bkTVHEKLa4gQEjwHhJgjuPeh+seeqbi0wV85PumUz2AzVRbGvo4BHKLvEi
         F0ytXFJEP/bbkK5SpejEFOGSkNnCHnVrjDKRFmmigwZlVYJa357TGJ7QCuFrNyiWieCK
         4SFr7jsO23K1CjARyu7QFUYFlFFqIj4FDSmHxfYhnLxJ1uQZ/Z82X30TIrDAvUSumEkq
         C1dA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 111/168] x86/CPU: Check CPU feature bits after microcode upgrade
Date: Wed, 11 Apr 2018 00:24:13 +0200
Message-Id: <20180410212804.995415058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400099827149153?=
X-GMAIL-MSGID: =?utf-8?q?1597400099827149153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 42ca8082e260dcfd8afa2afa6ec1940b9d41724c upstream.

With some microcode upgrades, new CPUID features can become visible on
the CPU. Check what the kernel has mirrored now and issue a warning
hinting at possible things the user/admin can do to make use of the
newly visible features.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180216112640.11554-4-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/common.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1757,5 +1757,25 @@ core_initcall(init_cpu_syscore);
  */
 void microcode_check(void)
 {
+	struct cpuinfo_x86 info;
+
 	perf_check_microcode();
+
+	/* Reload CPUID max function as it might've changed. */
+	info.cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+
+	get_cpu_cap(&info);
+
+	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
