Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9AEFC6121
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6020894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8kDbCbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC6020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeG3Tle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:41:34 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46782 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbeG3Tle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:41:34 -0400
Received: by mail-yb0-f196.google.com with SMTP id c3-v6so5097872ybi.13;
        Mon, 30 Jul 2018 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GgK//fN5K8KVly14+EBhnGFTl0s8rnz4fQJVuWZKBdY=;
        b=U8kDbCbtPtd8uooUMCXy8CmMVmC+9f72lmj1zGK2b30yb5DBN6N8NBtCfNLzmFfCp+
         ioksGX5gCWcaeoCk3ezzkgWBmaPiae64PVP2vHRPs58PIbLiULWeWc74ENtIkfVg22KQ
         0vxiDYOlOzVczwiT9aezYvs9Amhiy+1WyZZvEUUU2NQn9cg/k7vlDFeTFFyezvUjfOhs
         43ahGT/kR7oS9p6ZeYRunGzC80vyvTNpMy1NZgccWPmxmiOlTw1IdmFa0wnRGrd0ocNq
         SqmKwr55kiczEJDAUlAnEZ38UzlbseL1nzCyhIOFF7Nzg1h2hryVK5lyH3RPRUeEDTMe
         gtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgK//fN5K8KVly14+EBhnGFTl0s8rnz4fQJVuWZKBdY=;
        b=r4nm+PfmRGsvRwNIxpLzBDJbPEnhe7CGYxGX3uac4OZDwOXyKLtz4r6OhKmZAQo5GH
         MLh0iffru1/+7+tb8d0tyGzNcxO0uEJ/ee7IUiuRmLiykd+zyWAE+YGiYCtEOgSHJMkI
         CMnDchnpJOQM6ng7dsqeTOdQGASU55DHhAYu6NQ6hj7RnWDKICR2q/f1krxmcgQE/hCT
         DL4xvfugYC3V/lZC50J2mHqJ3IYZ/8L+9I6zlcLFuOs49Dg2ovqikCMFhbryp7bENFK+
         wLF+UwuC+AK/AYJ1rmVqW3QFmlS/z82Q0Kuls08fdGfzm1dD7LQqOKvBxZmZti+aIg+6
         kzig==
X-Gm-Message-State: AOUpUlFTFalyFCJQOYU6/GCK0UHgmYNnIQx10DiIUl1Nl+rIOtmOEJzx
        ML+l7mQLYI7RWwXVOz4JFV9ctNsb
X-Google-Smtp-Source: AAOMgpePIa/RlLeBp2ykMC+1PfiiG9TKKS+s7zO/me3CDSzhePp3VZn8TvBdM+YqqhtIKMC+tEhYkQ==
X-Received: by 2002:a25:b84d:: with SMTP id b13-v6mr10128941ybm.501.1532973923191;
        Mon, 30 Jul 2018 11:05:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id w143-v6sm19629344yww.49.2018.07.30.11.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 11:05:22 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:05:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730180520.GL1206094@devbig004.ftw2.facebook.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
 <20180730154035.GC4567@cmpxchg.org>
 <20180730173940.GB881@amd>
 <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
 <dfc3c810-8918-add4-b818-8b9c294f5ea4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc3c810-8918-add4-b818-8b9c294f5ea4@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 30, 2018 at 10:54:05AM -0700, Randy Dunlap wrote:
> I'd say he's trying to make something that is readable and easier to
> understand for users.

Sure, it's perfectly fine to make those suggestions and discuss but
the counter points have already been discussed (e.g. PSI is a known
acronym associated with pressure and internal symbols all use them for
brevity and uniqueness).  There's no clear technically winning choice
here and it's a decision of a relatively low importance given that
it's confined to kernel config.  I can't see any merit in turning it
into a last-word match.

Thanks.

-- 
tejun
