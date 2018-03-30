Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522397849; cv=none;
        d=google.com; s=arc-20160816;
        b=ErIB9GSrGZ0dYKVH2ilWolI24li7A4yLHCTk4yNiC8Y4ErugE8bwKQbxK5FrXsGKX5
         LIrYCKR3BV0Vf3xfVgpkvVouyELpPccIr2xSIY5xeh2FgUtJTMk560eV6NHDPJgU82+0
         Q/ZjUMiXtPsMQikEJKHaXujslpU9xaakWCAVATK++A6yllPijp1Wbdr2m3jQboYs0ojl
         PZSk2tfMNlsSZqI0elF0RvGRYys/nMqX7SagsR21Wb4Cy4ZmxOILIaTn7x6qRm01e9sP
         av0GjndY0pzSsR+whDs+sP4ZKp5sfuR1pKjD4yXE2n7zUlXkPLYRW9IF7iOMyoHeItqO
         fx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6Xi2gqOglNMvtA6STOTHUjz4SQcQoRXbWivLVdbm/ts=;
        b=rKW3CwkOMs2R63AWHJ3yxEVLkmHY7+RqLbRItnzhJ91wrEFFn1WLAtXDLDWdQOmATV
         OKAdbfFRT+aGopsdRbeybyefYCEFs3F1703MnXiHYGbErjuFSJ/dA63cTSDkGSDzkw+n
         FIMFh4vIEcKze0lTFOwqpc2Ru0zXMmNTRlNvZcR1YUB9oWo5gBqlGjrnfuILb2PBH24z
         ZBGokaQ6SARax4vnEP5rG/AIvPnOshK8N01+1q2l4/LbAN81wEC+A8GqClTb9h7Hgpek
         fZpTJTsX5YnxDMM92tvGpSKgl2lzr9ojiB4rtHky3PeRP8fmF+DQsUluKJRf6BV/0W5u
         Cwpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E8z36mdG;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E8z36mdG;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+KBnuapx600Rfh0zv6YU6DChAjx95i40RKKl2j9fwq1UnbLQStPPpi0k45G4vfQJx+P4z7Cw==
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
Subject: [PATCH v4 5/5] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date: Fri, 30 Mar 2018 01:15:55 -0700
Message-Id: <1522397755-33393-6-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
References: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596349847700103649?=
X-GMAIL-MSGID: =?utf-8?q?1596349847700103649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check check pfn++ is still in the same region.

Currently it only improve the performance on arm64 and will have no
impact on other arches.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d797716..b68d22c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1267,9 +1267,14 @@ static inline int pfn_present(unsigned long pfn)
 })
 #else
 #define pfn_to_nid(pfn)		(0)
-#endif
+#endif /*CONFIG_NUMA*/
 
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+#define early_pfn_valid(pfn) pfn_valid_region(pfn, &early_region_idx)
+#else
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
2.7.4
