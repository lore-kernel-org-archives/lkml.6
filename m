Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32922C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CAA218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="G61d0PPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbeLTTWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:22:24 -0500
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:54192 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389385AbeLTTWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545333722;
        h=Message-Id:Date:From:To:Cc:Cc:Cc:CC:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:References:MIME-Version:Content-Type:Feedback-ID;
        bh=BCm2PiyMf3tx6ZvzxPPkAP12ULxpZW06gS2AyjZcLp8=;
        b=G61d0PPsXs+Tscj8XOVELBwbPKNf0QVDMLAyIG79j+4VmVPBVzFJG5Dz0m/9PH2h
        ry86kMX1hOxMd6oDUO344KEEn9bQUqwhIDCnskTOtohaz/7Sf0sRWOibU7TT1d9AcwP
        bhouU10HazEhSJ9aeKk0WJh6roPvH8OD7Ou55ljE=
Message-ID: <01000167cd114cfc-077a81a2-a425-4578-a5af-89d000f59749-000000@email.amazonses.com>
User-Agent: quilt/0.65
Date:   Thu, 20 Dec 2018 19:22:02 +0000
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
Subject: [RFC 6/7] slub: Extend slabinfo to support -D and -F options
References: <20181220192145.023162076@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=extend_slabinfo
X-SES-Outgoing: 2018.12.20-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-F lists caches that support moving and defragmentation

-C lists caches that use a ctor.

Change field names for defrag_ratio and remote_node_defrag_ratio.

Add determination of the allocation ratio for a slab. The allocation ratio
is the percentage of available slots for objects in use.

Signed-off-by: Christoph Lameter <cl@linux.com>

---
 Documentation/vm/slabinfo.c |   48 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

Index: linux/tools/vm/slabinfo.c
===================================================================
--- linux.orig/tools/vm/slabinfo.c
+++ linux/tools/vm/slabinfo.c
@@ -33,6 +33,8 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
+	int movable, ctor;
+	int defrag_ratio, remote_node_defrag_ratio;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
@@ -67,6 +69,8 @@ int show_report;
 int show_alias;
 int show_slab;
 int skip_zero = 1;
+int show_movable;
+int show_ctor;
 int show_numa;
 int show_track;
 int show_first_alias;
@@ -109,14 +113,16 @@ static void fatal(const char *x, ...)
 
 static void usage(void)
 {
-	printf("slabinfo 4/15/2011. (c) 2007 sgi/(c) 2011 Linux Foundation.\n\n"
-		"slabinfo [-ahnpvtsz] [-d debugopts] [slab-regexp]\n"
+	printf("slabinfo 4/15/2017. (c) 2007 sgi/(c) 2011 Linux Foundation/(c) 2017 Jump Trading LLC.\n\n"
+		"slabinfo [-aCdDefFhnpvtsz] [-d debugopts] [slab-regexp]\n"
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-d<options>|--debug=<options> Set/Clear Debug options\n"
+		"-C|--ctor              Show slabs with ctors\n"
 		"-D|--display-active    Switch line format to activity\n"
 		"-e|--empty             Show empty slabs\n"
 		"-f|--first-alias       Show first alias\n"
+		"-F|--movable           Show caches that support movable objects\n"
 		"-h|--help              Show usage information\n"
 		"-i|--inverted          Inverted list\n"
 		"-l|--slabs             Show slabs\n"
@@ -369,7 +375,7 @@ static void slab_numa(struct slabinfo *s
 		return;
 
 	if (!line) {
-		printf("\n%-21s:", mode ? "NUMA nodes" : "Slab");
+		printf("\n%-21s: Rto ", mode ? "NUMA nodes" : "Slab");
 		for(node = 0; node <= highest_node; node++)
 			printf(" %4d", node);
 		printf("\n----------------------");
@@ -378,6 +384,7 @@ static void slab_numa(struct slabinfo *s
 		printf("\n");
 	}
 	printf("%-21s ", mode ? "All slabs" : s->name);
+	printf("%3d ", s->remote_node_defrag_ratio);
 	for(node = 0; node <= highest_node; node++) {
 		char b[20];
 
@@ -535,6 +542,8 @@ static void report(struct slabinfo *s)
 		printf("** Slabs are destroyed via RCU\n");
 	if (s->reclaim_account)
 		printf("** Reclaim accounting active\n");
+	if (s->movable)
+		printf("** Defragmentation at %d%%\n", s->defrag_ratio);
 
 	printf("\nSizes (bytes)     Slabs              Debug                Memory\n");
 	printf("------------------------------------------------------------------------\n");
@@ -585,6 +594,12 @@ static void slabcache(struct slabinfo *s
 	if (show_empty && s->slabs)
 		return;
 
+	if (show_movable && !s->movable)
+		return;
+
+	if (show_ctor && !s->ctor)
+		return;
+
 	if (sort_loss == 0)
 		store_size(size_str, slab_size(s));
 	else
@@ -599,6 +614,10 @@ static void slabcache(struct slabinfo *s
 		*p++ = '*';
 	if (s->cache_dma)
 		*p++ = 'd';
+	if (s->movable)
+		*p++ = 'F';
+	if (s->ctor)
+		*p++ = 'C';
 	if (s->hwcache_align)
 		*p++ = 'A';
 	if (s->poison)
@@ -633,7 +652,8 @@ static void slabcache(struct slabinfo *s
 		printf("%-21s %8ld %7d %15s %14s %4d %1d %3ld %3ld %s\n",
 			s->name, s->objects, s->object_size, size_str, dist_str,
 			s->objs_per_slab, s->order,
-			s->slabs ? (s->partial * 100) / s->slabs : 100,
+			s->slabs ? (s->partial * 100) /
+					(s->slabs * s->objs_per_slab) : 100,
 			s->slabs ? (s->objects * s->object_size * 100) /
 				(s->slabs * (page_size << s->order)) : 100,
 			flags);
@@ -1252,7 +1272,17 @@ static void read_slab_dir(void)
 			slab->cpu_partial_free = get_obj("cpu_partial_free");
 			slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
+			slab->defrag_ratio = get_obj("defrag_ratio");
+			slab->remote_node_defrag_ratio =
+					get_obj("remote_node_defrag_ratio");
 			chdir("..");
+			if (read_slab_obj(slab, "ops")) {
+				if (strstr(buffer, "ctor :"))
+					slab->ctor = 1;
+				if (strstr(buffer, "migrate :"))
+					slab->movable = 1;
+			}
+
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
@@ -1329,6 +1359,8 @@ static void xtotals(void)
 }
 
 struct option opts[] = {
+	{ "ctor", no_argument, NULL, 'C' },
+	{ "movable", no_argument, NULL, 'F' },
 	{ "aliases", no_argument, NULL, 'a' },
 	{ "activity", no_argument, NULL, 'A' },
 	{ "debug", optional_argument, NULL, 'd' },
@@ -1364,7 +1396,7 @@ int main(int argc, char *argv[])
 
 	page_size = getpagesize();
 
-	while ((c = getopt_long(argc, argv, "aAd::Defhil1noprstvzTSN:LXBU",
+	while ((c = getopt_long(argc, argv, "aACd::DefFhil1noprstvzTSN:LXBU",
 						opts, NULL)) != -1)
 		switch (c) {
 		case '1':
@@ -1420,6 +1452,12 @@ int main(int argc, char *argv[])
 		case 'z':
 			skip_zero = 0;
 			break;
+		case 'C':
+			show_ctor = 1;
+			break;
+		case 'F':
+			show_movable = 1;
+			break;
 		case 'T':
 			show_totals = 1;
 			break;

