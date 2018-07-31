Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036BDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB5920841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB5920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGaQN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:13:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732303AbeGaQN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0104887A71;
        Tue, 31 Jul 2018 14:32:50 +0000 (UTC)
Received: from localhost (ovpn-117-103.ams2.redhat.com [10.36.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97170167FA;
        Tue, 31 Jul 2018 14:32:47 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] device-dax: avoid hang on error before devm_memremap_pages()
Date:   Tue, 31 Jul 2018 15:32:46 +0100
Message-Id: <20180731143246.16915-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 14:32:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 14:32:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'stefanha@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dax_pmem_percpu_exit() waits for dax_pmem_percpu_release() to invoke the
dax_pmem->cmp completion.  Unfortunately this approach to cleaning up
the percpu_ref only works after devm_memremap_pages() was successful.

If devm_add_action_or_reset() or devm_memremap_pages() fails,
dax_pmem_percpu_release() is not invoked.  Therefore
dax_pmem_percpu_exit() hangs waiting for the completion:

  rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
  				&dax_pmem->ref);
  if (rc)
  	return rc;

  dax_pmem->pgmap.ref = &dax_pmem->ref;
  addr = devm_memremap_pages(dev, &dax_pmem->pgmap);

Avoid the hang by calling percpu_ref_exit() in the error paths instead
of going through dax_pmem_percpu_exit().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Found by code inspection.  Compile-tested only.
---
 drivers/dax/pmem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index fd49b24fd6af..99e2aace8078 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -105,15 +105,19 @@ static int dax_pmem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
-							&dax_pmem->ref);
-	if (rc)
+	rc = devm_add_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+	if (rc) {
+		percpu_ref_exit(&dax_pmem->ref);
 		return rc;
+	}
 
 	dax_pmem->pgmap.ref = &dax_pmem->ref;
 	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
-	if (IS_ERR(addr))
+	if (IS_ERR(addr)) {
+		devm_remove_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+		percpu_ref_exit(&dax_pmem->ref);
 		return PTR_ERR(addr);
+	}
 
 	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
 							&dax_pmem->ref);
-- 
2.17.1

