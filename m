Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89684213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPfCHTUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89684213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeK3FTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:19:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3FTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0HEU5J2Qf78Xp8NdP3inc4RVXCKDIY45GBCgQX2P4XE=; b=PPfCHTUOR2KlyKrsAEQcVhZPU
        eQ1He9vqP1qhM7VrqZw12MB6bRBKUN00TDNImUuVvIqQNatvzCzi0sKhlmFxQTa0Rsd9MZG3/itU1
        1h6OwcTgJZqReyJix5ox2n2Y1YdRvFdw8UGAqv/sAu1SIVtkXfSGGZSudRmwSDAQOH6jHI4nmKeKJ
        CVQ/xNX1X9BN01igBNZUx6p4INCvYun1kjorREwcZJMaF9lbL160qh82p/KQcwOh+H+uQN5kwweZn
        bTOxfCgRBm78yyrBjBVEJDi/GJr79hlasXoh8EUN4fuUIUKeS+Pp06u0X0Hl0U/bwGdccN8vZShdv
        1jM/qGZlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSQoM-0004Nm-Vh; Thu, 29 Nov 2018 18:13:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67EB12029FD58; Thu, 29 Nov 2018 19:13:12 +0100 (CET)
Date:   Thu, 29 Nov 2018 19:13:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129181312.GC11632@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <aa425caf-a080-3b67-22eb-15c5b5bbad85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa425caf-a080-3b67-22eb-15c5b5bbad85@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:58:26PM -0500, Waiman Long wrote:
> OK, you convinced me. However, that can still lead to anonymous wakeups
> that can be problematic if it happens in certain places. Should we try
> to reduce anonymous wakeup as much as possible?

No, we should at all times accept and expect spurious wakeups.
