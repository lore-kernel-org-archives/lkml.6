Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82B1C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC00206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cX7f602j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC00206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKUAi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:38:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUAi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=chWQynWaHweaWzzdgCKhL9DCQEUA09Im9v2AN4XaQUA=; b=cX7f602jKEcli+TP2UqDKhJmV
        4anpLZuhV8FNFWO0X4hNzrkMFeqS7J8Pk/uRovkc2qIFoYykPcdkKd3VDtIHUVkOYXiaHKbq8Sf/+
        F8KDR91AcIchfOXRVr+J6I4L/7tZl0SurZ8nfj2tb4gxXfX34Blgkht4fqIJCO7c1uU0Z+RwEOPjo
        mCS7ebRCZSkDIY16db1yNDvQ1HSeYqDFx2SHtsy+ELtydWcUGX8BmW+svPav2H8Na6SmVoYZSNNiP
        ORtXRMoYA7lTKMvtvyi9OblBO5oNOpx+3Wm8VZqX7jzdEGj/d9fjTZLAhKSyK2qR53qdl5LtPuQvU
        K3LN+s16A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6iU-0002Vp-T1; Tue, 20 Nov 2018 14:09:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 587392029F87F; Tue, 20 Nov 2018 15:09:25 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:09:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 18/25] vtime: Track nice-ness on top of context switch
Message-ID: <20181120140925.GV2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-19-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-19-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:46:02AM +0100, Frederic Weisbecker wrote:
> We need to read the nice value of the task running on any CPU, possibly
> remotely, in order to correctly support kcpustat on nohz_full.
> Unfortunately we can't just read task_nice(tsk) when tsk runs on another
> CPU because its nice value may be concurrently changed. There could be a
> risk that a recently modified nice value is thought to apply for a longer
> while than is supposed to.
> 
> For example if a task runs at T0 with nice = -10, then its nice value
> is changed at T0 + 1 second with nice = 10, a reader at T0 + 1 second
> could think that the task had this "nice == 10" value since the beginning
> (T0) and spuriously account 1 second nice time on kcpustat instead of 1
> second user time.
> 
> So we need to track the nice value changes under vtime seqcount. Start
> with context switches and account the vtime nice-ness on top of it.

Huh, what!? That doesn't make any sense..
