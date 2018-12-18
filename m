Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97112C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689F520874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apLdu4pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLRDmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41155 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeLRDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so5500071pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EBLJuRkvQ/Pwt45A7nDM2kgkrAB273lzj/6f3w11E50=;
        b=apLdu4pj07YFFvQS7R7Tgm+SqNnchAQECQYeZUrbvC0N4flvQa1L2mROSUNf+RDdjZ
         D2XaVupfQ7scqjAxlpH7KVnDM/Av7Q/t7JydtwqLyWISmLEE8M94wJulQDpItxXJymfa
         OiSHBz6oz2k97FjHJ6gIQWj94lTSTt/MO9BE0aIvJ5gTv0DqX0UrhgWnESGmhBX0vPGW
         lJAdXukcQL/IjM9IZg8eZQa81NwSD6LS4KW4rZjLwIqRsJW+tMtVDEIKS3QhDhZUjKbw
         CxMoBy6/ktklzkE7uYEexWQPWAe2ETEkZzT3Tn+iQ+l74L4USliw+QpnGIyisewnoB3j
         Uhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EBLJuRkvQ/Pwt45A7nDM2kgkrAB273lzj/6f3w11E50=;
        b=WTdkWxo0s2kJd7g+LBl7VchXLkBoJ4QuMqN4vsOGAb2Zu5+aWaRy/l50vaqcV8Scl7
         +MuFQRqbWOrewPTGdDkTRIpp5SRugO4Q+j5mhHkT/VHv+pq/2JzroGFZjd3W53xIbdvr
         EDqgUMFI1QHr0zKqAtA1l1+MuCfaJe+emC1zK2h9a6lhl4A1iXv6rfT9+tnkscH3AcZt
         EEvryVf7AxLI5L+NbVFPXSeES3Y/V1kjm872Lk5jp99gDylWJ1bSw0ci4VQufUHlf3By
         EJpw/NhhFi1c8nxQuXJGg0wEt9c1uY7Wu4uD9oF4e9n2wk1O5XvnhrfLkZogX28g0tno
         E46g==
X-Gm-Message-State: AA+aEWZbwG20MmQgTYVZN5kFEu36392I1k0zSR3UqeSb7CUNkkBUupVW
        L4GwttgmxZYAtQjsKnQm0g0=
X-Google-Smtp-Source: AFSGD/W14YNU7ZZk+izwGu8cXHEuzBL+lHrdEMz5Qp7EWkUYTrzxOKrTy27YHSpCGtQkmYm6SMDdkQ==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr14380839pge.327.1545104568615;
        Mon, 17 Dec 2018 19:42:48 -0800 (PST)
Received: from VM_15_152_centos.localdomain ([193.112.178.48])
        by smtp.gmail.com with ESMTPSA id h79sm25283306pfj.186.2018.12.17.19.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:48 -0800 (PST)
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
Subject: [PATCH] Export mm_update_next_owner function for unuse_mm.
Date:   Tue, 18 Dec 2018 11:42:11 +0800
Message-Id: <1545104531-30658-1-git-send-email-gchen.guomin@gmail.com>
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

The current issue flow is as follows:
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
 kernel/exit.c    | 1 +
 mm/mmu_context.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d..9e046dd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -486,6 +486,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	task_unlock(c);
 	put_task_struct(c);
 }
+EXPORT_SYMBOL(mm_update_next_owner);
 #endif /* CONFIG_MEMCG */
 
 /*
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

