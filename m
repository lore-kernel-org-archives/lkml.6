Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBBORA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:17:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42688 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeBBOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:16:56 -0500
From: Robert Harris <robert.m.harris@oracle.com>
Content-Type: text/plain; charset=us-ascii
Subject: [Resend] Possible bug in __fragmentation_index()
Date: Fri, 2 Feb 2018 14:16:39 +0000
Message-Id: <83AECC32-77A4-427D-9043-DE6FC48AD3FC@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kemi Wang <kemi.wang@intel.com>,
        ying.huang@intel.com, David Rientjes <rientjes@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>, Mel Gorman <mgorman@suse.de>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1085)
X-Mailer: Apple Mail (2.1085)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12EH4ZV004043

I was planning to annotate the opaque calculation in
__fragmentation_index() but on closer inspection I think there may be a
bug.  I could use some feedback.

Firstly, for the case of fragmentation and ignoring the scaling,
__fragmentation_index() purports to return a value in the range 0 to 1.
Generally, however, the lower bound is actually 0.5.  Here's an
illustration using a zone that I fragmented with selective calls to
__alloc_pages() and __free_pages --- the fragmentation for order-1 could
not be minimised further yet is reported as 0.5:

# head -1 /proc/buddyinfo
Node 0, zone      DMA   1983      0      0      0      0      0      0      0      0      0      0 
# head -1 /sys/kernel/debug/extfrag/extfrag_index 
Node 0, zone      DMA -1.000 0.500 0.750 0.875 0.937 0.969 0.984 0.992 0.996 0.998 0.999 
#

This is significant because 0.5 is the default value of
sysctl_extfrag_threshold, meaning that compaction will not be suppressed
for larger blocks when memory is scarce rather than fragmented.  Of
course, sysctl_extfrag_threshold is a tuneable so the first question is:
does this even matter?

The calculation in __fragmentation_index() isn't documented but the
apparent error in the lower bound may be explained by showing that the
index is approximated by

F ~ 1 - 1/N

where N is (conceptually) the number of free blocks into which each
potential requested-size block has been split.  I.e. if all free space
were compacted then there would be B free blocks of the requested size
where

B = info->free_pages/requested

and thus

N = info->free_blocks_total/B

The case of least fragmentation must be when all of the requested-size
blocks have been split just once to form twice as many blocks in the
next lowest free list.  Thus the lowest value of N is 2 and the lowest
vale of F is 0.5.  I readied a patch that, in essence, defined
F = 1 - 2/N and thereby set the bounds of __fragmentation_index() as
0 <= F < 1.  Before sending it, I realised that, during testing, I *had* seen
the occasional instance of F < 0.5, e.g. F = 0.499.  Revisting the
calculation, I see that the actual implementation is

F = 1 - [1/N + 1/info->free_blocks_total]

meaning that a very severe shortage of free memory *could* tip the
balance in favour of "low fragmentation".  Although this seems highly
unlikely to occur outside testing, it does reflect the directive in the
comment above the function, i.e. favour page reclaim when fragmentation
is low.  My second question: is the current implementation of F is
intentional and, if not, what is the actual intent?

The comments in compaction_suitable() suggest that the compaction/page
reclaim decision is one of cost but, as compaction is linear, this isn't
what __fragmentation_index() is calculating.  A more reasonable argument
is that there's generally some lower limit on the fragmentation
achievable through compaction, given the inevitable presence of
non-migratable pages.  Is there anything else going on?

Robert Harris
