Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C004C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBFE2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218698;
	bh=0/BU9iWaJGDoSgvqhp0/Zzd9dkmQ+jUEV9vteDSYO+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZGYyQAJwVT+Iekv8gAUH7X/fJ3JMUm3PoHEce+KxWcglGI8sbls4guxynssXvVdv
	 E2PWysnJgmdT+ZrCTg2K+AJvu5PJSQigXFeuhIjiMGMEezlTWi+FpdPU0gbwyuxTXz
	 VVc8dgluIfb97NvdVUAdzIoMPUifXWoWXlyGLY+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfAKO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389966AbfAKOep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9472133F;
        Fri, 11 Jan 2019 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217285;
        bh=0/BU9iWaJGDoSgvqhp0/Zzd9dkmQ+jUEV9vteDSYO+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaR6qz3OhtH21+PMeSU5598s29KKtrOrkBJ5ixyg2ilQNAV0OrqycvCX/os7Jt586
         soFYjt8tPzGgjwu0lsHjQ/qjDc2W6i6AErwIYFU/NfxCrLtkHWG/VsvNjGjHBJCvUH
         N00pLmSBgSqQHs7f1yfrkbQWWjQYOn9Z7lCGJIoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 104/105] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
Date:   Fri, 11 Jan 2019 15:15:15 +0100
Message-Id: <20190111131111.394160949@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 10fdf838e5f540beca466e9d1325999c072e5d3f upstream.

On several arches, virt_to_phys() is in io.h

Build fails without it:

  CC      lib/test_debug_virtual.o
lib/test_debug_virtual.c: In function 'test_debug_virtual_init':
lib/test_debug_virtual.c:26:7: error: implicit declaration of function 'virt_to_phys' [-Werror=implicit-function-declaration]
  pa = virt_to_phys(va);
       ^

Fixes: e4dace361552 ("lib: add test module for CONFIG_DEBUG_VIRTUAL")
CC: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_debug_virtual.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/test_debug_virtual.c
+++ b/lib/test_debug_virtual.c
@@ -5,6 +5,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
+#include <linux/io.h>
 
 #include <asm/page.h>
 #ifdef CONFIG_MIPS


