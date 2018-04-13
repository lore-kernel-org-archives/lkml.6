Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeDMJDu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:03:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34124 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbeDMJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:03:48 -0400
X-Google-Smtp-Source: AIpwx49zAHzIuPegtLDIuL+Tr9XkwFyADlwC/MPhgG8Ke2EOzoCSULH/O3CTYbo8FfkvTswZ8h7Atw==
Date: Fri, 13 Apr 2018 17:03:38 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: vgoyal@redhat.com, thomas.lendacky@amd.com, bp@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/resource: refine find_next_iomem_res() a little
Message-ID: <20180413090338.GA66608@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180326224606.79666-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326224606.79666-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello every one,

Someone would like to take a look at this?

On Tue, Mar 27, 2018 at 06:46:06AM +0800, Wei Yang wrote:
>This patch does several refine for find_next_iomem_res()
>
>  * use first_level_children_only directly
>  * remove some local variables
>  * use resrouce_clip()
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>---
> kernel/resource.c | 40 +++++++++++++++-------------------------
> 1 file changed, 15 insertions(+), 25 deletions(-)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index e270b5048988..769109f20fb7 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -351,6 +351,15 @@ int release_resource(struct resource *old)
> 
> EXPORT_SYMBOL(release_resource);
> 
>+static void resource_clip(struct resource *res, resource_size_t min,
>+			  resource_size_t max)
>+{
>+	if (res->start < min)
>+		res->start = min;
>+	if (res->end > max)
>+		res->end = max;
>+}
>+
> /*
>  * Finds the lowest iomem resource existing within [res->start.res->end).
>  * The caller must specify res->start, res->end, res->flags, and optionally
>@@ -361,31 +370,24 @@ EXPORT_SYMBOL(release_resource);
> static int find_next_iomem_res(struct resource *res, unsigned long desc,
> 			       bool first_level_children_only)
> {
>-	resource_size_t start, end;
> 	struct resource *p;
>-	bool sibling_only = false;
> 
> 	BUG_ON(!res);
>-
>-	start = res->start;
>-	end = res->end;
>-	BUG_ON(start >= end);
>-
>-	if (first_level_children_only)
>-		sibling_only = true;
>+	BUG_ON(res->start >= res->end);
> 
> 	read_lock(&resource_lock);
> 
>-	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
>+	for (p = iomem_resource.child; p;
>+		p = next_resource(p, first_level_children_only)) {
> 		if ((p->flags & res->flags) != res->flags)
> 			continue;
> 		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
> 			continue;
>-		if (p->start > end) {
>+		if (p->start > res->end) {
> 			p = NULL;
> 			break;
> 		}
>-		if ((p->end >= start) && (p->start < end))
>+		if ((p->end >= res->start) && (p->start < res->end))
> 			break;
> 	}
> 
>@@ -393,10 +395,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> 	if (!p)
> 		return -1;
> 	/* copy data */
>-	if (res->start < p->start)
>-		res->start = p->start;
>-	if (res->end > p->end)
>-		res->end = p->end;
>+	resource_clip(res, p->start, p->end);
> 	res->flags = p->flags;
> 	res->desc = p->desc;
> 	return 0;
>@@ -600,15 +599,6 @@ static resource_size_t simple_align_resource(void *data,
> 	return avail->start;
> }
> 
>-static void resource_clip(struct resource *res, resource_size_t min,
>-			  resource_size_t max)
>-{
>-	if (res->start < min)
>-		res->start = min;
>-	if (res->end > max)
>-		res->end = max;
>-}
>-
> /*
>  * Find empty slot in the resource tree with the given range and
>  * alignment constraints
>-- 
>2.15.1

-- 
Wei Yang
Help you, Help me
