Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A78C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A939021902
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="TfSWvzq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeLTTWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:22:01 -0500
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:34420 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731103AbeLTTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545333716;
        h=Message-Id:Date:From:To:Cc:Cc:Cc:CC:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:References:MIME-Version:Content-Type:Feedback-ID;
        bh=VdAFswNkZMzX1QnleI6nNoe36Hgyo5dlWLZMARfK7f8=;
        b=TfSWvzq+iWaub44mB9Mn8ltb+L1g6QW1S5kgNN/HUVsnK258K9k740hUbuDhEOMG
        bYTUyXxdL0Y3gmb2B+0S4/pIEqgRxEs5Qta6XL+73oW3WxvfSEyEN9EAbgWYzKYXFMv
        5dYhndZ2/byo4T9TMaGK71a7AaJMFgPyIpndY2ts=
Message-ID: <01000167cd113509-2c85d8a3-8e0e-4cb6-a745-88733e448471-000000@email.amazonses.com>
User-Agent: quilt/0.65
Date:   Thu, 20 Dec 2018 19:21:56 +0000
From:   Christoph Lameter <cl@linux.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Cc:     Pekka Enberg <penberg@cs.helsinki.fi>
CC:     akpm@linux-foundation.org
Cc:     Mel Gorman <mel@skynet.ie>
Cc:     andi@firstfloor.org
Cc:     Rik van Riel <riel@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC 1/7] slub: Replace ctor field with ops field in /sys/slab/*
References: <20181220192145.023162076@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=ctor_to_ops
X-SES-Outgoing: 2018.12.20-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an ops field in /sys/slab/*/ops to contain all the callback
operations defined for a slab cache. This will be used to display
the additional callbacks that will be defined soon to enable
defragmentation.

Display the existing ctor callback in the ops fields contents.

Signed-off-by: Christoph Lameter <cl@linux.com>

---
 mm/slub.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c
+++ linux/mm/slub.c
@@ -4994,13 +4994,18 @@ static ssize_t cpu_partial_store(struct
 }
 SLAB_ATTR(cpu_partial);
 
-static ssize_t ctor_show(struct kmem_cache *s, char *buf)
+static ssize_t ops_show(struct kmem_cache *s, char *buf)
 {
+	int x = 0;
+
 	if (!s->ctor)
 		return 0;
-	return sprintf(buf, "%pS\n", s->ctor);
+
+	if (s->ctor)
+		x += sprintf(buf + x, "ctor : %pS\n", s->ctor);
+	return x;
 }
-SLAB_ATTR_RO(ctor);
+SLAB_ATTR_RO(ops);
 
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
@@ -5413,7 +5418,7 @@ static struct attribute *slab_attrs[] =
 	&objects_partial_attr.attr,
 	&partial_attr.attr,
 	&cpu_slabs_attr.attr,
-	&ctor_attr.attr,
+	&ops_attr.attr,
 	&aliases_attr.attr,
 	&align_attr.attr,
 	&hwcache_align_attr.attr,

