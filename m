Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFDECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCFC2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkZmmJdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCFC2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI0PIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33490 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeI0PIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id r1-v6so16955774wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV7F4d1AYaAve1kQcC/87SijzJzQIBKlPBUcmLRWBv0=;
        b=TkZmmJdBo/SUvBqPKL+IcIanULSh9vtUwZ5eAdAWdba7syillbGVRCXzXNAyovEjhx
         h2S6gEAG/tX9CkTqagjlyppkJboAiR4CryMJID7lv2wLQwboMOyNG52rWbZxH0umVy3V
         MG8h/p/0E1462SFuOvI2Jg4mLzQjLYjD1h+gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV7F4d1AYaAve1kQcC/87SijzJzQIBKlPBUcmLRWBv0=;
        b=U36Y9sxlHZ9HwcBonvPo6jqzl5gUgdUitMDGz9LMO0gf8f/Catwj8n+EDvfFgp16ii
         wVQg15w9sk4b3lyJodc8uvnU6fnZlBZa4YFSOFMVkgSMnqNMJbS1GKUw4HN3or5xNOug
         z/C63aUt5q6K8nqTWqIWH37uvRcEjEIFm9atY1ShxwNjq7MRONV+2kK29dL2kd5jpFJU
         dXMmhxz7YbUm2PImXTErFlSkLuK0aJnRJwdvLuVW3/qCYf14ckv1/BGdPS9qXfCSDX9g
         /+8mPPbdGqGSyGssZmO0bqHvhI/jbG5mZFj+21lMrQ/BM2b9lJhtiJf/fKbLGLP96KdI
         jTGg==
X-Gm-Message-State: ABuFfoiP5+CIfujF84tuMLxAJf7wUP1a65wRs8dTzY7/a09z43CSXwuS
        9DzielUlJ5570tHcuwfWYHi7WVVbCow=
X-Google-Smtp-Source: ACcGV639shnoLP1ApaVus5JsrEFH4WI0GilSwGgCiaKn+UCYyd1S+teicmFXIqEqUZpPKDkatOJF/Q==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr7058866wmh.113.1538038267937;
        Thu, 27 Sep 2018 01:51:07 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:07 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 08/11] efi/x86: drop task_lock() from efi_switch_mm()
Date:   Thu, 27 Sep 2018 10:50:35 +0200
Message-Id: <20180927085039.8391-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

efi_switch_mm() is a wrapper around switch_mm() which saves current's
->active_mm, sets the requests mm as ->active_mm and invokes
switch_mm().
I don't think that task_lock() is required during that procedure. It
protects ->mm which isn't changed here.

It needs to be mentioned that during the whole procedure (switch to
EFI's mm and back) the preemption needs to be disabled. A context switch
at this point would reset the cr3 value based on current->mm. Also, this
function may not be invoked at the same time on a different CPU because
it would overwrite the efi_scratch.prev_mm information.

Remove task_lock() and also update the comment to reflect it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ee5d08f25ce4..e8da7f492970 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -619,18 +619,16 @@ void __init efi_dump_pagetable(void)
 
 /*
  * Makes the calling thread switch to/from efi_mm context. Can be used
- * for SetVirtualAddressMap() i.e. current->active_mm == init_mm as well
- * as during efi runtime calls i.e current->active_mm == current_mm.
- * We are not mm_dropping()/mm_grabbing() any mm, because we are not
- * losing/creating any references.
+ * in a kernel thread and user context. Preemption needs to remain disabled
+ * while the EFI-mm is borrowed. mmgrab()/mmdrop() is not used because the mm
+ * can not change under us.
+ * It should be ensured that there are no concurent calls to this function.
  */
 void efi_switch_mm(struct mm_struct *mm)
 {
-	task_lock(current);
 	efi_scratch.prev_mm = current->active_mm;
 	current->active_mm = mm;
 	switch_mm(efi_scratch.prev_mm, mm, NULL);
-	task_unlock(current);
 }
 
 #ifdef CONFIG_EFI_MIXED
-- 
2.18.0

