Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965272AbeE1KPc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966501AbeE1KP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 033/268] kconfig: Fix expr_free() E_NOT leak
Date: Mon, 28 May 2018 12:00:07 +0200
Message-Id: <20180528100205.827852300@linuxfoundation.org>
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

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit 5b1374b3b3c2fc4f63a398adfa446fb8eff791a4 ]

Only the E_NOT operand and not the E_NOT node itself was freed, due to
accidentally returning too early in expr_free(). Outline of leak:

	switch (e->type) {
	...
	case E_NOT:
		expr_free(e->left.expr);
		return;
	...
	}
	*Never reached, 'e' leaked*
	free(e);

Fix by changing the 'return' to a 'break'.

Summary from Valgrind on 'menuconfig' (ARCH=x86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 1,608 bytes in 67 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kconfig/expr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -113,7 +113,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_GEQ:
 	case E_GTH:
