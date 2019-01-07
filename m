Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3953C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7397F20989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxN9z5h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfAGJ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:56:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfAGJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:56:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so20550122pgu.0;
        Mon, 07 Jan 2019 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfX9LJFRBEa9hQeV1aHxcrD/vEn7cqhe6zKBxcT6HgQ=;
        b=qxN9z5h27fMgjyR4k4W3g79+W1f89QDZ/aEahgt//OOfN8mJ7jGXWPsQ0wn908T6eE
         22dzLaYYDCrLvLQfjw01fZj3/rTvwUSPSmiMLM5k2QNXtghDxSc3Gt9wxmO6aTa7AKL2
         2SA7v/j33JsIQqgtMCighJ4PQES5imdHtSFNRzynQM+cbjUwdD0ySkBMoLfUjC3tk0u7
         1XlS8+IdD3VeEBcaBW5BsPrIaJla9bbEjzqtudu9GQydi4RcfpHyMG/VmGbTR5b+pOgB
         hsjnI32Jwq5Sttet5s97WAWyQJPxdTQ+0MzjCAzF5sk0XhI/QQRfgrO0VEHF304NKLvX
         i/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfX9LJFRBEa9hQeV1aHxcrD/vEn7cqhe6zKBxcT6HgQ=;
        b=fzo1JEt/4XS0C+f7qd0E8BWAAe0pZgwFdShI1Merhx1BHgfPN1DHRBepzKm21gdifE
         oYylYl4/l/q2pv1WRphLdDvlAUrEoH6B3hxRxspCqJkceOhCade772ZCf2eSKrIzODoq
         S/mZLVs4LY0GfE5GO6NF/LQxALevDtJZQ+o+2Ic/e5NQ6GO/W6Q2pRt8XdidNATKrwzc
         kxwUQSaCsIt58nczcvL6i4WldkRUqcG4wC1RfEcCK8zU5AILEwHD7xuszw8uLjm8AUB/
         7eJkLeWkNnRXoth3zIakFs1JK9qOBSkMOSeDXq8mN2r0H3Rx34WvblNFxvjbkx/M8qbk
         XFfA==
X-Gm-Message-State: AA+aEWbD/+ozVigpoYxxfOm61Gp55oCmQuTNhnwmwDlKSvpyYPR0OiYB
        wrkU2q8pDro4U8bs7xGZ/t0=
X-Google-Smtp-Source: AFSGD/UMdLsLNHDjxPZ6Pl7pyi8ukDPi8ReLxGr8JLCAuCRKXjNQSiNmg4YJe5d2dwcAYcADc/th5w==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr64011590pfa.76.1546854979375;
        Mon, 07 Jan 2019 01:56:19 -0800 (PST)
Received: from localhost.localdomain ([175.223.14.193])
        by smtp.gmail.com with ESMTPSA id a15sm94573493pgb.1.2019.01.07.01.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:56:18 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] parisc: replace oops_in_progress manipulation with bust_spinlocks()
Date:   Mon,  7 Jan 2019 18:56:12 +0900
Message-Id: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bust_spinlocks() function to set oops_in_progress.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/parisc/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 472a818e8c17..7e1ccafadf57 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -218,7 +218,7 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
 		return;
 	}
 
-	oops_in_progress = 1;
+	bust_spinlocks(1);
 
 	oops_enter();
 
@@ -396,7 +396,7 @@ void parisc_terminate(char *msg, struct pt_regs *regs, int code, unsigned long o
 {
 	static DEFINE_SPINLOCK(terminate_lock);
 
-	oops_in_progress = 1;
+	bust_spinlocks(1);
 
 	set_eiem(0);
 	local_irq_disable();
-- 
2.20.1

