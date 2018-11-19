Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA27320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTEVEfyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA27320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbeKTDOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:14:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7018A208E4;
        Mon, 19 Nov 2018 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646203;
        bh=9hPjECk9raRnr5c8kWwnUN10ZqXtZAqEbXHXqDamP5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTEVEfyi55K3qWNSBR0owzx5YoBYYTXj68t+n3/aU6Lz8ZLkQjww6km3Ty2i0myme
         /Zt4x0qYOAw345orfUulHRizPhkdWQBgChSCoL17n6WAF9Ilws5PHJzeBxZvcheOvP
         I6u2xSr5ubiDhCowb4YegKySTFjTEDlSeqxjMeJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 038/124] xtensa: make sure bFLT stack is 16 byte aligned
Date:   Mon, 19 Nov 2018 17:28:12 +0100
Message-Id: <20181119162621.032014192@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 0773495b1f5f1c5e23551843f87b5ff37e7af8f7 upstream.

Xtensa ABI requires stack alignment to be at least 16. In noMMU
configuration ARCH_SLAB_MINALIGN is used to align stack. Make it at
least 16.

This fixes the following runtime error in noMMU configuration, caused by
interaction between insufficiently aligned stack and alloca function,
that results in corruption of on-stack variable in the libc function
glob:

 Caught unhandled exception in 'sh' (pid = 47, pc = 0x02d05d65)
  - should not happen
  EXCCAUSE is 15

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/processor.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -24,7 +24,11 @@
 # error Linux requires the Xtensa Windowed Registers Option.
 #endif
 
-#define ARCH_SLAB_MINALIGN	XCHAL_DATA_WIDTH
+/* Xtensa ABI requires stack alignment to be at least 16 */
+
+#define STACK_ALIGN (XCHAL_DATA_WIDTH > 16 ? XCHAL_DATA_WIDTH : 16)
+
+#define ARCH_SLAB_MINALIGN STACK_ALIGN
 
 /*
  * User space process size: 1 GB.


