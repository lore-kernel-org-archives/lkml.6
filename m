Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FD9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3FD246CC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3FD246CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeGDD6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:58:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932434AbeGDD6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 532FD40676C0;
        Wed,  4 Jul 2018 03:58:06 +0000 (UTC)
Received: from sky.random (ovpn-120-117.rdu2.redhat.com [10.10.120.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E24621C59C;
        Wed,  4 Jul 2018 03:58:05 +0000 (UTC)
Date:   Tue, 3 Jul 2018 23:58:05 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] userfaultfd: hugetlbfs: Fix userfaultfd_huge_must_wait
 pte access
Message-ID: <20180704035805.GA9833@redhat.com>
References: <20180626132421.78084-1-frankja@linux.ibm.com>
 <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>
 <961dc253-b071-8a72-c046-c23cae377e2c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961dc253-b071-8a72-c046-c23cae377e2c@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 03:58:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 03:58:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'aarcange@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 27, 2018 at 10:47:44AM +0200, Janosch Frank wrote:
> On 26.06.2018 19:00, Mike Kravetz wrote:
> > On 06/26/2018 06:24 AM, Janosch Frank wrote:
> >> Use huge_ptep_get to translate huge ptes to normal ptes so we can
> >> check them with the huge_pte_* functions. Otherwise some architectures
> >> will check the wrong values and will not wait for userspace to bring
> >> in the memory.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
> > Adding linux-mm and Andrew on Cc:
> > 
> > Thanks for catching and fixing this.
> 
> Sure
> I'd be happy if we get less of these problems with time, this one was
> rather painful to debug. :)

What I thought when I read the fix is it would be more robust and we
could catch any further error like this at build time by having
huge_pte_offset return a new type "hugepte_t *" instead of the current
"pte_t *". Of course then huge_ptep_get() would take a "hugepte_t *" as
parameter. The x86 implementation would then become:

static inline pte_t huge_ptep_get(hugepte_t *ptep)
{
	return *(pte_t *)ptep;
}

I haven't tried it, perhaps it's not feasible for other reasons
because there's a significant fallout from such a change (i.e. a lot
of hugetlbfs methods needs to change input type), but you said you're
actively looking to get less of these problems this could be a way if
it can be done, so I should mention it.

The need of huge_ptep_get() of course is very apparent when reading the
fix, but it was all but apparent when reading the previous code and the
previous code was correct for x86 because of course huge_ptep_get is
implemented as *ptep on x86.

For now the current fix is certainly good, any robustness cleanup is
cleaner if done orthogonal anyway.

Thanks!
Andrea
