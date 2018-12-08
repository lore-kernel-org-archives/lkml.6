Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26872C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C0F20837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itLgCRA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C0F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLHK0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:26:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeLHK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=07RiZHcHjdKJ2YeIsFWn0aEEyX0t7mX5dlFrtveIP3g=; b=itLgCRA0RukirbstVBXuCLb96
        aXSsdwHHIv0D6FD2GkzJ4ijIDMIzdzybbMzQr+Ue4Va92NJ+KGyZWNVoTlMWDupb0FaOZLXBPi9Th
        eW7JsRMuz2YJ3xts/muZoOeHkMQ5qxqOlQ2oGnpVrMd63QoRf4ZcRvbFxKrS09M3CoUiVgUmKr70j
        SBuDNP82qczJX3NPcRhOiiBjNpY+Dpa1Wfofp20GrQC8w3hpjflUzT9rbYTLU1mMyVPCC6BQV2txR
        GVSh1QZhMvKgzEvxjpxLf/kLvWaf7PExsDjj8UDSVgAKbqyIcnnAO9c7SH3S/GZiWymJ6bMK0twW5
        v0O80p5Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVZok-0006Hr-RW; Sat, 08 Dec 2018 10:26:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29545207261A6; Sat,  8 Dec 2018 11:26:36 +0100 (CET)
Date:   Sat, 8 Dec 2018 11:26:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] locking/lockdep: Add support for dynamic keys
Message-ID: <20181208102636.GC5289@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
 <20181207122329.GA5289@hirez.programming.kicks-ass.net>
 <1544200552.185366.311.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544200552.185366.311.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:35:52AM -0800, Bart Van Assche wrote:
> On Fri, 2018-12-07 at 13:23 +0100, Peter Zijlstra wrote:
> > I took the first 15 patches for now to shrink the series.
> 
> Thanks Peter. Since I would like to rebase the remaining patches on top of
> what you have already queued: is what you have queued available in a public
> git repository? I had a quick look at
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/ but couldn't
> find my patches in any of the branches that have been updated in the last 24
> hours.

I host my quilt tree here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git

It is a throw-away auto generated git tree. Your patches would be in the
locking/core branch.

If all goes well, they should also show up in tip/locking/core
'soonish'.
