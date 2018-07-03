Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B5BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214D321ADE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214D321ADE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeGCFiz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:38:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932732AbeGCFit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C7FC40267A1;
        Tue,  3 Jul 2018 05:38:49 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 050DF1117624;
        Tue,  3 Jul 2018 05:38:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wexu@redhat.com, tiwei.bie@intel.com, maxime.coquelin@redhat.com,
        jfreimann@redhat.com
Subject: [PATCH net-next 5/8] vhost: vhost_put_user() can accept metadata type
Date:   Tue,  3 Jul 2018 13:38:01 +0800
Message-Id: <1530596284-4101-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 05:38:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 05:38:49 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assumes used ring update is the only user for vhost_put_user() in
the past. This may not be the case for the incoming packed ring which
may update the descriptor ring for used. So introduce a new type
parameter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index af15bec..060a431 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -814,7 +814,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
+#define vhost_put_user(vq, x, ptr, type)		\
 ({ \
 	int ret = -EFAULT; \
 	if (!vq->iotlb) { \
@@ -822,7 +822,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	} else { \
 		__typeof__(ptr) to = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
+					  sizeof(*ptr), type); \
 		if (to != NULL) \
 			ret = __put_user(x, to); \
 		else \
@@ -1687,7 +1687,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 {
 	void __user *used;
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
-			   &vq->used->flags) < 0)
+			   &vq->used->flags, VHOST_ADDR_USED) < 0)
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
@@ -1706,7 +1706,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
-			   vhost_avail_event(vq)))
+			   vhost_avail_event(vq), VHOST_ADDR_USED))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		void __user *used;
@@ -2189,12 +2189,12 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	used = vq->used->ring + start;
 	for (i = 0; i < count; i++) {
 		if (unlikely(vhost_put_user(vq, heads[i].elem.id,
-					    &used[i].id))) {
+					    &used[i].id, VHOST_ADDR_USED))) {
 			vq_err(vq, "Failed to write used id");
 			return -EFAULT;
 		}
 		if (unlikely(vhost_put_user(vq, heads[i].elem.len,
-					    &used[i].len))) {
+					    &used[i].len, VHOST_ADDR_USED))) {
 			vq_err(vq, "Failed to write used len");
 			return -EFAULT;
 		}
@@ -2240,7 +2240,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
-			   &vq->used->idx)) {
+			   &vq->used->idx, VHOST_ADDR_USED)) {
 		vq_err(vq, "Failed to increment used idx");
 		return -EFAULT;
 	}
-- 
2.7.4

