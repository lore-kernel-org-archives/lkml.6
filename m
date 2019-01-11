Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630CA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EDXjX+mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfAKJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:16:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55884 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfAKJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2nGGM5Q3jk/aDnLCKMTW6iVRh37jiPxYSKQ4Jhzs7sM=; b=EDXjX+mnvbpLSLucLkWyfIaJu0
        iH8nnXDHFYerqA7mPRzV0AYiMuiH89YY7a9UxRQvsIZkJZM60Dkj9ZxMbtoN/aAsKtKYyrSOWi8HR
        DOYyq3SlCv/EOwhP4Z9EEiy0bxLA7wvVta42lrGZzZh5dq/pP3c/EwhX1CF4CrNwhftwKwKnqH4M6
        p5YEIhVVqWJw3sJjUg4fRq0EzfRwx7Hqx9DufeLRZmFMkpfQ7W1rCNoB1yIv2HOD0dNgWsN6fA8di
        JckPlDcLkMYFFVOSyzXZTbFBlNYjr2nedvvgHg093QTknzDg5DlR0hHAzBAQeEK4be2X/glHA/wRf
        xKpHydzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghsvf-0007xH-SU; Fri, 11 Jan 2019 09:16:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F0B420280450; Fri, 11 Jan 2019 10:16:38 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:16:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Question about qspinlock nest
Message-ID: <20190111091638.GK30894@hirez.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <2eca6f60-3e8b-a389-27cb-8adbd9676607@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eca6f60-3e8b-a389-27cb-8adbd9676607@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:06:52PM +0800, Zhenzhong Duan wrote:
> 
> On 2019/1/10 22:43, Waiman Long wrote:
> > On 01/10/2019 03:02 AM, Zhenzhong Duan wrote:
> > > Hi Maintainer,
> > > 
> > > 
> > > There is a question confused me for days. Appreciate an answer.
> > > 
> > > In below code, the comment says we never have more than 4 nested
> > > contexts.
> > > 
> > > What happen if debug and mce exceptions nest with the four, or we
> > > ensure it never happen?
> > > 
> > > 
> > > /*
> > >   * Per-CPU queue node structures; we can never have more than 4 nested
> > >   * contexts: task, softirq, hardirq, nmi.
> > >   *
> > >   * Exactly fits one 64-byte cacheline on a 64-bit architecture.
> > >   *
> > >   * PV doubles the storage and uses the second cacheline for PV state.
> > >   */
> > > static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
> > > 
> > Yes, both debug and mce exceptions are some kind of NMIs. So
> > theoretically, it is possible to have more than four. Are you aware of
> > any debug and MCE exception handlers that need to take a spinlock for
> > synchronization?
> 
> Not for debug exception, for MCE exception handler I found below two:
> 
> do_machine_check->mce_report_event->schedule_work
> do_machine_check->force_sig->force_sig_info
> 
> schedule_work() and force_sig_info() take spinlocks.

Boris, how can this be?
