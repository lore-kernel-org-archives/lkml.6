Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeBIVWZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:22:25 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41223 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbeBIVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:22:24 -0500
X-Google-Smtp-Source: AH8x226At/OaG0/YHOne1LaUFaoF3MNUCRBdm5z4iASMdXkdwOYhtWtYbas1ATkeMmH9ra02VyvLPQ==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Mark Brown <broonie@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/4] ASoC: dapm: fix debugfs read using path->connected
Date: Fri,  9 Feb 2018 13:22:13 -0800
Message-Id: <20180209212216.71447-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

This fix a bug in dapm_widget_power_read_file(),
where it may sent opposite order of source/sink widget
into the p->connected().

for example,
static int connected_check(source, sink);
{"w_sink", NULL, "w_source", connected_check}

the dapm_widget_power_read_file() will query p->connected()
in following case
	p->conneted("w_source", "w_sink")
	p->conneted("w_sink", "w_source")
we should avoid the last case, since it's the wrong order (source/sink)
as declared in snd_soc_dapm_route.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a10b21cfc31e..ee6d9d9a3c5e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2026,7 +2026,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	snd_soc_dapm_for_each_direction(dir) {
 		rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
 		snd_soc_dapm_widget_for_each_path(w, dir, p) {
-			if (p->connected && !p->connected(w, p->node[rdir]))
+			if (p->connected && !p->connected(p->source, p->sink))
 				continue;
 
 			if (!p->connect)
-- 
2.16.0.rc1.238.g530d649a79-goog
