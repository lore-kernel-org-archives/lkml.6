Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2591C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EF3223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="as6pH9A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF3223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeKLStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:49:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeKLStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hnuroTyDW2i5GN4XkKKngIjHBnLFpctUGkvwhs7Hyrg=; b=as6pH9A9yTcM3DRNzSQr9FmeX
        +w8c5MY8lJlTNWSEE6Qv02XgOlv9Cgx4A5CPUQdsxUg6pEoTp5rAJGRPqaKpgpwz3H/q5Pzg/8LP/
        PrQi5W2R1wEGFhVpR+xG0uJLKWIRlb+CwZ+INzygPrwXMRwRGfy9hvAcR+3m4NVICLjtI8B5zdY2M
        tmTNCqr1N5exLE8oSjSzfMd0fqk0VBeu68YUrWyVQqzl2Vi1/LwvTfoZI+gsSbPTUpkxF5O3ccmZd
        JUH5ARZU5jJg7ycCdmPsBqkQHnEQQnz732NUJKYTlJ3VWrgvHONNuJuCopgae5R3EAfkNFU++uYfV
        XnY+kwDSw==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM81a-0007i6-QD; Mon, 12 Nov 2018 08:56:50 +0000
Received: by worktop (Postfix, from userid 1000)
        id 130126E03B0; Mon, 12 Nov 2018 09:56:50 +0100 (CET)
Date:   Mon, 12 Nov 2018 09:56:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
Message-ID: <20181112085650.GM3056@worktop>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
 <20181108101729.GP9761@hirez.programming.kicks-ass.net>
 <20181112053147.GA78520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112053147.GA78520@gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 06:31:47AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 08, 2018 at 07:32:46AM +0100, Ingo Molnar wrote:
> > > 
> > > * Aubrey Li <aubrey.li@intel.com> wrote:
> > > 
> > > > Expose the per-task cpu specific thread state value, it's helpful
> > > > for userland to classify and schedule the tasks by different policies
> > > 
> > > That's pretty vague - what exactly would use this information? I'm sure 
> > > you have a usecase in mind - could you please describe it?
> > 
> > Yeah, "thread_state" is a pretty terrible name for this. The use-case is
> > detectoring which tasks use AVX3 such that a userspace component (think
> > job scheduler) can cluster them together.
> 
> I'd prefer the kernel to do such clustering...

I think that is a next step.

Also, while the kernel can do this at a best effort basis, it cannot
take into account things the kernel doesn't know about, like high
priority job peak load etc.., things a job scheduler would know.

Then again, a job scheduler would likely already know about the AVX
state anyway.
