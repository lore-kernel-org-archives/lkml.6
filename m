Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbeE3Vk2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:40:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeE3VkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:40:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Doug Oucharek <dougso@me.com>,
        NeilBrown <neilb@suse.com>, Dmitry Eremin <dmitry.eremin@intel.com>,
        Ingo Molnar <mingo@kernel.org>, lustre-devel@lists.lustre.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: lustre: include linux/highmem.h when needed
Date: Wed, 30 May 2018 23:38:48 +0200
Message-Id: <20180530213941.772006-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:pQYOzkXnNjuORuEYjN/kXtTO8xZCNpu4GH1Em+PJsgshkwyLGyn
 8b61AxYLB6O+nIEwyLmezRpyEOUdX5aT1wz33wJ821dmhIk0rjmiWkbawoTtl3KtGJNoSkZ
 NPJx6ApgTrIX2c+/k5CTDyZMxf0oPf+6uONycnW18uu0R+luBGQKHYrIEIPTMYp1sCG3JFH
 K+RyffcGb2riDEbwC2qZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WEAPVNXrm7U=:Bk3zZ+/oPEU7xUnoEpD5Kj
 9R0Y+MrUaR6oXAiDo124C30uP4gqAsy4+MFwwKnsnTpPetNcjKfRB5mxEOrVpdAb5cD89/+oX
 S5TgQEPyqfuSh16MymdAxamklNZGJjw/qxSd6mG67+K6n08CUnqNamBv4MYD0CmyttUQebEw5
 LXihgg4Sj3mQhjIVl9s/I7634wyz+MIrYDVuORcIH/3fdoCYZmbvCdXgt87pa/iFXetmERpZq
 a8ONEGwdOOvisRuStURZauf5BiMv2W8Bx90sOzRecksayiKNUqjHpKTWtRuAJsJKvPgXdsUX1
 cZKbpuQe8iE6D0epPDcaaT98lw5Lq/utU8ibCe8TCqhQV40PnmBFchqHjH4ckLDp8y+O3qLyD
 6pRWoiBF7PoTWxWoIgXavEq+k4qEdCeyl0Cy35NrDpwfgSOK4bD+z3EIrLa+SXieJ1aEjw+l+
 nGMVDXVDa1pFwRZvFZmfx3PXBv7qGvY514kImvqiu/eI+WB6tsFWnPa+WBPIN7TcWQIyQpRAp
 DNKNCa+sL7udKkdR6f+NLXQI8VSwhlkF0fFjkFbx2BhmWJEuC0mg/YL0IuBKEKX7D+ZlPi4x8
 DB+m73dZeteonQqjpzcvO41TvfhOZAgTcMTbK8T7v2hjczqD/hQMxgT4qS+crLfPYW6U7BQZx
 B2nSw+l0x4bmIqSBZjnjp6HDvvaPUJfIz41HWzt0zhfajbi10iZ8BLPA46/lyWf01p0Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something in recent linux-next kernels caused linux/highmem.h to
no longer be included implicitly from o2iblnd_cb.c, causing a build
failure:

drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c: In function 'kiblnd_kvaddr_to_page':
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:549:15: error: 'PKMAP_BASE' undeclared (first use in this function); did you mean 'RTM_BASE'?
  if (vaddr >= PKMAP_BASE &&
               ^~~~~~~~~~
               RTM_BASE
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:549:15: note: each undeclared identifier is reported only once for each function it appears in
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:550:28: error: 'LAST_PKMAP' undeclared (first use in this function); did you mean 'AT_HWCAP'?
      vaddr < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE)) {
                            ^~~~~~~~~~
                            AT_HWCAP

This adds back an explicit include for the header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 47eb8b4c28db..65b7a62943ad 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -35,6 +35,7 @@
  * Author: Eric Barton <eric@bartonsoftware.com>
  */
 
+#include <linux/highmem.h>
 #include "o2iblnd.h"
 
 #define MAX_CONN_RACES_BEFORE_ABORT 20
-- 
2.9.0
