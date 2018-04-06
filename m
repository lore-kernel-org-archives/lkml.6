Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx487JBHAVLuYlJeARlTFlbputC8xV22d5eZuuDtpx6ntII7L+10M/L6rKqDS0d6+Y41S00td
ARC-Seal: i=1; a=rsa-sha256; t=1523021862; cv=none;
        d=google.com; s=arc-20160816;
        b=FOLSWPxRMuNic6ws+rg9OvLVbjr3HnRAcqef2CQ9o/Ad36D2tlWF5GXGj3Tu6CND0R
         1ne+Dr6gU8w8f7BGTRMTNeXYMKEQHGUDJr1MjUL3chlbQiopzLXQ8Nl/GcwCj7Yh/0e8
         CqhOR9N6aIv/GcBg+aVLtmCpibpTezxtdm0HXEwe72At71YfRYjavu+iQDS2mE+d1dxp
         fI86/UkzlSn25XHy5EIRCMyzEMmd0JGEBcwPGXFj66xUOuck7vxs4qibOw8fWO6Se7/z
         g64mQe7uYlk9Wsh2FUU+l6tIncgSFvHaJ7Is/+a9212Q9rs8rno6thmoXIjteuC43sdy
         D3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M07uMXYrDhD/fMf1GMPKIDiAr9s3oEXdbKKIJbJIljg=;
        b=JZpio5J6tKfToosuYXMBy1Hib/Gf5SpZcY177E8ualDUiXcKtDqDJMGYtY54GbPwpq
         N1m2y/+x0hoAfjgsUYuAkHdl5qjnRvvZW4kWRdl/0holgTgjndTGz86rIBNCV13ZIkeB
         Ko2pLBWTv42k1rK8QQvxCVpjDI60futi1Lq/dh/Bh2rtj5T/2ZDzoXRQVOq4DmSZZgwO
         dGdQhgSfB6joH6ko4O7gby6Hebp6atRZ6+mG5JkxztP7vpWl29Z9j6XzmezJSAHQ/Bgq
         h6imEVurNYgbWQrTYI/kISs1IQ6FTMmZQozTXLmRBgF66O/4r3W86V1L0B6mkH8AMHwm
         BgpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Banman <abanman@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <rja@hpe.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4.14 10/67] x86/platform/uv/BAU: Add APIC idt entry
Date: Fri,  6 Apr 2018 15:23:40 +0200
Message-Id: <20180406084342.695837991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004172509533841?=
X-GMAIL-MSGID: =?utf-8?q?1597004172509533841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Banman <abanman@hpe.com>

commit 151ad17fbe5e56afa59709f41980508672c777ce upstream.

BAU uses the old alloc_initr_gate90 method to setup its interrupt. This
fails silently as the BAU vector is in the range of APIC vectors that are
registered to the spurious interrupt handler. As a consequence BAU
broadcasts are not handled, and the broadcast source CPU hangs.

Update BAU to use new idt structure.

Fixes: dc20b2d52653 ("x86/idt: Move interrupt gate initialization to IDT code")
Signed-off-by: Andrew Banman <abanman@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1522188546-196177-1-git-send-email-abanman@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/hw_irq.h |    1 +
 arch/x86/kernel/idt.c         |    3 +++
 arch/x86/platform/uv/tlb_uv.c |    2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -34,6 +34,7 @@ extern asmlinkage void kvm_posted_intr_w
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
+extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -140,6 +140,9 @@ static const __initconst struct idt_data
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
 # endif
+#ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
+#endif
 	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2254,8 +2254,6 @@ static int __init uv_bau_init(void)
 			init_uvhub(uvhub, vector, uv_base_pnode);
 	}
 
-	alloc_intr_gate(vector, uv_bau_message_intr1);
-
 	for_each_possible_blade(uvhub) {
 		if (uv_blade_nr_possible_cpus(uvhub)) {
 			unsigned long val;
