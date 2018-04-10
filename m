Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qhPsN7dhoCa3efwYDTyPVPz+NgvH30qP3Pqajej0hpk54V8XZhLNw5vOTav9PgsbXuRk2
ARC-Seal: i=1; a=rsa-sha256; t=1523399909; cv=none;
        d=google.com; s=arc-20160816;
        b=Yw6Z6QrSwuRbm83xTwBBsCwqnNRaB3KQw6nFBUtuAZwdjOiLHqowtRNTUmJcEYskls
         JIljLeEGkfVTrMP8KQbdwPe0DDaaofNI3YWgqiGagPB3OnDG0FcbO4dNzd0HAkyxelf0
         U/KavBSPHXB8/vPPoJ+EUZcQguvggTEblNtoNodSKfT6fksbT2uEXdb21mvyURzfDlLW
         WIZhRZmdmUoqQyj+rd4vmcNtKiyviD9ScdXpVQMfY3xA+SRJZoqVr5WNePTH+l0+d04S
         F+BFm4RLEbxkyGgYEdJ7Ph2imafV6iZ4SkCWJRt9coomT/AlaAhpnn6ifR6ufGvaIlon
         fZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UPr7zMI/E2/ifqFMbRRaecHTiVb99Ohkp74Lqfe/9YM=;
        b=pfa5vDQwWGr5355PjFg6dNw/GqhTfhzbWn+BBteh3AT9njqFv0vZStwbA2y0Xf5J5k
         O1dSlqcZE61nWe9ZVee4zjTzBdaeFHbbIbdaFzq+KWXnNGiqOnNTc94TbGQo9xusGnqH
         +evIh40JPR0Ryq6MJg5muJIS2196WE1RBmbRUxcVuwhtzr+6KtOWAfNLhaspWuW3Vjsr
         1eyu2xQfpwUCsSvjESnkCmFn5HnqsKP8zfqGhfDzApP/s2SyLaQI1nNzMjZBhmW6SMpO
         z4KrIKJT26YKWj75wzezqazdSm5dkclUk6KfnXy5rgR5zvfW0th8WQPQH82p7PrWZyll
         /hkw==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.14 089/138] x86/microcode/intel: Check microcode revision before updating sibling threads
Date: Wed, 11 Apr 2018 00:24:39 +0200
Message-Id: <20180410212912.530443736@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400184770921684?=
X-GMAIL-MSGID: =?utf-8?q?1597400583444206352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashok Raj <ashok.raj@intel.com>

commit c182d2b7d0ca48e0d6ff16f7d883161238c447ed upstream.

After updating microcode on one of the threads of a core, the other
thread sibling automatically gets the update since the microcode
resources on a hyperthreaded core are shared between the two threads.

Check the microcode revision on the CPU before performing a microcode
update and thus save us the WRMSR 0x79 because it is a particularly
expensive operation.

[ Borislav: Massage changelog and coding style. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-2-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-3-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -589,6 +589,17 @@ static int apply_microcode_early(struct
 	if (!mc)
 		return 0;
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -776,7 +787,7 @@ static enum ucode_state apply_microcode_
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	static int prev_rev;
 	u32 rev;
 
@@ -793,6 +804,18 @@ static enum ucode_state apply_microcode_
 			return UCODE_NFOUND;
 	}
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -813,8 +836,6 @@ static enum ucode_state apply_microcode_
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
