Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeFEUjZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:25 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:59504
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751962AbeFEUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:01 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Arjan van de Ven <arjan@linux.intel.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/8] use the new async probing feature for the hyperv drivers
Date: Tue,  5 Jun 2018 13:37:49 -0700
Message-Id: <20180605203756.29809-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203536.29751-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfAorYw9lwdMbUVXOmopGsUwUamZra+Q4XhFqpP9g4t5ddAl/R+jK9CDPQXrqoL5es+SZs4RLxLp3Yv0v+R00LC5e5pL6FVDvfukvPH3MGYlaZv1yChEF
 QDQRTNX4vmg9hM78XbuGAdfiD7YVsX6sLn+YcKMVylUoSjukNnGbsp00fueLDBHEkMPxf9Emlpa/hOPESqox9GPk/qT68ao+kdkxJchKzL9TDq/cOgSJz64t
 5zrKE5ag4G+RNPvo1EPvp8F8EHKeXy1/W+dZknZfXdGLvwlK71A30Y83ngZ68Ec6juWHkX/U/8Y54ZdUQ2kYLfQ7FZ56HkYfWNCaiKzbRhbdjzcOX/fMiWmd
 5HrKWm/tPiQ894fV3lT2TuOIcTjfwvS3Ph9X3dlPNQLsicAgCYJeZJ1bOvbSuhsZdfCJK5EMitivGxjueJLC0OdK9Z9NZ6VZpwuJgcSNCu1cCbriOIoJH1mR
 qdLTsrwEaBauGNCrxC4SzrFyuGAXGMfRY/oDR6vmmfIcM8F6QIfnHdATPLHvQM7k+34DGkdVMlVkCExKe7rdBhuIVAuRsOFWDRoIfA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

Recent kernels support asynchronous probing; most hyperv drivers
can be probed async easily so set the required flag for this.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hid/hid-hyperv.c              | 3 +++
 drivers/hv/hv_balloon.c               | 3 +++
 drivers/hv/hv_util.c                  | 3 +++
 drivers/input/serio/hyperv-keyboard.c | 3 +++
 drivers/net/hyperv/netvsc_drv.c       | 3 +++
 drivers/scsi/storvsc_drv.c            | 3 +++
 drivers/video/fbdev/hyperv_fb.c       | 6 ++++++
 7 files changed, 24 insertions(+)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 3aa2bb9f0f81..b372854cf38d 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -598,6 +598,9 @@ static struct  hv_driver mousevsc_drv = {
 	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init mousevsc_init(void)
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index b3e9f13f8bc3..b1b788082793 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1765,6 +1765,9 @@ static  struct hv_driver balloon_drv = {
 	.id_table = id_table,
 	.probe =  balloon_probe,
 	.remove =  balloon_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init init_balloon_drv(void)
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 14dce25c104f..423205077bf6 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -487,6 +487,9 @@ static  struct hv_driver util_drv = {
 	.id_table = id_table,
 	.probe =  util_probe,
 	.remove =  util_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int hv_ptp_enable(struct ptp_clock_info *info,
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 25151d9214e0..47a0e81a2989 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -424,6 +424,9 @@ static struct  hv_driver hv_kbd_drv = {
 	.id_table = id_table,
 	.probe = hv_kbd_probe,
 	.remove = hv_kbd_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init hv_kbd_init(void)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ecc84954c511..3965c62e79ba 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2155,6 +2155,9 @@ static struct  hv_driver netvsc_drv = {
 	.id_table = id_table,
 	.probe = netvsc_probe,
 	.remove = netvsc_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 /*
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8c51d628b52e..32027ac60aa4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1893,6 +1893,9 @@ static struct hv_driver storvsc_drv = {
 	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 2fd49b2358f8..403d8cd3e582 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -912,6 +912,9 @@ static struct hv_driver hvfb_drv = {
 	.id_table = id_table,
 	.probe = hvfb_probe,
 	.remove = hvfb_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int hvfb_pci_stub_probe(struct pci_dev *pdev,
@@ -929,6 +932,9 @@ static struct pci_driver hvfb_pci_stub_driver = {
 	.id_table =	pci_stub_id_table,
 	.probe =	hvfb_pci_stub_probe,
 	.remove =	hvfb_pci_stub_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	}
 };
 
 static int __init hvfb_drv_init(void)
-- 
2.17.1
