Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeBKTl5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:41:57 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:41553 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeBKTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:41:56 -0500
Date: Sun, 11 Feb 2018 20:41:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>, Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180211194154.GB22869@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <CAHbf0-Fhi9j5H7VTxF84SENQph+UQE2zRbi2Q-u_DAMh6x+eSg@mail.gmail.com>
 <20180211192314.GA22869@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211192314.GA22869@wunner.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 08:23:14PM +0100, Lukas Wunner wrote:
> On Sun, Feb 11, 2018 at 06:58:11PM +0000, Mike Lothian wrote:
> > On 11 February 2018 at 09:38, Lukas Wunner <lukas@wunner.de> wrote:
> > > The patches for radeon and amdgpu are compile-tested only, I only have a
> > > MacBook Pro with an Nvidia GK107 to test.  To test the patches, add an
> > > "msleep(12*1000);" at the top of the driver's ->runtime_suspend hook.
> > > This ensures that the poll worker runs after ->runtime_suspend has begun.
> > > Wait 12 sec after the GPU has begun runtime suspend, then check
> > > /sys/bus/pci/devices/0000:01:00.0/power/runtime_status.  Without this
> > > series, the status will be stuck at "suspending" and you'll get hung task
> > > errors in dmesg after a few minutes.
> > 
> > I wasn't quite sure where to add that msleep. I've tested the patches
> > as is on top of agd5f's wip branch without ill effects
> > 
> > I've had a radeon and now a amdgpu PRIME setup and don't believe I've
> > ever seen this issue
> > 
> > If you could pop a patch together for the msleep I'll give it a test on
> > amdgpu
> 
> Here you go, this is for all 3 drivers.
> Should deadlock without the series.
> Thanks!

Sorry, I missed that amdgpu_drv.c and radeon_drv.c don't include delay.h,
rectified testing patch below:


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 50afcf6..beaaf2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -36,6 +36,7 @@
 
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
@@ -718,6 +719,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	printk("waiting 12 sec\n");
+	msleep(12*1000);
+	printk("done waiting 12 sec\n");
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	drm_kms_helper_poll_disable(drm_dev);
 	vga_switcheroo_set_dynamic_switch(pdev, VGA_SWITCHEROO_OFF);
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 555fbe5..ee7cf0d 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -586,6 +586,7 @@ static void output_poll_execute(struct work_struct *work)
 		repoll = true;
 		goto out;
 	}
+	dev_info(&dev->pdev->dev, "begin poll\n");
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
@@ -651,6 +652,7 @@ static void output_poll_execute(struct work_struct *work)
 
 	if (repoll)
 		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
+	dev_info(&dev->pdev->dev, "end poll\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 3e29302..f9da5bc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -855,6 +855,9 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 		return -EBUSY;
 	}
 
+	printk("waiting 12 sec\n");
+	msleep(12*1000);
+	printk("done waiting 12 sec\n");
 	drm_kms_helper_poll_disable(drm_dev);
 	vga_switcheroo_set_dynamic_switch(pdev, VGA_SWITCHEROO_OFF);
 	nouveau_switcheroo_optimus_dsm();
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 31dd04f..2b4e7e0 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -35,6 +35,7 @@
 
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
@@ -413,6 +414,9 @@ static int radeon_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	printk("waiting 12 sec\n");
+	msleep(12*1000);
+	printk("done waiting 12 sec\n");
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	drm_kms_helper_poll_disable(drm_dev);
 	vga_switcheroo_set_dynamic_switch(pdev, VGA_SWITCHEROO_OFF);
