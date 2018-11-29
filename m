Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7722419
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nygxx1lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F7722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeK3JM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:12:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54590 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sQcchp0v1AdgV+xp04HannO5gduWeCP2b+Ww1xRMirI=; b=Nygxx1lSjsLaJNjNkpyw9sg6I
        Mnq7rhNeYIHhjx0a00imKIsE8nfG1cn3JQGenCB8cUdZlV3YPUrenw5ru7Ltrkli3jDK3K3l+efC4
        lFBobCoF+JuuVDT/MgUB6AMne2zVou2wy4Fh425OwQHAXc9ixLTbFGw5NtaKj/BzwocgDbLYW1tVG
        +YdmRiGUgTrPSLhbovYJ/cp2+DPlWssyhZrlZdmWxakWAAGaPeEOSRCxm/2dw7t1zY4GB4jbzSGuM
        YE/nttJ6YivxJ3gKApzTLeHyamY2QF5b/9Wpe7jESVsAfuLB8FzkZD3Q9I/yJgXSMQYQa6g1yh6oE
        jWfvRaW5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSURO-0005xR-5b; Thu, 29 Nov 2018 22:05:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8F6D2029FD58; Thu, 29 Nov 2018 23:05:44 +0100 (CET)
Date:   Thu, 29 Nov 2018 23:05:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>, Yongji Xie <elohimes@gmail.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129220544.GE11632@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129183103.GA4952@arm.com>
 <f991af45-2131-ad75-94cd-2c8548266a9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f991af45-2131-ad75-94cd-2c8548266a9e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:34:05PM -0500, Waiman Long wrote:

> That will certainly work for x86. However, I am not sure if that will be
> optimal for arm and powerpc.

	smp_mb__before_atomic()
	cmpxchg_relaxed()

works. Also see pv_kick_node()'s commit:

  34d54f3d6917 ("locking/pvqspinlock: Relax cmpxchg's to improve performance on some architectures")

you might know the author of that :-)
