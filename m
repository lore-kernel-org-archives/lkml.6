Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518788828-2-2954046488218840851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788828; b=XyruAV4T0XE93OV6NilkxVkoP7BmGinpCDI9dVlwostEn+j
    lRhGXkWun+mwlVi9i+30Y2FJu7khqUIRJXoSDdgHCgKQ3T8LgTiFWHWXm3n0xgJP
    VCmUXjnoPIFggDXC4QbdTaQXYIwiB3naZHBnfrJlFNb3fOieEz/JR0UUVid5DdHT
    hwH8bg/Zkxv2NErq0TWtAtlScgHg8jtn7/m3EWLWRH5EyMji8HPW/ygx0Q6ExKEx
    l4B3E1osCPu3Zm7hEtpZ7SujjyzyL6aiA9pHy1hx5xAL2yEpkfWW/O0I7Yk+jVDk
    TIgdZs+sj9a2wJRRUzcg/ML3LOHSv61D+p0ooAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518788828; bh=i+2Sk1wq56Blc/ECTjz1CS5dRu
    CZdeWNx+I/3MeIIVM=; b=RPeYKdfqjCzqm93Nns0eHAKlUEWsy0oXJqpAyHcbv3
    +pE4nFz/qmd0hqZ1cobFKdNklfbn+4Htt4QD5M9nhEX4HkWzE4vhxA3YEC25WwoQ
    RLL27XcIHEmyVyZXNkcINCCPIj2713XWMpSVk/64zORrxZL+W5FJivCH+E1CZ/Ul
    F6a963HCM+nkKdKSycd29QS8e/Ae66dt54S3GOL/1MglEsazkRZezROwtDb6idWM
    X2F5OGuFPS02TIaBAXT44bf3Y3PmoFyxS9msB0jPcySte2juAsYhVmzy3ICN8Cry
    y8nnTF7goHw9dTRzIFF8rvJ2RDIicM54S7l1EYx4FeYw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032118AbeBPNrH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:47:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031757AbeBPNrG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 08:47:06 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] mm: don't defer struct page initialization for Xen pv guests
Date: Fri, 16 Feb 2018 14:37:26 +0100
Message-Id: <20180216133726.30813-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
memory during allocation in vmemmap") broke Xen pv domains in some
configurations, as the "Pinned" information in struct page of early
page tables could get lost.

Avoid this problem by not deferring struct page initialization when
running as Xen pv guest.

Cc: <stable@vger.kernel.org> #4.15
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81e18ceef579..681d504b9a40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -347,6 +347,9 @@ static inline bool update_defer_init(pg_data_t *pgdat,
 	/* Always populate low zones for address-constrained allocations */
 	if (zone_end < pgdat_end_pfn(pgdat))
 		return true;
+	/* Xen PV domains need page structures early */
+	if (xen_pv_domain())
+		return true;
 	(*nr_initialised)++;
 	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
 	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
-- 
2.13.6
