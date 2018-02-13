Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965435AbeBMSIY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:08:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35472 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:08:22 -0500
X-Google-Smtp-Source: AH8x227L8ocSem8Yiwo6j+fpeZWBlP8M0u9UZJHJChAoX18cBSxYvcKqRQb+JCHVAmD+ORRIM9tDFg==
From: Mathieu Malaterre <malat@debian.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mathieu Malaterre <malat@debian.org>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: offb: Deallocate the color map
Date: Tue, 13 Feb 2018 19:07:45 +0100
Message-Id: <20180213180747.12666-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function offb_destroy did not deallocate the color map leaving some
memory around after destruction. Call the color map deallocate function to
remove the memory leak.

Handle another case where color map should have been deallocated during an
error code path.

Fix memory leaks reported by kmemleak:

# dmesg
...
[ 1884.719941] kmemleak: 3 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
# cat /sys/kernel/debug/kmemleak
unreferenced object 0xde3d9000 (size 512):
  comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 aa aa aa aa aa aa aa aa  ................
    55 55 55 55 55 55 55 55 ff ff ff ff ff ff ff ff  UUUUUUUU........
  backtrace:
    [<f1433400>] fb_alloc_cmap_gfp+0x54/0x15c
    [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
    [<b5a1c019>] offb_init+0xd0/0x164
    [<322f82a3>] do_one_initcall+0x4c/0x178
    [<b592db9f>] kernel_init_freeable+0x138/0x1cc
    [<2a17fa0e>] kernel_init+0x24/0x118
    [<4079749a>] ret_from_kernel_thread+0x5c/0x64
unreferenced object 0xde3d9200 (size 512):
  comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
  hex dump (first 32 bytes):
    00 00 00 00 aa aa aa aa 00 00 00 00 55 55 aa aa  ............UU..
    55 55 55 55 ff ff ff ff 55 55 55 55 ff ff ff ff  UUUU....UUUU....
  backtrace:
    [<4bf3594d>] fb_alloc_cmap_gfp+0x6c/0x15c
    [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
    [<b5a1c019>] offb_init+0xd0/0x164
    [<322f82a3>] do_one_initcall+0x4c/0x178
    [<b592db9f>] kernel_init_freeable+0x138/0x1cc
    [<2a17fa0e>] kernel_init+0x24/0x118
    [<4079749a>] ret_from_kernel_thread+0x5c/0x64
unreferenced object 0xde3d9600 (size 512):
  comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
  hex dump (first 32 bytes):
    00 00 aa aa 00 00 aa aa 00 00 aa aa 00 00 aa aa  ................
    55 55 ff ff 55 55 ff ff 55 55 ff ff 55 55 ff ff  UU..UU..UU..UU..
  backtrace:
    [<23a3ea03>] fb_alloc_cmap_gfp+0x84/0x15c
    [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
    [<b5a1c019>] offb_init+0xd0/0x164
    [<322f82a3>] do_one_initcall+0x4c/0x178
    [<b592db9f>] kernel_init_freeable+0x138/0x1cc
    [<2a17fa0e>] kernel_init+0x24/0x118
    [<4079749a>] ret_from_kernel_thread+0x5c/0x64

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/video/fbdev/offb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 6f65d132eba1..30786445de04 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -282,6 +282,7 @@ static void offb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
+	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
 }
 
@@ -520,6 +521,7 @@ static void __init offb_init_fb(const char *name,
 	return;
 
 out_err:
+	fb_dealloc_cmap(&info->cmap);
 	iounmap(info->screen_base);
 out_aper:
 	iounmap(par->cmap_adr);
-- 
2.11.0
