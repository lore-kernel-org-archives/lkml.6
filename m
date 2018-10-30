Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368802064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368802064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJ3PDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeJ3PDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FCFB88306;
        Tue, 30 Oct 2018 06:10:58 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-177.pek2.redhat.com [10.72.12.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DD7F5C541;
        Tue, 30 Oct 2018 06:10:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH net] vhost: Fix Spectre V1 vulnerability
Date:   Tue, 30 Oct 2018 14:10:49 +0800
Message-Id: <20181030061049.7424-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 30 Oct 2018 06:10:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idx in vhost_vring_ioctl() was controlled by userspace, hence a
potential exploitation of the Spectre variant 1 vulnerability.

Fixing this by sanitizing idx before using it to index d->vqs.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f52008bb8df7..3a5f81a66d34 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -30,6 +30,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/nospec.h>
 
 #include "vhost.h"
 
@@ -1387,6 +1388,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	if (idx >= d->nvqs)
 		return -ENOBUFS;
 
+	idx = array_index_nospec(idx, d->nvqs);
 	vq = d->vqs[idx];
 
 	mutex_lock(&vq->mutex);
-- 
2.17.1

