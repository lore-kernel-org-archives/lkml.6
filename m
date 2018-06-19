Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B837C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ED72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ged7QYXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ED72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937575AbeFSJpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:45:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35532 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937535AbeFSJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BNLtSJo4CWlLRHNPtaM2MNlFlA15JqjC0pIdWXVZOfc=; b=ged7QYXKhD1kM9RpdrczSnFkd
        1FF0mtrfA/2kopcWtHVPCapSISJVkT/j/SIwtCn+YDtlLfgZaHYgR5v6BLtPWfsPZd85oPjvzEcI9
        OnsnAEunfCTxh/BA8PtsxljwoqW/x7igJokjo3raxYdz1mfwAEI6E/Wqtv4z0wIsQyznwUeTgsnFQ
        OunzfyXG5klMjdimVz18ZmUn4GhjUvzwfbmXHEP1h4bGt+uu0Z1+bMFc6d68L5aNeRtQJtzkRvvep
        vIgCC2PrjE/qyzl3QAi+1xRPFNGl5cGt6634KD4QeV5F6P68G7vBjdO90TUuW6P3zo65jyDeey9Km
        Y84uN5FuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVDCB-00071a-2q; Tue, 19 Jun 2018 09:45:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6E120268507; Tue, 19 Jun 2018 11:45:00 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:45:00 +0200
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
Subject: Re: [PATCH v4 2/3] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180619094500.GL2458@hirez.programming.kicks-ass.net>
References: <20180619082445.11062-1-thellstrom@vmware.com>
 <20180619082445.11062-3-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619082445.11062-3-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:24:44AM +0200, Thomas Hellstrom wrote:
> The current Wound-Wait mutex algorithm is actually not Wound-Wait but
> Wait-Die. Implement also Wound-Wait as a per-ww-class choice. Wound-Wait
> is, contrary to Wait-Die a preemptive algorithm and is known to generate
> fewer backoffs. Testing reveals that this is true if the
> number of simultaneous contending transactions is small.
> As the number of simultaneous contending threads increases, Wait-Wound
> becomes inferior to Wait-Die in terms of elapsed time.
> Possibly due to the larger number of held locks of sleeping transactions.
> 
> Update documentation and callers.
> 
> Timings using git://people.freedesktop.org/~thomash/ww_mutex_test
> tag patch-18-06-15
> 
> Each thread runs 100000 batches of lock / unlock 800 ww mutexes randomly
> chosen out of 100000. Four core Intel x86_64:
> 
> Algorithm    #threads       Rollbacks  time
> Wound-Wait   4              ~100       ~17s.
> Wait-Die     4              ~150000    ~19s.
> Wound-Wait   16             ~360000    ~109s.
> Wait-Die     16             ~450000    ~82s.
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
> Co-authored-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> 
> ---
>  Documentation/locking/ww-mutex-design.txt |  57 +++++++++--
>  drivers/dma-buf/reservation.c             |   2 +-
>  drivers/gpu/drm/drm_modeset_lock.c        |   2 +-
>  include/linux/ww_mutex.h                  |  17 ++-
>  kernel/locking/locktorture.c              |   2 +-
>  kernel/locking/mutex.c                    | 165 +++++++++++++++++++++++++++---
>  kernel/locking/test-ww_mutex.c            |   2 +-
>  lib/locking-selftest.c                    |   2 +-
>  8 files changed, 213 insertions(+), 36 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
