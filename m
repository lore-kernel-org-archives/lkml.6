Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250C4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D506A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PP3cIKmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D506A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeHaOAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:00:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Z9clxjW3U+Fz0CBnB0Xf1KD0++mL+Gum5NfWi0pfRE=; b=PP3cIKmP5FW8cPZQltFqraD5M
        SBQU8PR7OlGE+W8n5eIueLjaMEnKjNuNFP5eZA5Cu37PMu73qny/kfL1O+HU7unmyruQH4XaPNO83
        T8gQJ9kPmpC5NEhEyjfjK9y6L830NFfSOQ/hKGtXJPhJ5Yl9eUvr6+0G0cIAZmqn8Fo8wBXlwPKCU
        q3elfpJ0qy6wFWOnkCFaNsttVrywd1grQSd1sy133xNymKAK37E6adqngjveQ+envgjiFkaY0IiWs
        Ervf3MSWMFcWtiOhf4gqnbeUIsn7HKJKL4Q6PGyzHN9Ja+F75PhacrTMrhs6/rxhjLYbRdgTtcD3U
        OJlOsVqjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvg6v-0006BR-7p; Fri, 31 Aug 2018 09:53:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12B222024D700; Fri, 31 Aug 2018 11:53:00 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:53:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
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
Message-ID: <20180831095300.GF24124@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3S3+DzAyo_SnoUW1GO0Cpd_x0A83MOx2p_MkogoAatLQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:47:16PM +0200, Jann Horn wrote:
>         do {
>                 pte = pte_wrprotect(pte);
>                 /* note: relies on _PAGE_DIRTY_HW < _PAGE_DIRTY_SW */
>                 /* dirty direct bit-twiddling; you can probably write
> this in a nicer way */
>                 pte.pte |= (pte.pte & _PAGE_DIRTY_HW) >>
> _PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
>                 pte.pte &= ~_PAGE_DIRTY_HW;
>                 pte = cmpxchg(ptep, pte, new_pte);
>         } while (pte != new_pte);

Please use the form:

	pte_t new_pte, pte = READ_ONCE(*ptep);
	do {
		new_pte = /* ... */;
	} while (!try_cmpxchg(ptep, &pte, new_pte);

Also, this will fail to build on i386-PAE, but I suspect this code will
be under some CONFIG option specific to x86_64 anyway.
