Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B6E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMqwBTza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B6E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeG3Uuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:50:51 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45060 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbeG3Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:50:50 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so5188448ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VKO+/0WpTfQu8GsWuG02LInhXhEPsRHnk1plEJRctE=;
        b=iMqwBTzaZEUz08AuqK3jhYhanGsog0iY7tcPhptDeyj+F4HdXFkWRq0z7TgjLL7MHZ
         gF3S+Qifa4h1/+h6ftktUirWzvfyrTBR9jR2QNciYVo4Xl3DgMTpYhv/axemHi6Kvr1S
         E9dynC+UDq75pUYLJenkpy8jd2U7LqF30Tf/CQTajW4hkXhnUPNYgUX/c4JF8bAazxTr
         oWs7OZvYp2xU2CIiWexRHLaksNJvXtbb36dvsVz+d2/ZR/+oOMVVK2dLWUTAIMmh4ZU4
         UaZZ54vZNOqEEvBmbg6jxdmLiGlsyGovW2o1EDhla3h1o/hU9ThfEucbG1G2JgtAw5E2
         Xb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VKO+/0WpTfQu8GsWuG02LInhXhEPsRHnk1plEJRctE=;
        b=q3HzbUi/PRVPLOqSKxyUMlooGoiFrxh8aPEISVdR9UMp6xyy9crmIvI2GzLMTiBou8
         BAP0ANewri3c6K/99UmXCsQi2P0XdpHXZ9ttC3SL4KG7RARr3zAGUEHkc4YFQkoOHuMb
         HPlyOCq2NOUTN9IPbldROqA0p2ySgx3c+vuF16PTpMe3LUXvl7ftL+aQxcwHV3SUIUPf
         zLL02Y2ZK6yqSOdxyy2XHnh41SbOHLvdlFR49LbxdSjbAdRAl1yeuybBj1dZEnDFc8NR
         XrZcqWVRbZ5/gfKCR/jrqJVYw840dwHPWUuyOc4gAN2n2T8+jYYQ3g8PaKElN2L8kVzR
         awRA==
X-Gm-Message-State: AOUpUlGqQ6LjctIIZc1dU0motjmbZhb+oV19LXaiycbuRclhRt+ADTjm
        j1Hb/3fjGEm4J0WRtzbnXGY=
X-Google-Smtp-Source: AAOMgpcgT1YihTauhXA3prREhAhV8/WoHJ6n8ELzzGaTxSblhHHK9+ZrKBLqaYRgJ8FgXuLUC/1dLQ==
X-Received: by 2002:a25:b4a:: with SMTP id 71-v6mr9715323ybl.412.1532978065543;
        Mon, 30 Jul 2018 12:14:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id k10-v6sm5032096ywk.101.2018.07.30.12.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 12:14:24 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:14:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180730191423.GN1206094@devbig004.ftw2.facebook.com>
References: <ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp>
 <20180726113958.GE28386@dhcp22.suse.cz>
 <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
 <20180730144647.GX24267@dhcp22.suse.cz>
 <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
 <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
 <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730185110.GB24267@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jul 30, 2018 at 08:51:10PM +0200, Michal Hocko wrote:
> > Yeah, workqueue can choke on things like that and kthread indefinitely
> > busy looping doesn't do anybody any good.
> 
> Yeah, I do agree. But this is much easier said than done ;) Sure
> we have that hack that does sleep rather than cond_resched in the
> page allocator. We can and will "fix" it to be unconditional in the
> should_reclaim_retry [1] but this whole thing is really subtle. It just
> take one misbehaving worker and something which is really important to
> run will get stuck.

Oh yeah, I'm not saying the current behavior is ideal or anything, but
since the behavior has been put in many years ago, it only became a
problem only a couple times and all cases were rather easy and obvious
fixes on the wq user side.  It shouldn't be difficult to add a timer
mechanism on top.  We might be able to simply extend the hang
detection mechanism to kick off all pending rescuers after detecting a
wq stall.  I'm wary about making it a part of normal operation
(ie. silent timeout).  per-cpu kworkers really shouldn't busy loop for
an extended period of time.

Thanks.

-- 
tejun
