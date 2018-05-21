Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrMC3NgRreic+gkfbTrRQpN5ScwX/I2jMFIFBf5AfBeTSEDKTsfwEYNm7UIvWDvRq+MA1Ni
ARC-Seal: i=1; a=rsa-sha256; t=1526937649; cv=none;
        d=google.com; s=arc-20160816;
        b=Qwl4a8YPp7n1mSJJCH/3TIGPfnXQ8nEnlCQexdWY2p/mCzH2E6kMO4Azb6yPqwuq7l
         8DuUUUqt/ln7H+fapUMqD8MlYvsz6M6b6J8av9o5OYUSw5XaBlrxCQkCeoIBfDNDUoav
         1NzDravnhySXmM0TZ7mNUGuPLVSXFHi1ijcPqIMrvrSdYR77vN0raTQ39yIJ+OoVeCKR
         C8pb/fDp7rBDEOjBT0Um/emE51jazXsIog5Lg9d6iCtraGm66x7K2uvDb/03gfDOKgPn
         Uef/cOHQGv4eVSEFHlAOim4RAm6cARfAHyM6vhC5XSit0LeQIo6YGd8erisxFQ0rYcwt
         M1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ed3iR4DCSvc1MXHmJWb2arGptGwFg8h7K6CnLtQxzSc=;
        b=cInU976slkbpAochDrNVlE6hSDdXDnpW47sGuOw8oaj/GSp1cv5NmAw5OWOqBUzX3a
         764MPk1PMoze2yalmNOllGS0lCqmhNFAzvMzLd80oEt2y1AXEzN5fjH+t3e/FbjLElx9
         UAHrEq/HCY587gL5tWWBVxKBnoTKSm5w6zIv65gl6//EdirByDZ6/Gt4w9gr3GRM/CWy
         nX764X5wgJ/M03JlZeWPcrDNIgraVpmjC1a3eWJU/+o0J/rCCbT9O+iAfgvV43HHbbbK
         vQ1rsATq8SX6rPBUb286wL7lSM0Y1qsMdDJLF6DNAhk6mhkXZ9ZBsnI4sryasOJNSL6i
         FrEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EkhJ1TQT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EkhJ1TQT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 38/95] ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
Date: Mon, 21 May 2018 23:11:28 +0200
Message-Id: <20180521210455.759624251@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109798325340068?=
X-GMAIL-MSGID: =?utf-8?q?1601110172700688843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 69af7e23a6870df2ea6fa79ca16493d59b3eebeb upstream.

Since get_kprobe_ctlblk() uses smp_processor_id() to access
per-cpu variable, it hits smp_processor_id sanity check as below.

[    7.006928] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    7.007859] caller is debug_smp_processor_id+0x20/0x24
[    7.008438] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1-00192-g4eb17253e4b5 #1
[    7.008890] Hardware name: Generic DT based system
[    7.009917] [<c0313f0c>] (unwind_backtrace) from [<c030e6d8>] (show_stack+0x20/0x24)
[    7.010473] [<c030e6d8>] (show_stack) from [<c0c64694>] (dump_stack+0x84/0x98)
[    7.010990] [<c0c64694>] (dump_stack) from [<c071ca5c>] (check_preemption_disabled+0x138/0x13c)
[    7.011592] [<c071ca5c>] (check_preemption_disabled) from [<c071ca80>] (debug_smp_processor_id+0x20/0x24)
[    7.012214] [<c071ca80>] (debug_smp_processor_id) from [<c03335e0>] (optimized_callback+0x2c/0xe4)
[    7.013077] [<c03335e0>] (optimized_callback) from [<bf0021b0>] (0xbf0021b0)

To fix this issue, call get_kprobe_ctlblk() right after
irq-disabled since that disables preemption.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -165,13 +165,14 @@ optimized_callback(struct optimized_kpro
 {
 	unsigned long flags;
 	struct kprobe *p = &op->kp;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	struct kprobe_ctlblk *kcb;
 
 	/* Save skipped registers */
 	regs->ARM_pc = (unsigned long)op->kp.addr;
 	regs->ARM_ORIG_r0 = ~0UL;
 
 	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
 
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(&op->kp);
