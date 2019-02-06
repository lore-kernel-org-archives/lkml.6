Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55432C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199ED218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nVR/+W7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfBFAMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:12:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfBFALy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so4467526edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO+RYEcmpOreznGDDZGCoO864712k1v0HTv9EOfb/gA=;
        b=nVR/+W7APlED/5oXx5iqB73rglfVteAO0hCyxfqSpA0vLRvEFdE9MrkUcchQwhD3Ki
         KCX1adhmwAiEIs/QDlTq6DAoeciNKFXs0m/zQuyhRYJGTMjhHVvLzzxQfcQYNZnLzFHX
         yC0ErFLMt+qtbT79BhbIZZ/SWqpMbSfjBWuBsI3ONRRwSOIhAgosso/t84B5z2wrS3OH
         NuSHedhQq4d8y/H1KMtEtc8w6axVhOb53OVYU+CXDsAiraqQplGpuHjuq8RJYzcd+B/Z
         LqJ3Tlkc7IyNraKWHCeSeAHAJ6MK1OG8cusFQNYqElUP1vUPs3c/CaUXXRNQL3wLeOW5
         TJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO+RYEcmpOreznGDDZGCoO864712k1v0HTv9EOfb/gA=;
        b=ZtgrGFj9soFiCTMGT+XkD/VPhMgu8sIcvXPmJYVO1NiS//htfX4RkC7ZKv9Lz1WBuQ
         cHRVgDHd2vlauugXt1xfxv2/J+WVa3PxRcW5A+rg5thw1rCh9tGBu/SjxMV2eSARRMmx
         LcyaSgksVsW1BJWrj0QMPTjqijlyBqz1Qq9btt/UX/4v3M1TSSJX90jpTyJXdouJuhgn
         AvmDRB1KiqVx5wFT9AG2ndQsMi6uBz3cxl4Ood+033q9H9Qv5laVGepdHYRwgqalN/bU
         xy+2SylzAYwJgovPEFEWqrtJOMfzrPPxk8/xzGWpjvIJTdjlfT3rgpO0ZTBtLMZ+dpvI
         2ZOA==
X-Gm-Message-State: AHQUAuaZisg2UWqER7ZBgb0iF0k32BoJgkfzFh9FC7dig5K6J58IkmYT
        UlXM0dWgv/AYucLZmUUe/sFB8+32xuA=
X-Google-Smtp-Source: AHgI3IZd715GY7oV9JLOUm2wksZ4xWMmA+plHuBx//m/bbIEqQqD9QE3WYssK/bX0U2oxPG6vMR7iw==
X-Received: by 2002:a50:ec19:: with SMTP id g25mr5907076edr.38.1549411912433;
        Tue, 05 Feb 2019 16:11:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:51 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 32/32] x86/vdso: Restrict splitting VVAR VMA
Date:   Wed,  6 Feb 2019 00:11:06 +0000
Message-Id: <20190206001107.16488-33-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although, time namespace can work with VVAR VMA split, it seems worth
to forbid splitting VVAR resulting in stricter ABI and reducing amount
of corner-cases to consider while working further on VDSO.

I don't think there is any use-case for partial mremap() of vvar,
but it there is - this patch can be easily dropped.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 52c1e4c24455..dc1fca4d935a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -87,6 +87,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	const struct vdso_image *image = current->mm->context.vdso_image;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -149,6 +161,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 #ifdef CONFIG_TIME_NS
-- 
2.20.1

