Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD27C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37352084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkgiXyQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfAVIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:55:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAVIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hutFtqjd8pMNAkIm4qvrmVrGifg6iG5LHXkGavh/jRI=; b=LkgiXyQ4Wwy3x/Y54OAOEMYco
        LIuDWE612Fdnov/BA4F+hHh7zHDpdwEmeVjxV7li8doYaJtqUmkDJ69EfnhQW+eAjR6ggmJc8a6Ma
        qESebrjfToIeBmUFDvu4ny1vETylU07Ji4Vs0/DnHPBbC+kaNTuWQb2CCm8pajxZRUJwbUBu41TO3
        TQwGh2w4CHMpMLYe9b9tSFkiIAdQ2ylJIBag0trxo2RbYZovQg8KzTfiYG0HunJhv4wwBM2673chv
        96Q2Ddfnypb6JA4ClOpErfMyexMs/B7FH3ojE2La3CRzsgAoqNHue5L40E9yyv0nnFOinOauaI3Ky
        m7pZ+2AkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glrpv-0002Cd-7J; Tue, 22 Jan 2019 08:55:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9E5A20D15820; Tue, 22 Jan 2019 09:55:08 +0100 (CET)
Date:   Tue, 22 Jan 2019 09:55:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>, Yongji Xie <elohimes@gmail.com>,
        mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [PATCH v4] sched/wake_q: Reduce reference counting for special
 users
Message-ID: <20190122085508.GD13777@hirez.programming.kicks-ass.net>
References: <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
 <20181218131419.GD16284@hirez.programming.kicks-ass.net>
 <20181218185443.g5jzinm3vnrkznmm@linux-r8p5>
 <a8767197-21b9-f470-b864-be88e020c647@redhat.com>
 <20181218193009.ytzz5rlrsh27rjre@linux-r8p5>
 <20181218193957.cjx34nn5tku2eaps@linux-r8p5>
 <20181218195352.7orq3upiwfdbrdne@linux-r8p5>
 <772085e9-35f3-1c32-1b87-f101cbc5f8f7@redhat.com>
 <20190121160218.rakg7vvhlx4pqpvu@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121160218.rakg7vvhlx4pqpvu@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:02:18AM -0800, Davidlohr Bueso wrote:
> Hi - considering that the wake_q patches were picked up for tip/urgent, can
> this one make it in as well?

Ah, here it is. Yes, got it now.

I was actually wondering what happened, but couldn't find it in a hurry.

All sorted now.
