Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B714221473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B714221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeHPVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:42:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeHPVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:54 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 644F3CEB;
        Thu, 16 Aug 2018 18:42:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <a.ryabinin@samsung.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 08/15] mm: slub: fix format mismatches in slab_err() callers
Date:   Thu, 16 Aug 2018 20:41:45 +0200
Message-Id: <20180816171633.856272393@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
References: <20180816171633.546734046@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <a.ryabinin@samsung.com>

commit f6edde9cbe0634e4391b6e421a609ca3f57f6c38 upstream.

Adding __printf(3, 4) to slab_err exposed following:

  mm/slub.c: In function `check_slab':
  mm/slub.c:852:4: warning: format `%u' expects argument of type `unsigned int', but argument 4 has type `const char *' [-Wformat=]
      s->name, page->objects, maxobj);
      ^
  mm/slub.c:852:4: warning: too many arguments for format [-Wformat-extra-args]
  mm/slub.c:857:4: warning: format `%u' expects argument of type `unsigned int', but argument 4 has type `const char *' [-Wformat=]
      s->name, page->inuse, page->objects);
      ^
  mm/slub.c:857:4: warning: too many arguments for format [-Wformat-extra-args]

  mm/slub.c: In function `on_freelist':
  mm/slub.c:905:4: warning: format `%d' expects argument of type `int', but argument 5 has type `long unsigned int' [-Wformat=]
      "should be %d", page->objects, max_objects);

Fix first two warnings by removing redundant s->name.
Fix the last by changing type of max_object from unsigned long to int.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/slub.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -849,12 +849,12 @@ static int check_slab(struct kmem_cache
 	maxobj = order_objects(compound_order(page), s->size, s->reserved);
 	if (page->objects > maxobj) {
 		slab_err(s, page, "objects %u > max %u",
-			s->name, page->objects, maxobj);
+			page->objects, maxobj);
 		return 0;
 	}
 	if (page->inuse > page->objects) {
 		slab_err(s, page, "inuse %u > max %u",
-			s->name, page->inuse, page->objects);
+			page->inuse, page->objects);
 		return 0;
 	}
 	/* Slab_pad_check fixes things up after itself */
@@ -871,7 +871,7 @@ static int on_freelist(struct kmem_cache
 	int nr = 0;
 	void *fp;
 	void *object = NULL;
-	unsigned long max_objects;
+	int max_objects;
 
 	fp = page->freelist;
 	while (fp && nr <= page->objects) {


