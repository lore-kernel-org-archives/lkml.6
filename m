Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937796AbeE1KqE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937780AbeE1Kp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/496] IB/uverbs: Fix method merging in uverbs_ioctl_merge
Date: Mon, 28 May 2018 11:57:42 +0200
Message-Id: <20180528100323.017231933@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matan Barak <matanb@mellanox.com>

[ Upstream commit 3d89459e2ef92cc0e5a50dde868780ccda9786c1 ]

Fix a bug in uverbs_ioctl_merge that looked at the object's iterator
number instead of the method's iterator number when merging methods.

While we're at it, make the uverbs_ioctl_merge code a bit more clear
and faster.

Fixes: 118620d3686b ('IB/core: Add uverbs merge trees functionality')
Signed-off-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_ioctl_merge.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/core/uverbs_ioctl_merge.c
+++ b/drivers/infiniband/core/uverbs_ioctl_merge.c
@@ -114,6 +114,7 @@ static size_t get_elements_above_id(cons
 	short min = SHRT_MAX;
 	const void *elem;
 	int i, j, last_stored = -1;
+	unsigned int equal_min = 0;
 
 	for_each_element(elem, i, j, elements, num_elements, num_offset,
 			 data_offset) {
@@ -136,6 +137,10 @@ static size_t get_elements_above_id(cons
 		 */
 		iters[last_stored == i ? num_iters - 1 : num_iters++] = elem;
 		last_stored = i;
+		if (min == GET_ID(id))
+			equal_min++;
+		else
+			equal_min = 1;
 		min = GET_ID(id);
 	}
 
@@ -146,15 +151,10 @@ static size_t get_elements_above_id(cons
 	 * Therefore, we need to clean the beginning of the array to make sure
 	 * all ids of final elements are equal to min.
 	 */
-	for (i = num_iters - 1; i >= 0 &&
-	     GET_ID(*(u16 *)(iters[i] + id_offset)) == min; i--)
-		;
-
-	num_iters -= i + 1;
-	memmove(iters, iters + i + 1, sizeof(*iters) * num_iters);
+	memmove(iters, iters + num_iters - equal_min, sizeof(*iters) * equal_min);
 
 	*min_id = min;
-	return num_iters;
+	return equal_min;
 }
 
 #define find_max_element_entry_id(num_elements, elements, num_objects_fld, \
@@ -322,7 +322,7 @@ static struct uverbs_method_spec *build_
 		hash = kzalloc(sizeof(*hash) +
 			       ALIGN(sizeof(*hash->attrs) * (attr_max_bucket + 1),
 				     sizeof(long)) +
-			       BITS_TO_LONGS(attr_max_bucket) * sizeof(long),
+			       BITS_TO_LONGS(attr_max_bucket + 1) * sizeof(long),
 			       GFP_KERNEL);
 		if (!hash) {
 			res = -ENOMEM;
@@ -509,7 +509,7 @@ static struct uverbs_object_spec *build_
 			 * first handler which != NULL. This also defines the
 			 * set of flags used for this handler.
 			 */
-			for (i = num_object_defs - 1;
+			for (i = num_method_defs - 1;
 			     i >= 0 && !method_defs[i]->handler; i--)
 				;
 			hash->methods[min_id++] = method;
