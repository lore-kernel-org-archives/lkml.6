Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeEIArI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:47:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42190 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeEIAmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:42:45 -0400
X-Google-Smtp-Source: AB8JxZoCGNoAm3MjQMCf7bkdg8CG2jZziC0BxdS1BbDCtlXHrA+HFi52gwv8E2P1aDc0chEnTVlbPg==
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 07/13] treewide: Use struct_size() for vmalloc()-family
Date: Tue,  8 May 2018 17:42:23 -0700
Message-Id: <20180509004229.36341-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509004229.36341-1-keescook@chromium.org>
References: <20180509004229.36341-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This only finds one hit in the entire tree, but here's the Coccinelle:

// Directly refer to structure's field
@@
identifier alloc =~ "vmalloc|vzalloc";
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(sizeof(*VAR) + COUNT * sizeof(*VAR->ELEMENT))
+ alloc(struct_size(VAR, ELEMENT, COUNT))

// mr = kzalloc(sizeof(*mr) + m * sizeof(mr->map[0]), GFP_KERNEL);
@@
identifier alloc =~ "vmalloc|vzalloc";
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(sizeof(*VAR) + COUNT * sizeof(VAR->ELEMENT[0]))
+ alloc(struct_size(VAR, ELEMENT, COUNT))

// Same pattern, but can't trivially locate the trailing element name,
// or variable name.
@@
identifier alloc =~ "vmalloc|vzalloc";
expression SOMETHING, COUNT, ELEMENT;
@@

- alloc(sizeof(SOMETHING) + COUNT * sizeof(ELEMENT))
+ alloc(CHECKME_struct_size(&SOMETHING, ELEMENT, COUNT))

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/nouveau/nvkm/core/ramht.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ramht.c b/drivers/gpu/drm/nouveau/nvkm/core/ramht.c
index ccba4ae73cc5..8162e3d2359c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/ramht.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/ramht.c
@@ -144,8 +144,7 @@ nvkm_ramht_new(struct nvkm_device *device, u32 size, u32 align,
 	struct nvkm_ramht *ramht;
 	int ret, i;
 
-	if (!(ramht = *pramht = vzalloc(sizeof(*ramht) +
-					(size >> 3) * sizeof(*ramht->data))))
+	if (!(ramht = *pramht = vzalloc(struct_size(ramht, data, (size >> 3)))))
 		return -ENOMEM;
 
 	ramht->device = device;
-- 
2.17.0
