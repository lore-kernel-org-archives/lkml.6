Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6783AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A8E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyZ9K/mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A8E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeH3GDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:03:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42225 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeH3GDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:03:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so3125006pff.9;
        Wed, 29 Aug 2018 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZriRi6qAj14t1p4MRdPKPXTSGBiamfNqVcP9ENPbS/M=;
        b=PyZ9K/miH87VO1ITKdhZ17dZswYPMdQEyVt5OZM6l5MF2f3Hkld46fO5Nw/74K9xiy
         qicJnBpvsrmIt/iV1PlUjACyHnItPckY7oza6faGVa+FzdRCCX/PjIY6lv9gY/LwAYbd
         CVywRw6Rq5DHnkk6Kzq2ja8HbN17prafKeUMeW2MQ+KKG16dwHG4O449ujC1siahYOe+
         ZZpe4qA52HbU/2EnNFUkyqa41A+z3gF+QlE53iRfue6Br9Noz6OnQCKZpmlLbpEVNrAc
         iAi2Y1dlo7u8axgngP+emXh3HiKBTTvGJ2ka+MDKWWlTZY3+rtWFscmLrkCJXH+Sw4F4
         u+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZriRi6qAj14t1p4MRdPKPXTSGBiamfNqVcP9ENPbS/M=;
        b=S3NWuldwRwDT8OlULek/1sJv1Hde0m9j5TgQsn3CLFrnWMMRExLJwZYDqepkIzdwFE
         h1TZqN6fs5+YmVXtBh2mVO3id9yQ4qrB6Q+IF8pKzs0yHumFxkyIasYj1kiP4VTCSfrI
         bn/jraRxuFRzPDCq2btOdPd3s7d+yzJcuaN19O7uSd6H++6K3wL8Vjuj1x1BgrIE0dxa
         3HoOiTiKQ/7xksz7nuuuvdolk4EvD3/F7YU77OheRf9iH7bhDDK2LJyHyaWPGYi1r0Qy
         PY2znKG+7Zui9+NOrAePz9AT7UW8dTZOHFIfQgDcH512rDWCM/uGxyty0abkiK6DT4Bd
         0QDg==
X-Gm-Message-State: APzg51BFwt/R2rUlsT1e3oldV8li3nn5xbdxFrXJ8eLUypivdPOJ8Pug
        waSOy+Vum5iYraVm2nIeteg6HAIj
X-Google-Smtp-Source: ANB0VdYVvbsPDiYJDnSI2UYe4w/kvgLGAPNjH3DwaHtyCImgxuA2SZxbKP5oAAyIbRrisTAP7pzSsw==
X-Received: by 2002:a63:225f:: with SMTP id t31-v6mr7770713pgm.275.1535594615054;
        Wed, 29 Aug 2018 19:03:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id b18-v6sm11433523pgk.15.2018.08.29.19.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 19:03:34 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] KVM: LAPIC: Fix pv ipis out-of-bounds access
Date:   Thu, 30 Aug 2018 10:03:30 +0800
Message-Id: <1535594610-9095-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Dan Carpenter reported that the untrusted data returns from kvm_register_read()
results in the following static checker warning:
  arch/x86/kvm/lapic.c:576 kvm_pv_send_ipi()
  error: buffer underflow 'map->phys_map' 's32min-s32max'

KVM guest can easily trigger this by executing the following assembly sequence 
in Ring0:

mov $10, %rax
mov $0xFFFFFFFF, %rbx
mov $0xFFFFFFFF, %rdx
mov $0, %rsi
vmcall

As this will cause KVM to execute the following code-path:
vmx_handle_exit() -> handle_vmcall() -> kvm_emulate_hypercall() -> kvm_pv_send_ipi()
which will reach out-of-bounds access.

This patch fixes it by adding a check to kvm_pv_send_ipi() against map->max_apic_id, 
ignoring destinations that are not present and delivering the rest. We also check 
whether or not map->phys_map[min + i] is NULL since the max_apic_id is set to the 
max apic id, some phys_map maybe NULL when apic id is sparse, especially kvm 
unconditionally set max_apic_id to 255 to reserve enough space for any xAPIC ID.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * add min > map->max_apic_id check
 * change min to u32
 * add min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 00ddb0c..e6534b3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1463,7 +1463,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-    		    unsigned long ipi_bitmap_high, int min,
+		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit);
 
 u64 kvm_get_arch_capabilities(void);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0cefba2..7de605c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -548,7 +548,7 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 }
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-    		    unsigned long ipi_bitmap_high, int min,
+		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit)
 {
 	int i;
@@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
+	if (min > map->max_apic_id)
+		goto out;
 	/* Bits above cluster_size are masked in the caller.  */
-	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
+	for_each_set_bit(i, &ipi_bitmap_low,
+		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
+		if (map->phys_map[min + i]) {
+			vcpu = map->phys_map[min + i]->vcpu;
+			count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
 	}
 
 	min += cluster_size;
-	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
+	for_each_set_bit(i, &ipi_bitmap_high,
+		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
+		if (map->phys_map[min + i]) {
+			vcpu = map->phys_map[min + i]->vcpu;
+			count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
 	}
 
+out:
 	rcu_read_unlock();
 	return count;
 }
-- 
2.7.4

