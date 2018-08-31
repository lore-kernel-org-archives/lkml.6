Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EAEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD0520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD0520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeHaSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:45:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:42997 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeHaSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:45:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 07:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="229217398"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2018 07:38:08 -0700
Message-ID: <1535726032.32537.0.camel@intel.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Fri, 31 Aug 2018 07:33:52 -0700
In-Reply-To: <20180831095300.GF24124@hirez.programming.kicks-ass.net>
References: <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com>
         <1535649960.26689.15.camel@intel.com>
         <33d45a12-513c-eba2-a2de-3d6b630e928e@linux.intel.com>
         <1535651666.27823.6.camel@intel.com>
         <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com>
         <1535660494.28258.36.camel@intel.com>
         <CAG48ez0yOuDhqxB779aO3Kss3gQ3cZTJL1VphDXQm+_M9jFPvQ@mail.gmail.com>
         <1535662366.28781.6.camel@intel.com>
         <CAG48ez0mkr95_TbLQnDGuGUd6G+eJVLZ-fEjDkwA6dSrm+9tLw@mail.gmail.com>
         <CAG48ez3S3+DzAyo_SnoUW1GO0Cpd_x0A83MOx2p_MkogoAatLQ@mail.gmail.com>
         <20180831095300.GF24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:53 +0200, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 11:47:16PM +0200, Jann Horn wrote:
> > 
> >         do {
> >                 pte = pte_wrprotect(pte);
> >                 /* note: relies on _PAGE_DIRTY_HW < _PAGE_DIRTY_SW
> > */
> >                 /* dirty direct bit-twiddling; you can probably
> > write
> > this in a nicer way */
> >                 pte.pte |= (pte.pte & _PAGE_DIRTY_HW) >>
> > _PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
> >                 pte.pte &= ~_PAGE_DIRTY_HW;
> >                 pte = cmpxchg(ptep, pte, new_pte);
> >         } while (pte != new_pte);
> Please use the form:
> 
> 	pte_t new_pte, pte = READ_ONCE(*ptep);
> 	do {
> 		new_pte = /* ... */;
> 	} while (!try_cmpxchg(ptep, &pte, new_pte);
> 
> Also, this will fail to build on i386-PAE, but I suspect this code
> will
> be under some CONFIG option specific to x86_64 anyway.

Thanks!  I will work on it.

Yu-cheng
