Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19475C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62BB207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HiZFFvfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62BB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJWUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:51:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:51:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NCIlF7007317;
        Tue, 23 Oct 2018 12:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xlVJTMtDx2NqR5iBa0pscJrEhHhYzwACWIFcyZUkVKw=;
 b=HiZFFvfKp6jGhV59jRAWvBfXNYJNJuYdXxGM9PEDaKcRs4xs9a0Qjgqn2gq+htGZu0su
 SjBv6Brje4S6qFokplO0cWEb8CM9gjZwlSK+jHbxH2D0EB/A4AYrzgHliDp+iKskzrK4
 T387DlbDVDOofkgCaVBPF7/sryFuJQjuvm/1Bypov85qFygPQlks0kD/1Rp+iC6GxiVs
 Krewz43Gm6zveoSdW9cTKt3VlAfD+7k5mb8AdVhIn78Pl+RXNY6j5H1ZoAsW6ixw7+iM
 3u3JGWW/uAt31u393JrCdThqX3794I3Ivc41IHmmduS5WdqDM42zCJI7UerEx1aiMxwm TA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usu4w5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 12:27:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9NCRdAJ001789
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 12:27:39 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NCRc0g013670;
        Tue, 23 Oct 2018 12:27:38 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 05:27:37 -0700
Date:   Tue, 23 Oct 2018 05:27:38 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V6 00/21] swap: Swapout/swapin THP in one piece
Message-ID: <20181023122738.a5j2vk554tsx4f6i@ca-dmjordan1.us.oracle.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010071924.18767-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:19:03PM +0800, Huang Ying wrote:
> And for all, Any comment is welcome!
> 
> This patchset is based on the 2018-10-3 head of mmotm/master.

There seems to be some infrequent memory corruption with THPs that have been
swapped out: page contents differ after swapin.

Reproducer at the bottom.  Part of some tests I'm writing, had to separate it a
little hack-ily.  Basically it writes the word offset _at_ each word offset in
a memory blob, tries to push it to swap, and verifies the offset is the same
after swapin.

I ran with THP enabled=always.  THP swapin_enabled could be always or never, it
happened with both.  Every time swapping occurred, a single THP-sized chunk in
the middle of the blob had different offsets.  Example:

** > word corruption gap
** corruption detected 14929920 bytes in (got 15179776, expected 14929920) **
** corruption detected 14929928 bytes in (got 15179784, expected 14929928) **
** corruption detected 14929936 bytes in (got 15179792, expected 14929936) **
...pattern continues...
** corruption detected 17027048 bytes in (got 15179752, expected 17027048) **
** corruption detected 17027056 bytes in (got 15179760, expected 17027056) **
** corruption detected 17027064 bytes in (got 15179768, expected 17027064) **
100.0% of memory was swapped out at mincore time
0.00305% of pages were corrupted (first corrupt word 14929920, last corrupt word 17027064)

The problem goes away with THP enabled=never, and I don't see it on 2018-10-3
mmotm/master with THP enabled=always.

The server had an NVMe swap device and ~760G memory over two nodes, and the
program was always run like this:  swap-verify -s $((64 * 2**30))

The kernels had one extra patch, Alexander Duyck's
"dma-direct: Fix return value of dma_direct_supported", which was required to
get them to build.

---------------------------------------8<---------------------------------------

/*
 * swap-verify.c - helper to verify contents of swapped out pages
 *
 * Daniel Jordan <daniel.m.jordan@oracle.com>
 */

#define _GNU_SOURCE
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

#define TEST_SUCCESS	0
#define TEST_FAIL	1
#define TEST_SKIP	2

static void usagedie(int exitcode)
{
	fprintf(stderr, "usage: swap-verify\n"
			"    -h                show this message\n"
			"    -s bytes\n");
	exit(exitcode);
}

int main(int argc, char **argv)
{
	int c, pgsize;
	char *pages;
	unsigned char *mincore_vec;
	size_t i, j, nr_pages_swapped, nr_pages_corrupted;
	size_t bytes = 1ul << 30;	/* default 1G */
	ssize_t bytes_read;
	size_t first_corrupt_word, last_corrupt_word, prev_corrupt_word;

	while ((c = getopt(argc, argv, "hs:")) != -1) {
		switch (c) {
		case 'h':
			usagedie(0);
			break;
		case 's':
			bytes = strtoul(optarg, NULL, 10);
			break;
		default:
			fprintf(stderr, "unrecognized option %c\n", c);
			exit(TEST_SKIP);
		}
	}

	pgsize = getpagesize();

	if ((mincore_vec = calloc(bytes / pgsize, 1)) == NULL) {
		perror("calloc");
		exit(TEST_SKIP);
	}

	if ((pages = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
		perror("mmap");
		exit(TEST_SKIP);
	}

	/* Fill pages with a "random" pattern. */
	for (i = 0; i < bytes; i += sizeof(unsigned long))
		*(unsigned long *)(pages + i) = i;

	/* Now fill memory, trying to push the pages just allocated to swap. */
	system("./use-mem-total");

	/* Is the memory swapped out? */
	if (mincore(pages, bytes, mincore_vec) == -1) {
		perror("mincore");
		exit(TEST_SKIP);
	}

	nr_pages_swapped = 0;
	nr_pages_corrupted = 0;
	first_corrupt_word = bytes;
	last_corrupt_word = 0;
	prev_corrupt_word = bytes;
	for (i = 0; i < bytes; i += pgsize) {
		bool page_corrupt = false;
		if (mincore_vec[i / pgsize] & 1) {
			/* Resident, don't bother checking. */
			continue;
		}
		++nr_pages_swapped;
		for (j = i; j < i + pgsize; j += sizeof(unsigned long)) {
			unsigned long val = *(unsigned long *)(pages + j);
			if (val != j) {
				if (!page_corrupt)
					++nr_pages_corrupted;
				page_corrupt = true;
				if (j - prev_corrupt_word != sizeof(unsigned long))
					fprintf(stderr, "** > word corruption gap\n");
				if (j % (1ul << 21) == 0)
					fprintf(stderr, "-- THP boundary\n");
				if (j < first_corrupt_word)
					first_corrupt_word = j;
				if (j > last_corrupt_word)
					last_corrupt_word = j;
				fprintf(stderr, "** corruption detected %lu "
					"bytes in (got %lu, expected %lu) **\n",
					j, val, j);
				prev_corrupt_word = j;
			}
		}
	}
	fprintf(stderr, "%.1f%% of memory was swapped out at mincore time\n",
	       ((double)nr_pages_swapped / (bytes / pgsize)) * 100);

	if (nr_pages_corrupted) {
		fprintf(stderr, "%.5f%% of pages were corrupted (first corrupt "
			"word %lu, last corrupt word %lu)\n",
			((double)nr_pages_corrupted / (bytes / pgsize)) * 100,
			first_corrupt_word, last_corrupt_word);
	} else {
		fprintf(stderr, "no memory corruption detected\n");
	}
	return (nr_pages_corrupted) ? TEST_FAIL : TEST_SUCCESS;
}

---------------------------------------8<---------------------------------------

#!/usr/bin/env bash
#
# use-mem-total
#
# Helper that allocates MemTotal and exits immediately.  Useful for causing
# swapping of previously allocated memory.

# XXX fix paths
source /path/to/vm-scalability/hw_vars

/path/to/usemem --thread $nr_task --step $pagesize -q --repeat 4 \
	$(( mem * 11 / 10 / nr_task )) > /dev/null

---------------------------------------8<---------------------------------------
