Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052252084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfAKIPb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:15:31 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:39746 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfAKIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:15:31 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x0B8FKgw004575
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jan 2019 17:15:20 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0B8FKTk022401;
        Fri, 11 Jan 2019 17:15:20 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0B8FKfp013282;
        Fri, 11 Jan 2019 17:15:20 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1394824; Fri, 11 Jan 2019 17:14:04 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Fri,
 11 Jan 2019 17:14:03 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jane Chu <jane.chu@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PMEM error-handling forces SIGKILL causes kernel panic
Thread-Topic: PMEM error-handling forces SIGKILL causes kernel panic
Thread-Index: AQHUqHYAxvTPvTfmqUexHC1SPEdRnKWpI2uA
Date:   Fri, 11 Jan 2019 08:14:02 +0000
Message-ID: <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
In-Reply-To: <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <20D6C8CB51441D4F91DA79AE81215CE1@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan, Jane,

Thanks for the report.

On Wed, Jan 09, 2019 at 03:49:32PM -0800, Dan Williams wrote:
> [ switch to text mail, add lkml and Naoya ]
> 
> On Wed, Jan 9, 2019 at 12:19 PM Jane Chu <jane.chu@oracle.com> wrote:
...
> > 3. The hardware consists the latest revision CPU and Intel NVDIMM, we suspected
> >    the CPU faulty because it generated MCE over PMEM UE in a unlikely high
> >    rate for any reasonable NVDIMM (like a few per 24hours).
> >
> > After swapping the CPU, the problem stopped reproducing.
> >
> > But one could argue that perhaps the faulty CPU exposed a small race window
> > from collect_procs() to unmap_mapping_range() and to kill_procs(), hence
> > caught the kernel  PMEM error handler off guard.
> 
> There's definitely a race, and the implementation is buggy as can be
> seen in __exit_signal:
> 
>         sighand = rcu_dereference_check(tsk->sighand,
>                                         lockdep_tasklist_lock_is_held());
>         spin_lock(&sighand->siglock);
> 
> ...the memory-failure path needs to hold the proper locks before it
> can assume that de-referencing tsk->sighand is valid.
> 
> > Also note, the same workload on the same faulty CPU were run on Linux prior to
> > the 4.19 PMEM error handling and did not encounter kernel crash, probably because
> > the prior HWPOISON handler did not force SIGKILL?
> 
> Before 4.19 this test should result in a machine-check reboot, not
> much better than a kernel crash.
> 
> > Should we not to force the SIGKILL, or find a way to close the race window?
> 
> The race should be closed by holding the proper tasklist and rcu read lock(s).

This reasoning and proposal sound right to me. I'm trying to reproduce
this race (for non-pmem case,) but no luck for now. I'll investigate more.

Thanks,
Naoya Horiguchi
