Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvMpWze1v15tMpZ0LuMJiEzrVnqlcAxrcQm5ocfYd/MOf6U/mFXGHFZiDXAunVfS6XYP0td
ARC-Seal: i=1; a=rsa-sha256; t=1519676577; cv=none;
        d=google.com; s=arc-20160816;
        b=iXOSltPe/eZMKCjx4D6CmzfQ6EhXjZY+rgUxpUrSjW6c++8Fj+mJ4EeKbMUrtZ2qDe
         HOtmoBnFeKifFPqwpR2ARymYzXCkMKxfsNT7rLIjzg2XleLwON5fir8x/PxUrE2MXnXn
         t0v53kP7NqavEC3ah+Vn2R+/WDuDStmFVcQNVYAerARXm/4fXBEW/5taBmJ0QUhLxXKb
         SU1jLqSYDE8fChZG2wxjahZKXZRFgSrb4Uyr/rvz/ec1vZX1cgfoYZPW6P9hKXrkVSPu
         2K7NQuN7ZNpy+eleN/9CZTEQZs8kV9uzGXtvZ+0wsBHcOHoiRFSVBKwtHr8t+4DdwHTO
         s9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tIZhhCboYYS+rnbDlp3dn5iRKVO1yAR1PI7YIpVe9mc=;
        b=OPRqf2PQa+fnJbvJdNUMQ06hu0zKUV3QBi5yvsIhJhUhKhwcHm4RZ7xDMTVkm8U7Yt
         KYonOGzKHY9J2GQe8iGycAFHCB368rJDA8EvpkdNDc3HZBJjewkDK1iQstLWkGVCId7+
         IzMv99pNioa43o9ikFUG7WEo8Op6p54TSKSe9tpU0bisLCyoUCMwRwQ2JM5fkH064bFy
         kFlSxONa4Ip/j6bikiXrxEoYkLHFzaCU1Et6bXVojVodrfrSVcr+0SKGzNDKSUSyR0G7
         9Ovf3QfG7hfuaAD/oI1e5TTkI8UVa2CoQ8pRORNZT0sUj3jFNDh0Y3mNlk3EQpGdFTY2
         Yveg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 37/39] mm: Fix devm_memremap_pages() collision handling
Date: Mon, 26 Feb 2018 21:20:58 +0100
Message-Id: <20180226201645.292220747@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593231662350727514?=
X-GMAIL-MSGID: =?utf-8?q?1593496387556325036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan H. Schönherr <jschoenh@amazon.de>

commit 77dd66a3c67c93ab401ccc15efff25578be281fd upstream.

If devm_memremap_pages() detects a collision while adding entries
to the radix-tree, we call pgmap_radix_release(). Unfortunately,
the function removes *all* entries for the range -- including the
entries that caused the collision in the first place.

Modify pgmap_radix_release() to take an additional argument to
indicate where to stop, so that only newly added entries are removed
from the tree.

Cc: <stable@vger.kernel.org>
Fixes: 9476df7d80df ("mm: introduce find_dev_pagemap()")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/memremap.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -194,7 +194,7 @@ void put_zone_device_page(struct page *p
 }
 EXPORT_SYMBOL(put_zone_device_page);
 
-static void pgmap_radix_release(struct resource *res)
+static void pgmap_radix_release(struct resource *res, resource_size_t end_key)
 {
 	resource_size_t key, align_start, align_size, align_end;
 
@@ -203,8 +203,11 @@ static void pgmap_radix_release(struct r
 	align_end = align_start + align_size - 1;
 
 	mutex_lock(&pgmap_lock);
-	for (key = res->start; key <= res->end; key += SECTION_SIZE)
+	for (key = res->start; key <= res->end; key += SECTION_SIZE) {
+		if (key >= end_key)
+			break;
 		radix_tree_delete(&pgmap_radix, key >> PA_SECTION_SHIFT);
+	}
 	mutex_unlock(&pgmap_lock);
 }
 
@@ -255,7 +258,7 @@ static void devm_memremap_pages_release(
 	unlock_device_hotplug();
 
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
-	pgmap_radix_release(res);
+	pgmap_radix_release(res, -1);
 	dev_WARN_ONCE(dev, pgmap->altmap && pgmap->altmap->alloc,
 			"%s: failed to free all reserved pages\n", __func__);
 }
@@ -289,7 +292,7 @@ struct dev_pagemap *find_dev_pagemap(res
 void *devm_memremap_pages(struct device *dev, struct resource *res,
 		struct percpu_ref *ref, struct vmem_altmap *altmap)
 {
-	resource_size_t key, align_start, align_size, align_end;
+	resource_size_t key = 0, align_start, align_size, align_end;
 	pgprot_t pgprot = PAGE_KERNEL;
 	struct dev_pagemap *pgmap;
 	struct page_map *page_map;
@@ -392,7 +395,7 @@ void *devm_memremap_pages(struct device
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
  err_pfn_remap:
  err_radix:
-	pgmap_radix_release(res);
+	pgmap_radix_release(res, key);
 	devres_free(page_map);
 	return ERR_PTR(error);
 }
