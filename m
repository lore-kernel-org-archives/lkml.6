Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF85C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC9821848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZM1/k2tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfA2PRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:17:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2PRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gjx0D2Hp2M6LW1jg+jUAo3bizRCgLIialUofJPerBW0=; b=ZM1/k2tvtEsbf4Yr3BAZU68P2
        aGBBvKiUnJ+pC5oDVacZS5s3oyMtjDVlQLFFy8uUEUxLSZViutxEhxlBgCApf2IBQmpOcml9jf5Di
        f7H74YUBsdSIu4OA/tIhqmsDJUIB49ePezMZuopRrv4+la2rnZZ4x5SpBxtlBwOPUc93t1f2d0wEt
        QYsAZYHfu9GTwbS1+QIgz6TJr4hzdUdy6G4hycQWTDwJyqzrDUgwT/ZfkXqQpwcQnuY2idiRbxenN
        ADWS3xs25+rgsjAP8/QvH7fjMcKaT0IlurWuD8d2nBh5HNkIKCd/w5H7Zkw3Bkvpn7q5dNGx7JeOs
        +LXkOyuWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goV88-0002kd-8I; Tue, 29 Jan 2019 15:16:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD64520101B8C; Tue, 29 Jan 2019 16:16:49 +0100 (CET)
Date:   Tue, 29 Jan 2019 16:16:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
Message-ID: <20190129151649.GA2997@hirez.programming.kicks-ass.net>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-6-surenb@google.com>
 <20190129123843.GK28467@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129123843.GK28467@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 01:38:43PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> > +			atomic_set(&group->polling, polling);
> > +			/*
> > +			 * Memory barrier is needed to order group->polling
> > +			 * write before times[] read in collect_percpu_times()
> > +			 */
> > +			smp_mb__after_atomic();
> 
> That's broken, smp_mb__{before,after}_atomic() can only be used on
> atomic RmW operations, something atomic_set() is _not_.

Also; the comment should explain _why_ not only what.
