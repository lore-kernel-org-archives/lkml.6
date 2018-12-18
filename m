Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F092C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3634B214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVsc4cwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLRFZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:25:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeLRFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:25:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so6043831pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 21:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uR+1Mad3ePqamgRvJnhBY8fs8pQrwjsimufOcV25DB4=;
        b=gVsc4cwRTiG6jawVcT0uHj7euZN4xi1nU+GTZB3U5Vp32MGcga2PcJXZu2evYVlGVu
         J5kzzsAWNAAPxgVJqOq2Le+8lHrJLJb6W52hMX2JjZ6jLvW8/07AUaRxnMo0rK9aLTMD
         0rPtC1wcDyWs4xt25eqUgbmAEK5hMaTOEUNm3qv9wXKRdzYDk0a3RiNl7TuYjgM/cyXp
         sN5FaSbC7PvUczS/1qzQoKcADQYwVjgtKIkmiITBPtDTo3CxxXorzr+MX49Nf7heUbGm
         BY86OYUCN6IeZPveZatzpZw6GkY+alQj8oNhMMhJvOuNnSei00PREnsWLYVr+wZ/6WKS
         5Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uR+1Mad3ePqamgRvJnhBY8fs8pQrwjsimufOcV25DB4=;
        b=H+3uoKopHCeVdEso3VO/sy4KEid8YskrTvJ2ydJT+jnschJ7KOlvxg0mknRcHcfXJ0
         vKEVnh/fhGqpie4ryjXCpYQdAU8/nlTMclFueJ2WAg6jMHeSED/4L1hoYHrMnsG/QZqV
         CtSwrgGxABwFvmCBdEMNPDsaQmBf1aPLbk2VC9Ig1ZHiDefDcsmjqybACz9zL9gZ1DWm
         8q8vtubGii1EC10uWzlfNDCKVBcwlCdgyqBK7UrOJytQKLrYxeoyTS1l4jWZ69MIXoFl
         pDET1DgBSkr4mAP+dyov2f+4v6iqIb5heGuuMHH0DjKYBmOtTk+qYdnpAtOil8i57xKd
         uQ8w==
X-Gm-Message-State: AA+aEWa7eWcvPwgVW0D/CSiZl/ynABx5FxKjKp2lgE+PKEfEG4P9SgwQ
        Xv5asDxDemnGip8H3JOF6hw=
X-Google-Smtp-Source: AFSGD/XZU2UHRsa32MWuxWu+04sz5Ca6Mb533bdfy8HarMZuAmTRW6iwH3RKNzOUaYhk9538/OnZpA==
X-Received: by 2002:a65:6392:: with SMTP id h18mr14796188pgv.107.1545110713789;
        Mon, 17 Dec 2018 21:25:13 -0800 (PST)
Received: from VM_15_152_centos.localdomain ([193.112.178.48])
        by smtp.gmail.com with ESMTPSA id v9sm21767762pfe.49.2018.12.17.21.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 21:25:13 -0800 (PST)
From:   gchen.guomin@gmail.com
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, <guominchen@tencent.com>
Cc:     guomin chen <gchen.guomin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] Fix mm->owner point to a tsk that has been free
Date:   Tue, 18 Dec 2018 13:24:44 +0800
Message-Id: <1545110684-8730-1-git-send-email-gchen.guomin@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guomin chen <gchen.guomin@gmail.com>

When mm->owner is modified by exit_mm, if the new owner directly calls
unuse_mm to exit, it will cause Use-After-Free. Due to the unuse_mm()
directly sets tsk->mm=NULL.

 Under normal circumstances,When do_exit exits, mm->owner will
 be updated on exit_mm(). but when the kernel process calls
 unuse_mm() and then exits,mm->owner cannot be updated. And it
 will point to a task that has been released.

The current issue flow is as follows: (Process A,B,C use the same mm)
Process C              Process A         Process B
qemu-system-x86_64:     kernel:vhost_net  kernel: vhost_net
open /dev/vhost-net
  VHOST_SET_OWNER   create kthread vhost-%d  create kthread vhost-%d
  network init           use_mm()          use_mm()
   ...                   ...
   Abnormal exited
   ...
  do_exit
  exit_mm()
  update mm->owner to A
  exit_files()
   close_files()
   kthread_should_stop() unuse_mm()
    Stop Process A       tsk->mm=NULL
                         do_exit()
                         can't update owner
                         A exit completed  vhost-%d  rcv first package
                                           vhost-%d build rcv buffer for vq
                                           page fault
                                           access mm & mm->owner
                                           NOW,mm->owner still pointer A
                                           kernel UAF
    stop Process B

Although I am having this issue on vhost_net,But it affects all users of
unuse_mm.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: guomin chen <gchen.guomin@gmail.com>
---
 mm/mmu_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index 3e612ae..9eb81aa 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -60,5 +60,6 @@ void unuse_mm(struct mm_struct *mm)
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	task_unlock(tsk);
+	mm_update_next_owner(mm);
 }
 EXPORT_SYMBOL_GPL(unuse_mm);
-- 
1.8.3.1

