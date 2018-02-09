Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBIOoa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:44:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeBIOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:44:27 -0500
Subject: Re: [Resend] Possible bug in __fragmentation_index()
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180202174721.f63gume3klxevkbj@suse.de>
Date: Fri, 9 Feb 2018 14:43:50 +0000
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kemi Wang <kemi.wang@intel.com>,
        ying.huang@intel.com, David Rientjes <rientjes@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <AA7930B9-1E4D-400C-89EA-FC2FC6A7E1E4@oracle.com>
References: <83AECC32-77A4-427D-9043-DE6FC48AD3FC@oracle.com> <20180202174721.f63gume3klxevkbj@suse.de>
To: Mel Gorman <mgorman@suse.de>
X-Mailer: Apple Mail (2.1085)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Feb 2018, at 17:47, Mel Gorman wrote:

> On Fri, Feb 02, 2018 at 02:16:39PM +0000, Robert Harris wrote:
>> I was planning to annotate the opaque calculation in
>> __fragmentation_index() but on closer inspection I think there may be a
>> bug.  I could use some feedback.

A belated thank you for the reply.

> It's intentional but could be fixed to give a real bound of 0 to 1 instead
> of half the range as it currently give. The sysctl_extfrag_threshold should
> also be adjusted at that time. After that, the real work is determining
> if it's safe to strike a balance between reclaim/compaction that avoids
> unnecessary compaction while not being too aggressive about reclaim or
> having kswapd enter a runaway loop with a reintroduction of the "kswapd
> stuck at 100% CPU time" problems.

In my (incomplete) view, striking the balance is a case of determining the
cost of memory regeneration through compaction versus reclaim and choosing
the cheaper.  I'm reasonably confident that this could be achieved for
compaction, which is why the calculation in __fragmentation_index() caught
my eye in the first place, but reclaim/swapping is probably significantly
harder to quantify.  Similarly, a cost function for allocation failure
is also necessary but not obvious.

All of the above is just a nebulous plan for now;  in the meantime, I'll
change __fragmentation_index() and the threshold as you suggest.

Robert  Harris
