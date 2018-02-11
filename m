Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326044-2-11917175494373673356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326043; b=f3m+ayHLXB3IGXO0uVp0Ey8Gls57IYIaVaUEI5iDTHulIt5
    zyylXP2k0udTgwcSFBPsGnxNDwjqNNtxg7GwrwZVbnqaK+GswcbsCXY9Ti2e7R6x
    tudcrYQvtqwNyb1ew7jMAOYKqWPkl1Z7wiuU4AQcIkf2TN23iutSdFdYz5rKxONI
    AZ2fplrv2P3AhK8PMrfF92ZHHIZonUDxYUDLctENQuctBDiR/I7IsYII8q1K8MEK
    fJLFAAkJanSWnExIV5i7iq8IJsj16ynn2c8jpV3xShSwt1kJWiCsbxq86Hticd4j
    2343CySqw2Moys4iTA0O/dcnZcrwkWLwrHJBFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326043; bh=IOYUKknV4qoEEdbitFH
    NwXufHch8IEjWKcEnQlkOG+0=; b=bjiOmwc2UBn0smzuYwYupzJ2zZpe3zgmvIS
    FYg6wGr3dVfRllAZhWennZw9aQBPz+bIlGY2qk58JRxNOidtLIBiw4QXMhEswdUv
    xTomqVXex3Q6aLCljPuuZPGVjdP3jMoHtaKL6mMtqGkEo6jydjXusalu9bCFpZ78
    VjZtqBKGkyZ6CV1BnCgEMC5xxhcMLl0jg2miap4ZcVAckM724w8QBheXQ4WY2BB/
    AD07yxqUqtUAxWPVN5hRpoRvSeFi4+TBmYEFdSNW/X243kTz5fRVI8ChZT4afSae
    twCHFDGjbKbEmxRBq926oVRlh2ix43LkA4A32217iHHkmtmd2aw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBKFMZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41421 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752638AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.575409571@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 45/79] dm bufio: fix integer overflow when limiting
 maximum cache size
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 74d4108d9e681dbbe4a2940ed8fdff1f6868184c upstream.

The default max_cache_size_bytes for dm-bufio is meant to be the lesser
of 25% of the size of the vmalloc area and 2% of the size of lowmem.
However, on 32-bit systems the intermediate result in the expression

    (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100

overflows, causing the wrong result to be computed.  For example, on a
32-bit system where the vmalloc area is 520093696 bytes, the result is
1174405 rather than the expected 130023424, which makes the maximum
cache size much too small (far less than 2% of lowmem).  This causes
severe performance problems for dm-verity users on affected systems.

Fix this by using mult_frac() to correctly multiply by a percentage.  Do
this for all places in dm-bufio that multiply by a percentage.  Also
replace (VMALLOC_END - VMALLOC_START) with VMALLOC_TOTAL, which contrary
to the comment is now defined in include/linux/vmalloc.h.

Depends-on: 9993bc635 ("sched/x86: Fix overflow in cyc2ns_offset")
Fixes: 95d402f057f2 ("dm: add bufio")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[bwh: Backported to 3.2: keep open-coded VMALLOC_TOTAL]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-bufio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -839,7 +839,8 @@ static void __get_memory_limit(struct dm
 		buffers = DM_BUFIO_MIN_BUFFERS;
 
 	*limit_buffers = buffers;
-	*threshold_buffers = buffers * DM_BUFIO_WRITEBACK_PERCENT / 100;
+	*threshold_buffers = mult_frac(buffers,
+				       DM_BUFIO_WRITEBACK_PERCENT, 100);
 }
 
 /*
@@ -1620,19 +1621,15 @@ static int __init dm_bufio_init(void)
 	memset(&dm_bufio_caches, 0, sizeof dm_bufio_caches);
 	memset(&dm_bufio_cache_names, 0, sizeof dm_bufio_cache_names);
 
-	mem = (__u64)((totalram_pages - totalhigh_pages) *
-		      DM_BUFIO_MEMORY_PERCENT / 100) << PAGE_SHIFT;
+	mem = (__u64)mult_frac(totalram_pages - totalhigh_pages,
+			       DM_BUFIO_MEMORY_PERCENT, 100) << PAGE_SHIFT;
 
 	if (mem > ULONG_MAX)
 		mem = ULONG_MAX;
 
 #ifdef CONFIG_MMU
-	/*
-	 * Get the size of vmalloc space the same way as VMALLOC_TOTAL
-	 * in fs/proc/internal.h
-	 */
-	if (mem > (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100)
-		mem = (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100;
+	if (mem > mult_frac(VMALLOC_END - VMALLOC_START, DM_BUFIO_VMALLOC_PERCENT, 100))
+		mem = mult_frac(VMALLOC_END - VMALLOC_START, DM_BUFIO_VMALLOC_PERCENT, 100);
 #endif
 
 	dm_bufio_default_cache_size = mem;
