Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeA3Tvt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:51:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeA3Tvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:51:46 -0500
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Martin Peres <martin.peres@free.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v5 4/5] drm/nouveau: Add support for SLCG for Kepler2
Date: Tue, 30 Jan 2018 14:49:24 -0500
Message-Id: <20180130195024.18172-5-lyude@redhat.com>
In-Reply-To: <20180130195024.18172-1-lyude@redhat.com>
References: <20180130195024.18172-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's right, there's still more power saving to go! Starting with
kepler 2, nvidia hardware has an additional level of clockgating known
as second level clockgating.  The details of this are not exact, but it
seems to work by waiting for a collection of dependent hardware blocks
to be gated before taking affect. As with the previous series, this
results in another noticeable drop in power consumption and is
programmed in the same manner.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c | 93 ++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
index a528894231d0..4da916a9fc73 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
@@ -187,6 +187,87 @@ gk110_clkgate_blcg_init_gpc_mp_0[] = {
 	{}
 };
 
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_main_0[] = {
+	{ 0x4041f4, 1, 0x00000000 },
+	{ 0x409894, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_unk_0[] = {
+	{ 0x406004, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_sked_0[] = {
+	{ 0x407004, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_ctxctl_0[] = {
+	{ 0x41a894, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_unk_0[] = {
+	{ 0x418504, 1, 0x00000000 },
+	{ 0x41860c, 1, 0x00000000 },
+	{ 0x41868c, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_esetup_0[] = {
+	{ 0x41882c, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_zcull_0[] = {
+	{ 0x418974, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_l1c_0[] = {
+	{ 0x419cd8, 2, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_unk_1[] = {
+	{ 0x419c74, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_mp_0[] = {
+	{ 0x419fd4, 1, 0x00004a4a },
+	{ 0x419fdc, 1, 0x00000014 },
+	{ 0x419fe4, 1, 0x00000000 },
+	{ 0x419ff4, 1, 0x00001724 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_gpc_ppc_0[] = {
+	{ 0x41be2c, 1, 0x00000000 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_slcg_init_pcounter_0[] = {
+	{ 0x1be018, 1, 0x000001ff },
+	{ 0x1bc018, 1, 0x000001ff },
+	{ 0x1b8018, 1, 0x000001ff },
+	{ 0x1b4124, 1, 0x00000000 },
+	{}
+};
+
 static const struct nvkm_therm_clkgate_pack
 gk110_clkgate_pack[] = {
 	{ gk104_clkgate_blcg_init_main_0 },
@@ -214,6 +295,18 @@ gk110_clkgate_pack[] = {
 	{ gk104_clkgate_blcg_init_rop_0 },
 	{ gk104_clkgate_blcg_init_rop_crop_0 },
 	{ gk104_clkgate_blcg_init_pxbar_0 },
+	{ gk110_clkgate_slcg_init_main_0 },
+	{ gk110_clkgate_slcg_init_unk_0 },
+	{ gk110_clkgate_slcg_init_sked_0 },
+	{ gk110_clkgate_slcg_init_gpc_ctxctl_0 },
+	{ gk110_clkgate_slcg_init_gpc_unk_0 },
+	{ gk110_clkgate_slcg_init_gpc_esetup_0 },
+	{ gk110_clkgate_slcg_init_gpc_zcull_0 },
+	{ gk110_clkgate_slcg_init_gpc_l1c_0 },
+	{ gk110_clkgate_slcg_init_gpc_unk_1 },
+	{ gk110_clkgate_slcg_init_gpc_mp_0 },
+	{ gk110_clkgate_slcg_init_gpc_ppc_0 },
+	{ gk110_clkgate_slcg_init_pcounter_0 },
 	{}
 };
 
-- 
2.14.3
