Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9E8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09BA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548062372;
	bh=lv4ARIQuBTY1ywLQfOrPjTpzGR3GgkAR+TPhxv+vGN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXVaQ5/hEZFbwoemUaWAEYXNImNL+dAchz0fgqco1lbvV571u/mwlw86707pVPnqJ
	 M50guHBfeFYvs8MUDpL8PJDsTk10uWJCy44NjdH3Vzv0wB/D/PWVyLVI9/YTC4ja+W
	 baYLwGgRUtLYhQ2gXLKKp94OYy/CrlJvR4RCZeyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfAUJTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:19:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfAUJT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:19:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B76FAD18;
        Mon, 21 Jan 2019 09:19:28 +0000 (UTC)
Date:   Mon, 21 Jan 2019 10:19:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
Message-ID: <20190121091927.GK4087@dhcp22.suse.cz>
References: <20190119005022.61321-1-shakeelb@google.com>
 <20190119070934.GD4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119070934.GD4087@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19-01-19 08:09:34, Michal Hocko wrote:
[...]
> Fixes: 5e9d834a0e0c ("oom: sacrifice child with highest badness score for parent")

So I've double checked and I was wrong blaming this commit. Back then it
was tasklist_lock to protect us from releasing the task. It's been only
since 6b0c81b3be11 ("mm, oom: reduce dependency on tasklist_lock") that
we rely on the reference counting and unless I am missing something this
is also the commit which has introduced this bug.

> Cc: stable

-- 
Michal Hocko
SUSE Labs
