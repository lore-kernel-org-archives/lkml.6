Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FAAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25C3252B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVEoxr6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25C3252B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeGBPl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:41:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37312 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeGBPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:41:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so8134813plc.4;
        Mon, 02 Jul 2018 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wyAiK4Z73klJn/XY6stySBJ5Zv9xD+y8C3/SF2thd7A=;
        b=gVEoxr6dIHWnPFZkBbXJT12Kxjg/uE3p9ebSSP5iAkcID2OI/GViEKLrQamyGsm697
         rhIVgMfIzYn9YTI2pMbUCkCQGQPBzBGpFqLxUEjccJV9g9F6u7yP3nJJBkx8ZS0l27OW
         vbfTh3yDh89+L9UeFpj0sAIS9rphwdc30UyTPmApmPdEmEx5vnEdJIL85TtrdPQP0zsP
         eNvR+8cL+++q+PsD+xpwrJ6YKjWDgyFjgx9A3oI/v/INxbbO8P46+UCgxUddUdyTP8mm
         wv+WldYsFFKl0v2TAEdXFX5CTnStzqgDhz5l/uITJne0tZLfHOLs9H76kRBMvvb5A02a
         3q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wyAiK4Z73klJn/XY6stySBJ5Zv9xD+y8C3/SF2thd7A=;
        b=Am1KVYeBnp4to3ojtWwyW6hv9wSd1HhHHFGuHwV87y6OAzHs0vqPNPGbwxSwszHvp8
         xpRVhfRXsrZp9XLTI6l9Fh8Qt3Sroy/qafdqoh4muS/ioA/PGpSvE1sx7g3EjqDyOjsy
         NxG+jlVU2FI4Cy+avXn0VAxJD0bU0MidO6cGZML0qrMRWw4hfVu5Sqlem1bUaCwLru2a
         ifOs+PDITdXnayXhxKc4HoXXo4GqgMYUO8wXHg2wcmyql2XfJArWcZFHotHbdWzZBABq
         5hMZUuXKrtvrnuyy3/s0fgiPaN+yTj57fKaqIFKOi4NnBogp/F9HpzSdvP0UKxyErk8K
         NZww==
X-Gm-Message-State: APt69E1ApLBOG/fu8GLQrKdCvLI/zlZEZ1BS7OswJyDmW2yvSOU+Skye
        OEIfeZFclgTvxWppA9Y477M=
X-Google-Smtp-Source: ADUXVKJiuc2tbs9m3AmauVa6nn3wbh8h0DjrmMpX4b8gswDb961tPSbQZmVh8Bv4S9mB493iTP8F3w==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr26291353pls.18.1530546085692;
        Mon, 02 Jul 2018 08:41:25 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id z123-v6sm24747606pfz.16.2018.07.02.08.41.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:41:24 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:13:54 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        agruenba@redhat.com, jack@suse.cz, dchinner@redhat.com,
        tytso@mit.edu, rpeterso@redhat.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] fs: iomap: Change return type to vm_fault_t
Message-ID: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
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

