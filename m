Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeE2KGn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:06:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54750 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933026AbeE2KEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:33 -0400
X-Google-Smtp-Source: AB8JxZrRIwXyOABx/Xb4X51c5Lcj3oLNew6FULQYHdusf/qHmEQEeaK/yntpRkYYTI1ZwJwNwYoHxg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>
Subject: [PATCH v2 3/9] PM / Domains: Drop genpd as in-param for pm_genpd_remove_device()
Date: Tue, 29 May 2018 12:04:15 +0200
Message-Id: <20180529100421.31022-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to pass a genpd struct to pm_genpd_remove_device(), as we
already have the information about the PM domain (genpd) through the device
structure.

Additionally, we don't allow to remove a PM domain from a device, other
than the one it may have assigned to it, so really it does not make sense
to have a separate in-param for it.

For these reason, drop it and update the current only call to
pm_genpd_remove_device() from amdgpu_acp.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c             | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
 include/linux/pm_domain.h               | 5 ++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 469edb401811..c89b0ad068b7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1475,13 +1475,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
- * @genpd: PM domain to remove the device from.
  * @dev: Device to be removed.
  */
-int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-			   struct device *dev)
+int pm_genpd_remove_device(struct device *dev)
 {
-	if (!genpd || genpd != genpd_lookup_dev(dev))
+	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+
+	if (!genpd)
 		return -EINVAL;
 
 	return genpd_remove_device(genpd, dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index a29362f9ef41..12558044acd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -513,7 +513,7 @@ static int acp_hw_fini(void *handle)
 	if (adev->acp.acp_genpd) {
 		for (i = 0; i < ACP_DEVS ; i++) {
 			dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
-			ret = pm_genpd_remove_device(&adev->acp.acp_genpd->gpd, dev);
+			ret = pm_genpd_remove_device(dev);
 			/* If removal fails, dont giveup and try rest */
 			if (ret)
 				dev_err(dev, "remove dev from genpd failed\n");
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 79888fb4a81f..42e0d649e653 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -144,7 +144,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 }
 
 int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
-int pm_genpd_remove_device(struct generic_pm_domain *genpd, struct device *dev);
+int pm_genpd_remove_device(struct device *dev);
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *new_subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
@@ -167,8 +167,7 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-					 struct device *dev)
+static inline int pm_genpd_remove_device(struct device *dev)
 {
 	return -ENOSYS;
 }
-- 
2.17.0
