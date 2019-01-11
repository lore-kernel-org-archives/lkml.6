Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDEC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EDC206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218110;
	bh=JnVBMGuoZ5tGgIxebghu8GlBUaqfEdqegMoAF8kfXFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDGxaDmMXCbh+lqlcTQ3wE+ekaTtQ0HXHq/aQT7/l4YQWRNsVGyDFjR67yR8O2nCH
	 RgiurmxbZ3EKIRIOxHlsG7jItO1uMy4RxCotcidYSiF4QHnRMfwwKmKpchusLZuSOG
	 0dTtenFywKJ4u49xOZpUaL27MTVOgnvw6NJH3KVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbfAKOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390837AbfAKOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EDF2133F;
        Fri, 11 Jan 2019 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217696;
        bh=JnVBMGuoZ5tGgIxebghu8GlBUaqfEdqegMoAF8kfXFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxf6W2+7qX/ciVpn7ywA56Y5REmFpr858idfdJzThqNwVusWBMLcJPQe3D0JsSNd1
         D5fS7KN2r5ddF7h/CcFJMcBAlbtAWxkVnLgjOiLV8fPsSfW6d9fXLRPSxGQQmGnUQk
         lRcVzdI58WVjdIkYHs+2XuyORIvjvf5/aA6Hkr40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 144/148] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
Date:   Fri, 11 Jan 2019 15:15:22 +0100
Message-Id: <20190111131120.071552661@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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


