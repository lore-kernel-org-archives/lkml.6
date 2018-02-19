Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeBSA37 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 19:29:59 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35310 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeBSA35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 19:29:57 -0500
X-Google-Smtp-Source: AH8x2263jlseu/SsZo4wiEA95TUvgKJ1pxoJsXzegzYBEvl3ASSEcXg8ScnbO9c9BwvXO+tRgmvBug==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH] of: Kconfig: OF_OVERLAY, select OF_EARLY_FLATTREE
Date: Sun, 18 Feb 2018 16:29:16 -0800
Message-Id: <1519000156-14319-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kbuild test robot reported a new warning for a recent patch:
>> drivers/of/overlay.c:832:2: error: implicit declaration of function 'of_fdt_unflatten_tree' [-Werror=implicit-function-declaration]
     of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);

The cause is that the prototype for of_fdt_unflatten_tree() in
include/linux/of_fdt.c is guarded by OF_EARLY_FLATTREE.

This was a pre-existing problem for any overlay related caller of
of_fdt_unflatten_device_tree(), who was then going to pass the
unflattened tree to of_overlay_apply().  After the patch that triggered
this warning, all other overlay callers of of_fdt_unflatten_device_tree()
no longer exist, so adding the select to OF_OVERLAY is a sufficient fix.

To reproduce the warning:
  Use the .config attached to https://lkml.org/lkml/2018/2/17/268
  make ARCH=i386 olddefconfig
  make ARCH=i386 CC=gcc-7 drivers/of/overlay.o

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 783e0870bd22..00a6abfaaec7 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -92,6 +92,7 @@ config OF_RESOLVE
 config OF_OVERLAY
 	bool "Device Tree overlays"
 	select OF_DYNAMIC
+	select OF_EARLY_FLATTREE
 	select OF_RESOLVE
 	help
 	  Overlays are a method to dynamically modify part of the kernel's
-- 
Frank Rowand <frank.rowand@sony.com>
