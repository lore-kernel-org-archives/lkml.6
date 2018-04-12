Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeDLTdt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:33:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54144 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeDLTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:33:46 -0400
X-Google-Smtp-Source: AIpwx49odxNJkmyeXTs53XmkuK7hXRzIBW132iEzsV13Pe2unyVST2l0Q+aEVbU55FXQu47WUhqNXw==
From: Mathieu Malaterre <malat@debian.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: change function signature to pass full range
Date: Thu, 12 Apr 2018 21:33:33 +0200
Message-Id: <20180412193333.4951-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ‘radeon_process_i2c_ch’ a comparison of a u8 value against
255 is done. Since it is always false, change the signature of this
function to use an `int` instead, which match the type used in caller:
`radeon_atom_hw_i2c_xfer`.

Fix the following warning triggered with W=1:

  CC [M]  drivers/gpu/drm/radeon/atombios_i2c.o
  drivers/gpu/drm/radeon/atombios_i2c.c: In function ‘radeon_process_i2c_ch’:
  drivers/gpu/drm/radeon/atombios_i2c.c:71:11: warning: comparison is always false due to limited range of data type [-Wtype-limits]
   if (num > ATOM_MAX_HW_I2C_READ) {
           ^

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/gpu/drm/radeon/atombios_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
index 4157780585a0..9022e9af11a0 100644
--- a/drivers/gpu/drm/radeon/atombios_i2c.c
+++ b/drivers/gpu/drm/radeon/atombios_i2c.c
@@ -35,7 +35,7 @@
 
 static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
 				 u8 slave_addr, u8 flags,
-				 u8 *buf, u8 num)
+				 u8 *buf, int num)
 {
 	struct drm_device *dev = chan->dev;
 	struct radeon_device *rdev = dev->dev_private;
-- 
2.11.0
