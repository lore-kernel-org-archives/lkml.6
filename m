Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB26C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2521720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270440;
	bh=ykit/g2NU6i0vXcuhkIbs5eCsXcsMBix1KH4DljnmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBfRvBaGgscOV+lJ21ksbYuyA3ZyNtslrcDOvbdwVYVJ4P/XI+/RAlwLNS/mjFqAx
	 C0iBkGmEa7pGK8CHdh8Kq9trxQYMWkjMHxDEwAZESiyt/W05UAA1P+/Qt+p+0lMYYR
	 nw0jhB6cbx7VfcW+IHWy9ETODJw9vTNpu76E0yCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeLaPd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:33:59 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344892133F;
        Mon, 31 Dec 2018 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270438;
        bh=ykit/g2NU6i0vXcuhkIbs5eCsXcsMBix1KH4DljnmKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrANTB8zuYsh81oph/U5jq8r9eiyptshl/KhNoMkwfyb9hsAM5cNAYxlRWrQHhceh
         vJIW81aM5J/sYmnHr4CmjYDsb16lZwzLYGgAmYvPwGD9lqVV+irOlvli1jhYx+lrDu
         nZLgfmA2+Vb451bzo1QR71SQddSo3QhuG82V2hNw=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 03/14] csky: fixup remove vdsp implement for kernel.
Date:   Mon, 31 Dec 2018 23:32:55 +0800
Message-Id: <1546270384-4590-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The vr regs for vdsp only saved in task_switch not in every
exception trap-in. The memcpy with vdsp instructions will
destroy the vr regs for user space applications.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv2/memcpy.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/csky/abiv2/memcpy.S b/arch/csky/abiv2/memcpy.S
index 987fec6..145bf3a 100644
--- a/arch/csky/abiv2/memcpy.S
+++ b/arch/csky/abiv2/memcpy.S
@@ -27,13 +27,7 @@ ENTRY(memcpy)
 
 	LABLE_ALIGN
 .L_len_larger_16bytes:
-#if defined(__CSKY_VDSPV2__)
-	vldx.8	vr0, (r1), r19
-	PRE_BNEZAD (r18)
-	addi	r1, 16
-	vstx.8	vr0, (r0), r19
-	addi	r0, 16
-#elif defined(__CK860__)
+#if defined(__CK860__)
 	ldw	r3, (r1, 0)
 	stw	r3, (r0, 0)
 	ldw	r3, (r1, 4)
-- 
2.7.4

