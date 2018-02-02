Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBBP2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:28:13 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51532 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:28:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gcc.gnu.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: nouveau: use larger buffer in nvif_vmm_map
Date: Fri,  2 Feb 2018 16:27:31 +0100
Message-Id: <20180202152745.1036820-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:LHEtsjdmab79gXNtsl2KjbYb9TYo6oIahqP/Ilwf2qV/8ST13Iu
 fgAftU6FRc4qhHjE3oR6XWWlaq51eNZn/b5TP5fciD8GfJhSAz5vnWAhDer/ppIFz1SyEBC
 NgG8StR5T3Qd1DnaaPN/T/JeicTweoyLNr5lPsMKMDXCFCGkUT59T0Ce0K4VgakkNrZwYYh
 i0YWHjx89txVVpky9L4PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TG7ChgZbtE=:KDOVuf/0810z3tFAC/TyhZ
 SSyTiZLCKSkdj7w5hepPRIaPeI93cQNxNVBOSqug4p5Yv6HVixZ/KBzhqukkfuCNs7/WxLpPo
 vn85ZyKvIk7dS7NqvX56Hu0Kz5giauY3Znusr8hNbCsZXi0dgl19tqa2roFNXd4Pk3GjzpMRT
 Tg1y0IokfE+mTZYV9K5JEJuFZrXz0aM+2E9KW0xXaHLgkcSNy46irxh4CWaznSukfl20reNMa
 TiYXamQuV1fW5OZ56ZCKKGd0vjVhsmJzGLgMHMEyrg41uyQgbbOFUsOb2mrN/WnydJyx1ZAMI
 XXkhtSfljDGxW66BHiPUSTY+rvP1PTL2NmOm6HPr046i8wRIryNVR2r1n+3uOowQTc+H5scGi
 cjYg7V7Va2dzefVcZOGjdFSCyDifMvkMtSq0Ct3557C1xvmS1p6kuPFgtgUTe5tlU5GKErOmt
 Y85NZaWW7sQ3hUlXkIb70MZx71U1HLOafXKc17xy5qT7RNiqsgJufyG5mnYINBp9uKIaTrYVx
 PnHuy8xTSWP0nZ/hsFM0eYenPkLOaAJtjSsOyEUcd8e8DyapvvcwWw8MJGlcAV6FqLo8gicW9
 XVvVhn6G9j7QXZj1IVB0Iv0FNwy1PV1IKnm/nb8/1W40enHZlEf8NYj0jwjfuTaXb9BPdTgds
 IDdcgLQLjBXmp1Xl1c2FXX3vtHtlwaRfyqvxQzYg5VrDsaooQsLryySUDP/sK9Z4EJNf6LHSf
 nhrUa88qU0HM5GB65cLp4QxpcnfBHmObd0OA2g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out a buffer that is clearly too small to be used
in a meaningful way, as the 'sizeof(*args) + argc > sizeof(stack)'
will always fail:

In function 'memcpy',
    inlined from 'nvif_vmm_map' at drivers/gpu/drm/nouveau/nvif/vmm.c:55:2:
include/linux/string.h:353:9: error: '__builtin_memcpy' offset 40 is out of the bounds [0, 16] of object 'stack' with type 'u8[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/nouveau/nvif/vmm.c: In function 'nvif_vmm_map':
drivers/gpu/drm/nouveau/nvif/vmm.c:40:5: note: 'stack' declared here

This makes the buffer large enough so it should serve the purpose
that the author presumably had in mind. Alternatively we could
just get rid of it completely and simplify the code at the cost
of always doing the kmalloc (as we do in the current version).

Fixes: 920d2b5ef215 ("drm/nouveau/mmu: define user interfaces to mmu vmm opertaions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Cc: Martin Sebor <msebor@gcc.gnu.org>

Martin: this one is interesting, I think it qualifies as a
false-positive warning that gcc should not print because there
is no overflow, but the code is still wrong because we never
copy into the fixed-size buffer that was intended as a
micro-optimization
---
 drivers/gpu/drm/nouveau/nvif/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/vmm.c b/drivers/gpu/drm/nouveau/nvif/vmm.c
index 31cdb2d2e1ff..191832be6c65 100644
--- a/drivers/gpu/drm/nouveau/nvif/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvif/vmm.c
@@ -37,7 +37,7 @@ nvif_vmm_map(struct nvif_vmm *vmm, u64 addr, u64 size, void *argv, u32 argc,
 	     struct nvif_mem *mem, u64 offset)
 {
 	struct nvif_vmm_map_v0 *args;
-	u8 stack[16];
+	u8 stack[48];
 	int ret;
 
 	if (sizeof(*args) + argc > sizeof(stack)) {
-- 
2.9.0
