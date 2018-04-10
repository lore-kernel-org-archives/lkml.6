Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48S6KkrEnf85x51sLJIS/8QeLQHUf9oA/ANF5obYzA5CDj0VGhjCErsLcyFZUyna7X+vLO9
ARC-Seal: i=1; a=rsa-sha256; t=1523399906; cv=none;
        d=google.com; s=arc-20160816;
        b=fVpv5TOQrnoLhps/tAVg6HKSoatxtem9y4Ia35GtArGdBbapJAVYc2qYJppaYTkPQ3
         gocWhCKIV8pUqOPVcKzHWDHu/Y0K929ylL13F0h/aEwg88QO6/xdiWOAZTromfNMjRB1
         Qb/Wtzt6L6X+CnSv0qXdWmGWfn+h9JJSSkxFr3nd/YlFEXR2huE2Y2R5eIKME/jwobZF
         zINFVgH8MBdNb0mGZdCXgiH7rkew4Y+zRH4m2biOed3kCmrP2+4STy/rJ28X54MWw4TJ
         ot01H4S7PLc+HXymN8wyqC9RJdrGK6hY+d7cUgusRvNtJ453Og6qBATE4Er6g2dX+oU/
         GRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=feu4uUw5pqIrJCiHy43C6cWmprnPjFpyR5cQH6ZO3ug=;
        b=zu2UC8ASCI6Zs/ZXmil0l+NiQjvH7h+PWxxSM+UbAgSeY06VpPAmRtYM+ShXP1mv0w
         HPGyIaGi58cyobqqWB2WSyTMCicTccRds0PJ6F+eLkXY5SdNsoSmZrnSF21xG/nPVDFI
         CRVDcrnHGffvtqYXyetpxXBm40EVWm84xsHDpsI+TjzCiHfPW/QsOXDJY0CoVg1V0zWt
         NiHMOM+JE1t4Vqw3+qdpCIKVLRzePylvESlTG79tToMLxw6q9lieiVVkiVygzpellAmN
         +Flh5RoMUT1EP+AQl0x0Tc/1di9OIuvt2L3ixIFEpywcgWumeYnrbzXqz8yHDPsR8tKb
         hhIQ==
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
Subject: [PATCH 4.14 088/138] x86/microcode: Get rid of struct apply_microcode_ctx
Date: Wed, 11 Apr 2018 00:24:38 +0200
Message-Id: <20180410212912.404765272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400102659058161?=
X-GMAIL-MSGID: =?utf-8?q?1597400579984963368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
