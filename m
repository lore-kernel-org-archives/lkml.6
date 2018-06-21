Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB61C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6A820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMyhIros"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6A820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeFUElD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:41:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45693 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeFUElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:41:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22-v6so863666pfo.12;
        Wed, 20 Jun 2018 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:lines;
        bh=vVNt+6pS5w5n9GwgcCx79Wlx39OgH+NrkmlTct5ZOgs=;
        b=RMyhIrosgP9Cwp5L3Ei9MPKpl79RbWhRYAZcZUVYb8Ac/l+HgwvJFmTHqtV1OJorct
         copN+rZNBJyBixQJDl1skVZyJA95PLG36W8yKRfwB/GV0QykSll8iFwrHmjVageMxn8h
         Q+SsTAkCt4yoE+9O7YNdMcWaaJ2Q5F+bHSxUHZdMOGIQ63Q9SYfuzZ/Y5RTJt8euaTcH
         obNatJVDg3E6JgmAet9GNMDZBBUYKbDmdc1dkkKfIq+fguVvHFYdtlvcf1cA+tZ1CWKp
         7aoOF4l0bXDGOy0kmHNAPbYMXTvw8eT+kDmu0S1hWSYB7vkUYr6u8MJ6Au2zvPL60kJH
         Fz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id:lines;
        bh=vVNt+6pS5w5n9GwgcCx79Wlx39OgH+NrkmlTct5ZOgs=;
        b=atF8psHSg+TicHrt2EvpK3/WJx989TYD07/izu6TEYCaMhCtLpcey06iWp5fMWXpWN
         b1KyeBEOEU/3uPedGVI8eZhPHPI+/GTBVzkZuVmN0qtKKvXMMPJrtvpxYgflvMRmjA/v
         wtEo0moUzyEtgMjWfAWj4WJYwZ34e7WJUXPsd1YoEWIzrfsAjP0N3s41UeSyF7F6nIYe
         otfFzEDVxPKbsoqyWcCwpph1nvOHCZLEWgWuzB/MtvA6RHr5mkgAOL4WCup7ZHhID4Sa
         yBk8q3iiTO0T1oX4PXPhCwBWVu8BmtUWhWKZfgLoYe8qxoW4+SLZcEmnFp8W96J/hs/V
         yrkQ==
X-Gm-Message-State: APt69E2sSgMj72xpKZlzcQVwRZS2gm8+omxzVyWUaAb2VYYrnGG3eu5H
        Rnky0vuVSuS9qc+a3X+nSo0=
X-Google-Smtp-Source: ADUXVKIBSroURAG8FkvpgOabi+US3+TA6L17dT78K12OB3X1C5HC7m3SkX5Njdr195c8b5R0HjyuDg==
X-Received: by 2002:a62:81c5:: with SMTP id t188-v6mr25693398pfd.146.1529556061373;
        Wed, 20 Jun 2018 21:41:01 -0700 (PDT)
Received: from mx.localdomain (114.69.239.49.rev.vmobile.jp. [49.239.69.114])
        by smtp.gmail.com with ESMTPSA id n25-v6sm5726915pff.119.2018.06.20.21.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 21:40:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.localdomain (Postfix) with ESMTP id 5A04083CDDA8;
        Thu, 21 Jun 2018 13:40:57 +0900 (JST)
From:   Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Subject: [PATCH] fs: nilfs2: Adding new return type vm_fault_t
Date:   Thu, 21 Jun 2018 13:38:48 +0900
Message-Id: <1529555928-2411-1-git-send-email-konishi.ryusuke@lab.ntt.co.jp>
X-Mailer: git-send-email 1.8.3.1
X-Dispatcher: imput version 20110525(IM151)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Souptick Joarder <jrdr.linux@gmail.com>

Use new return type vm_fault_t for page_mkwrite
handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
---
 fs/nilfs2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index c5fa3de..7da0fac 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -51,7 +51,7 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	return err;
 }
 
-static int nilfs_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = vmf->page;
-- 
1.8.3.1

