Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522033405; cv=none;
        d=google.com; s=arc-20160816;
        b=RI952HaGFrvAuyMdRWlkoi5W7RUl4SV0On975n7DxTg5q3JCMt0omHVhJmCO4uA+kV
         P4cZTobGpcoF+ga3ZunerJ0ZGIuvUXpZVrQsBnakPeUAwcJzoq1IN4RmHgJz97lkxwhr
         qQn0zQRq5VmLe6aucwkiyQXl3lKsPM2Akzg8VhJM01WxHriaxVgzh9ni2gfzgH8dxCGg
         HOudAWhXmNzjiCVOehTmbmgLI0cjdgDe3OKyZi4h69B6xEpgw90R87oZZsZPB5H6uhlD
         uDbWnUP1g7od248ZPf/udNuEvE49K4Sa9+EXepZ7Q4Y/HDkD3u/LPl2uwVekjAmkvjAO
         NWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=A3iyvOJjQFbESrn9840Z+H7nJuG4UfdlxalRzNH63tE=;
        b=bHNyuLVSRR57P9Dmey5zHLtUJ72KoDghMVLsUREIMai5CnOx1ObzPeRWhsYQulk8ck
         ul7W5lD2pNL9bCeWomahQqx7FVBw7G/ghw+viG/mShSh4vZlKf5bTZfpF+JfjW4jOk9n
         M2IjDGUpd24VhIqpnB1JqhBpujcNBKmLr1X4pjvndwgUnNYAIlZatpONvMF4isyxrjQG
         cu8D1PhX7TLFwgDOtNwqqvZlJEKaKNJd7bo3dVSUY3pD2Jt3xEY0Mu6gPdkWPSfxsbIA
         dnGXwUO94H8axP2WQgK4EcGellcV8YXMEbV3yp+kZYwygw4leveWKiBVMMJcqeMENk7q
         Ql1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FR7U4Axv;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FR7U4Axv;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/4b4B5Mc4X5Kdi+KxlWnzBSoMqb98XcnSuE2Y4ygSKYJMzbwdD/lkqHB486A8peKNd69j48Q==
From: Jia He <hejianet@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v3 3/5] mm/memblock: introduce memblock_search_pfn_regions()
Date: Sun, 25 Mar 2018 20:02:17 -0700
Message-Id: <1522033340-6575-4-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967700505835880?=
X-GMAIL-MSGID: =?utf-8?q?1595967700505835880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This api is the preparation for further optimizing early_pfn_valid

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h | 2 ++
 mm/memblock.c            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index a8fb2ab..104bca6 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -207,6 +207,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 unsigned long memblock_next_valid_pfn(unsigned long pfn, int *idx);
 #endif
 
+int memblock_search_pfn_regions(unsigned long pfn);
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index 06c1a08..15fcde2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1661,6 +1661,15 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
 	return -1;
 }
 
+/* search memblock with the input pfn, return the region idx */
+int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	int mid = memblock_search(type, PFN_PHYS(pfn));
+
+	return mid;
+}
+
 bool __init memblock_is_reserved(phys_addr_t addr)
 {
 	return memblock_search(&memblock.reserved, addr) != -1;
-- 
2.7.4
