Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5936DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063A125AC6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eWuLqkoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063A125AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFZHnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:43:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wYPy+O0T+s5w6TsZEKd1bVF/i4NF5faDJ4NBpx5/QCA=; b=eWuLqkoe9RHQqEbpW6CWa9WVB
        FTcDav8SmUzfk2mjyH7lxqwP+5mW2pKKq2wn04vMWQOWjYVKoUpUxr9Rnf9nB25/kprb3e7mn09Hc
        cU0XbXlCjVj9znhmFYp4YNOlexDZpaHeDtUeMV1U5kc0+R+wEAg5IshPyecozrdMC3giNiM8V9et6
        POZC+YKZgJ+20WBKEhzsaI0S6FlvxTSQJtkkX3ynzUdGzT+/eIV+vs8v28X1dp6+A/2FzwRgQCd2S
        q7V2TKun20U6xaL/c8VCR5IedzysV1ExegaxkvqxceaTdu7sSlE8fAkvF7dtr0uo7/8QMd2u5oyQe
        wtj7hes2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXidd-0008Bv-Rq; Tue, 26 Jun 2018 07:43:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 592F02029F1D7; Tue, 26 Jun 2018 09:43:44 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:43:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180626074344.GZ2458@hirez.programming.kicks-ass.net>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
 <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
 <BFD6A249-B1D7-43D5-8D7C-9FAED4A168A1@gmail.com>
 <20180620071817.GJ13685@dhcp22.suse.cz>
 <263935d9-d07c-ab3e-9e42-89f73f57be1e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263935d9-d07c-ab3e-9e42-89f73f57be1e@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:06:23PM -0700, Yang Shi wrote:
> By looking this deeper, we may not be able to cover all the unmapping range
> for VM_DEAD, for example, if the start addr is in the middle of a vma. We
> can't set VM_DEAD to that vma since that would trigger SIGSEGV for still
> mapped area.
> 
> splitting can't be done with read mmap_sem held, so maybe just set VM_DEAD
> to non-overlapped vmas. Access to overlapped vmas (first and last) will
> still have undefined behavior.

Acquire mmap_sem for writing, split, mark VM_DEAD, drop mmap_sem. Acquire
mmap_sem for reading, madv_free drop mmap_sem. Acquire mmap_sem for
writing, free everything left, drop mmap_sem.

?

Sure, you acquire the lock 3 times, but both write instances should be
'short', and I suppose you can do a demote between 1 and 2 if you care.
