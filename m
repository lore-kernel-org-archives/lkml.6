Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5004CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEF7213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ej4oLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfAGJ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:57:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAGJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:57:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so20517991pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ze2tdZRcrsfRWtX0DH4fBvdbFaxqCQ1B/ZmEi8dntyM=;
        b=H5ej4oLlqskUIU0/ucYmdyzpaWBObClYAkOa/Cw27/xi4pZOVaZkX7crpmj30sk3DL
         hLB22BagvfKHWfuG5kgkiZHN+yqE0YIvrYSk8ozAeBtsj6JISI82DvIR/ibetPW50jWi
         5bOMcSiGhPkMzOS2MlHUyY8JRvjNyglE34kS6LZf/sCy4HWT2xrcExddTWfGVg2DP+H6
         eDiHDts0QZz1m2ssCb0VGbHJ2auIsL+vb65GHktGc+fFX0SoukntTOGkY1RP4b1ihpu7
         IqUaHfJFgxfHnASi3s4L2FbY6c96Os+Dq95Bj2Us8wgtMo4TEHTSzrbWq76px90/ayGm
         m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ze2tdZRcrsfRWtX0DH4fBvdbFaxqCQ1B/ZmEi8dntyM=;
        b=rFnGHv4k1ROTqF41pgFS0mE/BCbwHOKNHVmhwu/HwmmqSEVFuBtsjzThK2T1YU0NA6
         3Vg2yH+DUpP0uXN4dLUvDv4ldiHZDC9RTQbZ2AhGaDwW7CeAJUjPWxUaT6VALvCclqn0
         w9Ff+R4pwDysdIODha2AQ0WR0yyMbQU+hC26qlw4v2gnhALp/57PwtPVXvs/mwM1XKMj
         cNq3bxFPQCBPYAVExnSUTuzNXlih/sWMV9J1vSktraBrVGAl3WZhlS5LGIOondf/bHAu
         NuybV+kibbppPTZ2VMTRUjaBjyBo1xYmiMvQFDDroIcuoiolj0v8BQni1wWmjSGhOymH
         qOsg==
X-Gm-Message-State: AA+aEWa8pfXPBhUTNf/74/Pp/xJdZPq+o/tV1SfwIuNtHp0hk7W38I5p
        mf8Tyka1dnsMlnE/V4UoUuM=
X-Google-Smtp-Source: AFSGD/Uf84UEDVKpsIVbbr/BY+uTuwlcRjEShYRNhc6NyDrtBTToH/NIveMPLkQefVLE3aKJB6k8UA==
X-Received: by 2002:a62:710a:: with SMTP id m10mr61997859pfc.69.1546855048251;
        Mon, 07 Jan 2019 01:57:28 -0800 (PST)
Received: from localhost.localdomain ([175.223.14.193])
        by smtp.gmail.com with ESMTPSA id x19sm111676579pfk.14.2019.01.07.01.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:57:27 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] powerpc: use a CONSOLE_LOGLEVEL_DEBUG macro
Date:   Mon,  7 Jan 2019 18:57:20 +0900
Message-Id: <20190107095720.7538-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a CONSOLE_LOGLEVEL_DEBUG macro for console_loglevel rather
than a naked number.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/powerpc/kernel/udbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7cc38b5b58bc..8db4891acdaf 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -74,7 +74,7 @@ void __init udbg_early_init(void)
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
-	console_loglevel = 10;
+	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 
 	register_early_udbg_console();
 #endif
-- 
2.20.1

