Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964938AbeB1XUC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:20:02 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964887AbeB1XUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:20:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: renesas-ceu: mark PM functions as __maybe_unused
Date: Thu,  1 Mar 2018 00:19:37 +0100
Message-Id: <20180228231951.460060-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:OwxZZPCuJjqynJFvTphawLGuKuYFqbLVrgZkEp4vwOh4FS4TvYO
 kqc2GDK8pfjLV03ANGLNm0thPAroVCj6c3YOutB5c34y6HdQzAwRBOJ3nP0P978/kkXunKU
 gMUrBXr3TVS4/7edXFmFa5bnw7UTodeVZZKD2vHc+Lx5vXr450yARu0U8RRTtCXElU1smno
 YVneLBCDtlgaiM1Iy+eig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1NstrN1UIOg=:T1+H0t5i5r6gYkqexVveXs
 ZHjnl0YaeSqGYcFK2D9OG3KBGrsoxZszJ1uNRXP4Aw3+Pxi+vCu7OJMlRQfDLny5n+nzJLKIs
 gYR55OWJWlsBxQvfNsZphaEAJzwXWiNZ7ZiqWIUm1nDmTQTdX5irSQ7aAclHLqF52SBGK8iLO
 Mo9CztG60/OFyhKzoC/2ytapNJS5WOhGqGll9xfd4u9A/cJ2flhGxLNkQ6hAovrUsSqhn64bi
 hkFCahoBmfbXk1dqRYotRC4voUXTf8pMbx1bb+ZTuzxUpPHJFeRFr9Vi/zJVUi9w++82qCVSf
 uXq+Lt6PvPu1UmTB6D6NAZuDp+cslDElmLe8ssDNMWvAMJhoWn7DOZtyazRhlMrHF4BOdWQhs
 fkcep7TsuPp0hcydToefZqOzPRUYclywCErUsotoucF9UIagi+DnZCKEd6v3xexYU3ONfxAhH
 lVeNn4LCe+rxJRDWnm8d4gu98WATpe3wFN4VLO4IIcxlFZMErYYmNAh6hhvK9unjDFFHFr5qK
 19PrfaFczd2YAKKIN88Mo2JXYWBd6xQKkCt0avpzGA4HN9IoIjrdDva5EF4eVo9roi3+OonXD
 jiaFE9k6rVtkdsqn6NraZ0xVhUeLCRn39xAsO5oDpeeKaiDx1u2JpgtAjCcibItLle0JLHeP3
 PbEzOM1PkgT0m7u8ATWswg/0Kgbt6/zhjwyfkUDS31OYZij4NKvvbnyi/1mrI5c4PxBJjD9du
 jHgx3xFfotRlgXNh+4LK63R74b/D+YORhCe9Ag==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM runtime operations are unused when CONFIG_PM is disabled,
leading to a harmless warning:

drivers/media/platform/renesas-ceu.c:1003:12: error: 'ceu_runtime_suspend' defined but not used [-Werror=unused-function]
 static int ceu_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~
drivers/media/platform/renesas-ceu.c:987:12: error: 'ceu_runtime_resume' defined but not used [-Werror=unused-function]
 static int ceu_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~

This adds a __maybe_unused annotation to shut up the warning.

Fixes: 32e5a70dc8f4 ("media: platform: Add Renesas CEU driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/renesas-ceu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
index 22330c0c2f6a..eccd60a7ebec 100644
--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -984,7 +984,7 @@ static int ceu_init_mbus_fmt(struct ceu_device *ceudev)
 /*
  * ceu_runtime_resume() - soft-reset the interface and turn sensor power on.
  */
-static int ceu_runtime_resume(struct device *dev)
+static int __maybe_unused ceu_runtime_resume(struct device *dev)
 {
 	struct ceu_device *ceudev = dev_get_drvdata(dev);
 	struct v4l2_subdev *v4l2_sd = ceudev->sd->v4l2_sd;
@@ -1000,7 +1000,7 @@ static int ceu_runtime_resume(struct device *dev)
  * ceu_runtime_suspend() - disable capture and interrupts and soft-reset.
  *			   Turn sensor power off.
  */
-static int ceu_runtime_suspend(struct device *dev)
+static int __maybe_unused ceu_runtime_suspend(struct device *dev)
 {
 	struct ceu_device *ceudev = dev_get_drvdata(dev);
 	struct v4l2_subdev *v4l2_sd = ceudev->sd->v4l2_sd;
-- 
2.9.0
