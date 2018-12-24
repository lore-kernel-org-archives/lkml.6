Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB5AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2272021850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDuxmq/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeLXNYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:24:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbeLXNYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:24:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so5587967pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5oYSW/GvpO5Jr2lAVUEKxgPmdiaC90t9yQ4KohCOQbY=;
        b=GDuxmq/Aic15WMXOQMH4HrSFG0stmPhzQGi79maKq+afi8zw5IjbX4WO7EBtU4Y4Aa
         es7qIcOpTYJ4MljVBfAKdeTApaICyrUwH9OHwTSRD29kMCYJUvUrqfFRTtWBCFSDVNaB
         D+08WqR+rmVKV+OBhkdgasAMMBrRM3dftytU94MpNoljNyFWIQC5SLE3qv2rEmBJP1iY
         PlWL494kqT4wHJc9k0khQ6jPK4JiFTqKXalJHhj9TcvGX63+U/1VnAEr5HTgPK+1/Old
         8ZWRZQjCT44ajiLNhJX8FmB02uUMM09edQpVw7rX6LARSq6srEeuDlG8Z8hUmpKJre3P
         rPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5oYSW/GvpO5Jr2lAVUEKxgPmdiaC90t9yQ4KohCOQbY=;
        b=X4OCCOWQjRygZKF3st/eRU9KnaKNsG50p+H5e5bYMnZ5uDIgcL4oLt5CbMviB4AIVo
         x5U47hXncct6WafHTgZcRP+oX/CXnTRdrNDz0F2ZG+RQBC2gesjo0gM1b8aEq00byB6E
         7qY/raao7on2KjEA9zEbRbEm6vzEJ848DbOL7BA+wjomgqzk/94yJlcaHMG4p1SmbGos
         xP3TAgWW8kolAD1mGM5r+JKQSJ36BudboHrRuPySzW7n9atLW57IxNzdSgg9ofOQDQZo
         HB+g3NqF0FkvWKhrCA7jKAaum5aJc87zaTTNSSIP0lkO9mP/xOyg9nSDv97B6/wJCSDL
         0EAQ==
X-Gm-Message-State: AA+aEWZY8/q8gaUplyOD8IrkqvknKYQLW2TUtSBrTmT8knVF3IQkucIT
        7f2nbTZsIMscydXR2DKrAUk=
X-Google-Smtp-Source: ALg8bN7MqKdlBoEyyvA+3qDEze8cTZiGRFINTLDBE/Qm6sZIoDhaLCAuk2cAeM0YMez3riWsyZJJLA==
X-Received: by 2002:a62:9111:: with SMTP id l17mr13092429pfe.200.1545657878185;
        Mon, 24 Dec 2018 05:24:38 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id v9sm44373114pfe.49.2018.12.24.05.24.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:24:37 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:58:34 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v5 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range
Message-ID: <20181224132834.GA22203@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index df1ed37..d31b837 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -180,12 +180,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range(vma, vma->vm_start, vma_priv->pages,
+					vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

