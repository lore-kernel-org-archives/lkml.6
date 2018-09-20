Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84383C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3453121532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxAkxRhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3453121532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbeIUCFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:05:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33765 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:05:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so4878637plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AS6EgmSxwMYdedbSX81HCwH5kOdx41w+NymON0Nql0c=;
        b=dxAkxRhyJ42a5ay81J2yOgAi6vaA5yqc/iZtnV2ocuLHMBAirYHqx5NWMU/++na8P4
         FQV1iy2syFaS8FvJAF2LxIKnv8cL6MrG2br9+YUhQUrKXhoxcOKUpjNmJo6w5ELSWO6b
         KZ23ikDzm7ba0imkt+Uxg6AoxWyhup23RdhxdZ0G87T+4IFeN1kRaU4/VH83WOxADtt6
         lRXSDVLCl2bwImjpelGkIYPNMq2WaNvNDms5sZ2iNEisObAW+wcJMw6oEmemsdsPzMr7
         lsDJmenZawi+6FfHYwV2r3of1nd8WsB1DkxPwEbXlV/OXsiOhuaAn4h9drAYtznM4c7r
         Wdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AS6EgmSxwMYdedbSX81HCwH5kOdx41w+NymON0Nql0c=;
        b=umVaHDhxs0h8wDwuV1nWh2RUVgxZArNXujg3hknbhd0wDJIZAvWMTfkCgrahDALmqs
         QZlzMGLHbrNEO5X6oYs0iPBXt4hmqs+sOo8TMZJcR+rIhxU0+Ex1nGLE8kblXlSXMzRz
         ENGjG2WIEFXILku6WyxKLze91rYm/XpPUWCgZS2TfcutPmQS6i0/KYxJrovv+fP2oNyp
         /wWT/oIuluySnOPrj1/tCep1PZKqrmZUSNNevmzWHh/uLCcQ1C7Kyrnxyqgu8tVp28JH
         bp2sxjePLg91lF2bXvyBZln51WKQAggpUFB7D3u0mKvC1xeBpoR8qnPJK1Gga5ALT7e3
         IvGw==
X-Gm-Message-State: APzg51CCW6U+yAUpANbK2WxnWRH/oPDsgJb/uSpuB0Hmtm2kehi8lrgi
        rGlxGcSOMQovQenbxoSorTc=
X-Google-Smtp-Source: ANB0Vdb5u6WucnbYM2HgHOovVd4l/4ryk4d9aiKgB8ZPhcV52QZ1qo2GqFe4+e0ZVB//F6eBzIuswg==
X-Received: by 2002:a17:902:7447:: with SMTP id e7-v6mr41030342plt.186.1537474809396;
        Thu, 20 Sep 2018 13:20:09 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2405:204:5289:9609:5988:edc0:7df2:fea7])
        by smtp.gmail.com with ESMTPSA id g6-v6sm46075251pfb.11.2018.09.20.13.20.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 13:20:07 -0700 (PDT)
Date:   Fri, 21 Sep 2018 01:53:16 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] auxdisplay/cfag12864bfb.c: Replace vm_insert_page
Message-ID: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to remove vm_insert_page permanently
and replace it with new API vmf_insert_page which will
return vm_fault_t type. As part of it vm_insert_page
is removed from this driver.

remap_pfn_range() will be used to map kernel memory to
user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/auxdisplay/cfag12864bfb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 40c8a55..3b4411d 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -52,8 +52,12 @@
 
 static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	return vm_insert_page(vma, vma->vm_start,
-		virt_to_page(cfag12864b_buffer));
+	struct page *page;
+	unsigned long size = vma->vm_end - vma->vm_start;
+
+	page = virt_to_page(cfag12864b_buffer);
+	return remap_pfn_range(vma, vma->vm_start, page_to_pfn(page),
+				size, vma->vm_page_prot);
 }
 
 static struct fb_ops cfag12864bfb_ops = {
-- 
1.9.1

