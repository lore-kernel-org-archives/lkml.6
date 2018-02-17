Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227884cz9s0dvvJUzonEEU6U/Sh2AY3JP+lKqZc4+xFfaSKccSYLLtXan7cazM2bataoSsXl
ARC-Seal: i=1; a=rsa-sha256; t=1518863592; cv=none;
        d=google.com; s=arc-20160816;
        b=ynjZMB4/cXFCtwElO7P1yRpiYw1NemK287q0goyC+Da7+3prnvzCZTnvIsPn9E7eRW
         Y6hkqPYdAICuCYenp9wGYM6z4clTdeZcRZGsjw/9aXPXxdMRnawqIoFYtVOkvqug4xNn
         frtkDmoKmrNgrmCX8otGMFZQydovDWBug4KjurTE4GxUJaDZl2THxj6hyQdw/x1XeMMQ
         49xtCf63mLvt/M4FQonvDcJRg0/xiXWBAC75E31ezEQnl2srB1zgp93o8FBG+KtOQSVP
         xaYt10eujmvq8F/IleQ/IzHnE17RlMYIbVRbJy1LlX7Aa8DFjmhUzFmGRNDbnZQkp+f4
         QObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=npa8zYN0xrs35jlO6x7l1Dh0uSaYh4zX/5mqZB1DmE0=;
        b=jMVqkbbIxvQzH1f7JS3qoLxx7prMJjVplRW8hSwBumd7bjzMrMG+2WK5q2DpU4wF5K
         0pwTK+ke/6CMoENwQVT/ib0NvSUpDxJ1JBrvbE1h8orvSUW84S5Nn1lyYy2y44NdwbAX
         Z0Z4wATZyQCcm4hMdr8Yp7MUKczVEuOaZNjyGK11F3bmWtkmF/G0/JnCarJfvtjh/N3d
         ly/sBPDtNdPfNwIKBR22NUBq7JmvD/Q08yhuL8Via85STdW/2WCqM/Fd42UI/vgqFFYG
         /6dn+70jzvduyFBoXKrwrRDFUNol1TdVHC6RdvKpuuYnHHhywPoQDeUB2AhkwEBQjgoN
         EykA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 02:13:02 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-42ca8082e260dcfd8afa2afa6ec1940b9d41724c@git.kernel.org>
Cc: arjan@linux.intel.com, dan.j.williams@intel.com, mingo@kernel.org,
        luto@kernel.org, bp@alien8.de, gregkh@linuxfoundation.org,
        hpa@zytor.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ashok.raj@intel.com,
        dave.hansen@linux.intel.com, bp@suse.de, peterz@infradead.org,
        jpoimboe@redhat.com, tglx@linutronix.de
Reply-To: bp@suse.de, peterz@infradead.org, jpoimboe@redhat.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, dwmw2@infradead.org,
        hpa@zytor.com, torvalds@linux-foundation.org, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, bp@alien8.de, arjan@linux.intel.com,
        dan.j.williams@intel.com
In-Reply-To: <20180216112640.11554-4-bp@alien8.de>
References: <20180216112640.11554-4-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/CPU: Check CPU feature bits after microcode
 upgrade
Git-Commit-ID: 42ca8082e260dcfd8afa2afa6ec1940b9d41724c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592643910631502341?=
X-GMAIL-MSGID: =?utf-8?q?1592643910631502341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  42ca8082e260dcfd8afa2afa6ec1940b9d41724c
Gitweb:     https://git.kernel.org/tip/42ca8082e260dcfd8afa2afa6ec1940b9d41724c
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 16 Feb 2018 12:26:40 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 08:43:55 +0100

x86/CPU: Check CPU feature bits after microcode upgrade

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
---
 arch/x86/kernel/cpu/common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 84f1cd8..348cf48 100644
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
