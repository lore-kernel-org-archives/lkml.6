Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D13C214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D13C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbeHPJb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeHPJbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:31:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E732AE85;
        Thu, 16 Aug 2018 06:35:10 +0000 (UTC)
Date:   Thu, 16 Aug 2018 08:35:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180816063509.GS32645@dhcp22.suse.cz>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com>
 <20180815172044.GA29793@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815172044.GA29793@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-08-18 13:20:44, Johannes Weiner wrote:
[...]
> This is completely backwards.
> 
> We respect the limits unless there is a *really* strong reason not
> to. The only situations I can think of is during OOM kills to avoid
> memory deadlocks and during packet reception for correctness issues
> (and because the network stack has its own way to reclaim memory).
> 
> Relying on some vague future allocations in the process's lifetime to
> fail in order to contain it is crappy and unreliable. And unwinding
> the stack allocation isn't too much complexity to warrant breaking the
> containment rules here, even if it were several steps. But it looks
> like it's nothing more than a 'goto free_stack'.
> 
> Please just fix this.

Thinking about it some more (sorry I should have done that in my
previous reply already) I do agree with Johannes. We should really back
off as soon as possible rather than rely on a future action because
this is quite subtle and prone to unexpected behavior.

-- 
Michal Hocko
SUSE Labs
