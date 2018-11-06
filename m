Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31302C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A122086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOrRg5nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A122086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbeKFVVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:21:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbeKFVVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eDM4lYpUCUya4QcGkn98W8k7ZyS7c5HEaJpfsU6bvqw=; b=NOrRg5njD3X2dgR2PInxtxdkz
        AR+7Hys4BK2lnEE/zwOZn19WSY6aj3koiT7cnQ3HZCV9c1CZK5WYb262BLtQSnSfRhN/NKsYutPY7
        OcB38xzwFhfATOn7+6GKnJy2ZY5TQ8V0vJCULlP+oRir+hxG4blQM0ed2KiVv/lMoQI/iCBGNhGmf
        koaleKN8BM0bxvsHZtxvXo5yhUS1gvWI4M4iQoaZSF6KA/YCNLa3RfI+eL+bwE/15hb6TwcbKLzSf
        b+KgJarJoBghOzlBSQHDgg+Q+8R1wp3ik7VkUEofobPmSgE92ytWCLc8F5knxM6OMlXjuaAk7UOV2
        HkvYD4kBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJzxj-0007Pe-BL; Tue, 06 Nov 2018 11:56:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A7332029F9FF; Tue,  6 Nov 2018 12:55:58 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:55:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181106115558.GB22485@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
 <20181106115335.GQ22431@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106115335.GQ22431@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:53:35PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 05, 2018 at 08:36:56AM -0800, Tejun Heo wrote:
> > Hello,
> > 
> > So, this looks good to me.  Peter, I'm gonna roll the series into
> > cgroup/for-4.21-cpuset.  Please holler if you have any objections /
> > comments.
> 
> Mostly nits, except I think the interface for cpuset.sched.partition
> needs to find another term for "not a parition", "normal" really doesn't
> work for me.

cpuset.sched.partition: "true", "false", "error"

makes more sense to me.
