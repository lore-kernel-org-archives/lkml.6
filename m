Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbeE1QBF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:01:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeE1QA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:00:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: xen: ensure nul-terminated device name
Date: Mon, 28 May 2018 17:59:57 +0200
Message-Id: <20180528160011.2989632-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fN5CoebTTlxn96QSe9v4PE89O3YtuNySApcFhbG3nlhmgJiC7cH
 m8tX2/c3Ha24tnjVHFOkDXPh1p7HbP1N153fRbzKzZcD/28PN2IP/SA1QteyuCQzhQtt36U
 D3ey5FsB8Evn6Qejf2r/KQSeZjTIisz8ZEb4kbQtjM7z1ScnW2c2quItwUSm24P9eKK+O6b
 mc61+ru3VOVZybuYAg5Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JHXXZncySW0=:OU1qZKhNGNVUCuzxprmo8V
 l/O2NtAdTYnBL0nuKUZf+tqFFXQ8SQ7ZzA9f5bVjzgoKE5LiSRN36lbdbgTaifdV3MR2N8ZmW
 1SB9tyQKn4/IOLBmpKNKAQAdw3EKcBjbSDpDcWi3QDrcu5Zv6ENZlt3Gin6RwrZYjlukSGfrC
 GlyJWThPCO6Sj0W6qrYgKFgPoqyuz5Zj5p6UpYqjwUKhFj+AYf49ZwKmWvGPAdLtJVvaibN1m
 Smrpgk99EUJ/AmqWTtKG8AUuQj40D7MEbfC5VO1NsdZfxux0XT4a0sh3aK+xRJyubgAUUXDVD
 lHBWUxWGF9rYAMXUG9UKOuSp9VzcW5WuVVQfba+HTeWFuncftCCQZwx7W6Z5JCGYClpB6eZQy
 icX+Sy9KPx2XmRNcOcy89rjyMDleFBDo/ctvmV6rISh4tX/cUjThwSbt7cSTL7tg6B6k5SV5/
 FqjbMf3UKO8LYtc3nMP9XwO2ARxPLHKx1LSY9BBrEEc9JzAoQR4ASqaX2L0TmXz9zRfRpgODK
 cRHZtZ9sFh/Mc6W44qIZV7HOFVf+eGtwSMBnMcpQZxKRVNybIC4mVlwYR5Nz15yzqy88MGOCv
 aI6hB4clEEIckVGzRlriCXiV3/CRlbEJzRmZTCuKeeuRuo0dd7jhzDd89dUG6QXN7IqI66w6R
 8iuhkiAY+eBVobTwj687CX/kgzHRc19Fhso4RMBT/tffcNUcCzFpgovOwYDQzstzQlDM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 warns that pcm_instance->name is not necessarily terminated correctly
if the input is more than 80 characters long or lacks a termination byte
itself:

In function 'strncpy',
    inlined from 'cfg_device' at sound/xen/xen_snd_front_cfg.c:399:3,
    inlined from 'xen_snd_front_cfg_card' at sound/xen/xen_snd_front_cfg.c:509:9:
include/linux/string.h:254:9: error: '__builtin_strncpy' specified bound 80 equals destination size [-Werror=stringop-truncation]
  return __builtin_strncpy(p, q, size);

Using strlcpy() instead of strncpy() makes this a bit safer.

Fixes: fd3b36045c2c ("ALSA: xen-front: Read sound driver configuration from Xen store")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/xen/xen_snd_front_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/xen/xen_snd_front_cfg.c b/sound/xen/xen_snd_front_cfg.c
index 38c7e1eefbb9..684b5f1d51ac 100644
--- a/sound/xen/xen_snd_front_cfg.c
+++ b/sound/xen/xen_snd_front_cfg.c
@@ -396,7 +396,7 @@ static int cfg_device(struct xen_snd_front_info *front_info,
 
 	str = xenbus_read(XBT_NIL, device_path, XENSND_FIELD_DEVICE_NAME, NULL);
 	if (!IS_ERR(str)) {
-		strncpy(pcm_instance->name, str, sizeof(pcm_instance->name));
+		strlcpy(pcm_instance->name, str, sizeof(pcm_instance->name));
 		kfree(str);
 	}
 
-- 
2.9.0
