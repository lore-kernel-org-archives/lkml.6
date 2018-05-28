Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034225AbeE1PWT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033218AbeE1KVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:21:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 158/268] sh: fix debug trap failure to process signals before return to user
Date: Mon, 28 May 2018 12:02:12 +0200
Message-Id: <20180528100220.362000978@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rich Felker <dalias@libc.org>

[ Upstream commit 96a598996f6ac518ac79839ecbb17c91af91f4f7 ]

When responding to a debug trap (breakpoint) in userspace, the
kernel's trap handler raised SIGTRAP but returned from the trap via a
code path that ignored pending signals, resulting in an infinite loop
re-executing the trapping instruction.

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/entry-common.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -255,7 +255,7 @@ debug_trap:
 	mov.l	@r8, r8
 	jsr	@r8
 	 nop
-	bra	__restore_all
+	bra	ret_from_exception
 	 nop
 	CFI_ENDPROC
 
