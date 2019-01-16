Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC559C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbfAPJnr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:43:47 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:52939 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbfAPJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:43:47 -0500
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 04:43:45 EST
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x0G9X4BV021404
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 18:33:04 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0G9X45g021398;
        Wed, 16 Jan 2019 18:33:04 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0G9WWcY000507;
        Wed, 16 Jan 2019 18:33:04 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1507344; Wed, 16 Jan 2019 18:30:47 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Wed,
 16 Jan 2019 18:30:47 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Jane Chu <jane.chu@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: hwpoison: use do_send_sig_info() instead of force_sig()
 (Re: PMEM error-handling forces SIGKILL causes kernel panic)
Thread-Topic: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
Thread-Index: AQHUrX4o7Slk8dv5sk2r4phfic2oGA==
Date:   Wed, 16 Jan 2019 09:30:46 +0000
Message-ID: <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
 <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BD3F5D9C9DFE744584823ED995CFB4AB@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ CCed Andrew and linux-mm ]

On Fri, Jan 11, 2019 at 08:14:02AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> Hi Dan, Jane,
> 
> Thanks for the report.
> 
> On Wed, Jan 09, 2019 at 03:49:32PM -0800, Dan Williams wrote:
> > [ switch to text mail, add lkml and Naoya ]
> > 
> > On Wed, Jan 9, 2019 at 12:19 PM Jane Chu <jane.chu@oracle.com> wrote:
> ...
> > > 3. The hardware consists the latest revision CPU and Intel NVDIMM, we suspected
> > >    the CPU faulty because it generated MCE over PMEM UE in a unlikely high
> > >    rate for any reasonable NVDIMM (like a few per 24hours).
> > >
> > > After swapping the CPU, the problem stopped reproducing.
> > >
> > > But one could argue that perhaps the faulty CPU exposed a small race window
> > > from collect_procs() to unmap_mapping_range() and to kill_procs(), hence
> > > caught the kernel  PMEM error handler off guard.
> > 
> > There's definitely a race, and the implementation is buggy as can be
> > seen in __exit_signal:
> > 
> >         sighand = rcu_dereference_check(tsk->sighand,
> >                                         lockdep_tasklist_lock_is_held());
> >         spin_lock(&sighand->siglock);
> > 
> > ...the memory-failure path needs to hold the proper locks before it
> > can assume that de-referencing tsk->sighand is valid.
> > 
> > > Also note, the same workload on the same faulty CPU were run on Linux prior to
> > > the 4.19 PMEM error handling and did not encounter kernel crash, probably because
> > > the prior HWPOISON handler did not force SIGKILL?
> > 
> > Before 4.19 this test should result in a machine-check reboot, not
> > much better than a kernel crash.
> > 
> > > Should we not to force the SIGKILL, or find a way to close the race window?
> > 
> > The race should be closed by holding the proper tasklist and rcu read lock(s).
> 
> This reasoning and proposal sound right to me. I'm trying to reproduce
> this race (for non-pmem case,) but no luck for now. I'll investigate more.

I wrote/tested a patch for this issue.
I think that switching signal API effectively does proper locking.

Thanks,
Naoya Horiguchi
---
From 16dbf6105ff4831f73276d79d5df238ab467de76 Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Wed, 16 Jan 2019 16:59:27 +0900
Subject: [PATCH] mm: hwpoison: use do_send_sig_info() instead of force_sig()

Currently memory_failure() is racy against process's exiting,
which results in kernel crash by null pointer dereference.

The root cause is that memory_failure() uses force_sig() to forcibly
kill asynchronous (meaning not in the current context) processes.  As
discussed in thread https://lkml.org/lkml/2010/6/8/236 years ago for
OOM fixes, this is not a right thing to do.  OOM solves this issue by
using do_send_sig_info() as done in commit d2d393099de2 ("signal:
oom_kill_task: use SEND_SIG_FORCED instead of force_sig()"), so this
patch is suggesting to do the same for hwpoison.  do_send_sig_info()
properly accesses to siglock with lock_task_sighand(), so is free from
the reported race.

I confirmed that the reported bug reproduces with inserting some delay
in kill_procs(), and it never reproduces with this patch.

Note that memory_failure() can send another type of signal using
force_sig_mceerr(), and the reported race shouldn't happen on it
because force_sig_mceerr() is called only for synchronous processes
(i.e. BUS_MCEERR_AR happens only when some process accesses to the
corrupted memory.)

Reported-by: Jane Chu <jane.chu@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7c72f2a95785..831be5ff5f4d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -372,7 +372,8 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			if (fail || tk->addr_valid == 0) {
 				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
-				force_sig(SIGKILL, tk->tsk);
+				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
+						 tk->tsk, PIDTYPE_PID);
 			}
 
 			/*
-- 
2.7.5


