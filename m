Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89218C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBA620880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542990;
	bh=hhL/76R98sHmWbd3paeuyqZ/dN5KWx69qwWTOTpvASE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JuVd5K+AZB0HplLAqjsHKA0kSiRzzTUCvHXALMlCdWBXeIu4dFG8iG1KWEeAHWSml
	 D4qYcsRk/JAix0DTEy0stX5qVrGVNrE0Nh9SqMxcdcsQ9rdWsrzmMqR0UvRMQnQuHB
	 /JQ9MasesSDnbUKFeo307puHckHA1jO3FbjtHXgo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBA620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeLKPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbeLKPnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53F220870;
        Tue, 11 Dec 2018 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542987;
        bh=hhL/76R98sHmWbd3paeuyqZ/dN5KWx69qwWTOTpvASE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+WwX5ZSJTNXNLW5pHtsyDxapdfjcQRLBu1I+6zLe75vthbCiOkDK2jSZfcfdsrjk
         b3esPXXrRnpMtKRMUKd3WBFd0F0ARZ7/JVLifDxxd71Jawsj6f7g2BDWJ0a7HC64rF
         UGCoWA/UzgN1kgm80dSBEqCdT6/oqw8O+OIu0Lp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Paul Burton <paul.burton@mips.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 3.18 24/54] mips: fix mips_get_syscall_arg o32 check
Date:   Tue, 11 Dec 2018 16:41:12 +0100
Message-Id: <20181211151547.336853752@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry V. Levin <ldv@altlinux.org>

commit c50cbd85cd7027d32ac5945bb60217936b4f7eaf upstream.

When checking for TIF_32BIT_REGS flag, mips_get_syscall_arg() should
use the task specified as its argument instead of the current task.

This potentially affects all syscall_get_arguments() users
who specify tasks different from the current.

Fixes: c0ff3c53d4f99 ("MIPS: Enable HAVE_ARCH_TRACEHOOK.")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21185/
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/syscall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -57,7 +57,7 @@ static inline unsigned long mips_get_sys
 #ifdef CONFIG_64BIT
 	case 4: case 5: case 6: case 7:
 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return get_user(*arg, (int *)usp + n);
 		else
 #endif


