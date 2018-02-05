Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeBEF3j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 00:29:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:41306 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeBEF3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 00:29:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,463,1511856000";
   d="scan'208";a="31995893"
Date: Mon, 5 Feb 2018 13:30:13 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: RFC: eliminate zone->lock contention for will-it-scale/page_fault1
 on big server
Message-ID: <20180205053013.GB16980@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124023050.20097-1-aaron.lu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition the the two patches, there are two more patches that I would
like to get some feedback.

The two patches are more radical: the 3rd deals with free path
zone->lock contention by avoiding doing any merge for order0 pages while
the 4th deals with allocation path zone->lock contention by taking
pcp->batch pages off the free_area order0 list without the need to
iterate the list.

Both patches are developed based on "the most time consuming part of
operations under zone->lock is cache misses on struct page".

The 3rd patch may be controversial but doesn't have correctness problem;
the 4th is in an early stage and serves only as a proof-of-concept.

Your comments are appreciated, thanks.
