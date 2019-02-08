Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48371C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1245E21929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663586;
	bh=LlL9qNuXyhnhjO0/gkCHpEfYioNA3elYCVyeib5vitg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=h7JxwmnIIYeSDKck0bi1u0AhsAsParIyzvsMuh506PjTIxNX/Cuu+uoBTr5H395Yr
	 aT4b2uaLvmPUYCioU93ju+EuC3DrukUvrixNYYqYYoAdllxPH0gUn95Qs+s9Y0/fY8
	 98YZyQW8wb4L8eb5m0pD4B6Pw+ZJ30LjgY3NdZXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBHWGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfBHWGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:06:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC9121908;
        Fri,  8 Feb 2019 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663583;
        bh=LlL9qNuXyhnhjO0/gkCHpEfYioNA3elYCVyeib5vitg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HXSw8Z5g6syIwOd1uQoVKHcl+kHFdi69fOM/ahm+ELlf0jCja7LNfU/7ZoK8i9mX6
         fGlMkTKi0JJVoLWPorUkb78PstOghkXahKsehO4ZEgQXJz/3kIMT45fm+Rd+s7fUJ9
         nQzxf19J8DevkJwez91gZnP2A780Wj98NK48pSus=
Subject: [PATCH v1 6/7] iommu/vt-d: Remove misleading "domain 0" test from
 domain_exit()
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:06:22 -0600
Message-ID: <154966358199.132359.6085600915087301558.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The "Domain 0 is reserved, so dont process it" comment suggests that a NULL
pointer corresponds to domain 0.  I don't think that's true, and in any
case, every caller supplies a non-NULL domain pointer that has already been
dereferenced, so the test is unnecessary.

Remove the test for a null "domain" pointer.  No functional change
intended.

This null pointer check was added by 5e98c4b1d6e8 ("Allocation and free
functions of virtual machine domain").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6e9f277bfd6d..b0860a8c48d4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1903,10 +1903,6 @@ static void domain_exit(struct dmar_domain *domain)
 {
 	struct page *freelist;
 
-	/* Domain 0 is reserved, so dont process it */
-	if (!domain)
-		return;
-
 	/* Remove associated devices and clear attached or cached domains */
 	rcu_read_lock();
 	domain_remove_dev_info(domain);

