Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpd/YEo4l2bCdBrBtAN2pGhMdCqinS47CxTACQ9Ul9BkOCR/qY/OpA0tKqqUqajKjMPxmPC
ARC-Seal: i=1; a=rsa-sha256; t=1524837628; cv=none;
        d=google.com; s=arc-20160816;
        b=OVjAfHk8G396E133ahmYoFddT2+kIgRqFLDK1fqvku4zZ24c02tv9wpd2SJfi6+kqz
         UdyWCDsFxruX6fC7fMz7/EO/ZUWBSdzUlI54IqATC3PRmHG5g1W2gzQkgssMIB+hR2O3
         Gqesgxrinx8zTnGdZGxU2aaupFK6k+qoXEQvRtHJEGJzLQXObfk6So6IXS6yw75xjhdG
         GodU/e2JhSfzJ4a0s7jgDQxHyqAhQglUVuTwCVMvyxRRjj9zRUTOqDdlJoPkLAtztQoU
         cCDbLpaFaErw/tvRKMBVW+/+gwfSiY31PtPAMTEWhrql9lWO96gjhT/tCR9Z+Pq8Yabf
         MfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=a3+wEcvVwfJelENA4l3Y5fMOuPYoyIkdo+9WrJ9lUT0=;
        b=HCLSQqw8McYs7mWS5YFCpfyBmelFx+K94mHbbgVXD/xX6ediFx2wS6jkfnEJk2HbYt
         VYz+68b73M21u3ZhqPRnIJaNdI8FqfpLxmMEu3lAidrboSgcYgK6uEqkU6+qNlzY/lvy
         LtGJtkDo/FyU6GSSWyGKgVYaLforLZsgsXGAUfdrtOacitFQzs3Y7urMQAUqjwnlpB5g
         wbifTGawh/C7xXyAx/TY4YXx0peqQTlkYPA421f7Ry7ezLCgOvNmvtTG0yX9zA/AL2gj
         Pc/uSnb+JFWIUUt+DjUdM6/PbdS1MGwIAy8PqxJNq7T0Ywvoyl3szkKa5LePVrnG06ew
         Cw1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE0821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Chris Fries <cfries@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 3.18 07/24] mm/filemap.c: fix NULL pointer in page_cache_tree_insert()
Date: Fri, 27 Apr 2018 15:57:42 +0200
Message-Id: <20180427135631.888933204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908140702629825?=
X-GMAIL-MSGID: =?utf-8?q?1598908140702629825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit abc1be13fd113ddef5e2d807a466286b864caed3 upstream.

f2fs specifies the __GFP_ZERO flag for allocating some of its pages.
Unfortunately, the page cache also uses the mapping's GFP flags for
allocating radix tree nodes.  It always masked off the __GFP_HIGHMEM
flag, and masks off __GFP_ZERO in some paths, but not all.  That causes
radix tree nodes to be allocated with a NULL list_head, which causes
backtraces like:

  __list_del_entry+0x30/0xd0
  list_lru_del+0xac/0x1ac
  page_cache_tree_insert+0xd8/0x110

The __GFP_DMA and __GFP_DMA32 flags would also be able to sneak through
if they are ever used.  Fix them all by using GFP_RECLAIM_MASK at the
innermost location, and remove it from earlier in the callchain.

Link: http://lkml.kernel.org/r/20180411060320.14458-2-willy@infradead.org
Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reported-by: Chris Fries <cfries@google.com>
Debugged-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -468,7 +468,7 @@ int replace_page_cache_page(struct page
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -561,7 +561,7 @@ static int __add_to_page_cache_locked(st
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg);
