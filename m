Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E8C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE3F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PauAGUcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE3F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeKHTwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:52:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58448 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeKHTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tmRtPXjofVIj5o/lAJwKyOGggGTVfDB2eg0zVqw8p5g=; b=PauAGUcCB7E5u5Rddo6IMYZ+F
        WWCuIhpi5B77NQ3NAJTNTxZUWyQt8+aUk+THjemh/FoA76CK0f5whBYKfCIEhWZbAn9iCFFvsQWbe
        7vUIwGATxblqCW+91ajBXFy7KPGO9fIj94wzxhFdinCx6KQkRnwNWJV2DufZVXX5E+KwmdwUsJbVl
        kmzfpH2CzU8kWWxaDQK7XoKG27Me0sFW5YF5YJcz1T1rGikgzivEK1M3esUlXGEwPbQxp4T/XgzP2
        ksPrl7mtQ/KfS8JeIoV0Tr0+5VGdNi/hFyrn1owo/L1buH3VmAorpvu6DrGJ7EbslLp7Ep7a/HK5V
        jKhMIH0tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKhNU-0008TV-7N; Thu, 08 Nov 2018 10:17:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D36B520284F98; Thu,  8 Nov 2018 11:17:29 +0100 (CET)
Date:   Thu, 8 Nov 2018 11:17:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
Message-ID: <20181108101729.GP9761@hirez.programming.kicks-ass.net>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108063246.GA13233@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:32:46AM +0100, Ingo Molnar wrote:
> 
> * Aubrey Li <aubrey.li@intel.com> wrote:
> 
> > Expose the per-task cpu specific thread state value, it's helpful
> > for userland to classify and schedule the tasks by different policies
> 
> That's pretty vague - what exactly would use this information? I'm sure 
> you have a usecase in mind - could you please describe it?

Yeah, "thread_state" is a pretty terrible name for this. The use-case is
detectoring which tasks use AVX3 such that a userspace component (think
job scheduler) can cluster them together.

The 'problem' is that running AVX2+ code drops the max clock, because
you light up the massive wide (and thus large area) paths.

So maybe something like "simd_active" is a better name, dunno.

Or maybe "simd_class" and we can write out 0,1,2,3 depending on the AVX
class being used, dunno. It might make sense to look at what other arch
SIMD stuff looks like to form this interface.
