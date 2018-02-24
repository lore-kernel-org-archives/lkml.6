Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-117529-1519433676-3-16710632783518556298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519433675; b=mrRWw2cmXJ38GMoHVVYTD9p4utQCwNe5+8TvRNLwzWlQpJ8
    VzjPqL6Xuii0fJ5Oi2NiWogk+hnrmz9iTcisoe118/blCOO/fQs4teywIztiz753
    vMl/ZW/6m+QnlcV/7py1YqYXAAgAx5cKhadz/CQeAgLfu7PJu5UaNMQkFl/R5C9c
    qw4x/Ubcvg2ymmabpKJt4fCsZIWiMNSxPbpjbi/M1i58y46MFfJYLbcc3cWybtUj
    y9Va+hj+y4uEH25IBVxpJb1H0NTGHlOEmVLGaV9/2hyH6dH7G54PJjKd1PqnqvDl
    RYD84GpHXSGHe50AD+uS8pjIXrGaVgdkifK2Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519433675; bh=BUAE02TQ6dMzHs3KQdpr8yjPWLMwH9hJfo/o7usjS8I=; b=A
    Y2w9cyMc2QQXeRmZvnf7oXBS3zl17Xr7GL3G/Cy06IZSg+So2pMZ2Ki0/+7uDypn
    zuJHn8QGVbpofPTFrPx9Qi8sA2V8/rAI5r2I63Sp51krkIgob/u/U3tefaOcNylA
    3ze1qO1rid+I8DBDJ9CCKm1SZsNdD2ENhvhFjLxe/0/aemwK33LK3i/19x+DOfOl
    BhwS81QHsxifvT+JTCnl7KjfyCnDnPwDozz0ezsIGSho+aDqcN9neYPoS7qoiO9u
    UXnmFS9/VEo22MFbHJOxRuML79V8C8Jmc8uuKdv3bc4UohrDD0upTBfw0ptEJTAq
    PY1e8AAwOx1zJHSZ0QaaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeBXAw3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:52:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:21662 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeBXAw2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="203347021"
Subject: [PATCH v3 2/6] dax: fix dax_mapping() definition in the FS_DAX=n +
 DEV_DAX=y case
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Date: Fri, 23 Feb 2018 16:43:22 -0800
Message-ID: <151943300200.29249.14072486041472340237.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An address_space will only have dax exceptional entries when FS_DAX is
enabled. The current reliance on S_DAX causes compile failures when
S_DAX is defined for DEV_DAX, but FS_DAX is disabled. Make dax_mapping()
always return false so that mm/truncate.c drops its link time
dependencies on fs/dax.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/dax.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0185ecdae135..62e8cf7eb566 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -107,6 +107,10 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int length);
+static inline bool dax_mapping(struct address_space *mapping)
+{
+	return mapping->host && IS_DAX(mapping->host);
+}
 #else
 static inline int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
@@ -114,12 +118,11 @@ static inline int __dax_zero_page_range(struct block_device *bdev,
 {
 	return -ENXIO;
 }
-#endif
-
 static inline bool dax_mapping(struct address_space *mapping)
 {
-	return mapping->host && IS_DAX(mapping->host);
+	return false;
 }
+#endif
 
 struct writeback_control;
 int dax_writeback_mapping_range(struct address_space *mapping,
