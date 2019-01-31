Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D28CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4BF218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NswK+pXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfAaDKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:10:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38269 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:10:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so809865plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iIOMyeYWlqivChsy2LGI2papAkfM6upHHEb8AWJyE+Q=;
        b=NswK+pXyki9uV20jIt/KHa7HuTuS4V54Zl/q2CrjDYOjRi1VObkIq30U6glKytirnt
         0uFEr/8IylNweVdpe6nAdkmQlUPc799Ng9XtT9HQWQtcaLU0vx0CH9uUKToZ0dcHIRRz
         OFVjx5BG4zF32ejxpzEAhCQwoiiyqWhNOBnox42mca/EHqg56YYWJ57EMdY5Dk7uHoNG
         1HnE1nbkcSa83Nzgv6xfPIkaG/VWmkT2hfc6BC5eKGqTkwfTAf8pJ4CnIVedn5x6zrD5
         31z46YUAOPYiqGZEOMosBhObBe9Bewwh7SZJ7fyrkzS6ImMft7hMC24e0ZOxrrmU+AXX
         zaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iIOMyeYWlqivChsy2LGI2papAkfM6upHHEb8AWJyE+Q=;
        b=glLqO16rqcYePPNj1YWZ9WWW6AWvQUBbWctSIb+m0r+9jYPiSle5KBpTHniflztnUQ
         X1KA2obPxAhAb/TV2uEvZHtroof0wKs04NXlF2Q2f5vAAbh6SwsTJSXxC2b4SCHeke1u
         KYnbbdbpOtVztUyK28JCKhLIp75zmmSlX5eu7BfrJn2SMR5460/ts/8sUJmhXFT7pYXF
         Gs3RAHPl3FC1ynXyVqtD9FFB30YoREWDeondKOLnE+ACUOxl5qmhDHhvaYtC8T/bk9TR
         oyNv026ORX1EMAiyG9BaNlya7prBw73RGvDOVPzdZ69vzDMJXSdE+7JAPcOptjxPjqzK
         nXjQ==
X-Gm-Message-State: AJcUukcCHtI7wUs9EgpP611oKhds2lsLx3JpJWVVB9odSwbNUh/7X0+R
        CJYGCUiSK0ziOHD3X/psX98=
X-Google-Smtp-Source: ALg8bN7JWTDtmY7f0SD7kzOXbcjmQSyCFO1iAegZ9zKD6pwUOUT9KVciGd4lF1sfXawzVQ673btnEA==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr33506912pld.23.1548904239727;
        Wed, 30 Jan 2019 19:10:39 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id a65sm3802656pge.65.2019.01.30.19.10.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:10:38 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:44:52 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCHv2 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range_buggy
Message-ID: <20190131031452.GA2442@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range_buggy() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _buggy suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..a9d7e97 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range_buggy(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

