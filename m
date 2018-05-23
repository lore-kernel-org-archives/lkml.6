Return-Path: <david@redhat.com>
X-Google-Smtp-Source: ADUXVKJmKRQNl6Fxla1WTauROYR326m3Me2Lf90rq3M723pLHRyn4iBvS0QvuK20KDS+5lMPzupa
ARC-Seal: i=1; a=rsa-sha256; t=1527099858; cv=none;
        d=google.com; s=arc-20160816;
        b=rZiqaWOG7jcQkmXdKT3nyQKDe8vqnejzydMDVZ0Y1TLsqwkTZEd7RrZ1ul0PV49HHX
         Aj77idQPVnEHUN/hsgOAU5vRK3UW8OgRBmbhD2POkn55j4FYDjxNtmLc5JkiA6yi1jBo
         caHMA5rwCOhw2As21xR9RLCQPqvzL67nF9hRYlOTI7XNQVeJpssiuUhudw9p5SbzZW5A
         +EvXzKfdaVzpCX0//arecQJF99kWi6Nwsm0B2/qE/Vqo5uoDdhFRTDB65XZDJsxxtwL1
         p8L5/QKKBi/bYPlGVHwXBljNoKDJnEWFqCYIOh0zzTtUb0FP+rGlIcCx50OfqumWWMZ1
         Zkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=47Nhj412fyl/hg8GWq0ps6rxaw9fjmOhSMQGQwR3sjU=;
        b=B3dDelMVneVVtXRrJtAR7miShgQQ/xXLK+hsM1iAAFXp43TkSerUTRkEMgJVwwn+2e
         5lcXkVnqNekZpIaCOjKq8qdtQzbxrYeuEd8cXiEOnbMcB6ROhpqE/yWwZ44H7BlQz+FU
         LuA7vvgX5e+kVUPOZBmmq/EGSDnw7mKH4LLA3h0D5Rlg+0Xv9rjO56N6dN43Sq0PsQl4
         y/VfGgoiWyby4drk0ZoF5eIffewIgB/aCFNIoQvvbizgEFkSc7JaaqldnZti1PaLi2NC
         D1yIXELehc5FETr0k01minVCTAu8aLN/Q+eJzflT6w3Rh2ytr0ckpEpCsbctB7FFC1nk
         SIXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-s390@vger.kernel.org
Subject: [PATCH RFCv2 2/4] s390: mm: support removal of memory
Date: Wed, 23 May 2018 20:24:02 +0200
Message-Id: <20180523182404.11433-3-david@redhat.com>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601280261006729287?=
X-GMAIL-MSGID: =?utf-8?q?1601280261006729287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With virtio-mem, we actually want to remove memory again.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/init.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3fa3e5323612..7202344d0eae 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -242,12 +242,18 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 #ifdef CONFIG_MEMORY_HOTREMOVE
 int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
-	/*
-	 * There is no hardware or firmware interface which could trigger a
-	 * hot memory remove on s390. So there is nothing that needs to be
-	 * implemented.
-	 */
-	return -EBUSY;
+	const unsigned long start_pfn = start >> PAGE_SHIFT;
+	const unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(start_pfn);
+	struct zone *zone;
+	int ret;
+
+	zone = page_zone(page);
+	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	WARN_ON_ONCE(ret);
+	vmem_remove_mapping(start, size);
+
+	return ret;
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.17.0
