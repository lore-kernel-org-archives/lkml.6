Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8oouJR38oW+m0TLMGCvalC/Q0PCaat5nv/09Vi+KpxXKc744bTiHkuH+TH4J2pHPTPs4p
ARC-Seal: i=1; a=rsa-sha256; t=1523981228; cv=none;
        d=google.com; s=arc-20160816;
        b=xXKcoeDN9pbz1xtPUSRwv4Nu6dSrKmUNtCWCL1OPRcVoLzNjIll4NlfMHtohXtZL+X
         WjL7SjoB1j8gaFs8FmgE8BY9QP+HCuJMJHfWwvXud0PSzhGdez9rCLQOPrai+ABW+Zv8
         3QbbqecmXvwFiiWTLCQT2vWekpJXGn/lb0TpRRAnPOtzVsSciM09Upqb+QWoUvQnNLut
         SurL+mmgzVGbUJLLfFWCpabTgL6YB3kWdU33Oa4gXidcEqcoMTFmxCrrr6tfMZzceHEr
         UUEnNTPAR3R/+E4A6rqXBf/udAhFB3Mv82n3ioRV70CmMunj6CZQZttGW0uWfoeHMG4+
         mCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OtZWjni0tua+Fqgg5cNw/stv83UDTz5ZyGWP+m+GDDM=;
        b=BCxnR5wdqMVb2WQwIt7KM9megK6R7GU8OSbN+1VkzDhLcLWbSABcV2xDlVv6TVMtPK
         7pY0OCxi+V5qdhcUYw9wdK83xv/uS15zrwoHl2wNyrbp2DWmgJYOvfSMwv/0DSSwXfll
         NyrHrpr1CPWWfviHDqoXKnl4nvUh7rqdNo114UhUkrtl1bGNvZ6p+e9+Bwo+u92Fl65z
         jRDKk3j3Vgi8J8QyE+7FTQ0KLNGF2XBtIqyBDx4NQE4Du53ROq6OLENQHQEcmqNDODRa
         iTwXecA+0moCQcl9CILiWwef0x+oSCBvxj6c4wip2g5W6VRuKKHdJDCO9ItOl5IdvOKV
         jtbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@suse.de>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 39/49] x86/mce/AMD: Get address from already initialized block
Date: Tue, 17 Apr 2018 17:59:18 +0200
Message-Id: <20180417155716.895432903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009860124329571?=
X-GMAIL-MSGID: =?utf-8?q?1598010140442309933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 27bd59502702fe51d9eb00450a75b727ec6bfcb4 upstream.

The block address is saved after the block is initialized when
threshold_init_device() is called.

Use the saved block address, if available, rather than trying to
rediscover it.

This will avoid a call trace, when resuming from suspend, due to the
rdmsr_safe_on_cpu() call in get_block_address(). The rdmsr_safe_on_cpu()
call issues an IPI but we're running with interrupts disabled. This
triggers:

    WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-8-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -434,6 +434,21 @@ static u32 get_block_address(unsigned in
 {
 	u32 addr = 0, offset = 0;
 
+	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+		return addr;
+
+	/* Get address from already initialized block. */
+	if (per_cpu(threshold_banks, cpu)) {
+		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
+
+		if (bankp && bankp->blocks) {
+			struct threshold_block *blockp = &bankp->blocks[block];
+
+			if (blockp)
+				return blockp->address;
+		}
+	}
+
 	if (mce_flags.smca) {
 		if (smca_get_bank_type(bank) == SMCA_RESERVED)
 			return addr;
