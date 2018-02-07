Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2873564-1517975001-2-5656329200710914439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517975000; b=j8hrJ8VEF/ZaIqOeN8tb1VA5onamCTSeL3FwUgSicfO9jTm
    PcpPksw5GZAcpXwsL8cZS8DY5pFTRI6oZvj+qzJmybjFFNj50p8z4Fsqp0fR2wLL
    OR/15hsHwYGZdln7zh5pR/VFXM0ZpkhAiywDzKCakxwm1KRjYqQ5cS85INtk7bDp
    nNxINOhugdBqgn5f6a6lYBRujfCMp/ZTPn59qW3v/cjqbPAcz0ArcY/hYpZgoNJA
    4ohqQqqSJuAfzXHj64dT3Z8bP/0iOQPE3gnnWvcwARkFlnXOqg1gR688Iy7DVjlx
    4bD9ieX2qc9SIfnSDdDNerRbTJBACIm7BREyHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517975000; bh=Rv3qLWDPriNDsOuSAntRYn0nBt
    UQvDNXix+35uOb+aw=; b=aZukVhqHmx2F2oopQ5qBOb0M4WEdJkwShkqPI1gNx3
    /e/vCVrOw8A6TbMKzlr6zItG4hwuLuBIuq3i39uw4wyv39O+5AnLJ2wKanYGgPUJ
    Yas21TN7/1nauJzSArst3rQ7Uf1DaNJVQnFCFX73NwtPwKukbqL8PbhdI5XMfd+z
    W49AhqOh+piqs9QSH3+82WEOKekZ5GijRQWdLEU9dYt9vIzijZYLnvE9u9HQmKwX
    Qy+to87/wKZq+CvbMrHP/SAHe2vaXIEeIgYMjLSRDoNIa+IrpvxrtaqSN3pK5HgJ
    HaK8W9ncjDs+M6e3nBUkp7/qNvrBczBfOKPE/9Y0ECqQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeBGDnS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 22:43:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:24772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbeBGDnR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 22:43:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="202120806"
Subject: [PATCH] memremap: fix softlockup reports at teardown
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date: Tue, 06 Feb 2018 19:34:11 -0800
Message-ID: <151797445154.29778.16795392483399217682.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cond_resched() currently in the setup path needs to be duplicated in
the teardown path. Rather than require each instance of
for_each_device_pfn() to open code the same sequence, embed it in the
helper.

Link: https://github.com/intel/ixpdimm_sw/issues/11
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Fixes: 71389703839e ("mm, zone_device: Replace {get, put}_zone_device_page()...")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 4849be5f9b3c..4dd4274cabe2 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -275,8 +275,15 @@ static unsigned long pfn_end(struct dev_pagemap *pgmap)
 	return (res->start + resource_size(res)) >> PAGE_SHIFT;
 }
 
+static unsigned long pfn_next(unsigned long pfn)
+{
+	if (pfn % 1024 == 0)
+		cond_resched();
+	return pfn + 1;
+}
+
 #define for_each_device_pfn(pfn, map) \
-	for (pfn = pfn_first(map); pfn < pfn_end(map); pfn++)
+	for (pfn = pfn_first(map); pfn < pfn_end(map); pfn = pfn_next(pfn))
 
 static void devm_memremap_pages_release(void *data)
 {
@@ -337,10 +344,10 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	resource_size_t align_start, align_size, align_end;
 	struct vmem_altmap *altmap = pgmap->altmap_valid ?
 			&pgmap->altmap : NULL;
+	struct resource *res = &pgmap->res;
 	unsigned long pfn, pgoff, order;
 	pgprot_t pgprot = PAGE_KERNEL;
-	int error, nid, is_ram, i = 0;
-	struct resource *res = &pgmap->res;
+	int error, nid, is_ram;
 
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
@@ -409,8 +416,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		list_del(&page->lru);
 		page->pgmap = pgmap;
 		percpu_ref_get(pgmap->ref);
-		if (!(++i % 1024))
-			cond_resched();
 	}
 
 	devm_add_action(dev, devm_memremap_pages_release, pgmap);
