Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBBNSW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:18:22 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeBBNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:18:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] scsi: sym53c416: avoid section mismatch with LTO
Date: Fri,  2 Feb 2018 14:12:17 +0100
Message-Id: <20180202131225.1658853-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:nlqpScef+VnKmKfKY5WGznwFLfkiu6WqOqPaTPPhVr22f//NWIU
 Rz+xiBTELZ6R+t1J91VfnRmRcfHbWwBPxtd+epzs0vP61VgQB0FpLhxhGj31SfEnnHSC0Hg
 EuQb5X6dQcnWO0Jaw/FHvNT8y64RzJmKM+CkZvbvBPz9UhE+U88Ee+c+E+hfGQfCe2LbN1R
 LIPY2DqhcnHICjSQ2BG4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:awnMV8IkLbA=:dBYWJD77Cy3XnDIn9RLTfs
 fXrOpE7SyNxzGn5sT2719DMKbUb/PHiCNTT94JLPRf2thkqDqhC8gc5oFWKD/EjWZ4iLUqWbf
 pNCx10f3uuaWXGWqRNTC5b9QTqIO+3TLMVShE9ItQ/GMSBY+e3wYOyH6TjkTGksXj5fEwfBYx
 ByK3ITKw/Yi5KUGkTyqE0GzsGEtvJRldaVX6t5JLCD6VLXMbrkROSninT0wWTkhS3ej+aQmMn
 srhjOdxWivASR7A3KfiXngRsrbv+KQGLFCWqFh22miC03ouqYqUtYPYtScSiWyA17RbPbrlbO
 94qnjdUuupqq95fT4LT7bH4WbVr8v5+RVRhOdwmI9UnieHOg1HT96+yHy/BTvxE9IwjR62XAr
 OSuUnYGWu+WC8N5PzjpV/pShMqinliDe0TRzRc123Mrr70/tyzkHhGReSNXF7AG5fZtEU5DhZ
 ad/FcplpJ3oxQNxwOrzalG9nYKhF0EokX++kIgGfEuPVRtw2gLHyhVMFNZpK6RQmdEfrrvk1T
 ewEB5EP1t3dcb26KbxapYBk4wvGdBwOlCAqF2FCe/V0MiTCLfNzMFA1S2VTIaI5C2TzeuebZx
 YHZ8zUwPcqRhImW3QA5jTPHNQFOF+T30FVD1QZSFO0pYoFVtuCdiWS4j4OaHpWvscImNLSJ4W
 NXzXiiVFb5jU2C4hfeMxdsXmAI3kVDCIQbwzBEL17cMeLfL8uHclXkSuQrqvVu+HRt1/fkYuf
 6qhKvHYMQvOuhvyt43VPj0fPY8XkAIwwtLZLRw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with link time optimizations produces a false-postive section
mismatch warning:

WARNING: vmlinux.o(.data+0xf8c8): Section mismatch in reference from the variable driver_template.lto_priv.6915 to the function .init.text:sym53c416_detect()
The variable driver_template.lto_priv.6915 references
the function __init sym53c416_detect()
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
 drivers/scsi/sym53c416.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sym53c416.c b/drivers/scsi/sym53c416.c
index 5bdcbe8fa958..e68bcdc75bc3 100644
--- a/drivers/scsi/sym53c416.c
+++ b/drivers/scsi/sym53c416.c
@@ -608,7 +608,7 @@ static void sym53c416_probe(void)
 	}
 }
 
-int __init sym53c416_detect(struct scsi_host_template *tpnt)
+int sym53c416_detect(struct scsi_host_template *tpnt)
 {
 	unsigned long flags;
 	struct Scsi_Host * shpnt = NULL;
-- 
2.9.0
