Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C151ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E333D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fU6OScGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E333D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeGTCdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTCdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so5365638pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCxcDyoNvlUcvuTSjmiiZjG/8edg36zCnHJtENpLPBA=;
        b=fU6OScGz91asZgqmPcQ+EE8S9L2/RUvjxDv4x+MHOSBtQiGemCHooQ2fOKASeRT8/h
         amrEZwDOWJ5CNryd+1rIdDQtYhffwV8zPfETIjSce1XuvglsbAwB+sP1yG9bYCBwmRHp
         tWe+hyIi9VJQKCaqCs4VyMxLE1QTATxozVooQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCxcDyoNvlUcvuTSjmiiZjG/8edg36zCnHJtENpLPBA=;
        b=toyRuXhbhSfGxMezB9FC+DvKRwNALNboMFruQGKrdhNoeKRcebX5nRxDPerztwF7/V
         ss5fnamuFHeIWkmci7LbMw9mQoruObW7KNze2dqDpDqLJY4sR14eGrmScDYi+HhPcFLz
         trQwRao6kcGIl6Q+q+s1Os37U/vHhKLsmqCzCz7mNCJsDa9IOyhPGRIn8k4AUyxmXtwr
         6ROY3o0Mlh2moZMIidBm3vVxNM4XosgUqOlb1G0iv9PYWnZdFQ7E3bi/EdKe9bu4SE+b
         h4xqCJA1pe8LKtauEDSxFgK9rG9uvI3GrRirqQhBEIIxmjan0iRH6FGzTMtDAF4/mZto
         8ANA==
X-Gm-Message-State: AOUpUlEadNR1VamGjDR55w3DbRfmFFcjGz3vmLQKRHUT54ZeGosXIZob
        rYTgU51p4rbA4Pn5i8eeOqbDZE9vJlM=
X-Google-Smtp-Source: AAOMgpebE/VQdyShPxseduTxUV+vcXkVQUlKKJI+XpqV0xO2v5MvedctD6VyPzYN6XNDGa3elOAE9A==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr100066pgo.378.1532051269595;
        Thu, 19 Jul 2018 18:47:49 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:48 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/9] efi/x86: prevent reentrant firmware calls in mixed mode
Date:   Fri, 20 Jul 2018 10:47:18 +0900
Message-Id: <20180720014726.24031-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UEFI spec does not permit runtime services to be called
reentrantly, and so it is up to the OS to provide proper locking
around such calls.

For the native case, this was fixed a long time ago, but for the
mixed mode case, no locking is done whatsoever. Note that the calls
are made with preemption and interrupts disabled, so only SMP
configurations are affected by this issue.

So add a spinlock and grab it when invoking a UEFI runtime service
in mixed mode. We will also need to provide non-blocking versions
of SetVariable() and QueryVariableInfo(), so add those as well.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi_64.c | 101 ++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77873ce700ae..448267f1c073 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -636,6 +636,8 @@ void efi_switch_mm(struct mm_struct *mm)
 #ifdef CONFIG_EFI_MIXED
 extern efi_status_t efi64_thunk(u32, ...);
 
+static DEFINE_SPINLOCK(efi_runtime_lock);
+
 #define runtime_service32(func)						 \
 ({									 \
 	u32 table = (u32)(unsigned long)efi.systab;			 \
@@ -657,17 +659,14 @@ extern efi_status_t efi64_thunk(u32, ...);
 #define efi_thunk(f, ...)						\
 ({									\
 	efi_status_t __s;						\
-	unsigned long __flags;						\
 	u32 __func;							\
 									\
-	local_irq_save(__flags);					\
 	arch_efi_call_virt_setup();					\
 									\
 	__func = runtime_service32(f);					\
 	__s = efi64_thunk(__func, __VA_ARGS__);				\
 									\
 	arch_efi_call_virt_teardown();					\
-	local_irq_restore(__flags);					\
 									\
 	__s;								\
 })
@@ -702,14 +701,17 @@ static efi_status_t efi_thunk_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	efi_status_t status;
 	u32 phys_tm, phys_tc;
+	unsigned long flags;
 
 	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_tm = virt_to_phys_or_null(tm);
 	phys_tc = virt_to_phys_or_null(tc);
 
 	status = efi_thunk(get_time, phys_tm, phys_tc);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 	spin_unlock(&rtc_lock);
 
 	return status;
@@ -719,13 +721,16 @@ static efi_status_t efi_thunk_set_time(efi_time_t *tm)
 {
 	efi_status_t status;
 	u32 phys_tm;
+	unsigned long flags;
 
 	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_tm = virt_to_phys_or_null(tm);
 
 	status = efi_thunk(set_time, phys_tm);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 	spin_unlock(&rtc_lock);
 
 	return status;
@@ -737,8 +742,10 @@ efi_thunk_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
 {
 	efi_status_t status;
 	u32 phys_enabled, phys_pending, phys_tm;
+	unsigned long flags;
 
 	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_enabled = virt_to_phys_or_null(enabled);
 	phys_pending = virt_to_phys_or_null(pending);
@@ -747,6 +754,7 @@ efi_thunk_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
 	status = efi_thunk(get_wakeup_time, phys_enabled,
 			     phys_pending, phys_tm);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 	spin_unlock(&rtc_lock);
 
 	return status;
@@ -757,13 +765,16 @@ efi_thunk_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
 	efi_status_t status;
 	u32 phys_tm;
+	unsigned long flags;
 
 	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_tm = virt_to_phys_or_null(tm);
 
 	status = efi_thunk(set_wakeup_time, enabled, phys_tm);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 	spin_unlock(&rtc_lock);
 
 	return status;
@@ -781,6 +792,9 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 	efi_status_t status;
 	u32 phys_name, phys_vendor, phys_attr;
 	u32 phys_data_size, phys_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_data_size = virt_to_phys_or_null(data_size);
 	phys_vendor = virt_to_phys_or_null(vendor);
@@ -791,6 +805,8 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 	status = efi_thunk(get_variable, phys_name, phys_vendor,
 			   phys_attr, phys_data_size, phys_data);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
 	return status;
 }
 
@@ -800,6 +816,34 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 {
 	u32 phys_name, phys_vendor, phys_data;
 	efi_status_t status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efi_runtime_lock, flags);
+
+	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
+	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_data = virt_to_phys_or_null_size(data, data_size);
+
+	/* If data_size is > sizeof(u32) we've got problems */
+	status = efi_thunk(set_variable, phys_name, phys_vendor,
+			   attr, data_size, phys_data);
+
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
+	return status;
+}
+
+static efi_status_t
+efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
+				   u32 attr, unsigned long data_size,
+				   void *data)
+{
+	u32 phys_name, phys_vendor, phys_data;
+	efi_status_t status;
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&efi_runtime_lock, flags))
+		return EFI_NOT_READY;
 
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
 	phys_vendor = virt_to_phys_or_null(vendor);
@@ -809,6 +853,8 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	status = efi_thunk(set_variable, phys_name, phys_vendor,
 			   attr, data_size, phys_data);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
 	return status;
 }
 
@@ -819,6 +865,9 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 {
 	efi_status_t status;
 	u32 phys_name_size, phys_name, phys_vendor;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_name_size = virt_to_phys_or_null(name_size);
 	phys_vendor = virt_to_phys_or_null(vendor);
@@ -827,6 +876,8 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 	status = efi_thunk(get_next_variable, phys_name_size,
 			   phys_name, phys_vendor);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
 	return status;
 }
 
@@ -835,10 +886,15 @@ efi_thunk_get_next_high_mono_count(u32 *count)
 {
 	efi_status_t status;
 	u32 phys_count;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_count = virt_to_phys_or_null(count);
 	status = efi_thunk(get_next_high_mono_count, phys_count);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
 	return status;
 }
 
@@ -847,10 +903,15 @@ efi_thunk_reset_system(int reset_type, efi_status_t status,
 		       unsigned long data_size, efi_char16_t *data)
 {
 	u32 phys_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efi_runtime_lock, flags);
 
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
 	efi_thunk(reset_system, reset_type, status, data_size, phys_data);
+
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 }
 
 static efi_status_t
@@ -872,10 +933,13 @@ efi_thunk_query_variable_info(u32 attr, u64 *storage_space,
 {
 	efi_status_t status;
 	u32 phys_storage, phys_remaining, phys_max;
+	unsigned long flags;
 
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
+	spin_lock_irqsave(&efi_runtime_lock, flags);
+
 	phys_storage = virt_to_phys_or_null(storage_space);
 	phys_remaining = virt_to_phys_or_null(remaining_space);
 	phys_max = virt_to_phys_or_null(max_variable_size);
@@ -883,6 +947,35 @@ efi_thunk_query_variable_info(u32 attr, u64 *storage_space,
 	status = efi_thunk(query_variable_info, attr, phys_storage,
 			   phys_remaining, phys_max);
 
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
+	return status;
+}
+
+static efi_status_t
+efi_thunk_query_variable_info_nonblocking(u32 attr, u64 *storage_space,
+					  u64 *remaining_space,
+					  u64 *max_variable_size)
+{
+	efi_status_t status;
+	u32 phys_storage, phys_remaining, phys_max;
+	unsigned long flags;
+
+	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
+		return EFI_UNSUPPORTED;
+
+	if (!spin_trylock_irqsave(&efi_runtime_lock, flags))
+		return EFI_NOT_READY;
+
+	phys_storage = virt_to_phys_or_null(storage_space);
+	phys_remaining = virt_to_phys_or_null(remaining_space);
+	phys_max = virt_to_phys_or_null(max_variable_size);
+
+	status = efi_thunk(query_variable_info, attr, phys_storage,
+			   phys_remaining, phys_max);
+
+	spin_unlock_irqrestore(&efi_runtime_lock, flags);
+
 	return status;
 }
 
@@ -908,9 +1001,11 @@ void efi_thunk_runtime_setup(void)
 	efi.get_variable = efi_thunk_get_variable;
 	efi.get_next_variable = efi_thunk_get_next_variable;
 	efi.set_variable = efi_thunk_set_variable;
+	efi.set_variable_nonblocking = efi_thunk_set_variable_nonblocking;
 	efi.get_next_high_mono_count = efi_thunk_get_next_high_mono_count;
 	efi.reset_system = efi_thunk_reset_system;
 	efi.query_variable_info = efi_thunk_query_variable_info;
+	efi.query_variable_info_nonblocking = efi_thunk_query_variable_info_nonblocking;
 	efi.update_capsule = efi_thunk_update_capsule;
 	efi.query_capsule_caps = efi_thunk_query_capsule_caps;
 }
-- 
2.17.1

