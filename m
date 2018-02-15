Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225evHKPt714awc8rqW/kL5X9BWO92/YwO+KsYBnBqSFJ8TtyOqbb2Q/cVl4mkWbEsYAF/Rx
ARC-Seal: i=1; a=rsa-sha256; t=1518708755; cv=none;
        d=google.com; s=arc-20160816;
        b=BFDpGGWusN2fFXhuhoEfuqKuU0MzNIzPxlGqf871fBF5n/Umd7xjI+HpJ5fIt0sQtK
         LQjPpGzqHxxUSTvpFcIYWxX3A5uxa9SuNoFZFukN82IIHTga8iOn+KyVyeSpHzR5/hV7
         1/ULVd4a61SX/SLzVKTQWV8+bAeSSFbj6A5Gg1a1HuVei80mZvl1yNpFPpKw1jmmXMjk
         zDsCg1NvTocjBIiFxgu4Wj6JYjmgz2Mbj64ZXxduLB5coqi5X9O5fj1iwUc8Lb0Q3oLQ
         JNcSFh4augaeNv3gLA4p133R3bHZUSpHPwTF96zIzmdijbCcFSDohoiXU6w4pWNkkGRd
         nfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sL5ab00/i8wyPPZ+FMZ9dBeP08cRYAAf8hC05MV2okM=;
        b=gZgXkmwggpy3G3078ZMV/eO7pnyuNAwUx4s6tge77qDRkzI/wBaUnajqLXL2Atj7Kl
         lvDyEKMWsoRkvDNZf8F/2Ddt4J4b+X9hmlJSd6Sd1suqXlbVZozxv/BfbBVvyFOSXJrN
         YSrua/jnX5ansZVRbPiRePjzSy/uuy/96YIABJ80P7ymh4e6hrqKZTfJykP20wxR88zv
         PVmL+k9mVNTAlUbhjtcmMyezLsZi6QNbMN6ZqMYwV3NrAK08CJy6xKYYpneq/cfWaR/J
         5F4UkTFzIqCnhVBADx5/DW8S7faSjZqR9aideokG9/H3GHTBfnisjVAhd5xv3c+sctie
         +uSQ==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 068/195] [Variant 2/Spectre-v2] drivers/firmware: Expose psci_get_version through psci_ops structure
Date: Thu, 15 Feb 2018 16:15:59 +0100
Message-Id: <20180215151709.118920798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481551616385727?=
X-GMAIL-MSGID: =?utf-8?q?1592481551616385727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
