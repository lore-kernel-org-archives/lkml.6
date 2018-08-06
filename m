Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A29DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78721A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E78721A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbeHFSDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:03:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732396AbeHFSDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E76A7C6CA;
        Mon,  6 Aug 2018 15:54:09 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-134.ams2.redhat.com [10.36.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 009552026D76;
        Mon,  6 Aug 2018 15:54:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390x/mm: avoid taking the table lock in gmap_pmd_op_walk()
Date:   Mon,  6 Aug 2018 17:54:07 +0200
Message-Id: <20180806155407.15252-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 15:54:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 15:54:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we temporarily take the page table lock in gmap_pmd_op_walk()
even though we know we won't need it (if we can never have 1mb pages
mapped into the gmap).

So let's special case this, so
gmap_protect_range()/gmap_sync_dirty_log_pmd() will not take the lock in
case huge pages are not allowed.

gmap_protect_range() is called quite frequently for managing shadow
page tables in vSIE environments.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bb44990c8212..d4fa0a4514e0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -905,10 +905,16 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
 	pmd_t *pmdp;
 
 	BUG_ON(gmap_is_shadow(gmap));
-	spin_lock(&gmap->guest_table_lock);
 	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
+	if (!pmdp)
+		return NULL;
 
-	if (!pmdp || pmd_none(*pmdp)) {
+	/* without huge pages, there is no need to take the table lock */
+	if (!gmap->mm->context.allow_gmap_hpage_1m)
+		return pmd_none(*pmdp) ? NULL : pmdp;
+
+	spin_lock(&gmap->guest_table_lock);
+	if (pmd_none(*pmdp)) {
 		spin_unlock(&gmap->guest_table_lock);
 		return NULL;
 	}
-- 
2.17.1

