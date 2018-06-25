Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6925B59
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnDj2h3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C6925B59
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934314AbeFYOZy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:25:54 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:40777 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbeFYOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:25:52 -0400
Received: by mail-vk0-f73.google.com with SMTP id y200-v6so6260748vky.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=BhDO8aPbef7UNHAyRB6gCF+msDGCfhuBkb/kmk1wzCc=;
        b=ZnDj2h3sW7fg8M9ME55S56Egez2ZVlY4wFHKZqJbSOZ2xxeKMzefqrfyif6OxokpqW
         d1j9k/beIL8kYgnav25hrQl+0cyQgyph584vziICnVWh7eBT/rHz7CuB9huCl4CTu0lx
         PitUkFUvHuCt6/HIlfo5806k4Ngewzemm4a6QxcnhdVU33rQTYWmpQuXyoqblTAgep5f
         aiOApP3TQeRviCZruoVVkbtQAr0V4wtANtfQR+sYy3+IyxaxJZ0ssLyXYkfciGW4orJY
         KUKE3fvrrKeNWaYISM211CvxjWCTe4SKMxtKzhn/Y8l7+NVCk+PsPq58OiSl+TCfLcI0
         ak0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=BhDO8aPbef7UNHAyRB6gCF+msDGCfhuBkb/kmk1wzCc=;
        b=RtrlHo6bX4vi+L95DP9XnC5s4Z2WFVjauORLmRaunCFUlQUE9WDGkEKfGpT6jm3n7b
         mNfvqWPOPCWy99vn/Anxr3h0PwfzGfA/pG0U/05UmGmiolJuJwvxIU7ZC8A+2Ed0aIoO
         eJGoEu1Fz8X7kZHhyU41Rx/GIzf8suwHA4PQJNN3Oq3DwgO1jD+G+aBIqwo0wEcfrIOS
         9hBE4XBEKAu4WzYj4pusPRLUWtsTjTKdeOagZ/FaYx2sdssqrTheSav/seTdE1rH+k9g
         OcFtgGTdIkvqSQfb9sgAW0ROC/6cpE4JfYKvMWmFOI5N8eN0B3h6/Wb7+Gkor9A5Qvlk
         PrPg==
X-Gm-Message-State: APt69E0wNuc3achB070cXyp3p39GkIsquBb+1Wd3sFIHOx5SBNAkqj2+
        fksT4tte/kKxljZjJ9Nf1XcGeDishQ==
X-Google-Smtp-Source: ADUXVKKApkXBCVPMc5TC/w6BluVGRVPkjnY70krHfg/C3jNf/yzh+7N7Id5lHPCqq3O7Qz1fazWK3p2QBw==
MIME-Version: 1.0
X-Received: by 2002:a1f:bac1:: with SMTP id k184-v6mr5821524vkf.40.1529936749025;
 Mon, 25 Jun 2018 07:25:49 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:25:44 +0200
Message-Id: <20180625142544.182673-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3] sg: mitigate read/write abuse
From:   Jann Horn <jannh@google.com>
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jannh@google.com
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        kernel-hardening@lists.openwall.com, security@kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
to be called under KERNEL_DS"), sg improperly accesses userspace memory
outside the provided buffer, permitting kernel memory corruption via
splice().
But it doesn't just do it on ->write(), also on ->read().

As a band-aid, make sure that the ->read() and ->write() handlers can not
be called in weird contexts (kernel context or credentials different from
file opener), like for ib_safe_file_access().

If someone needs to use these interfaces from different security contexts,
a new interface should be written that goes through the ->ioctl() handler.

I've mostly copypasted ib_safe_file_access() over as sg_safe_file_access()
because I couldn't find a good common header - please tell me if you know a
better way.

changed in v2:
 - remove the bsg parts per Christoph Hellwig's request

changed in v3:
 - move error messages into helper function
 - use two different error messages and return values (Douglas Gilbert)
 - add comment on stranded responses (Douglas Gilbert)
 - use current_real_cred() instead of current_cred() (so that
   override_creds() can't bypass this check)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/scsi/sg.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 53ae52dbff84..4f4e88ca8213 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -51,6 +51,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
+#include <linux/cred.h> /* for sg_safe_file_access() */
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -209,6 +210,33 @@ static void sg_device_destroy(struct kref *kref);
 	sdev_prefix_printk(prefix, (sdp)->device,		\
 			   (sdp)->disk->disk_name, fmt, ##a)
 
+/*
+ * The SCSI interfaces that use read() and write() as an asynchronous variant of
+ * ioctl(..., SG_IO, ...) are fundamentally unsafe, since there are lots of ways
+ * to trigger read() and write() calls from various contexts with elevated
+ * privileges. This can lead to kernel memory corruption (e.g. if these
+ * interfaces are called through splice()) and privilege escalation inside
+ * userspace (e.g. if a process with access to such a device passes a file
+ * descriptor to a SUID binary as stdin/stdout/stderr).
+ *
+ * This function provides protection for the legacy API by restricting the
+ * calling context.
+ */
+static int sg_check_file_access(struct file *filp, const char *caller)
+{
+	if (filp->f_cred != current_real_cred()) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			caller, task_tgid_vnr(current), current->comm);
+		return -EPERM;
+	}
+	if (uaccess_kernel()) {
+		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
+			caller, task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+	return 0;
+}
+
 static int sg_allow_access(struct file *filp, unsigned char *cmd)
 {
 	struct sg_fd *sfp = filp->private_data;
@@ -393,6 +421,14 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	struct sg_header *old_hdr = NULL;
 	int retval = 0;
 
+	/*
+	 * This could cause a response to be stranded. Close the associated
+	 * file descriptor to free up any resources being held.
+	 */
+	retval = sg_check_file_access(filp, __func__);
+	if (retval)
+		return retval;
+
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
@@ -580,9 +616,11 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	struct sg_header old_hdr;
 	sg_io_hdr_t *hp;
 	unsigned char cmnd[SG_MAX_CDB_SIZE];
+	int retval;
 
-	if (unlikely(uaccess_kernel()))
-		return -EINVAL;
+	retval = sg_check_file_access(filp, __func__);
+	if (retval)
+		return retval;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
-- 
2.18.0.rc2.346.g013aa6912e-goog

