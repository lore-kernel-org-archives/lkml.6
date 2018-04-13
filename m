Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx48yM5nzsO1xmEExB/BSLQ8Lufym6a0BGugROJuojHcXPlRihIWUnLCcqluS1KIz7FhPGoLG
ARC-Seal: i=1; a=rsa-sha256; t=1523625413; cv=none;
        d=google.com; s=arc-20160816;
        b=z4Obz9jAiABwD6Jp4LUSJJkZ+pWebqa7PVTuX1DeX60BZmws89cGWbfGLH4+4qSg0r
         bihObPh126sAXjgwtqxPMGTCRFLomTDmy5UQeLuTW5iadAOxWP0of4YcpXn/qEc1zs2k
         uIV5+MjP54uh5RlzdkEmtA/X0TiqMd9icShCvvdMbJ28Vd/nmNyzPYvqlFt4TeFUxvcP
         ljSbXWl0lq1PGTBOJ4SAG4leY/SGy6l9slVY0OP8MChbr104/vMVelYtp/RXgZNP/jo/
         AwyDXBxs47slyrvH8HaBFrNiw67wCZDuhaN+EgNGfM2RpT21mW2QJdFd/H9wGEmGOPS6
         Wr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JnYBeKDSEeGoe5CGKGkJPLaRU0Nbl4t46LzLHxUcaq0=;
        b=IPYNwO27rloPnF+nvXD+TTtiG3OdUvpXoFY21YgnlqgEcMsOt10HErJLAmjg1BRN1M
         N4BBw1Ghuye4etk03/1CKd9ze5lOSy0z/bXhP/jKcm+GXFVfDbCZKVLgYZQT+4M+pFLN
         qbnlKCAynPar+NizYID+7NN5Ce3FYlqoOJct2ONHMYpyMvS0+4sQ6eFp7wCnBZPjQsrf
         mvNF55Y6OyFccegMGS7timXXOnRNf3vVH+nnu8c/aUKISMiszbgALG43X42FVBhwSHPz
         v7h+ucT6mkq87JgbnY/11xzrOpKtbSbWMP+V5Tj7AiMj9ymyvhs+MJcd7LWsfxYKB6yR
         p97A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@redhat.com>,
	James Hogan <jhogan@kernel.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 2/8] mm: introduce PG_offline
Date: Fri, 13 Apr 2018 15:16:26 +0200
Message-Id: <20180413131632.1413-3-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597637040722220932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

online_pages()/offline_pages() theoretically allows us to work on
sub-section sizes. This is especially relevant in the context of
virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
4MB chunks.

While the whole section is marked as online/offline, we have to know
the state of each page. E.g. to not read memory that is not online
during kexec() or to properly mark a section as offline as soon as all
contained pages are offline.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h     | 10 ++++++++++
 include/trace/events/mmflags.h |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e34a27727b9a..8ebc4bad7824 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -49,6 +49,9 @@
  * PG_hwpoison indicates that a page got corrupted in hardware and contains
  * data with incorrect ECC bits that triggered a machine check. Accessing is
  * not safe since it may cause another machine check. Don't touch!
+ *
+ * PG_offline indicates that a page is offline and the backing storage
+ * might already have been removed (virtualization). Don't touch!
  */
 
 /*
@@ -100,6 +103,9 @@ enum pageflags {
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
 	PG_young,
 	PG_idle,
+#endif
+#ifdef CONFIG_MEMORY_HOTPLUG
+	PG_offline,		/* Page is offline. Don't touch */
 #endif
 	__NR_PAGEFLAGS,
 
@@ -381,6 +387,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+PAGEFLAG(Offline, offline, PF_ANY)
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a81cffb76d89..14c31209e34a 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -79,6 +79,12 @@
 #define IF_HAVE_PG_IDLE(flag,string)
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define IF_HAVE_PG_OFFLINE(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_OFFLINE(flag,string)
+#endif
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -104,7 +110,8 @@ IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
-IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
+IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
+IF_HAVE_PG_OFFLINE(PG_offline,		"offline"	)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-- 
2.14.3
