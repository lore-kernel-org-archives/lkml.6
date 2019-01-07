Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB858C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3821873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865090;
	bh=0rEJxKMMFwaxOCd67KbF+13LChc5QNQXLas3rHzHkIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w9Dnd0fByznSq7rRqa5c7cVh5z/fnuTqg4zcRKiZBD+Rs8261AjfoSjqsSNgVUqvZ
	 feikA87W8q1m+NiLG3vLyg5++4LJKB7l0jAKAh6dT2SgHFHxAk4YRiJS5qdI8qwf8q
	 HFrdCImEhmPSzKI8ixApQDxcFtzzunfxqlnfk8nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfAGMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfAGMoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B9C2183E;
        Mon,  7 Jan 2019 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865085;
        bh=0rEJxKMMFwaxOCd67KbF+13LChc5QNQXLas3rHzHkIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wwlug+MhPz7495enH8Q7YKxnLnGjHnh2GvM2QsUkNNtCaQPvRQYryP33K8VXT//gs
         nNjHWuv4GWbrtg0u/HfzbGZk4KRh4OetZ1/AUvByCUVVaLrPJvceVqdXeAOptgJ4Bl
         rwF6ZMy5pHGyQXL66XHJt427XzcAGYJzVwDqDta8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.20 143/145] parisc: Remap hugepage-aligned pages in set_kernel_text_rw()
Date:   Mon,  7 Jan 2019 13:33:00 +0100
Message-Id: <20190107104455.846950033@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit dfbaecb2b707cfdc5276b548d52b437384bd6483 upstream.

The alternative coding patch for parisc in kernel 4.20 broke booting
machines with PA8500-PA8700 CPUs. The problem is, that for such machines
the parisc kernel automatically utilizes huge pages to access kernel
text code, but the set_kernel_text_rw() function, which is used shortly
before applying any alternative patches, didn't used the correctly
hugepage-aligned addresses to remap the kernel text read-writeable.

Fixes: 3847dab77421 ("parisc: Add alternative coding infrastructure")
Cc: <stable@vger.kernel.org>	[4.20]
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/mm/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -512,8 +512,8 @@ static void __init map_pages(unsigned lo
 
 void __init set_kernel_text_rw(int enable_read_write)
 {
-	unsigned long start = (unsigned long)__init_begin;
-	unsigned long end   = (unsigned long)_etext;
+	unsigned long start = (unsigned long) _text;
+	unsigned long end   = (unsigned long) &data_start;
 
 	map_pages(start, __pa(start), end-start,
 		PAGE_KERNEL_RWX, enable_read_write ? 1:0);


