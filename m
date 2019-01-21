Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B3CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0B920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080380;
	bh=+ayuBEzACxEzrZknOifPltnbjiA2pRZF0kaPmJPnGjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LaGbF7cn06OhJuM17DZWiRoaikrBg6PHCO3tIfAOyuesu1CH/Z3F+uSrt/4vs2GjE
	 W7+by4vIkRmx2MBsF3TdQfr4cpAzeV1QvNI0vziv6sHaC7FzXKI77wCd4HWvpfDF6k
	 sX74D6jH/fKGeO/Nu4QRtWss8M3ToZ0etJzVRCig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfAUOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:19:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfAUNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917BB2063F;
        Mon, 21 Jan 2019 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078516;
        bh=+ayuBEzACxEzrZknOifPltnbjiA2pRZF0kaPmJPnGjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKkV/8hzNVVfTtN+QHaOQg4Nsf9aWPluSFmYzU/Ja576j95Baso9vdr8UQn5k/rJD
         t7xi4h/ch/9DZ3KBoJDRBXwL0x3iNeInqON9TylWvEGRjn5x13Cohvn4eyoWiUEFGz
         6sza9au+ARV+p1QUSuLRRs5UMXvNV0dUYjZ9vXzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.20 060/111] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <= 4.7
Date:   Mon, 21 Jan 2019 14:42:54 +0100
Message-Id: <20190121122502.631722437@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1130,6 +1130,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
+	depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)
 	depends on $(cc-option,-ffunction-sections -fdata-sections)
 	depends on $(ld-option,--gc-sections)
 	help


