Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA76121901
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cVyLVlWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbeLTTV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:21:56 -0500
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:34894 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731103AbeLTTV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545333715;
        h=Message-Id:Date:From:To:Cc:Cc:Cc:CC:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:Feedback-ID;
        bh=ZC6NB5lKn8jM6W/kwe979AqbHeNIIEDgIRYq8F0S3jo=;
        b=cVyLVlWCMnX/xXwSbAOjGke/AaYduszsLs/wcSBoRGW5RCfHoQOhRZPLy65aov7v
        9F/S49PS1d+goBBjMmRpktLA/MBVFqqHc031bjQtF3/MdMPm1fRkfHVEofYlextIQBK
        fgnfbFMt6KSXHbGnpRm3LWKe9CJGadGv7vXr+1Ps=
Message-ID: <01000167cd1130c8-c9bebcb9-1f95-4f7c-b24a-90600d56c62f-000000@email.amazonses.com>
User-Agent: quilt/0.65
Date:   Thu, 20 Dec 2018 19:21:55 +0000
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
Subject: [RFC 0/7] Slab object migration for xarray V2
X-SES-Outgoing: 2018.12.20-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1->V2:
	- Works now on top of 4.20-rc7
	- A couple of bug fixes


This is a patchset on top of Matthew Wilcox Xarray code and implements
slab object migration for xarray nodes. The migration is integrated into
the defragmetation and shrinking logic of the slab allocator.

Defragmentation will ensure that all xarray slab pages have
less objects available than specified by the slab defrag ratio.

Slab shrinking will create a slab cache with optimal object
density. Only one slab page will have available objects per node.

To test apply this patchset and run a workload that uses lots of radix tree objects


Then go to

/sys/kernel/slab/radix_tree_node

Inspect the number of total objects that the slab can handle

	cat total_objects

qmdr:/sys/kernel/slab/radix_tree_node# cat objects
868 N0=448 N1=168 N2=56 N3=196

And the number of slab pages used for those

	cat slabs

qmdr:/sys/kernel/slab/radix_tree_node# cat slabs
31 N0=16 N1=6 N2=2 N3=7


Perform a cache shrink operation

	echo 1 >shrink


Now see how the slab has changed:

qmdr:/sys/kernel/slab/radix_tree_node# cat slabs
30 N0=15 N1=6 N2=2 N3=7
qmdr:/sys/kernel/slab/radix_tree_node# cat objects
713 N0=349 N1=141 N2=52 N3=171


This is just a barebones approach using a special mode
of the slab migration patchset that does not require refcounts.



If this is acceptable then additional functionality can be added:

1. Migration of objects to a specific node. Not sure how to implement
   that. Using another sysfs field?

2. Dispersion of objects across all nodes (MPOL_INTERLEAVE)

3. Subsystems can request to move an object to a specific node.
   How to design such functionality best?

4. Tying into the page migration and page defragmentation logic so
   that so far unmovable pages that are in the way of creating a
   contiguous block of memory will become movable.
   This would mean checking for slab pages in the migration logic
   and calling slab to see if it can move the page by migrating
   all objects.

This is only possible for xarray for now but it would be worthwhile
to extend this to dentries and inodes.

