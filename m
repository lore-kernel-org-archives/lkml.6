Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B8FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6320831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 07:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIey4V7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLIHVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 02:21:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44593 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLIHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 02:21:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so3524660pgr.11;
        Sat, 08 Dec 2018 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ONkZ9i+vSVBwiKv0jCSx2lBpiXozUtvPXgShMmZkvZE=;
        b=SIey4V7DZEVEzGD8JerF+CaPVC26cyP/HPBc7f7nqRUzKE6UI7S7QLnQkggx19NmQa
         Ig7ZsORmTeXQc3bfEe1OThH4VWlJw0vQ94nEiA6DZLp50xjlj3u/0czyJtbl3/uMqukx
         3hwCVo2qmVgMBjj+d5eCL4Nu/8O5oAYZApQF6LkwRG8R1u9TPSavHDCxIjUzsVfA4+Dq
         +xRIaGBYnMj+iiYH4e53BkXlRYkCNJn8J+bxIJS8SN/nRXwuNcgJlh7ISwF5H0+iFE5S
         oEpr3gQ0FX7l8UBra266bu1JJ/v/WdrQeNbJoU/2OjWhue43XwVg6b1qAa/yspR5MUQu
         phYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ONkZ9i+vSVBwiKv0jCSx2lBpiXozUtvPXgShMmZkvZE=;
        b=YhcbDeo2OiRKmeg3cuD78wCoOLihJqpsEV9Vb69mbnWa0UbBYJNMSHCkadtbXMksDB
         ZpXjkj4YW4AHC2keCqad5puMi4Xknfzig+6hWsJT2+2hCJ1/FwlKvWlK1bQy5SrNolmk
         kslFd3+guCK6DRnMXrqhEwKW3sXpLFBbgvO9pqR/Y+9FUbABXy9LaxVKhS7vCOUpy8S/
         ZVIgsIHMteBQEInsQ03FGo8Ig2rknFYvztBkUDE0TBav/k5ZXfvf2KA6XE3IGUeXFYLD
         0bkDVGnA4paZwcl2XcGBqq8KoZEGny/RS34/R/qCn8tN8FTW9hljBBM/bYpiYPRVwP/N
         k+6A==
X-Gm-Message-State: AA+aEWbNKJJYv3JSqvfv1KEjWP9k7b0yWbl/UYSZr/jtirUIq4pPZRQo
        M8z5Wsmh22g4WrQ39iI5igc=
X-Google-Smtp-Source: AFSGD/UeG1S+spJZwpsO7uTIMmtFllcxMzQuBh73tHi/xSlPgrOaMhWIO6j9HLnMvUp8Z8Atp1DtXQ==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr6948431pgf.402.1544340102774;
        Sat, 08 Dec 2018 23:21:42 -0800 (PST)
Received: from VM_15_152_centos.localdomain ([193.112.178.48])
        by smtp.gmail.com with ESMTPSA id v9sm11425173pfg.144.2018.12.08.23.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 23:21:42 -0800 (PST)
From:   gchen.guomin@gmail.com
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     guominchen <guominchen@tencent.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH]  Fix mm->owner point to a task that does not exists
Date:   Sun,  9 Dec 2018 15:21:17 +0800
Message-Id: <1544340077-11491-1-git-send-email-gchen.guomin@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guominchen <guominchen@tencent.com>

  Under normal circumstances,When do_exit exits, mm->owner will
  be updated, but when the kernel process calls unuse_mm and exits,
  mm->owner cannot be updated. And will point to a task that has
  been released.

  Below is my issue on vhost_net:
    A, B are two kernel processes(such as vhost_worker),
    C is a user space process(such as qemu), and all
    three use the mm of the user process C.
    Now, because user process C exits abnormally, the owner of this
    mm becomes A. When A calls unuse_mm and exits, this mm->ower
    still points to the A that has been released.
    When B accesses this mm->owner again, A has been released.

  Process A		Process B
 vhost_worker()	       vhost_worker()
  ---------    		---------
  use_mm()		use_mm()
   ...
  unuse_mm()
     tsk->mm=NULL
   do_exit()     	page fault
    exit_mm()	 	access mm->owner
   can't update owner	kernel Oops

			unuse_mm()

Cc: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: <netdev@vger.kernel.org>
Signed-off-by: guominchen <guominchen@tencent.com>
---
 mm/mmu_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index 3e612ae..185bb23 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -56,7 +56,6 @@ void unuse_mm(struct mm_struct *mm)
 
 	task_lock(tsk);
 	sync_mm_rss(mm);
-	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	task_unlock(tsk);
-- 
1.8.3.1

