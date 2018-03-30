Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522397823; cv=none;
        d=google.com; s=arc-20160816;
        b=r3gxrTAULU1sEaadbBFr0SqFG6UzY9pdKxfimqQa56bPaC7+lpqHzXAjYZMdq3TWGi
         OVQOyFsf1pFIJUdGI+xpnTO126st6fO23gpOyNIQeUtsoGEyx9gWECIbgoC2Pqtu+qdy
         MPcJZmSWOCkR0zpkI05LfT9vKx8es7MxkczkUT26SyWXirvT/J7nHgsnYImA/ihY9Gb1
         F7nlNeknXAOnOKeqsZJtHS/k2/PSlv+krjtEgZ+byfmRR32tmwl1rxtvwNYCUNjDt304
         hOmiNSTgXf7WpqpX8/sDQoE2HzCGztl8o+kC7awTwzykvxSiC5lwVjEVhipEsyvPqo1l
         XnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qp5NKpTdcRM6Rau/uqwRW72+6gftVpoNr2Kh3FeSdLk=;
        b=KshiIh9vlzDaOmTig2DfsswC9gb/wxsNdeT7HKF3QjaU/FvLe1R+alyPQQP6pDSecQ
         DLysppsFBd5C1Uk55uLRKlrtsrvUqsF/JhBF8kxmMhlp25kHM+W9FcGBKDWqprbT/17l
         difBaIVT7sv6MnNQGnNFMkN/sZSDKr/H1T8BXJuMo+IOYljGaaPgFzoeM2QswTVKkenC
         wZlAp4ru01dnKEyG1pZnhHghPR3rYAwoEXsrZ31Hw/JSk5qARYdBa95ZXp1mYb+yedrR
         syWLFg9N0Rwty9osX+ugjFmMBgQM2VU0IVmrwkPLBfsY4qhEHgb0BCL23CTOzhoXdmnB
         XmfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mVkfziFH;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mVkfziFH;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/EpwqQ2BYQnuzuswGVHM7PlY3i/PJmfcSFEFIRKWfO8Y4KeWIvSPeM+/u0dZ9Pss2tuN3/9w==
From: Jia He <hejianet@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	richard.weiyang@gmail.com,
	Jia He <hejianet@gmail.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v4 3/5] mm/memblock: introduce memblock_search_pfn_regions()
Date: Fri, 30 Mar 2018 01:15:53 -0700
Message-Id: <1522397755-33393-4-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
References: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596349819957995721?=
X-GMAIL-MSGID: =?utf-8?q?1596349819957995721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This api is the preparation for further optimizing early_pfn_valid

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h | 2 ++
 mm/memblock.c            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 0257aee..a0127b3 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+int memblock_search_pfn_regions(unsigned long pfn);
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index ba7c878..0f4004c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1617,6 +1617,15 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
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
