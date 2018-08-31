Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE068C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BCC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yzf1GoE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BCC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeHaUiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:38:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aZaMyeYIzW94zNlfZHWpOYH8K8AlT31808LtMB8uB4I=; b=Yzf1GoE8pn56Kp3h24nmTfkc2
        FfpOA1i+0P7EMZAHVN6pta/Nh4RdwtrnhsuSJsaH1wOB6lOYLOqwDe9i86wSJZbe3ZI7+NdO8zbqX
        n20Hwl03bEUFIvFPbkmCzrg2OOYm4uLgYXaXwsh85HN0k0Z1H1v7CHHOZ+dpVDqzxDBWJUyHViLi8
        VJ2r7mCdXaW6SXjoLq4mhAPOCx2QO72991pq7j/KGwy0oXTPYQpqOBhsRX4HGQiR4ZJ1eFDlrZ0E2
        0X1YahIbkLV3arzj5i8BByaDXXXsD+3us2mcxUIOiGk+/lZraKdiyRKgG08OsiHm4BeMbHEaphsex
        pJo1ljD+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvmIa-0008AA-0B; Fri, 31 Aug 2018 16:29:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F232A2024D700; Fri, 31 Aug 2018 18:29:20 +0200 (CEST)
Date:   Fri, 31 Aug 2018 18:29:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Jann Horn <jannh@google.com>,
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
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
Message-ID: <20180831162920.GQ24124@hirez.programming.kicks-ass.net>
References: <1535660494.28258.36.camel@intel.com>
 <CAG48ez0yOuDhqxB779aO3Kss3gQ3cZTJL1VphDXQm+_M9jFPvQ@mail.gmail.com>
 <1535662366.28781.6.camel@intel.com>
 <CAG48ez0mkr95_TbLQnDGuGUd6G+eJVLZ-fEjDkwA6dSrm+9tLw@mail.gmail.com>
 <CAG48ez3S3+DzAyo_SnoUW1GO0Cpd_x0A83MOx2p_MkogoAatLQ@mail.gmail.com>
 <20180831095300.GF24124@hirez.programming.kicks-ass.net>
 <1535726032.32537.0.camel@intel.com>
 <f5a36e32-7c5f-91fe-9e98-fb44867fda11@linux.intel.com>
 <1535730524.501.13.camel@intel.com>
 <6d31bd30-6d5b-bbde-1e97-1d8255eff76d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d31bd30-6d5b-bbde-1e97-1d8255eff76d@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:58:39AM -0700, Dave Hansen wrote:
> On 08/31/2018 08:48 AM, Yu-cheng Yu wrote:
> > To trigger a race in ptep_set_wrprotect(), we need to fork from one of
> > three pthread siblings.
> > 
> > Or do we measure only how much this affects fork?
> > If there is no racing, the effect should be minimal.
> 
> We don't need a race.
> 
> I think the cmpxchg will be slower, even without a race, than the code
> that was there before.  The cmpxchg is a simple, straightforward
> solution, but we're putting it in place of a plain memory write, which
> is suboptimal.

Note quite, the clear_bit() is LOCK prefixed.
