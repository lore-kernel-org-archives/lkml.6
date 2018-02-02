Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBBNNa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:13:30 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62108 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:13:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] scsi: NCR53c406a: avoid section mismatch with LTO
Date: Fri,  2 Feb 2018 14:12:16 +0100
Message-Id: <20180202131225.1658853-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:YiX/S4C7AZzl1ZRkL/ZfgKL7eJ+TgFZ3OOrBDk4TV8DDokgB7+2
 RxA+2xbU6E2LHoKV4M/4er11qchYq3vq1YA8yjVNLTB1BY+EL10nAt9KNTF0kqNNCHaH0Tl
 yG0UdW++i1C2lGEmmBCMdJoPtrKRqipVVFT8iE1oZWS3qdm1g3FCtkXRyyudASryi9ritL9
 Ed3UMiu4/RJrnfoaVr1tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4xtqviWg+ak=:eOHwGyy+h1NGu2t/NTAeDG
 /0dEkb4bIltlV1/DN5/Oq7zLZB7N7bCqSJfoE5kuGwomQgIeeiPG5ju5tfUhPboxz5ekb7EyE
 SbaYsvYCMT7qMw3RTHbn5yCMI8RadUOfVK1RsHYw4GRen7sqgvqq/xC5A+pB/H3Zb7zird575
 avws5xga0NR67O6MLc9RT49FEkB56N6j+pd7/K7troOr10ilt7NcP6JToUd+k0L7rSwJwJ0Wp
 nJawRs98UmcxB1igKNNBvMj3JMmdzhUcPDvDGTmu/98Qu/G71g6/A9Fc0vuvb1/qLTX6hDwmK
 tfw0UTGP6wj35MeiYPRu6jOgox+vjRtdozIPqahJ8Q01PhgLOrEHZKuBOzp7YKPIvV3uWf9kc
 sxzgbyHcuk7gxH4t6S6bTfdfRoA0dhh6zRQ2aFdlm5WYSBDqVThJ4bXLBHvgdhMa9Ymp/pJ/T
 PoV5/B7OrSVKvh40JIgQg+Jxh9fSd8pYe2fuQvMgsXWrRZcvDguKLXy0IurmQ+DSWAnoOn8f0
 S8Hmx3ebpCaDbISCGnxHpS8qz4WMl09cFP8uysEIt9ivPoch3fiiJJsmfPLS9xSviidPNy14C
 DNJrm0Nstp7lK4SwpircbpA1iLEHKfXNW8PuR9ejKQa5IGvUihCwSnQ/nYwKFugMMP7ISPUh8
 jbNHEtMIUdl8U+vmD6CGdyp/2GwF8SvToLOOtwu1ZrZ3/Sn0Ovamj3i7j/6b0/PnlSJap0Jo/
 yU7JHvrDhCCO/2V9vKW7evkQ0/GCLM0MlNZ54A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with link time optimizations produces a false-postive section
mismatch warning:

WARNING: vmlinux.o(.data+0xf7e8): Section mismatch in reference from the variable driver_template.lto_priv.6914 to the function .init.text:NCR53c406a_detect()
The variable driver_template.lto_priv.6914 references
the function __init NCR53c406a_detect()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

The ->detect callback is always entered from the init_this_scsi_driver()
init function, but apparently LTO turns the optimized direct function
call into an indirect call through a non-__initdata pointer.

All drivers using init_this_scsi_driver() are for ancient hardware,
and most don't mark the detect() callback as __init(), so I'm
just removing the annotation here to kill off the warning instead
of doing a larger rework.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/NCR53c406a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR53c406a.c b/drivers/scsi/NCR53c406a.c
index 6e110c630d2c..44b09870bf51 100644
--- a/drivers/scsi/NCR53c406a.c
+++ b/drivers/scsi/NCR53c406a.c
@@ -448,7 +448,7 @@ static __inline__ int NCR53c406a_pio_write(unsigned char *request, unsigned int
 }
 #endif				/* USE_PIO */
 
-static int __init NCR53c406a_detect(struct scsi_host_template * tpnt)
+static int NCR53c406a_detect(struct scsi_host_template * tpnt)
 {
 	int present = 0;
 	struct Scsi_Host *shpnt = NULL;
-- 
2.9.0
