Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519908536-2-13397509292787535485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519908535; b=LUliqGdmL63HyBTLCRGDV2CBr2T+2P60cDgRkQhS4DyfgpV
    piK2DHJ9N9zz0HH5FXUM8E9SbGkii4MfwdISqX4Jb0N9Klfadupgkd/Dh9qS63OM
    DqN8zpBosMwJ5wf+Mkqi47rfbAGkGJje+nXcaCqnGY9C/AN26kjI/vYaVHApE6dA
    W6kkffKqstvvPVa0SrfFl4tHouh7wvLMGHVClEH1G7vcldu18Uh4Cgr6J0dFURxJ
    3tQhiUr+6DuO4Z9ifpqzNeRD4zKHi+Z1jzFZ6LrP7oJDEu636g3zoYKCPssQho2O
    nGqmaihQ6kUFrG2OgJIGGE5ARpCFoSbQjdVip2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519908535; bh=jSrjkyWZAp067yqj6RfzXfag4n
    hzvG7DS6py7o2dDP0=; b=aQAgD52x9OKcaIvCmxLjFkMk1Wd/YVIm3hxE7qBbUr
    pwwVX0wakRWoiHASoS6HjGfmSKnMZTyhyWstoeQIKqR6tLQgy14FeQcjPPX756fk
    Ef1VIJLpN4qVyYM6860p4lmN/9g6yDlyBWP0Xe5qQVR31nocN+f+aHSYTMKvic6P
    G+HJg+uG9LnDI7AqsAk1YhAJqj/iVRtwzEiDzfN8OORbr9AnMy8CsPR6YwGyk0G2
    30G1HAe3cjV1g6EDsGLkYyUjpeqYriRYlph3OISW+/ffxXqdHCwCvRlGUR72CTz1
    VxsFnx24504D4x0fIl/zY84nIMuAvBxAalSDZTy4i+fg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030482AbeCAMsy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:48:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030347AbeCAMsx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 07:48:53 -0500
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
Date: Thu,  1 Mar 2018 13:47:45 +0100
Message-Id: <1519908465-12328-1-git-send-email-neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In move_freepages() a BUG_ON() can be triggered on uninitialized page structures
due to pageblock alignment. Aligning the skipped pfns in memmap_init_zone() the
same way as in move_freepages_block() simply fixes those crashes.

Fixes: b92df1de5d28 ("[mm] page_alloc: skip over regions of invalid pfns where possible")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/page_alloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb416723538f..9edee36e6a74 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5359,9 +5359,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop.
+			 * on our next iteration of the loop. Note that it needs
+			 * to be pageblock aligned even when the region itself
+			 * is not as move_freepages_block() can shift ahead of
+			 * the valid region but still depends on correct page
+			 * metadata.
 			 */
-			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
+			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
+						~(pageblock_nr_pages-1)) - 1;
 #endif
 			continue;
 		}
-- 
2.16.2
