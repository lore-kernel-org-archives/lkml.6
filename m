Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521619843; cv=none;
        d=google.com; s=arc-20160816;
        b=nlQM5c4bgY1eHXo5wzNq+Muo9st7OYDhyI3UUPalmaLIb2Pz8eFE1CGGLIRq42GpcU
         /7w6LTcd39+oPYM0xsaTEfRjODkI4ZHCo1TmMJ3im6B0fV/iJohq9UBYp5YN95COABP5
         iWxEbJ3SPmjhbjv4/F49JG8SrcPm11ZUKovndPkVoifZPtJs04kCkRHJDwbhmOn4vPlO
         1IocpB183YhdzZFUGvymm/nEVMcDHBu66GzuNfCYwp+EvpeLeWVRFVGOdjffGiHjbI9M
         cLIP6p2O/DwOzcSMZFmg+ST/uKDE3ulu6cwVt3kJk04Bj2P+VCHx3TM51OgddptB7eLS
         OfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zGzDxI/pQbF6JtLTpDOhPdXBCDikCpmHgp2TY5damxw=;
        b=Z/fENy7YxhIGUEPb0hH52qSY6h0DlRKqYC+rCI0V8zmfODxVhx7+lWZKnqmQlCpW/5
         /fi3zvWNb67nRl+rLDfJnLkaObJ5GPzFzXo6aUbHaiSAs8tO7A78TSXFEsTNJfFvJ4SB
         22UYb/frVi2b2Qff/10EmP17LLJU6Rq3qfJFCah1lQIqitMk76hKxYFMrI2r1LzGD6uH
         hyJs/S+yTpmhNkLRELrEwjRdNJHccPYCMT/dApaPUTxFO5TIAXKUURnUwFPHt39txVvw
         QL+Z0mYgQ2GEdWcfVJ7JwlV0m1h9gbYrbmFYOFiwZcqM8Ba+dfrLQDx83I6Kt9S0GR0l
         hgBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6GoliF6;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6GoliF6;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvYcyU3NMLZ7OOPDv6/YaO+L44EMgfi+IT/2XJeSi4VCAuB1Ctxb+q4ZtRTcGiR4rFG7/QNRA==
From: Jia He <hejianet@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Vacek <neelx@redhat.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	James Morse <james.morse@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steve Capper <steve.capper@arm.com>,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>,
	Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>,
	Jia He <hejianet@gmail.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH 2/4] mm/memblock: introduce memblock_search_pfn_regions()
Date: Wed, 21 Mar 2018 01:09:54 -0700
Message-Id: <1521619796-3846-3-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534048954240176?=
X-GMAIL-MSGID: =?utf-8?q?1595534048954240176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This api is the preparation for further optimizing early_pfn_valid

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9471db4..5f46956 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+int memblock_search_pfn_regions(unsigned long pfn);
+
 unsigned long memblock_next_valid_pfn(unsigned long pfn, int *last_idx);
 /**
  * for_each_free_mem_range - iterate through free memblock areas
diff --git a/mm/memblock.c b/mm/memblock.c
index a9e8da4..f50fe5b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1659,6 +1659,18 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
 	return -1;
 }
 
+/* search memblock with the input pfn, return the region idx */
+int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	int mid = memblock_search(type, PFN_PHYS(pfn));
+
+	if (mid == -1)
+		return -1;
+
+	return mid;
+}
+
 bool __init memblock_is_reserved(phys_addr_t addr)
 {
 	return memblock_search(&memblock.reserved, addr) != -1;
-- 
2.7.4
