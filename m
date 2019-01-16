Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39560C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E33206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfAPXkC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:40:02 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:47191 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfAPXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:40:02 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x0GNdl1C009943
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Jan 2019 08:39:47 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0GNdltj028347;
        Thu, 17 Jan 2019 08:39:47 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0GNaxs1017996;
        Thu, 17 Jan 2019 08:39:47 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1511757; Thu, 17 Jan 2019 08:32:09 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Thu,
 17 Jan 2019 08:32:08 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Jane Chu <jane.chu@oracle.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
Thread-Topic: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
Thread-Index: AQHUrX4o7Slk8dv5sk2r4phfic2oGKWxl6AAgABd54A=
Date:   Wed, 16 Jan 2019 23:32:07 +0000
Message-ID: <20190116233207.GA5868@hori1.linux.bs1.fc.nec.co.jp>
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
 <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
 <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
 <97e179e1-8a3a-5acb-78c1-a4b06b33db4c@oracle.com>
In-Reply-To: <97e179e1-8a3a-5acb-78c1-a4b06b33db4c@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.84]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <68BC388A3267A242ADFC5973F8C41A59@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

On Wed, Jan 16, 2019 at 09:56:02AM -0800, Jane Chu wrote:
> Hi, Naoya,
> 
> On 1/16/2019 1:30 AM, Naoya Horiguchi wrote:
> 
>     diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>     index 7c72f2a95785..831be5ff5f4d 100644
>     --- a/mm/memory-failure.c
>     +++ b/mm/memory-failure.c
>     @@ -372,7 +372,8 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>                             if (fail || tk->addr_valid == 0) {
>                                     pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>                                            pfn, tk->tsk->comm, tk->tsk->pid);
>     -                               force_sig(SIGKILL, tk->tsk);
>     +                               do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
>     +                                                tk->tsk, PIDTYPE_PID);
>                             }
> 
> 
> Since we don't care the return from do_send_sig_info(), would you mind to
> prefix it with (void) ?

Sorry, I'm not sure about the benefit to do casting the return value
just being ignored, so personally I'd like keeping the code simple.
Do you have some in mind?

- Naoya
