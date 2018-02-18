Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeBRWCe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:02:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751813AbeBRWBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:55 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ASoc: rt5651: Fix regcache sync errors on resume
Date: Sun, 18 Feb 2018 23:01:44 +0100
Message-Id: <20180218220146.22485-8-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ALC5651 does not like multi-write accesses, avoid them. This fixes:

rt5651 i2c-10EC5651:00: Unable to sync registers 0x27-0x28. -121

Errors on resume (and all registers after the registers in the error not
being synced).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 831b297978a4..45a73049cf64 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1722,6 +1722,7 @@ static const struct regmap_config rt5651_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+	.use_single_rw = true,
 };
 
 #if defined(CONFIG_OF)
-- 
2.14.3
