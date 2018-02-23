Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022886-1519424154-2-3027737197799476668
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519424153; b=GZpdWv/W8Bdi8nZa/gVhcrC4S9GoG+/9Tt8OpzjRJW62OQM
    yCaCJEln6fafu/o5z2mxoa+q116Dj6c5v9TIAu9huL3a9U45upDtHYmwUlBzmWdW
    hIZiLHMG+kapwZGrHkLscYD8GcUxh6kQI6IGc14ofux7SBZjMOpUprAybxQ9PfUH
    zQqbVGvi6ziIwqpxcY7KyjO0MFR1OD0dTnYUYihPGf13uQnwE8kc4s6m9/HmIHRF
    F7dkXH+qm06wPqOYZjV5eh9KemzFJZOep1rWwr1fWLWhpK/b6fGQ97eZloZ0TduK
    bcgk6Vz1aFb1xBZCtVzrPUlm4rsYB4nZk8kbgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519424153; bh=jLodIIEuLpGQK784/PSrqHHb0cRI/zolUEnbR6hrFFs=; b=f
    mPHy6g8N98vx2mDrdRlXvGP9o/a8HT+gSLeoubeDpUbnBATZvyn3go7RJ0Clcy++
    lm5LgRqKeNLrIrsmQZuGnlNtLLkmZfkrjS25cWmVdym7OLi4jkIYQrt8coIYPifb
    5uByuD7EIfJ8hiPWQoH0vELAHbRubTr4jl7YAFkB0DLh6QCgi28ApMOubkP3eK1o
    JWXldIjlk2pJ+QNyyZu9/BkkKst927NRBSak0ywGkXFmx51gM97ODeadJlTFoCmb
    SwULe+KkYygx5jzJx5/InOJ2kZYWzhzhB5O4NOVZGL1eLu7kNodzbmBYTJSr6Whi
    5+PMMdfp9H8tO+owq5g2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeBWWPX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:15:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:39862 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbeBWWPW (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:15:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="33686844"
Subject: [4.9-stable PATCH 10/11] mm: fail get_vaddr_frames() for
 filesystem-dax mappings
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jan Kara <jack@suse.cz>, Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-kernel@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Inki Dae <inki.dae@samsung.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Feb 2018 14:06:16 -0800
Message-ID: <151942357601.21775.3085470269801679738.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit b7f0554a56f21fb3e636a627450a9add030889be upstream.

Until there is a solution to the dma-to-dax vs truncate problem it is
not safe to allow V4L2, Exynos, and other frame vector users to create
long standing / irrevocable memory registrations against filesytem-dax
vmas.

[dan.j.williams@intel.com: add comment for vma_is_fsdax() check in get_vaddr_frames(), per Jan]
  Link: http://lkml.kernel.org/r/151197874035.26211.4061781453123083667.stgit@dwillia2-desk3.amr.corp.intel.com
Link: http://lkml.kernel.org/r/151068939985.7446.15684639617389154187.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/frame_vector.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index db77dcb38afd..375a103d7a56 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -52,6 +52,18 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 		ret = -EFAULT;
 		goto out;
 	}
+
+	/*
+	 * While get_vaddr_frames() could be used for transient (kernel
+	 * controlled lifetime) pinning of memory pages all current
+	 * users establish long term (userspace controlled lifetime)
+	 * page pinning. Treat get_vaddr_frames() like
+	 * get_user_pages_longterm() and disallow it for filesystem-dax
+	 * mappings.
+	 */
+	if (vma_is_fsdax(vma))
+		return -EOPNOTSUPP;
+
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref = true;
 		vec->is_pfns = false;
