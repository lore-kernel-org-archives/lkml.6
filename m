Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeEOVRE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:17:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33231 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEOVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:17:03 -0400
X-Google-Smtp-Source: AB8JxZrpEq347M+TXMxSrLpCKfs9BD0F4+SH2EqTa15pgWnNOpLdEaDFIwFBGCmiQ4kyGKZcXvHzJw==
From: Douglas Anderson <dianders@chromium.org>
To: srinivas.kandagatla@linaro.org, kishon@ti.com
Cc: mgautam@codeaurora.org, mka@chromium.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us
Date: Tue, 15 May 2018 14:16:22 -0700
Message-Id: <20180515211622.195140-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on
Qcom chips") you can see a call like:

  devm_nvmem_cell_get(dev, NULL);

Note that the cell ID passed to the function is NULL.  This is because
the qcom-qusb2 driver is expected to work only on systems where the
PHY node is hooked up via device-tree and is nameless.

This works OK for the most part.  The first thing nvmem_cell_get()
does is to call of_nvmem_cell_get() and there it's documented that a
NULL name is fine.  The problem happens when the call to
of_nvmem_cell_get() returns -EINVAL.  In such a case we'll fall back
to nvmem_cell_get_from_list() and eventually might (if nvmem_cells
isn't an empty list) crash with something that looks like:

 strcmp
 nvmem_find_cell
 __nvmem_device_get
 nvmem_cell_get_from_list
 nvmem_cell_get
 devm_nvmem_cell_get
 qusb2_phy_probe

There are several different ways we could fix this problem:

One could argue that perhaps the qcom-qusb2 driver should be changed
to use of_nvmem_cell_get() which is allowed to have a NULL name.  In
that case, we'd need to add a patche to introduce
devm_of_nvmem_cell_get() since the qcom-qusb2 driver is using devm
managed resources.

One could also argue that perhaps we could just add a name to
qcom-qusb2.  That would be OK but I believe it effectively changes the
device tree bindings, so maybe it's a no-go.

In this patch I have chosen to fix the problem by simply not crashing
when a NULL cell_id is passed to nvmem_cell_get().

NOTE: that for the qcom-qusb2 driver the "nvmem-cells" property is
defined to be optional and thus it's expected to be a common case that
we would hit this crash and this is more than just a theoretical fix.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/nvmem/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b0cdc21d01..514d1dfc5630 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -936,6 +936,10 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 			return cell;
 	}
 
+	/* NULL cell_id only allowed for device tree; invalid otherwise */
+	if (!cell_id)
+		return ERR_PTR(-EINVAL);
+
 	return nvmem_cell_get_from_list(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
-- 
2.17.0.441.gb46fe60e1d-goog
