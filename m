Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lkVd17kvhngZnYb4lG4KREAdkzF0oqcNAKK0Wf8AFDDFOFZhp3nRNoDSoR63AEgeXUUXI
ARC-Seal: i=1; a=rsa-sha256; t=1523399451; cv=none;
        d=google.com; s=arc-20160816;
        b=DvMIhrNyKnKBPPou1FuhGSiQiT0vpQDj8s/brMof5Gg1yUyNSjc+4UaMmXtyU5rUJz
         LlOOAJUwpzjtQckMu7bbLpAFqYbVHUdhHsVHuuSnxxN5kjGyLbFdkJpquEFgxA2LcfmT
         EA+kYxP0B9jqXrji8sOcxgidYd4xqaNDdOhLkE9UkAxjX6jcbBgZyKtc6GOUd31ewh73
         4C2f9GPzaetk/6FopENKHkry4iLtyoGlIMSptIAx+yNq5dLXi8fwCQbfVhlwKNjWw0bQ
         hDjOIKi+LhpTTNzYzhF0r7ANnZQeTsoQ/Zzrj6KmYcql9JVDLPI1oB6kujwsRIMiY+5V
         T7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YLwWVbaX8czuwAyU9IJFLvV2ViHS2ivh8pbMsrJx9X8=;
        b=rfnvzEZAMTfGMQJo/NZlX4TYuzjUEX2OWvX6mDrMv49gPhO/4zNMMT2yIAtmEtXNlj
         /tDtMdyqMUJA9Mpyn4rjqcsXu50K+Z59OZ63246xAj953/+Kxe1a/IEdfGTwwIwjlA1r
         LpTLTQ8ny7nD8eACLla2Ba07plgZY8t4ggtfJlhfGodLw7QFqMm8KWLWca891tyE0u4s
         65yQE3IuP7XyZzH0GvG7Ul1GnqWYI0VD2BeVqt4VtzrimoJmGeqT/Z2CZe54r9nDiir/
         c4nWUs3YEXL1CdH6cXvoySx9kC72PkcnMlY1y6KqYExQPwWF+GvaorrD8N8eKt81wLlK
         N/iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.15 112/168] x86/microcode: Get rid of struct apply_microcode_ctx
Date: Wed, 11 Apr 2018 00:24:14 +0200
Message-Id: <20180410212805.041379171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400102659058161?=
X-GMAIL-MSGID: =?utf-8?q?1597400102659058161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 854857f5944c59a881ff607b37ed9ed41d031a3b upstream.

It is a useless remnant from earlier times. Use the ucode_state enum
directly.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-2-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,26 +373,23 @@ static int collect_cpu_info(int cpu)
 	return ret;
 }
 
-struct apply_microcode_ctx {
-	enum ucode_state err;
-};
-
 static void apply_microcode_local(void *arg)
 {
-	struct apply_microcode_ctx *ctx = arg;
+	enum ucode_state *err = arg;
 
-	ctx->err = microcode_ops->apply_microcode(smp_processor_id());
+	*err = microcode_ops->apply_microcode(smp_processor_id());
 }
 
 static int apply_microcode_on_target(int cpu)
 {
-	struct apply_microcode_ctx ctx = { .err = 0 };
+	enum ucode_state err;
 	int ret;
 
-	ret = smp_call_function_single(cpu, apply_microcode_local, &ctx, 1);
-	if (!ret)
-		ret = ctx.err;
-
+	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
+	if (!ret) {
+		if (err == UCODE_ERROR)
+			ret = 1;
+	}
 	return ret;
 }
 
