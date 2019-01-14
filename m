Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DBE20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh+lmbYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfANUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:36:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:36:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so1058479wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPRgNVGVdN1EoBLCSLIBiHJm22U/icg+/hPxnSvOnlE=;
        b=Rh+lmbYY8vTW5dG1RaQ+6jen7BJZBC/vb5n+pLdjoAnb65PamEiXWdTfMqReCOjeys
         gAvjEXGq5Ka+XCbyuakLrP+rI802dYkHiie7xaMUV3/f5wSdwD6mkkJFa3VMrFH/WR87
         1ZOLTgIFnf7xR20gOddSormmnn3gGJlG+/FWPaDFswRCV0Y+LFUc0PZQNqpenUIn80hX
         7uflaHvIs0LqvNuvYW9bnDISkfv0Qw3wiZaXst3v1VaRwAyIAb43+qbi10rkNkppc5hs
         ObjKg0+J7qfy6UIxunM6ZhLNpfZOyZZgbMXue4dBMqJnONofJfv8B4y3rMis9EdvU/Z/
         tSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rPRgNVGVdN1EoBLCSLIBiHJm22U/icg+/hPxnSvOnlE=;
        b=Ic1ID/XlUx9WYzDYEtiUrcBWhxD3hVooToMGRzScUe0hnH0n1jEvPm6Yvhv2gFp56w
         9F6k4ODIx+DaeX3gnpN9dn8e7M5pN1mZK+L1XUCnBlbsYAhEZilrYGGjebAp8hZoy7dK
         4R4NtFFIItncNldug6ixOx3gwn0/ZvxSNUy0DxoT3+ocr6b+mKHU9KlJ7zkW+0kFy3Pn
         uIdHba/RVpimpQSqA97S2PBjrhf88HqhgY5NRQV0hQKY64M7KcoS5GnJS9AoJDVnIpbA
         2/DcBE+VxcECMEslFm7AKN7tunqPjrefCaG3ouaH2xtATM65hU4TC71MZPHhBu8VA2yP
         st5A==
X-Gm-Message-State: AJcUukdUu1mS2KrtWwbf2seFD7vOW7WaQzPu9tS4uloK2GXIjSMXDUcb
        JncnS5nmVwAho1rk9GksshJ0L+8u
X-Google-Smtp-Source: ALg8bN64X+eM+wqT3lo1O/gZvqQ778zNYB8foWQeE9eIbl+sZHKt2qfcdVuPLBLHlNMi4u9BtrrUXA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr625731wmj.127.1547498197494;
        Mon, 14 Jan 2019 12:36:37 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id a187sm28067157wmf.33.2019.01.14.12.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:36:36 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CA17E11422AD; Mon, 14 Jan 2019 21:36:35 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] irq: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:36:33 +0100
Message-Id: <20190114203633.18557-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case add a ‘-’ so as to match the regular expression
expected by GCC.

This commit remove the following warning:

  kernel/irq/handle.c:167:4: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/irq/handle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 38554bc35375..6df5ddfdb0f8 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -166,7 +166,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 			__irq_wake_thread(desc, action);
 
-			/* Fall through to add to randomness */
+			/* Fall through - to add to randomness */
 		case IRQ_HANDLED:
 			*flags |= action->flags;
 			break;
-- 
2.19.2

