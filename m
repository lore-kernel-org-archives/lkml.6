Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3697BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D0D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBLIs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:48:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:51713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfBLIs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:48:28 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MbOoG-1gd3Jl0Ya4-00IjLv; Tue, 12 Feb 2019 09:48:25 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] chardev: fix an overlap misjudgement case in __register_chrdev_region()
Date:   Tue, 12 Feb 2019 16:47:38 +0800
Message-Id: <20190212084739.27602-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZVkklKB4yA20TBa5UAKpbccy7+P0JS1aSvFoJF48KeWHWfCAP8b
 o6s/bHx/VGJP/CQR/OgM626GQyDSeWxKswIg+DQUTIMHLpdjFdTioTIVNHeA05LFrxqrzhH
 tfYk57jrrlRZpICjJiNHjKsuuCyMXLG7dA7lShVGEtn9rOp7X3uf4rGUMTGSm2UkNnXL2Dt
 ifHaS0LV8nEJOBW3JUUdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1P+skBUiQ6g=:8F+DXF2AAq2cMvd9Z55qcN
 jXR3VzkTS82U74eXgGfnYGX0Q9JW1X/VbLb/CQblTADKQL2IP4f3VN3QZHsKUi+B6EYrXFnyh
 6H/HtyvoHNfIufBaj4y2VxKmGhINus1El4RryH2T4A/+3OXlJD3WvzmmfxeiDWPjRoMlzVGYo
 0MfFsRnxE0fGQ2/T+jlyfUBOBE3paXIW9RLXf4YF+a1vIcqu7BbkFY+j0jOrZebtyYSHpw2O0
 vik/BTCRxmBVVf73/iSLXqsz6tGm/qgYk0/T7yKezxqnLApzquUaEA4ja3/K81xLuuT86glM1
 1ofMJJaqN2SxART/pCckVq97BUetD8rC5qvyr3Ib4iqYxVzioLlqUrxji9u6xJmDMz0HByu5g
 /L0XmBSVSmWIgOQVEiYOVTuYGSc5hnFJQ0L9LklfprqtNqSB3xYVsjlgaW+Iis5qBszDOm0jg
 DHWY313Eetu1jP2owTFccU6F78xHIFdp+DEagrFdRAUn25xpy15lGYU+0BHhVZffmS+klvE0Y
 inP/p5tnfBNJHkw/3pWQFJ2jOUXWCJAR5GM8E85P4uVtNJ0dFzVGr5HEH/3OOFC6vDPWuPFYF
 R5UME6w9IwapAc9Vt5Kp7K1zkmudH8UpF0yheAzda4GYqVaCewurOdbKixlrEwI/jTK8CyPRS
 TwF6sohf8SgT/JOpqKXHNdWw1l1MOln42t4tfPHRVxx2Gk3TtDtoJwgld3w6Ui720hkTUFtuK
 zt/5YmYaZxLfESKIannLANY+WfKHSWqk8ve5wi90CYGuzExs15WtgSXy1Zu4n32QOPp77ITvF
 UW/HnmuJKXi3WPfEM95NVRvF4aF0uzEi9m7v4n0HDgRaWA6vkZ89DjyucmZU4pTKGBrrT+JlA
 oDzwmTj9UnObZQHvlMY/sfmuWSz+q5+vAnZ5jPrShVqJKI4ViKfCExuPtpjPCt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current overlap check of minor range cannot correctly
handle a case which is baseminor < existing baseminor &&
baseminor + minorct > existing baseminor + minorct.
Fix it and meanwhile do some code cleanups.

Fixes: 01d553d0fe9f90 ("Chardev checking of overlapping ranges")
Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Cc: stable@vger.kernel.org
---
 fs/char_dev.c | 94 ++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a279c58fe360..b25b1da097d5 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -88,86 +88,80 @@ static int find_dynamic_major(void)
 /*
  * Register a single major with a specified minor range.
  *
- * If major == 0 this functions will dynamically allocate a major and return
- * its number.
- *
- * If major > 0 this function will attempt to reserve the passed range of
- * minors and will return zero on success.
+ * If major == 0 this function will dynamically allocate an unused major,
+ * otherwise attempt to reserve the range of minors with given major.
  *
- * Returns a -ve errno on failure.
  */
 static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			   int minorct, const char *name)
 {
-	struct char_device_struct *cd, **cp;
-	int ret = 0;
+	struct char_device_struct *new, *curr, *prev = NULL;
+	int ret = -EBUSY;
 	int i;
 
-	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
-	if (cd == NULL)
+	if (major >= CHRDEV_MAJOR_MAX) {
+		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
+		       name, major, CHRDEV_MAJOR_MAX-1);
+		return  ERR_PTR(-EINVAL);
+	}
+
+	if (minorct > MINORMASK + 1 - baseminor) {
+		pr_err("CHRDEV \"%s\" minor range requested (%u-%u) is out of range of maximum range (%u-%u) for a single major\n",
+		       name, baseminor, baseminor + minorct - 1, 0, MINORMASK);
+		return ERR_PTR(-EINVAL);
+	}
+
+	new = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
+	if (new == NULL)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&chrdevs_lock);
 
 	if (major == 0) {
-		ret = find_dynamic_major();
-		if (ret < 0) {
+		major = find_dynamic_major();
+		if (major < 0) {
 			pr_err("CHRDEV \"%s\" dynamic allocation region is full\n",
 			       name);
 			goto out;
 		}
-		major = ret;
 	}
 
-	if (major >= CHRDEV_MAJOR_MAX) {
-		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
-		       name, major, CHRDEV_MAJOR_MAX-1);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	cd->major = major;
-	cd->baseminor = baseminor;
-	cd->minorct = minorct;
-	strlcpy(cd->name, name, sizeof(cd->name));
-
 	i = major_to_index(major);
+	for (curr = chrdevs[i]; curr; prev = curr, curr = curr->next) {
+		if (curr->major < major)
+			continue;
 
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major == major &&
-		     (((*cp)->baseminor >= baseminor) ||
-		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
+		if (curr->major > major)
 			break;
 
-	/* Check for overlapping minor ranges.  */
-	if (*cp && (*cp)->major == major) {
-		int old_min = (*cp)->baseminor;
-		int old_max = (*cp)->baseminor + (*cp)->minorct - 1;
-		int new_min = baseminor;
-		int new_max = baseminor + minorct - 1;
+		if (curr->baseminor + curr->minorct <= baseminor)
+			continue;
 
-		/* New driver overlaps from the left.  */
-		if (new_max >= old_min && new_max <= old_max) {
-			ret = -EBUSY;
-			goto out;
-		}
+		if (curr->baseminor >= baseminor + minorct)
+			break;
 
-		/* New driver overlaps from the right.  */
-		if (new_min <= old_max && new_min >= old_min) {
-			ret = -EBUSY;
-			goto out;
-		}
+		goto out;
+	}
+
+	new->major = major;
+	new->baseminor = baseminor;
+	new->minorct = minorct;
+	strlcpy(new->name, name, sizeof(new->name));
+
+	if (!prev) {
+		new->next = curr;
+		chrdevs[i] = new;
+	} else {
+		new->next = prev->next;
+		prev->next = new;
 	}
 
-	cd->next = *cp;
-	*cp = cd;
 	mutex_unlock(&chrdevs_lock);
-	return cd;
+	return new;
 out:
 	mutex_unlock(&chrdevs_lock);
-	kfree(cd);
+	kfree(new);
 	return ERR_PTR(ret);
 }
 
-- 
2.20.1

