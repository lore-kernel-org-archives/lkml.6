Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274/o0R1V7gRcQmh43OWmuMQakh87+Ucr5zqFyRm1xv0XW7bcISpxi9qTtCFN9pRYYCBanD
ARC-Seal: i=1; a=rsa-sha256; t=1518709277; cv=none;
        d=google.com; s=arc-20160816;
        b=TP/grQMHy3D+Z4SGNV8QB92HrkFasi4RCG5iUzn0wqBr/bdxceHPdIgw0tpTteypVY
         sgW1jPLUK+8+BXLI8Xpu11DsdCkUslvYZv5qjGIp7pDYt2sG25gN34g3b5oakfmrg1P9
         hlD9L1U9cOwBb0WkInLMucVn7Z56SaIq3zRRd22hfcc1L9naRv9mUBVbbgLgRk/bjX5x
         saEuixcYMNun0i9vSVoTGXXHU96D+v/H6HPoiyLJmD4lIzhHFrwkivR/EQoBh+9u+hM1
         6A1Jopb4w+J+qXtLnrgbeqOJvgFGbi1e1PwbUQXfIwPsauJn5WGOpYxWk1XlFyaFw2Xo
         tW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JJKLR6P3yKaAnrCWi5bXwuNGAFyxCFWJ/HVmY/ECsyM=;
        b=rSpJbxcxwxdJ4l8vgq4iL/qe2vaflhLnMdSCcaTWBoEbR8GmZTipHcyiXp841QaF5t
         3495Hdh7nfcWc4BegvuZRoV9yqwmfVU6z5MhRLk/fMrxpnWqTLKKfJoY2kVY9j2L9eUY
         OzVpi2q5+2IXF39LCtLwaUQsZJL9+aFKDsHcmR5x8f+vOz4IL17bA5VRpDYnFQlP7Xdo
         vOlh21Eq2p1hXcIuweRP/yY12eC6oyWk5B0f5O1LvBrhj4AYXsocV+ysy15kbZNThxFx
         P3QJk8Sp9EvIL7YGCF5fBV/GS7EqN1ty8/evH1aigtwvFSRnx7OTRS2Hudi/K3sSTTJG
         Newg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 061/202] [Variant 2/Spectre-v2] drivers/firmware: Expose psci_get_version through psci_ops structure
Date: Thu, 15 Feb 2018 16:16:01 +0100
Message-Id: <20180215151716.565495689@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481551616385727?=
X-GMAIL-MSGID: =?utf-8?q?1592482100042220351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit d68e3ba5303f upstream.

Entry into recent versions of ARM Trusted Firmware will invalidate the CPU
branch predictor state in order to protect against aliasing attacks.

This patch exposes the PSCI "VERSION" function via psci_ops, so that it
can be invoked outside of the PSCI driver where necessary.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/psci.c |    2 ++
 include/linux/psci.h    |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -496,6 +496,8 @@ static void __init psci_init_migrate(voi
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_ops.get_version = psci_get_version;
+
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -26,6 +26,7 @@ int psci_cpu_init_idle(unsigned int cpu)
 int psci_cpu_suspend_enter(unsigned long index);
 
 struct psci_operations {
+	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
