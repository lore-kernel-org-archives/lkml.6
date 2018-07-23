Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80720858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxYMSNTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B80720858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeGWBq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33744 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeGWBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so10962341pgv.0;
        Sun, 22 Jul 2018 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw6302ch86pg258GLepkuZEk2pw2bUxOqBJi45V/0IA=;
        b=mxYMSNTjPaTuk9p6flXgdWta6SBmnXCoCTCepfsUIczcJWdbdvSP/MaPriFgwl85g+
         49JAZwnnqvOPm1/5V6kxWhZ2iBrrIUq5vLhNzcMvnklPqF/KvZ5R2I6vr6rppXY3tP/e
         gmJzaha8cxi+WyrhrOsS35aYdH8HM30k+IxCfKqfawK4wbpToPxys3rycZQXzgB71zU0
         HOj5e3sBwvH8LCup8G9DCP5otkQVNKJEHZyWF3KvYDV5ZSpPoqA2RF0FC1eoy2nVVLbb
         r1YGFJuap/5niBiosnkpRInmNOhZe6WnQaTYTBLrMsolYp/VHKNhlDWl9HDjUibkOaMi
         IJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw6302ch86pg258GLepkuZEk2pw2bUxOqBJi45V/0IA=;
        b=t2yVerLribMk7ljjiGucGk+TQl3WkoI5SG39KiWuLngbzMyIgahJaC+p58hRWyRwoT
         U3tatFvi9V7sWT1VvaG28HWxZWXF23/0NORdpSWWtGsD8cMQ86bwupAKJlzdnnPWjqyi
         KJBgG8NVw/KXqVM1hj+QTsbwYGjudlPjfZm2brACI5IQx7qUO0frwS5UwpdnuTEcxis3
         XcLYl9NbUWnUN0/bDvj4khi20fliUtW6sCoTEjSIkHCOYc5XaqQqAgY3FQLBb3/JSm/n
         SuFuv9vAzVnjC0MSC+Nnk7DafTI8mRpIk1kjsR/XKI0wb1ezEm7d/uKY1RZ5Uxyibw70
         OVXA==
X-Gm-Message-State: AOUpUlEUBdezh0Ey0WkKPNH0HhQn84lsHbWOaRC7/VXIPVVwQZSNv3Wx
        6dnSq3TX6RHKDpYgzpZD+lVzZlOH
X-Google-Smtp-Source: AAOMgpdl0lxkAf0uWXMLGxqtRTG8IvSYsCxlLd48PhAZbAXOQnnJ38N1biNRAjQgL6VfwGIYCxZyXw==
X-Received: by 2002:a62:d98f:: with SMTP id b15-v6mr11035185pfl.1.1532306870251;
        Sun, 22 Jul 2018 17:47:50 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:49 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 3/6] KVM: X86: Fallback to original apic hooks when bad happens
Date:   Mon, 23 Jul 2018 08:47:36 +0800
Message-Id: <1532306859-31166-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
References: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Fallback to original apic hooks when unlikely kvm fails to add the 
pending IRQ to lapic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index eed6046..57eb4a2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -47,6 +47,7 @@
 #include <asm/hypervisor.h>
 #include <asm/kvm_guest.h>
 
+static struct apic orig_apic;
 static int kvmapf = 1;
 
 static int __init parse_no_kvmapf(char *arg)
@@ -454,10 +455,10 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
-static void __send_ipi_mask(const struct cpumask *mask, int vector)
+static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	int cpu, apic_id, min = 0, max = 0;
+	int cpu, apic_id, min = 0, max = 0, ret = 0;
 #ifdef CONFIG_X86_64
 	__uint128_t ipi_bitmap = 0;
 	int cluster_size = 128;
@@ -467,7 +468,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 #endif
 
 	if (cpumask_empty(mask))
-		return;
+		return 0;
 
 	local_irq_save(flags);
 
@@ -481,7 +482,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 		} else if (apic_id < min + cluster_size) {
 			max = apic_id < max ? max : apic_id;
 		} else {
-			kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
 			min = max = apic_id;
 			ipi_bitmap = 0;
@@ -490,11 +491,12 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 	}
 
 	if (ipi_bitmap) {
-		kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
 	}
 
 	local_irq_restore(flags);
+	return ret;
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
@@ -511,7 +513,8 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 	cpumask_copy(&new_mask, mask);
 	cpumask_clear_cpu(this_cpu, &new_mask);
 	local_mask = &new_mask;
-	__send_ipi_mask(local_mask, vector);
+	if (__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
 }
 
 static void kvm_send_ipi_allbutself(int vector)
@@ -521,7 +524,8 @@ static void kvm_send_ipi_allbutself(int vector)
 
 static void kvm_send_ipi_all(int vector)
 {
-	__send_ipi_mask(cpu_online_mask, vector);
+	if (__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
 }
 
 /*
@@ -529,6 +533,8 @@ static void kvm_send_ipi_all(int vector)
  */
 static void kvm_setup_pv_ipi(void)
 {
+	orig_apic = *apic;
+
 	apic->send_IPI_mask = kvm_send_ipi_mask;
 	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
 	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
-- 
2.7.4

