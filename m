Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hi9jCVlEGVvBEwAAmS7hNA
	; Thu, 07 Jun 2018 14:46:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19092608BF; Thu,  7 Jun 2018 14:46:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89524607DC;
	Thu,  7 Jun 2018 14:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89524607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934815AbeFGOqR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:46:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40756 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934982AbeFGOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:46:11 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zl-66; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002ws-9y; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ganesh Mahendran" <opensource.ganesh@gmail.com>,
        "Todd Kjos" <tkjos@google.com>, "Martijn Coenen" <maco@android.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.932827222@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 168/410] android: binder: use VM_ALLOC to get vm area
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Mahendran <opensource.ganesh@gmail.com>

commit aac6830ec1cb681544212838911cdc57f2638216 upstream.

VM_IOREMAP is used to access hardware through a mechanism called
I/O mapped memory. Android binder is a IPC machanism which will
not access I/O memory.

And VM_IOREMAP has alignment requiement which may not needed in
binder.
    __get_vm_area_node()
    {
    ...
        if (flags & VM_IOREMAP)
            align = 1ul << clamp_t(int, fls_long(size),
               PAGE_SHIFT, IOREMAP_MAX_ORDER);
    ...
    }

This patch will save some kernel vm area, especially for 32bit os.

In 32bit OS, kernel vm area is only 240MB. We may got below
error when launching a app:

<3>[ 4482.440053] binder_alloc: binder_alloc_mmap_handler: 15728 8ce67000-8cf65000 get_vm_area failed -12
<3>[ 4483.218817] binder_alloc: binder_alloc_mmap_handler: 15745 8ce67000-8cf65000 get_vm_area failed -12

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
Acked-by: Martijn Coenen <maco@android.com>
Acked-by: Todd Kjos <tkjos@google.com>

----
V3: update comments
V2: update comments
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/binder.c
+++ b/drivers/staging/android/binder.c
@@ -2808,7 +2808,7 @@ static int binder_mmap(struct file *filp
 		goto err_already_mapped;
 	}
 
-	area = get_vm_area(vma->vm_end - vma->vm_start, VM_IOREMAP);
+	area = get_vm_area(vma->vm_end - vma->vm_start, VM_ALLOC);
 	if (area == NULL) {
 		ret = -ENOMEM;
 		failure_string = "get_vm_area";
