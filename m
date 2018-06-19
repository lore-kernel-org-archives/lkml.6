Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDFAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6996A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uOggwq1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756877AbeFSJow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:44:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755270AbeFSJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZnYOCbje+sb3JV62wl4oKJPwf2rfgXuLiPbr8Ir4ucI=; b=uOggwq1QLbIYfYuvuJUg8WorP
        VQqhqRplVg730FZkjNykO+/AKG9Z71mzfT3t1tngszW4p0onwCgMWrdUen4hWouVotqG/wkzkuGZa
        yDlyh0slbYQsNRal9yd/nOxwuEZQ/giRebtN9ZsFYAmEM9uQL+xzHhkpb3zeBBkW8qRFMiOIj+F4a
        rhiizRFU/EJXbT1ld9CpKsFpJQi2Xb+Lhxvp/Z6sf3RsmW6MxuOUdK4CLQHEFpBYFk4qPUHsCTenp
        PmotjmlDgIsDCjVXe9kiARH0ZMTqhgvcsuyfe02kcNL2eMO/hGqhkLah0JePIhtf7IzMhJyXm+GAc
        msqtw5INg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVDBL-0001hc-Fm; Tue, 19 Jun 2018 09:44:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80CA620268507; Tue, 19 Jun 2018 11:44:09 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:44:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
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
Subject: Re: [PATCH 1/3] locking: WW mutex cleanup
Message-ID: <20180619094409.GK2458@hirez.programming.kicks-ass.net>
References: <20180619082445.11062-1-thellstrom@vmware.com>
 <20180619082445.11062-2-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619082445.11062-2-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:24:43AM +0200, Thomas Hellstrom wrote:
> From: Peter Ziljstra <peterz@infradead.org>
> 
> Make the WW mutex code more readable by adding comments, splitting up
> functions and pointing out that we're actually using the Wait-Die
> algorithm.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Co-authored-by: Thomas Hellstrom <thellstrom@vmware.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  Documentation/locking/ww-mutex-design.txt |  12 +-
>  include/linux/ww_mutex.h                  |  28 ++---
>  kernel/locking/mutex.c                    | 202 ++++++++++++++++++------------
>  3 files changed, 145 insertions(+), 97 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
