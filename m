Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C7FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EAC20647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EAC20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGQXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:39:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:34308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbeGQXjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:39:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 16:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,367,1526367600"; 
   d="scan'208";a="73200020"
Received: from 2b52.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2018 16:04:22 -0700
Message-ID: <1531868435.3541.18.camel@intel.com>
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 17 Jul 2018 16:00:35 -0700
In-Reply-To: <20180711092951.GW2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-17-yu-cheng.yu@intel.com>
         <20180711092951.GW2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 11:29 +0200, Peter Zijlstra wrote:
> On Tue, Jul 10, 2018 at 03:26:28PM -0700, Yu-cheng Yu wrote:
> > 
> > There are three possible shadow stack PTE settings:
> > 
> >   Normal SHSTK PTE: (R/O + DIRTY_HW)
> >   SHSTK PTE COW'ed: (R/O + DIRTY_HW)
> >   SHSTK PTE shared as R/O data: (R/O + DIRTY_SW)
> I count _2_ distinct states there.
> 
> > 
> > Update can_follow_write_pte/pmd for the shadow stack.
> So the below disallows can_follow_write when shstk && _PAGE_DIRTY_SW,
> but this here Changelog doesn't explain why. Doesn't even get close.

Can we add the following to the log:

When a SHSTK PTE is shared, it is (R/O + DIRTY_SW); otherwise it is
(R/O + DIRTY_HW).

When we (FOLL_WRITE | FOLL_FORCE) on a SHSTK PTE, the following
must be true:

  - It has been COW'ed at least once (FOLL_COW is set);
  - It still is not shared, i.e. PTE is (R/O + DIRTY_HW);

> 
> Also, the code is a right mess :/ Can't we try harder to not let this
> shadow stack stuff escape arch code.

We either check here if the VMA is SHSTK mapping or move the logic
to pte_dirty().  The latter would be less obvious.  Or can we
create a can_follow_write_shstk_pte()?

Yu-cheng
