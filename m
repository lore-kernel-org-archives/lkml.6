Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2835548-1520036014-2-13746701029119898257
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
    t=1520036013; b=avi++Gf5j/4oo8IYmIAikfjY+F6LV+YxREYNm0DkALxff2x
    5g89RIG4Qm7c+rmIn+/9DHqEtFANqnQf8YoEpV7PWslb9LYKOevyTC7odOmwvnVb
    ostjCYtPQtPcNkTcc2tS3EmG253lpf42SEQ0/BB3IrSRQ1BUjmPA8/9EKdnVbFtl
    On2emq+QGzM7+i4gnepv7qFKbYODsoY6x16gZTfjkJxLFpyRJCzJI7HxQxpDpvZu
    H0gFKEiljuqpeGd6VS/ZJ//h8y0A3DYpZ2WUYl8xeBZJUg9SfrHym9begppdh1mq
    MfG6GPx1Bio3aNKPIgDVujsASLiUY8tnN0kYARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520036013; bh=Gjnb8RUhOTODsB7dyEhsErJphvnU96EPcf2
    VbBbVKlw=; b=SNG/MMtt1V+zxRXVL1IrITzHkrnYhfF22CwjIFYpesJL+MQE60o
    7/ySY8jk9nEsHYpjSbNtkS9RGPtTi+vgKlsycxl0luG8Al2DPRTYOYavJTmaJIhZ
    usywQwDl9GAAQxHm6MtPaSUgNKOjFyR1r+q7OcYGu1nwQwFQsgsaF8mK3PuBWz1K
    gtV0aBn/PJC3MkVMp0ZyqC9JS+y07+ao+JzGQ/5x8ux9TcPmw+1BELkeUrDgHTJn
    rLhtndh8SAtv8qEEudd3jndSZVr/QSOjkFMAFaKYcOVxUFiI9fB9YQxOoyZi/zKn
    k+16M7Zx76/U57WQWYoJJXAbMWPDTW3UVFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935242AbeCCAMq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:12:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935239AbeCCAMp (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 19:12:45 -0500
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v3 0/2] mm/page_alloc: fix kernel BUG at mm/page_alloc.c:1913! crash in move_freepages()
Date: Sat,  3 Mar 2018 01:12:24 +0100
Message-Id: <cover.1520011944.git.neelx@redhat.com>
In-Reply-To: <1519908465-12328-1-git-send-email-neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
In-Reply-To: <1519908465-12328-1-git-send-email-neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kernel can crash on failed VM_BUG_ON assertion in function move_freepages()
on some rare physical memory mappings (with huge range(s) of memory
reserved by BIOS followed by usable memory not aligned to pageblock).

crash> page_init_bug -v | grep resource | sed '/RAM .3/,/RAM .4/!d'
<struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff	System RAM (391.02 MiB = 400408.00 KiB)
<struct resource 0xffff88067fffd4b8>      646b2000 -     793fefff	reserved (333.30 MiB = 341300.00 KiB)
<struct resource 0xffff88067fffd4f0>      793ff000 -     7b3fefff	ACPI Non-volatile Storage ( 32.00 MiB)
<struct resource 0xffff88067fffd528>      7b3ff000 -     7b787fff	ACPI Tables (  3.54 MiB = 3620.00 KiB)
<struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff	System RAM (480.00 KiB)

More details in second patch.

v2: Use -1 constant for max_pfn and remove the parameter. That's
    mostly just a cosmetics.
v3: Split to two patches series to make clear what is the actual fix
    and what is just a clean up. No code changes compared to v2 and
    second patch is identical to original v1.

Cc: stable@vger.kernel.org

Daniel Vacek (2):
  mm/memblock: hardcode the max_pfn being -1
  mm/page_alloc: fix memmap_init_zone pageblock alignment

 mm/memblock.c   | 13 ++++++-------
 mm/page_alloc.c |  9 +++++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.16.2
