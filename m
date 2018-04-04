Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755943AbeDDAED convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:04:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:9302 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753927AbeDDAEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:04:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,403,1517904000";
   d="scan'208";a="43792704"
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
CC: Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Thread-Topic: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Thread-Index: AdPK2c/PPwOowndOTcOJK3AvgBGmfAAf20wAAAkhGgAACoL0sA==
Date: Wed, 4 Apr 2018 00:04:00 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
In-Reply-To: <20180403185829.yteixqsb5zazmav6@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjk3ZDRjZTctM2QyNy00NmU3LTg5MWMtMWRhOTAyMzVjNWYyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJPZ2dVVWQ1SWlCSlZBU3A4QzkyZm5RWExuOTFpbm0rejRBNzVtNFh1VEZiUEpoTFo5WG5mS0c0djlBNkVkRW5SIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> bisect says:
>
> d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")
> 
> Reverting just this commit makes the problem go away.

The unaligned read and write seem to come from:

struct util_est ue = READ_ONCE(p->se.avg.util_est);
WRITE_ONCE(p->se.avg.util_est, ue);

which is puzzling as they were around before. Also the "avg"
field is tagged with an attribute to make it cache aligned
and there don't look to be holes in the structure that would
make util_est not be 8-byte aligned ... though it does consist
of two 4-byte fields, so legal for it to be 4-byte aligned.

-Tony
