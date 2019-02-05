Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8ZGqHvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBEMbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:31:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfBEMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QozlUW1TpJfnCAN2YHaDg9xm4V3p18WLYsFNk12knoM=; b=Z8ZGqHvBEiGfZIK8HeSftP03p
        NmizVFExKO8G/GODZmKcDVceS3iDKL8FPp99c4eNUi6he1ZN5Sao8zPRXPioT/tp8y78fZkU/F8DR
        oHGcdAvQEqwU5vNmAOCVQvFKcPVKBe3/qoO/bb6uvGPUSyRS8ALISQ1u6sF2xBPy3ZoRMWUW4fr1b
        dkOdAd17+mPdHtALAFOoTH5E8U+7vGJJollvkvWPHytfX7+YNR6TxSZMfgw5lMGtz6fs5pO9HAOkG
        i/IRe4+JQudT5iBEjGmjIq9g9oYgKj5N5VWPx37oTJYjgTHMQ2532oUvPjC0YKkSCMSm4GV17SEE/
        aKC+yDt1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqzsj-0006YQ-06; Tue, 05 Feb 2019 12:31:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 458092029FA02; Tue,  5 Feb 2019 13:31:14 +0100 (CET)
Date:   Tue, 5 Feb 2019 13:31:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/5] sched refcount_t conversions
Message-ID: <20190205123114.GR17528@hirez.programming.kicks-ass.net>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <20190118160312.GF14054@worktop.programming.kicks-ass.net>
 <2236FBA76BA1254E88B949DDB74E612BA4BA2980@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4BA2980@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:57:00AM +0000, Reshetova, Elena wrote:
> > On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> > > Elena Reshetova (5):
> > >   sched: convert sighand_struct.count to refcount_t
> > >   sched: convert signal_struct.sigcnt to refcount_t
> > 
> > These should really be seen by Oleg (bounced) and I'll await his reply.
> > 
> > >   sched: convert numa_group.refcount to refcount_t
> > >   sched/task_struct: convert task_struct.usage to refcount_t
> > >   sched/task_struct: convert task_struct.stack_refcount to refcount_t
> > 
> > Those are ok and I'll queue them.
> 
> Just to double check that nothing got lost in between: 
> I noticed that above task_struct patches got merged, is numa_group one also
> coming soon?

I have tip commit mails for all 5
