Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeE3WH5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:07:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeE3WH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:07:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: v4l: omap: add VIDEO_V4L2 dependency
Date: Thu, 31 May 2018 00:07:11 +0200
Message-Id: <20180530220735.1651221-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180530220735.1651221-1-arnd@arndb.de>
References: <20180530220735.1651221-1-arnd@arndb.de>
X-Provags-ID: V03:K1:A/P65lCfhg5b7st4LKQlZQ1GFxihGQepgmm4UTJSe37PMtGuzps
 dgRQ9+tOSgKUwmI85h2uABRyVD4b8rN04AHuM5t4i5cmvkZDj2rS/c5w0e+OsQRCx3mlZwP
 SZswI3wh/CgSxxDzMnWYqvJdC8eBfRRAoSLFRieabKN8NjSsB7RdujbkodN+VfH+5c/2+q4
 gbVRCA9cD73ygxwpjNy2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6k8HBU8lOcU=:U2HOSxcMEgIQKO1I+9inTh
 P+AXNuYQXhmU2xCc5AczeaUGRall4gjSHl38DlB3NmoPTlqNNH+VDdEs8/M1nM3ekOcgWWiAm
 POEYHFB8zhj+4eqMpI93g2oDEcSiG2xygZhAu6xiyLX4x3QfJOoqLrwjfVf8Sw/Kmf5MGrjCs
 jRnpMsg7OTe/LYJ/bV63sR+bvEF3A3+Ko3KxAs+3BY/3eZNDSPNjiDQ963vjfYAwqqxmTdA/K
 zhQcvd82HVEc76ifHuus0no7B2MzjckghC/pkGMfFuLDUWZsdQ8bnLPwSaqkqpcEPtl+JsuyO
 6+piGQf7mOjleKpJwKhDrqOvNc7cDfHQNQkp5SGqjpYtLPF9P9MQEYvqFHCCz+JjsMtyFdUt7
 yGNX8y1Ezxr1195onWYWkyUerxt27YWh0ITW2QpIMbziKNl0qQ0xjK9Cc1QkQYsQQaCSIFZFm
 6qyjUf7imwBdknwWir4qa9NqAxk0+WpWyyl2L1UXoK1XQMlkPO99iMbYRlbB1bJjSBa9auz5/
 uHYoo27CA1ovLYsvtVF+vDYBq4lTth4svgVP21b/VNFwoU0VlEIHkq3GREZxXnteCqjY3b02h
 VkRr+yAu80XurD+kbKh5kTB68BohNhwQxG7wU8P1udn8TCxSrVzEF9ZZzymPTynB5HkysZxBr
 7eiNII+8XD5UL2phkaqjTAoMw9mV2lPXrh1varRHeoWmTZfWFReWEkLwXjSyJ4XHVMwA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The omap media driver can be built-in while the v4l2 core is a loadable
module. This is a mistake and leads to link errors:

drivers/media/platform/omap/omap_vout.o: In function `omap_vout_remove':
omap_vout.c:(.text+0xec): undefined reference to `v4l2_device_unregister'
omap_vout.c:(.text+0x140): undefined reference to `video_device_release'
omap_vout.c:(.text+0x150): undefined reference to `video_unregister_device'
omap_vout.c:(.text+0x15c): undefined reference to `v4l2_ctrl_handler_free'

An explicit Kconfig dependency on VIDEO_V4L2 avoids the problem.
I ran into this problem for the first time today during my randconfig
builds, but could not find what caused it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/omap/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/omap/Kconfig
index d827b6c285a6..4b5e55d41ad4 100644
--- a/drivers/media/platform/omap/Kconfig
+++ b/drivers/media/platform/omap/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_OMAP2_VOUT
 	depends on MMU
 	depends on FB_OMAP2 || (COMPILE_TEST && FB_OMAP2=n)
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || COMPILE_TEST
+	depends on VIDEO_V4L2
 	select VIDEOBUF_GEN
 	select VIDEOBUF_DMA_CONTIG
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-- 
2.9.0
