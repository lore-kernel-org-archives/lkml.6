Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C67C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372B720665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXsPxpxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372B720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJWROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:14:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeJWROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5O5EUWCTYX4TgB0xqILhK7k+WaSQy4FSABRtisgyZT0=; b=oXsPxpxswdyp1yeiLHNOFO0Af
        WjK4nIFSeA7vB8QyznXi7lhjtibZiPXw+bn8SOFzDB7F1fB5IHdr4l45lCk1kaHTDHGrFsw41+vRr
        xy69QURCWDtGR51gWrEw49QU44dIof2D5UUZWSs0uAqy1CnF1sTtNUDjQ9XvxgcCBV5sfj+DNbtdM
        MxCUar6PjiaHydwc/OGyLlcl6p0ZJRv3Tv+GtRwJQKAw3WKAuRzxjDzNJqDLqD5VrD/FvAjyzh1S6
        4dYB5QUHQdzcqZ9tVv/qse3mgA4WyNHrxVUFNyfmw2+yIIb9sn5ffj5rdPfYmibrNDe0FWmiliMfv
        dfUF9Wfxw==;
Received: from [185.7.230.213] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEsPR-0001Zl-TW; Tue, 23 Oct 2018 08:51:30 +0000
Received: by worktop (Postfix, from userid 1000)
        id 9B2476E08AB; Tue, 23 Oct 2018 10:51:27 +0200 (CEST)
Date:   Tue, 23 Oct 2018 10:51:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     Waiman Long <longman@redhat.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181023085127.GG3109@worktop.c.hoisthospitality.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023025740.GL11769@yi.y.sun>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:57:40AM +0800, Yi Sun wrote:
> On 18-10-22 19:15:16, Peter Zijlstra wrote:

> > > >>>> +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
> > > >>>> +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
> > > >>>> +				break;
> > > >>>> +#endif
> > 
> > Secondly; how come you thought that was acceptable in any way shape or
> > form?
> > 
> Sorry for that. Will try another way.

Can you try and explain why vcpu_is_preempted() doesn't work for you?
