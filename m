Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7543C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94456217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551171910;
	bh=3sto7kOpeZ2qCYgIlWzHM5FOi5FiA0U84uVW6InFnvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TLW9vTNAwf2sKPBPASfolK4trsE3i2IlsBFg5pGGi8AK4cjYP5YAvLUFcSC6LMpQA
	 EGKpoYP1Vz1o0yugeQBgQaIZr7DiNp3ZkEjvZkNNeuNLdZ6ae4CFfjmmvX7ZUNat0y
	 /QO1ngocn1ZN3gkkXGwHWsedqdl7G14mcMQqm46g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBZJFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfBZJFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:05:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB561213A2;
        Tue, 26 Feb 2019 09:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551171908;
        bh=3sto7kOpeZ2qCYgIlWzHM5FOi5FiA0U84uVW6InFnvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV5ZMwx5QR95+X9mENSkQHToAuS8anWCaluRgDP6G1ZEcAWaHNSlR/cokdQhnVNXp
         u4KPJ5nRfhfKXpPdBznjb7xPuHk4DuL8W6Nl6DE0Q4IcXBslq5oHeJWuCQ+cO5h+z7
         4JLnNYQ1y8zzvNhmDINsystLE+2uSIXuqTZ/CNN0=
Date:   Tue, 26 Feb 2019 10:05:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Subject: Re: [bug report][stable] perf probe: failed to add events
Message-ID: <20190226090505.GA24409@kroah.com>
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
> Hi,
> 
> I'm using kernel v4.19.24 and have found that there is an issue when
> using perf probe to define a new dynamic tracepoint.
> 
> $ perf probe -a handle_mm_fault
> Failed to write event: Numerical result out of range
>   Error: Failed to add events.
> 
> I've also tried kernel v4.20, and it can pass.

Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
you can run 'git bisect' to find the offending commit?

> So I've bisected and finally found the first good commit is:
> bf904d2762ee x86/pti/64: Remove the SYSCALL64 entry trampoline
> which is based on another commit:
> 98f05b5138f0 Use the TSS sp2 slot for SYSCALL/SYSRET scratch space
> 
> Once I've backpoted these two commits into 4.19.24, the above case can
> pass, though I'm not sure how it is fixed.
> So is there any plan to let them go into stable as well?

If they are needed, I'll gladly queue them up, but this feels like
something might have broken, so it should be easier to just revert the
offending commit instead.

Andy, any ideas?

thanks,

greg k-h
