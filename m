Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3021848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217852;
	bh=m+BDDSNKDi3petwEPL/zp8eE5VM6jeQdz77FJ9KUJAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RcLFek7/D2wN5QdTKYnIXb6tJxBUqVtbYRgkFa1Re3yJoqxb+H7AYpWxbzQh1IhFm
	 8Wi+DVwNZpsfomZ42mZhtFe/JBcuviL7GEP3zlKGY4mNfNhTmRW3AN8hnOUtAEhd2j
	 ActqwD1/sc20LT5kodZnF5zD71z4MH1ZZOIPODlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbfAKOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404550AbfAKOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5EA206B6;
        Fri, 11 Jan 2019 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217847;
        bh=m+BDDSNKDi3petwEPL/zp8eE5VM6jeQdz77FJ9KUJAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okFVmic05eOMqYkbmmKSUVyP0aOYhzv3Rp43zc8LcJ1avnuROSKAk6lqV6mduqXbO
         8sa6Jp7+K0dHTWqrwNeJR7Zu+H2J4jkWf8iy/LZYWrQARmZrRVu+VSeDQyoP89vxuF
         1NZBbnHlRXMxar+tT8XjRMIEhNF6UQepuRffy8vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 62/65] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
Date:   Fri, 11 Jan 2019 15:15:48 +0100
Message-Id: <20190111131104.292995789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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


