Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB1920836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR1zb3ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbfBMODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:03:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38737 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBMODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:03:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1185165pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=mR1zb3ZEg02mBIPkYaAVMZE66k5L2R/4wFfthpIKD2x3RXESd7eiszAW4r1knRLpTn
         wnxSzM8wZc5Mkz3Z49kMS93pCVbrKDkebiXliRr0MLguCoBBzx3UIY6gRbVSevX8sUlA
         t0TnCvA4KzIxDQ1NhguOdXUGK6CEp2PM35M5kw6L8CUGCQorsyg8koIIUymChKedDxwo
         wDUw7vvME3QeIWVpILxu3BZjyCiOfgTp+xlM8wcQWb2ioU0gaK0lIdJ+zNZxg+bA9B1c
         6HYiTaKbvgyyQHIL08zPUp5Nm4UWICDz8npUj7KAUtwMGujiFlESyiR4EEVtAG0NSBzJ
         vYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=FhgOO1I4l3pFpFmnC538+7lt4x7BJCQTjlmI8hX/uKmx47FGIVY8dY1DORbI33NwSB
         zHksAHTvi/nx6QdRGiVTlV672+wxmg6XdIKbc8ZtEMyELmCeqYLsqVDkJkkUKibNDmlO
         ZTsBYrSU8TWtolZ6aq9/KUJgHdvMcZ6y9NBzQdGfn+W4HX13PpzaZvk8tMigEJ1UCzGi
         4aF84jedJyKcvpZXOKyGSdt59vYLvVC1k/8qi9NFfW3Q50RFGCoy43ic/wkIXYVj+gcn
         e0WIJ7tUVA3LzAWe1m/VeL2q9DrThvXGVhX6342b0MTBtodbDJwLFRn1TXlS87CY1rA5
         Rndg==
X-Gm-Message-State: AHQUAube2wiarC5BvRjAqED4SNPvVOF9fC1yjJm0HNet1ULch6ut/6ZG
        OZDVLnX0ZyfOhQN8GQEbiM4=
X-Google-Smtp-Source: AHgI3Ian//MU/KECqqeVW28HKO0eOqidmv+3nYdGVBdjjqesuGGlM5g1X58lilAYfu4GeuswRHCPdA==
X-Received: by 2002:a63:d444:: with SMTP id i4mr600550pgj.237.1550066630319;
        Wed, 13 Feb 2019 06:03:50 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id e2sm36513942pga.92.2019.02.13.06.03.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 06:03:49 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:38:07 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 9/9] xen/privcmd-buf.c: Convert to use vm_map_pages_zero()
Message-ID: <20190213140807.GA22098@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _zero suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..d02dc43 100644
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
+		ret = vm_map_pages_zero(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

