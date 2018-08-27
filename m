Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B123C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308DC208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPyBmbvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308DC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeH0VFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:05:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0VFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:05:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so2311181pgv.5;
        Mon, 27 Aug 2018 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wyAiK4Z73klJn/XY6stySBJ5Zv9xD+y8C3/SF2thd7A=;
        b=EPyBmbvV4ZbFB/jjBEnYpdgiBs//JDsPs4dwJhBdPzwhTssp4mWQ5++F72mzgspUsd
         LcMHqix9K6EJaeKIi7EmJGdaUR5iUf0+KkYORhH53Ris+prZ9iJMK/pBWeCF7GoMcfrR
         FSguvjNt+t9fdfbht81hsncqCsNJkCLix7c0iehOL6ag07PHPVDaQLj5vcgIUV8j0eGX
         RexeD2pn8CK6TPIj/R6As+rSGF+eEp9HSWc++Mh8i5KrPQ6BBVWAUJCSBVwxTdpYpIc5
         wI/ATvqJUFezuMUqdOXImBxe+7On+Pt0U/vbEBz/MQORNruf15/qUvL6125eIhZQ1LaH
         ghdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wyAiK4Z73klJn/XY6stySBJ5Zv9xD+y8C3/SF2thd7A=;
        b=YN9HhC6d6nRhgconc3KBzeEcGvf2mG1TdHvN9RO+491QT7P38sNyK0JrKzYS5Gq5/s
         JEwDEI0+DdEt7w6UKLxrsNNZAi35wGbG4V8OXjph7N77pPQdOQvDuR2ObvXVGwHydWVz
         fGNRd3AkOn9adfVG8H9nZwtICUcWyOr9jYHLlbjjDrzTqABZ6Gx/Rf7W4uuZV4SgoZzv
         UgFlrEAuS2QXUua0LEmEGcTgCC33EN5bSln+Gl7lEIor5swt3ht7GT31iwPWaowTLcby
         ca2gEZCLONZ9XJo7lfJBzlIfDnE0GRKTDM1k8Cw/rUxIm2zMncjfHc0Demxfr7SJkIAB
         A57g==
X-Gm-Message-State: APzg51Anqm92awIJlDnTnQ65aSq1b/5oc3mchQXFyf7d4sV9GF8ASb3/
        qIF3O9BrV7X84H8jHiM7m/udCPPS
X-Google-Smtp-Source: ANB0VdZwTA7D4JYIKhnHDR/0Ayg5Xbdcd1ldAgENLAoh7sko7lWJRlNMrOQ7jsGC+UHeBtvmC7UKPA==
X-Received: by 2002:a63:ec43:: with SMTP id r3-v6mr13231359pgj.295.1535390270365;
        Mon, 27 Aug 2018 10:17:50 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2409:4071:2211:efd5:b1dc:ae3c:1ea:9833])
        by smtp.gmail.com with ESMTPSA id n79-v6sm29232471pfh.2.2018.08.27.10.17.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Aug 2018 10:17:49 -0700 (PDT)
Date:   Mon, 27 Aug 2018 22:50:50 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        agruenba@redhat.com, jack@suse.cz, dchinner@redhat.com,
        tytso@mit.edu, rpeterso@redhat.com, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: iomap: Change return type to vm_fault_t
Message-ID: <20180827172050.GA18673@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type has been changed to vm_fault_t type for
iomap_page_mkwrite().

see commit 1c8f422059ae ("mm: change return type to
vm_fault_t") for reference.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/iomap.c            | 2 +-
 include/linux/iomap.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd1635..58477ee 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -443,7 +443,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 	return length;
 }
 
-int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
+vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 19a07de..666b717 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -3,6 +3,7 @@
 #define LINUX_IOMAP_H 1
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
 
 struct fiemap_extent_info;
 struct inode;
@@ -88,7 +89,8 @@ int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
-int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
+vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
+			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		loff_t start, loff_t len, const struct iomap_ops *ops);
 loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
-- 
1.9.1

