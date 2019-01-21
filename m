Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4060C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944892087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079239;
	bh=TN3YDjrqdDm4fw1/QMUkMKZfebz/rOIWBgKgRcUnfh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRMWoSfE7eAzueoupe+xKDdkpTonhNHLtB7en+u6E4uxJ/M4rCmbqE3/Peneb0DNA
	 lY2Wr5cWENID9lysl542qlDLveNwnDHMTbMNKw4gjfMgGt5SyJgO2pFMDR+j6USPAA
	 qJM6lNx3PzlW85fs3dXSXZyzmG8f+KaGyfijElBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfAUOAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfAUOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1F62084C;
        Mon, 21 Jan 2019 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079231;
        bh=TN3YDjrqdDm4fw1/QMUkMKZfebz/rOIWBgKgRcUnfh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rTZ2izqEDmwuDZVQ9OIdVkMQUoErZ7kdjyHNssIK8c5wses2Mp+dydc0LtyRybJw
         i/ILMM1ez6F8b9cDfeSxY1hON2A3+i1JI7k3D3mZ5U9or1AAhEApi735n5OdXwRhN7
         GRMV8pXJHG1DGDp2ZWVNUsCKAYIHwSRcXQWu9qbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.19 54/99] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <= 4.7
Date:   Mon, 21 Jan 2019 14:48:46 +0100
Message-Id: <20190121134916.034105521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: Paul Burton <paul.burton@mips.com>

commit 16fd20aa98080c2fa666dc384036ec08c80af710 upstream.

When building using GCC 4.7 or older, -ffunction-sections & the -pg flag
used by ftrace are incompatible. This causes warnings or build failures
(where -Werror applies) such as the following:

  arch/mips/generic/init.c:
    error: -ffunction-sections disabled; it makes profiling impossible

This used to be taken into account by the ordering of calls to cc-option
from within the top-level Makefile, which was introduced by commit
90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
-pg on gcc-4.7"). Unfortunately this was broken when the
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data elimination
support in Kconfig"), because the flags used by this check no longer
include -pg.

Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
using GCC 4.7 or older.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support in Kconfig")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1102,6 +1102,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
+	depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)
 	depends on $(cc-option,-ffunction-sections -fdata-sections)
 	depends on $(ld-option,--gc-sections)
 	help


