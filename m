Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B662C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18DA21903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498423;
	bh=ABP7WavkDsRdNG5K0YIsKglktxL+rTpAHOOgENVTPo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSQ1k5uVx5N3OJH6sp8gUVfPJmXZhgtQw1tSsh67wzbiv+sTny46IHgNJ7vUiXe+5
	 iuKNNNIK4DrbrwexrQvntQTsw1+muIulmlTN7XNyKvpWfSLrlxxnU//rJ6WdBq0MtD
	 1LWFuTHUy8lr9k9ov2QO37CzLg2csUUACr77SfO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbfBROAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388780AbfBROAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:00:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A036217D9;
        Mon, 18 Feb 2019 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498415;
        bh=ABP7WavkDsRdNG5K0YIsKglktxL+rTpAHOOgENVTPo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9pIUZsR2vPPatGEeyluKIbx+gwJziMqyYx4I99kTL0r99VDtn5RFt6VWsNVu3qdd
         7E741CXwKEh4xT9Q+vLdvfdvK2aNbXdHOGViQDMLGuhoHDtbrd3RLzyrkOcReaQrR8
         4nJSsTPxjzqJJSEWKVqaJ2O53NEP0Ob0ckOWFdx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hedi Berriche <hedi.berriche@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.9 47/58] x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls
Date:   Mon, 18 Feb 2019 14:44:08 +0100
Message-Id: <20190218133512.176790600@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hedi Berriche <hedi.berriche@hpe.com>

commit f331e766c4be33f4338574f3c9f7f77e98ab4571 upstream.

Calls into UV firmware must be protected against concurrency, expose the
efi_runtime_lock to the UV platform, and use it to serialise UV BIOS
calls.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: stable@vger.kernel.org # v4.9+
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190213193413.25560-5-hedi.berriche@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/uv/bios.h          |    8 +++++++-
 arch/x86/platform/uv/bios_uv.c          |   23 +++++++++++++++++++++--
 drivers/firmware/efi/runtime-wrappers.c |    7 +++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -48,7 +48,8 @@ enum {
 	BIOS_STATUS_SUCCESS		=  0,
 	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
 	BIOS_STATUS_EINVAL		= -EINVAL,
-	BIOS_STATUS_UNAVAIL		= -EBUSY
+	BIOS_STATUS_UNAVAIL		= -EBUSY,
+	BIOS_STATUS_ABORT		= -EINTR,
 };
 
 /* Address map parameters */
@@ -167,4 +168,9 @@ extern long system_serial_number;
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
+/*
+ * EFI runtime lock; cf. firmware/efi/runtime-wrappers.c for details
+ */
+extern struct semaphore __efi_uv_runtime_lock;
+
 #endif /* _ASM_X86_UV_BIOS_H */
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -29,7 +29,8 @@
 
 struct uv_systab *uv_systab;
 
-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
+			u64 a4, u64 a5)
 {
 	struct uv_systab *tab = uv_systab;
 	s64 ret;
@@ -51,6 +52,19 @@ s64 uv_bios_call(enum uv_bios_cmd which,
 
 	return ret;
 }
+
+s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+{
+	s64 ret;
+
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
+	up(&__efi_uv_runtime_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(uv_bios_call);
 
 s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cm
 	unsigned long bios_flags;
 	s64 ret;
 
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
 	local_irq_save(bios_flags);
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
 	local_irq_restore(bios_flags);
 
+	up(&__efi_uv_runtime_lock);
+
 	return ret;
 }
 
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -50,6 +50,13 @@ void efi_call_virt_check_flags(unsigned
 }
 
 /*
+ * Expose the EFI runtime lock to the UV platform
+ */
+#ifdef CONFIG_X86_UV
+extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
+#endif
+
+/*
  * According to section 7.1 of the UEFI spec, Runtime Services are not fully
  * reentrant, and there are particular combinations of calls that need to be
  * serialized. (source: UEFI Specification v2.4A)


