Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522338182; cv=none;
        d=google.com; s=arc-20160816;
        b=IKqzz9MOIWaKyxNa1zFPH4xXal7yA7XlwMmB8xE9ErfTonavHOcfleLskYNKRjVDyc
         e7u6OhRwLJpP0lOe0TdZZ4oE5QSsSD+2eGn8cm7jr834KqYTPxZ4Jedypnr82Zn7RngE
         4f1JqfZ5qS8ddAW7ckmYX8YBm36jRZFU4eAh+P7YpIOKF/pj5bjT9uhfOmEf2sDubA6e
         WfFULpLOnt38+fyT6O3SVpashwuqC4OZgjrm9P7ufEOucwvhL4a36lXG7eRAs9I/R1Ht
         Q+OXSOoDp/RloJ+qjgkb+z3fpoYSUi2W24atC0mUTi4/oNaCwLcQ2naMjloJw1/okLle
         lU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0OdepG3/2Mj/euKRpsHnHQSbqvN5CiK6En2jWO8CmzY=;
        b=vo5WZhuSKph9CqNd9TyJb5a3AS0oSVHV2xkbiTP3EbsEX4LWnOdNVQeDnHAsASO/IL
         FVKrzYU7UCCVEc+nLNh1zm8oREVZBkWQujoWs6yVdX9mRbBVy8qwMcT9xg0MX+PcNmkc
         M0Iwd/4VGZKka1gCTGMnNYxfj0tGh0Z/QuZmRZU3ZvQz0Z40v3sfQiTPsYj68LlcD9++
         nnIXWF3qTOae8WULT20yA0NfCtrtir/idJAbxU2GTA7NjkBi7qWpF+z3uczgg190HzxH
         vaPBS6l46ocamREjwtAsG7ebFBGLxF9WahbhDq+dyHiaC2PS0aFXnt5t2+yQRtcEx4jQ
         VXSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx4+BVKTLIQjMyb3ocGV2om2Lmp5HqIeP25KCFPSZ0rCVUPCZAmn+NZdVGshzXrcoiSqPnuDw2w==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4/6] fpga: region: change fpga_region_register to have one param
Date: Thu, 29 Mar 2018 08:36:56 -0700
Message-Id: <20180329153658.11614-5-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287282137577782?=
X-GMAIL-MSGID: =?utf-8?q?1596287282137577782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Change fpga_region_register to only take one parameter:

  int fpga_region_register(struct fpga_region *region)

The parent dev is added to struct fpga_region.

This make it similar to fpga_bridge_register and fpga_mgr_register
which also just take their respective struct.

The one caller of fpga_region_register is changed to alloc the
fpga_region struct, fill it in, and pass it to the register
function.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 Documentation/fpga/fpga-region.txt | 3 +--
 drivers/fpga/fpga-region.c         | 8 +++++++-
 drivers/fpga/of-fpga-region.c      | 3 ++-
 include/linux/fpga/fpga-region.h   | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/fpga/fpga-region.txt b/Documentation/fpga/fpga-region.txt
index 139a02ba1ff6..d38fa3b4154a 100644
--- a/Documentation/fpga/fpga-region.txt
+++ b/Documentation/fpga/fpga-region.txt
@@ -42,8 +42,7 @@ The FPGA region API
 To register or unregister a region:
 -----------------------------------
 
-	int fpga_region_register(struct device *dev,
-				 struct fpga_region *region);
+	int fpga_region_register(struct fpga_region *region);
 	int fpga_region_unregister(struct fpga_region *region);
 
 An example of usage can be seen in the probe function of [3]
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ebe1f872810d..660a91b9e246 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -162,10 +162,16 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
-int fpga_region_register(struct device *dev, struct fpga_region *region)
+int fpga_region_register(struct fpga_region *region)
 {
+	struct device *dev = region->parent;
 	int id, ret = 0;
 
+	if (!dev) {
+		pr_err("Attempt to register fpga region without parent\n");
+		return -EINVAL;
+	}
+
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		return id;
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35e7e8c4a0cb..a7b38aafeaa7 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -428,12 +428,13 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 	}
 
+	region->parent = dev;
 	region->mgr = mgr;
 
 	/* Specify how to get bridges for this type of region. */
 	region->get_bridges = of_fpga_region_get_bridges;
 
-	ret = fpga_region_register(dev, region);
+	ret = fpga_region_register(region);
 	if (ret)
 		goto eprobe_mgr_put;
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index b6520318ab9c..423c87e3e29a 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -8,6 +8,7 @@
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
+ * @parent: parent device
  * @mutex: enforces exclusive reference to region
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
@@ -18,6 +19,7 @@
  */
 struct fpga_region {
 	struct device dev;
+	struct device *parent;
 	struct mutex mutex; /* for exclusive reference to region */
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
@@ -34,7 +36,7 @@ struct fpga_region *fpga_region_class_find(
 	int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
-int fpga_region_register(struct device *dev, struct fpga_region *region);
+int fpga_region_register(struct fpga_region *region);
 int fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
-- 
2.16.2
