Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46720700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216579;
	bh=ObGw4xElizEXEUkPdzBo4x/1vip3i5Y7b8VteIiXv5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yiohTPsqkU9Od7r8WEhsah6EeVrbDUh1mXf6ujy5u8LRBCSnKQ8e+sVHum79mTb/X
	 2TOfxtsj4Up/kZ8IuNIKn9u1To8zkRn/ZNki9P2NgawbnuijUXcQ+1k0aql+kdS5X9
	 722vqI8qWVQN6lJcxXJ6tGSiqpp6kCab92kUjDI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfAKOW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbfAKOTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2EB2177B;
        Fri, 11 Jan 2019 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216345;
        bh=ObGw4xElizEXEUkPdzBo4x/1vip3i5Y7b8VteIiXv5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDSNWLaxIDZndWjfTKhoF7LzQV4h66jhVJ8qycwQo424NkGv7H/DRF3+b9gSekCKy
         qrwVQhEsBGEREdrBJLqDZkUBxOFDgSb/Hv+faSHriNCxA1RG40Z1I3XdQmgCJi1fol
         U1Q/kwbds0vO93gyrf1+x3kqVj2m88NFCbIGvX2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 66/88] mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
Date:   Fri, 11 Jan 2019 15:08:35 +0100
Message-Id: <20190111131057.064559895@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 808153e1187fa77ac7d7dad261ff476888dcf398 upstream.

devm_memremap_pages() is a facility that can create struct page entries
for any arbitrary range and give drivers the ability to subvert core
aspects of page management.

Specifically the facility is tightly integrated with the kernel's memory
hotplug functionality.  It injects an altmap argument deep into the
architecture specific vmemmap implementation to allow allocating from
specific reserved pages, and it has Linux specific assumptions about page
structure reference counting relative to get_user_pages() and
get_user_pages_fast().  It was an oversight and a mistake that this was
not marked EXPORT_SYMBOL_GPL from the outset.

Again, devm_memremap_pagex() exposes and relies upon core kernel internal
assumptions and will continue to evolve along with 'struct page', memory
hotplug, and support for new memory types / topologies.  Only an in-kernel
GPL-only driver is expected to keep up with this ongoing evolution.  This
interface, and functionality derived from this interface, is not suitable
for kernel-external drivers.

Link: http://lkml.kernel.org/r/154275557457.76910.16923571232582744134.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -202,5 +202,5 @@ void *devm_memremap_pages(struct device
 	devres_add(dev, page_map);
 	return __va(res->start);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 #endif /* CONFIG_ZONE_DEVICE */


