Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tnHMLW/PwIFhTc7gKzBevrEIzjiVl9Lqg53hQo0oP2+azdtgDFZ3QUF/pVvcO6U4Duz+O
ARC-Seal: i=1; a=rsa-sha256; t=1523399875; cv=none;
        d=google.com; s=arc-20160816;
        b=LSupX9JBYbwIbJVEdRift9xlAk2t3ABiYytnhXgukw5xuzihsgRpdhOiXT33lpcNCh
         wCU6lPxYycQMiW3OoeYnZWuDIfqn5FU+Ljtv/t7SlGYLyMMIQuvoHIMo52yaVx5Gfgvn
         DDpUl+mKOMGQtsXyiKRnf7kVhUUclZ53q4N/iOkEi5ZS22NeFbpj+ycBdx4FhBitd2XX
         kWxk5me/c9YYjAy+5QQxcHuqr1h0nkn58kS6w/hGqs9WQEINzj+kfVnh3yJIo58wHdy5
         Zc7NAagHtiSZnUAEYo4odzCkiOrWSRLaGm/4zSJtREgC78kP9gFAoqHo0Jcz7pypYgsE
         iNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UFBXjE9ZDhrg8+g1iPKZR1fV2Kfzu6VOXNZmIYD1DZw=;
        b=Gk3E3/L5NvVaferCFhvx7cO3XZm9z3saBztGHq3jwePW9oWgOXz9arULNJLQCjtS2B
         1bJRVGC4+U6nlwAJzVOGwauD909/o1spynnuhALLRSgiVDgE379iFIFlN3SriwdX4IAj
         ypTb4yQn+T4s7IOvYUPNdkGxZ1dodUU/QgMZ+62bXhyHma86cn8/4yRNUWkNG/84rJ57
         arAV7zDB/TOBLC5bpXtUhbR6bdEik5m0Z6Jpk+1IM7viP89vj4b1OW5Z9OfsRGkipa9D
         01AR8cy8NPGCwmiVv58pcFHYnPNS5hfBiqOHICl3tlo9rpK7TnhvNVkhVfvZO3yhY90w
         fmxA==
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
Subject: [PATCH 4.14 087/138] x86/CPU: Check CPU feature bits after microcode upgrade
Date: Wed, 11 Apr 2018 00:24:37 +0200
Message-Id: <20180410212912.289118138@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400099827149153?=
X-GMAIL-MSGID: =?utf-8?q?1597400547994904228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1732,5 +1732,25 @@ core_initcall(init_cpu_syscore);
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
