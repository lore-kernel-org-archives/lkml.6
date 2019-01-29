Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF46C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF942175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg3atIf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfA2PEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:04:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43605 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfA2PEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:04:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so17755785lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXMFISiPlkQDpdZA8bK8+pzyO4DsYsihlwnDgdehNwA=;
        b=mg3atIf1mWA0C/JzN6XGSYlRPozX/Wiqzdyvy4VlQltmE0m6K0t7eYeDOgt/Ztk3+n
         zIK0bznrdTinPuuxXez3CTwvyAKAduIporVxRjFOPWDbQ8Jx0/QIvbqJGAuJ3B1WAywn
         YTuZLEK0mUM76gxz/NoIja3YRweM4m3fm0XkUgr14mpUCY4iTJ5CI2ereGBS/qoYdkVC
         aelVRsghlpfc2+//1jQREz3aEbCpLKm2lDRBWucf3z9Drop4bGLybfrHPHdJuXJqce3c
         9bN2XcajTZLcP6zgfjEZP0IGZrvugDQQZZN7Jgon1QEybg31+DOoghFRnDEhBscmt9ET
         ++gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXMFISiPlkQDpdZA8bK8+pzyO4DsYsihlwnDgdehNwA=;
        b=IPVno7UogLkhQmUQHafMnDcvxfVhWnW63WczxxgEYK0h7snRJGAUihgCFQ3cND/OLq
         wsc01Ke/H2qqIxGsHKltU7pODUinF/jvI0u/GKsZ5qTU4h0F3WLigUf7UU61mIb9DX83
         1StFvHmHL1JqmIHFxLVsIJ7oN42fiiJx08mGEwpZVWzWeEpw9flan6xVrtd2VG1dvS80
         urT79MkNsWxD5GX66P4LmL6ZCIGUsGGe/3G5C27zkIwFv9URe0UYr1CVaFkLE5V2ctr1
         YLw6Jfj54i+d3qq3Mv6tgmng7MLedXoBHkVIzC5X4WTEez+dK1qLE0ptnlJ1gp4APGgV
         6yNA==
X-Gm-Message-State: AJcUukdav4UD5FM5HzqtCk+emwjbtzpZsWPv/1M36Tk7MRa2+HE9O4Vk
        TxyCopgQHkk+tgJJQdlbXKg=
X-Google-Smtp-Source: ALg8bN6GRRWmTBU/Selfj+MJOLMb0wxXtyiGI+Nk4o7ydFetDWUoFcC18j1fyeY/W5SykWAWtxnTcg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr18841740ljj.49.1548774269897;
        Tue, 29 Jan 2019 07:04:29 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id r29-v6sm3535027ljd.44.2019.01.29.07.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 07:04:29 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, kraxel@redhat.com,
        noralf@tronnes.org, hch@infradead.org, julien.grall@arm.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for display buffers
Date:   Tue, 29 Jan 2019 17:04:22 +0200
Message-Id: <20190129150422.19867-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

When GEM backing storage is allocated those are normal pages,
so there is no point using pgprot_writecombine while mmaping.
This fixes mismatch of buffer pages' memory attributes between
the frontend and backend which may cause screen artifacts.

Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Suggested-by: Julien Grall <julien.grall@arm.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index d303a2e17f5e..9d5c03d7668d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -235,8 +235,7 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_flags |= VM_MIXEDMAP;
 	vma->vm_pgoff = 0;
-	vma->vm_page_prot =
-			pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	/*
 	 * vm_operations_struct.fault handler will be called if CPU access
@@ -283,7 +282,7 @@ void *xen_drm_front_gem_prime_vmap(struct drm_gem_object *gem_obj)
 		return NULL;
 
 	return vmap(xen_obj->pages, xen_obj->num_pages,
-		    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+		    VM_MAP, PAGE_KERNEL);
 }
 
 void xen_drm_front_gem_prime_vunmap(struct drm_gem_object *gem_obj,
-- 
2.20.1

