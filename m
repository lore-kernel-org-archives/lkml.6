Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB3D5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602A4208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x6uEGeiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602A4208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbeFNOrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:47:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeFNOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bzsp9R/0/TnIKNRQwr3DEN7SceKsbqc5Ixm+pnWo0j8=; b=x6uEGeiWXHW+jBzjcMWRLT4ON
        OZPE2wxzoANWTR+a0lT1QGPvFczh/uuAvUBsJJRdZ5DW2wCBhvx/TF4Dr7XSiVDUFuzhiFlIYwrvx
        hC7sgtngA7REYdmF95ycXplBM4qn457vqjooHb+lEuHdcXphNBX6ezislsxYAbbRa8S9AVhYk9O8S
        6CSp5+9XrKKYVR/dTSkHqs0xxB/GSKt23wsodJf2plhAD7NrTmq4imGfvhkyz0+zbMdjgyK0cyc5X
        moptAka5BKeXifA8IGsU8OGYCDaBUejYkGUyP6KR0lxbzmIRtikUL2B+U4gCS63pweTGxaNISxRWq
        rbJc3Dxbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTTWh-0005GI-08; Thu, 14 Jun 2018 14:47:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1D79201EA7C8; Thu, 14 Jun 2018 16:46:59 +0200 (CEST)
Date:   Thu, 14 Jun 2018 16:46:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180614144659.GC12198@hirez.programming.kicks-ass.net>
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614113604.GZ12198@hirez.programming.kicks-ass.net>
 <7eb10c22-57b3-1472-0a77-7f787f612217@vmware.com>
 <20180614132905.GA7841@bombadil.infradead.org>
 <425f4d5b-d414-de46-f388-55f1e6821ba6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425f4d5b-d414-de46-f388-55f1e6821ba6@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 03:43:04PM +0200, Thomas Hellstrom wrote:
> It's intended to be enforced by storing the algorithm choice in the
> WW_MUTEX_CLASS which must be common for an acquire context and the
> ww_mutexes it acquires. However, I don't think there is a check that that
> holds. I guess we could add it as a DEBUG_MUTEX test in ww_mutex_lock().

There is ww_mutex_lock_acquired():

	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class)

which should trigger if you try and be clever.
