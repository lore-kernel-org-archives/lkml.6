Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE0C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E842075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OodV8v3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E842075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeI3XX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:23:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeI3XX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:23:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so11217563wrw.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zQQypsis8U9V5SwYSdiwkV97643L7/h1ZNc5LuarjFA=;
        b=OodV8v3bobbNdNmv+cyAs7PWon/jUCL6IXhX8zoP6ZMFXVleoUbzKbG9D2/GRaF9QG
         BsJm819S8GwMLZLRsjwV6EgU2r+6udwYyxDkA1GKMycHcSavhwU6BKEmQKKW7jFETad4
         iA/XnQaMWoKEtuGi8dfLEvZFNd+PsFxPnWbGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zQQypsis8U9V5SwYSdiwkV97643L7/h1ZNc5LuarjFA=;
        b=C/8JgqwykeUoVAdjz36Y5zPkdZxE/VsrC1pOQuknsqZw7ICowacN6rx7MR4MJkLXiz
         NcQRtl9wqcg8fFr4Exh1XV7PUHReb4ZRyAeOvPP3d8x1O5R2PVhAPjz+QsO5mW8xkqyV
         yfaUo7Jr1NGqz3Y2xSruQLqEWA1W78CIPMDsA+cVExvhrWYvlS+VV7EtiwRWzwAhS8M7
         3wX9DLqn6PahjARJSdAzeJhgRfpZCIm6k28oVLDJj4f9Dzd26fn1LfflP4nIXOrUv447
         UaxDiz1i+GNbHxjDB9oZZAZbVyjdaeaDPFlbJWF2UTU8DsA3dCTbZq/9ddSMLKlJwQD0
         89FA==
X-Gm-Message-State: ABuFfoiP6HoEh8XeXgXjOZKVePiT4cIEQCzEbvMYL0QZdEow1hg9yHQG
        nXvPbMjwaK1YjpfsWip2rvkJ2Q==
X-Google-Smtp-Source: ACcGV61RM/yPVpO0D96KBxJ2bqI17bItBWCHK1TI7gj2qI8UCt5zgG50z0Ajb9hBkC63oCLeaBEzpg==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr5040655wrx.300.1538326211066;
        Sun, 30 Sep 2018 09:50:11 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:60c8:8590:40da:4e8e])
        by smtp.gmail.com with ESMTPSA id s26-v6sm6740812wmh.44.2018.09.30.09.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 09:50:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output section
Date:   Sun, 30 Sep 2018 18:49:50 +0200
Message-Id: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
region") moved the __jump_table input section into the __ro_after_init
output section, but inadvertently put the macro in the wrong place in
the s390 linker script. Let's fix that.

Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 4042bbf3f9ad..457713f48734 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -64,9 +64,9 @@ SECTIONS
 	__start_ro_after_init = .;
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
+		JUMP_TABLE_DATA
 	}
 	EXCEPTION_TABLE(16)
-	JUMP_TABLE_DATA
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
-- 
2.17.1

