Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3299C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGKvXB+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB62A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbeKLITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbeKLITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:16 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E53208A3;
        Sun, 11 Nov 2018 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975360;
        bh=rzYuNCNn8yCcnXQp8q6vBKrAjRjCJ+qodoNVelBr33o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGKvXB+57sW/lkTmW0Z3k7lpPYQqC44UbPclv4qSm0HZ824YZt2l6dbAXZXhXCoTC
         /qyFCmla3uq+Rmnp7enDdJa9DrOb2pycFMTMyoVDsX5PLca7VKFF4a52sCK+oOD+cq
         u6Uf6Zvs7Fe2lNv9t9rbKhvB2rdpwzIdeg5m6hYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.18 028/350] parisc: Fix map_pages() to not overwrite existing pte entries
Date:   Sun, 11 Nov 2018 14:18:12 -0800
Message-Id: <20181111221708.351865113@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 3c229b3f2dd8133f61bb81d3cb018be92f4bba39 upstream.

Fix a long-existing small nasty bug in the map_pages() implementation which
leads to overwriting already written pte entries with zero, *if* map_pages() is
called a second time with an end address which isn't aligned on a pmd boundry.
This happens for example if we want to remap only the text segment read/write
in order to run alternative patching on the code. Exiting the loop when we
reach the end address fixes this.

Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/mm/init.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -495,12 +495,8 @@ static void __init map_pages(unsigned lo
 						pte = pte_mkhuge(pte);
 				}
 
-				if (address >= end_paddr) {
-					if (force)
-						break;
-					else
-						pte_val(pte) = 0;
-				}
+				if (address >= end_paddr)
+					break;
 
 				set_pte(pg_table, pte);
 


