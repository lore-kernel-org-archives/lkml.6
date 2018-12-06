Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF6C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B574C20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108489;
	bh=VpvsAR3vSec7lpA9pAnS+c3PVnna/Cd/Zo7xp2rdJbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dH/0mIGljFF7Viw36bfmOo+UDeX2fgZZOcFwdSNQ9zY6BwOPcuRWGpWAQZSJQXit
	 ahihseREjLXuu5TUsH6GjiHbzog+tvK2PPBf3R16XUVtNJdydGaRBr34MG4zHzax66
	 IcRmlnmnJ6A/6gunLQNX7mPFzVAGY3KatKMaj0eY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B574C20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeLFOj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbeLFOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:39:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EF821479;
        Thu,  6 Dec 2018 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107194;
        bh=VpvsAR3vSec7lpA9pAnS+c3PVnna/Cd/Zo7xp2rdJbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkaJg9e7RaO7vZcDyerUz0Z3Khv0GqBgT/WthHBrrbDuNYi4OMLl4Jyr0UMlSEEGw
         nqZv7ItLIsAW2c7mNqviJAELVJIJvBzF7udd22NcHrj7++jQ0O9WF5Wbe9LCl+ToIV
         GIkr0WKntcVlXQUHxFIOhSGqXiGRdHO8TNP8MNRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Paul Burton <paul.burton@mips.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.19 11/41] mips: fix mips_get_syscall_arg o32 check
Date:   Thu,  6 Dec 2018 15:38:51 +0100
Message-Id: <20181206142950.608854349@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -73,7 +73,7 @@ static inline unsigned long mips_get_sys
 #ifdef CONFIG_64BIT
 	case 4: case 5: case 6: case 7:
 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return get_user(*arg, (int *)usp + n);
 		else
 #endif


