Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD672148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="byEFi1uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD672148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406894AbeKTD35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406868AbeKTD3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BB72148E;
        Mon, 19 Nov 2018 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647137;
        bh=rF4ilzL32LA/3HcU29/GWxhkONskaNQQFNGXWfAZbfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byEFi1uXP/IGnEUEcFR8jHr2xR/ilIopnVUh6w3/mLbqS4WuK6I1xtz32Pmo7RRnD
         Vzi/iKjk/uwe7weQ6K/lb7Q/WNGKB+1g5LKgUilO97NARTVoAYxmbvHP63RXCKBQg9
         guSJAv2NJxwe+W4JUfgr4WoDnTrXmDIgiAi6PJlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3.18 63/90] xtensa: fix boot parameters address translation
Date:   Mon, 19 Nov 2018 17:29:45 +0100
Message-Id: <20181119162630.735459102@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 40dc948f234b73497c3278875eb08a01d5854d3f upstream.

The bootloader may pass physical address of the boot parameters structure
to the MMUv3 kernel in the register a2. Code in the _SetupMMU block in
the arch/xtensa/kernel/head.S is supposed to map that physical address to
the virtual address in the configured virtual memory layout.

This code haven't been updated when additional 256+256 and 512+512
memory layouts were introduced and it may produce wrong addresses when
used with these layouts.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/head.S |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -88,9 +88,12 @@ _SetupMMU:
 	initialize_mmu
 #if defined(CONFIG_MMU) && XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY
 	rsr	a2, excsave1
-	movi	a3, 0x08000000
+	movi	a3, XCHAL_KSEG_PADDR
+	bltu	a2, a3, 1f
+	sub	a2, a2, a3
+	movi	a3, XCHAL_KSEG_SIZE
 	bgeu	a2, a3, 1f
-	movi	a3, 0xd0000000
+	movi	a3, XCHAL_KSEG_CACHED_VADDR
 	add	a2, a2, a3
 	wsr	a2, excsave1
 1:


