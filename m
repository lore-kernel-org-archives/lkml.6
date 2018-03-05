Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeCEIbu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:31:50 -0500
Received: from mout.web.de ([212.227.17.12]:46725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933522AbeCEIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:31:47 -0500
Subject: [PATCH 1/4] scsi: hpsa: Use memdup_user() rather than duplicating its
 implementation
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Don Brace <don.brace@microsemi.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Message-ID: <1feebb55-05f4-a4f7-b478-efa57639c431@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LOZ12GGSBSDrYoLCHqIjjxItrGVqZVzFYQrZcVMjl8Ae85sG1YH
 +n9KShhXcR1mWcaz6PQ9y53cq3MIeTbLDEC0KtKrTVhETtsB7ImJ76nNhyHqFxbOpxvjCU2
 UME6NcgswvHkpWnENcSsnLBsjCcHXpqC81bFieQ9ZQN5jmc0Qq1oWBbkaeN6k9T0KfLtVbo
 WP7SgjTrKQpoeoSTCaPyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aG67iMDnZTc=:nLo1depIsu1xYZtViIQNu9
 v3sC4RBUyVyfsX43T+UfyG5B6OPKaASafyIniX6Df81HuB0oLeb3Zgal3mnC8e7NWpHJCHG28
 zzDG1As1tMG/1KnWdEXVgjaf4AkGMJ5y1EUOXDMaKXk7wmBRSA0qqjFiW2vZ5CPAJEGUaszlo
 uFIVRZ0qTNQR7At5sM0AtvzcX5bwybIZr80NtlZV3zKJWFcC8Y0PLPQwRd/9GrbZEFHdUcEB+
 th8EMumYEZp9/QdrAw3C+8y7gULEakOMR7RwPxVfbt+6MLX570JJSUt+qsvOnkgbztao2lMKt
 pUgs2yktDmVnyqZHltWWeqsOyD6pBzP4PuT6UvRaKEYYDLfUXBuaUF3z7fz+GE5u6wRNHFxqb
 ZBislOmo5LVGvUkmFSv/R6e/f96v9UBVwJtGJh9fi1XMOCbcD9LzJ5RIrZ1tAMi7Mub+T0O5w
 I3wjL5At7m0AOGBl99Ct4wG0MaV1ILrsuEwgnLn7bs1UDov6rhY8sXz6ub9/gm3HfV704+NSJ
 tASkOh5a745igD78bVfZhLgW5zcNY2BwuvoNiLIka1MKtImHY8FNWItKB8VKN91KIW/Cg2b6I
 Z8uchyQwP0QIc+kufN/xa+m+3Vnylfe+HUZfx5Sy8pZEVfFX/tKCp9yZPM3Eq/k5QwX3H6pv1
 KqweyXWFVOWzqE/uVrZZJ4kCoB9OWczDXKxV7YWRGQbjaTWOtj+vUpb46P9Yn4i1rgnXBrx2I
 6EbYl4C5r0um+BlYdJA7otKWvipM52/BmjDaF4SwXcur2AcVsYmFz7BdvhxXp8Cw6PMXEsWAQ
 L392x3pEXKd17XKADWiPcRAHKsn+DSv+1jQXSVnQUtnU19mLsw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Mar 2018 21:19:52 +0100

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  This issue was detected by using the Coccinelle software.

* Return directly after this function call failed at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/scsi/hpsa.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 5293e6827ce5..b35248becef9 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6390,15 +6390,10 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	ioc = kmalloc(sizeof(*ioc), GFP_KERNEL);
-	if (!ioc) {
-		status = -ENOMEM;
-		goto cleanup1;
-	}
-	if (copy_from_user(ioc, argp, sizeof(*ioc))) {
-		status = -EFAULT;
-		goto cleanup1;
-	}
+	ioc = memdup_user(argp, sizeof(*ioc));
+	if (IS_ERR(ioc))
+		return PTR_ERR(ioc);
+
 	if ((ioc->buf_size < 1) &&
 	    (ioc->Request.Type.Direction != XFER_NONE)) {
 		status = -EINVAL;
-- 
2.16.2
