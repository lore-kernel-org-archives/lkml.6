Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3A520C03
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCDPHOTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3A520C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeGBPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:21:10 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40887 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:21:09 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so1725172ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjAU1n16nNiLQs4iuK4WOdn03VIJLmVf1f4XWDGd9ZU=;
        b=aCDPHOTYjHannO9MWJUDQl4I/43Og1SlrgDWncSxA0wrHrRg6PkPnXpldkSLS9No9h
         eoJoDNWOnnB9DeR6pRtp7IowFaewGtkTn2CTswb+RNHayOBePd8z30EmQ+MsoXHfO/Qo
         R26prDQGB+xYgBuaoaFeroXwF9KPMv/w93N2hh8X+HsWDB17sxy31QwV0J2pnGa/CA1q
         1FhSMalg8vLMXthpLTv51APnbOLEfm0ljH+MeSLwUiwG0H10ZCe/wPVIANLrsq4LSGpr
         GNS7kfC+KsP6jlpy1qLbynUbJHReWQDUoZN1ZhnC/xPKAKclyJaIE5ty7+0/eEzbuvdE
         8eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjAU1n16nNiLQs4iuK4WOdn03VIJLmVf1f4XWDGd9ZU=;
        b=JFG7xFrh5wlrHDNH7dDVyijcbTdGBHh+BlqT2r+kr2YBNCOf+MhVelbmftejIwKsH6
         2sasms1Oz/beDUXYMl479bhf60iXtYb/74plIXFd1MaMXuMum/SS4PYz4k+AaNcyERPw
         bOJDJfZooMnFY8/ErBtBS0Sw0Jdu02BsOP0JHYvzMCeBEND7pY3bfFo1q36zIP63HqRS
         FjnME4FOs7oNzClb+aN2NfhoTHkfZkZvh/Ks607NbRqDcne/GYOdXQUGGXYDjOXC4Kc7
         is6CkbqkgFu/CAZbG86VHER/c5ERY32Ufgn2GSqjp6SOGVbxU9i5O9ahyPup2+oar6+/
         5ttA==
X-Gm-Message-State: APt69E0/ssNqM+QjB6WnJdY3lJYfbIoj0N25/gYFqPnn9V/KHQPxbrfE
        gqkUVYQzRz2O619xJSurXJE=
X-Google-Smtp-Source: AAOMgpeZWxaCkSPTvM/JLIj+ZMp16EVHAKq+MqnesUIdYWvc3z7IiwjeLLue8fRjoGxxy7A5Q9omng==
X-Received: by 2002:a5b:841:: with SMTP id v1-v6mr11286591ybq.250.1530544868388;
        Mon, 02 Jul 2018 08:21:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id l14-v6sm6114604ywi.35.2018.07.02.08.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 08:21:07 -0700 (PDT)
Date:   Mon, 2 Jul 2018 08:21:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Message-ID: <20180702152106.GD533219@devbig577.frc2.facebook.com>
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626154908.GE2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Tue, Jun 26, 2018 at 05:49:08PM +0200, Peter Zijlstra wrote:
> Well, no, because the Changelog is incomprehensible and the patch
> doesn't really have useful comments, so I'll have to reverse engineer
> the entire thing, and I've just not had time for that.

Just as an additional data point, we also sometimes see artifacts from
cpu_adjust_time() in the form of per-task user or sys time getting
stuck for some period (in extreme cases for over a minute) while the
application isn't doing anything differently.  We're telling the users
that it's an inherent sampling artifact but it'd be nice to improve it
if possible without adding noticeable overhead.  No idea whether this
patch's approach is a good one tho.

Thanks.

-- 
tejun
