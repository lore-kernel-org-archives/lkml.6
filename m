Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226qfhpqwJ9I4Z3oIETqASadHzu7DIIv24VVJGkFO57lkF+MQ7fwXcT7FFiHODnoNkT3WVBB
ARC-Seal: i=1; a=rsa-sha256; t=1519411323; cv=none;
        d=google.com; s=arc-20160816;
        b=WvirLbfh09ORuXxj0bjDCTZ/EC52XlmPrSLEd0GmTXdrYhsmZqOOYjnJzSBOq2/LVL
         vRSaPpd0QIAtCMEH6qWB8wM6IaIP8FY97dYNoKZ4xMGSZHiL09h+bWFZYLLLw/cy17py
         vgvOQjm47OktAXsw/GAmGIW23Kcx/Fdewaxi/W1mod1ygO7Zfm7ZQTVx4V31UC3G/ciz
         W1uQDZPAsupfL4V+PIfholL7S4psVAyRYJlYGHKJO+dMaen5SXOu5n2SI/Bcdvk2yuJg
         ttFrit+EZUrz63e+WJtUojjo707gfDgwao8HnHoPx+WIwkw4f9dk3Ef7g/4eyONLO8iz
         6peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CHHpWrK7ahODgRw/W3prm9UobT+7NUzlND8KburwavM=;
        b=NjEpLt0YCr27VXAP4QON/pU+9tr2Q0COcEeXFyaQfwTX4S9UF4ThxiEZUsUcQOodXu
         rX9KHkvu6ES4xfsbUj874dox1Q3n+zNIFfn1dnuS8sn0PVrjeOSEzQTxKgBkbPhwubiB
         I1t/GGKFL9VJ8CnMf9Er+a20kJyJXcfKvb0GhNjRCeq3/qXrnbQpckh18lT8DA0mnCMW
         WnPh5DebaN7EHd+NbK/LNV+pxfH20rnVrQVAg5/5tCRkfUXdxyG6SHAOFIv+ZNy19ASR
         OnUXcbi5HVZqj8c0/SX3lg1NMIo3elJ0G0IYh+tmzj1qUqPs4gaw0lreh7mY0Oulpc7D
         fB6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 161/193] x86/microcode/AMD: Change load_microcode_amd()s param to bool to fix preemptibility bug
Date: Fri, 23 Feb 2018 19:26:34 +0100
Message-Id: <20180223170351.126349872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218248322575865?=
X-GMAIL-MSGID: =?utf-8?q?1593218248322575865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dac6ca243c4c49a9ca7507d3d66140ebfac8b04b upstream.

With CONFIG_DEBUG_PREEMPT enabled, I get:

  BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
  caller is debug_smp_processor_id
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc2+ #2
  Call Trace:
   dump_stack
   check_preemption_disabled
   debug_smp_processor_id
   save_microcode_in_initrd_amd
   ? microcode_init
   save_microcode_in_initrd
   ...

because, well, it says it above, we're using smp_processor_id() in
preemptible code.

But passing the CPU number is not really needed. It is only used to
determine whether we're on the BSP, and, if so, to save the microcode
patch for early loading.

 [ We don't absolutely need to do it on the BSP but we do that
   customarily there. ]

Instead, convert that function parameter to a boolean which denotes
whether the patch should be saved or not, thereby avoiding the use of
smp_processor_id() in preemptible code.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170528200414.31305-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[arnd: rebased to 4.9, after running into warning:
 arch/x86/kernel/cpu/microcode/amd.c:881:30: self-comparison always evaluates to true]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/microcode_amd.h |    1 -
 arch/x86/kernel/cpu/microcode/amd.c  |   17 +++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -59,7 +59,6 @@ static inline u16 find_equiv_id(struct e
 
 extern int __apply_microcode_amd(struct microcode_amd *mc_amd);
 extern int apply_microcode_amd(int cpu);
-extern enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size);
 
 #define PATCH_MAX_SIZE PAGE_SIZE
 extern u8 amd_ucode_patch[PATCH_MAX_SIZE];
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -131,6 +131,9 @@ static size_t compute_container_size(u8
 	return size;
 }
 
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+
 /*
  * Early load occurs before we can vmalloc(). So we look for the microcode
  * patch container file in initrd, traverse equivalent cpu table, look for a
@@ -438,7 +441,7 @@ int __init save_microcode_in_initrd_amd(
 	eax   = cpuid_eax(0x00000001);
 	eax   = ((eax >> 8) & 0xf) + ((eax >> 20) & 0xff);
 
-	ret = load_microcode_amd(smp_processor_id(), eax, container, container_size);
+	ret = load_microcode_amd(true, eax, container, container_size);
 	if (ret != UCODE_OK)
 		retval = -EINVAL;
 
@@ -854,7 +857,8 @@ static enum ucode_state __load_microcode
 	return UCODE_OK;
 }
 
-enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size)
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
 	enum ucode_state ret;
 
@@ -868,8 +872,8 @@ enum ucode_state load_microcode_amd(int
 
 #ifdef CONFIG_X86_32
 	/* save BSP's matching patch for early load */
-	if (cpu_data(cpu).cpu_index == boot_cpu_data.cpu_index) {
-		struct ucode_patch *p = find_patch(cpu);
+	if (save) {
+		struct ucode_patch *p = find_patch(0);
 		if (p) {
 			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
@@ -901,11 +905,12 @@ static enum ucode_state request_microcod
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || c->cpu_index != boot_cpu_data.cpu_index)
+	if (!refresh_fw || !bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
@@ -922,7 +927,7 @@ static enum ucode_state request_microcod
 		goto fw_release;
 	}
 
-	ret = load_microcode_amd(cpu, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);
