Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BCDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7838220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFTPem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35693 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754288AbeFTPel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:34:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DC25AD7C;
        Wed, 20 Jun 2018 15:34:40 +0000 (UTC)
Date:   Wed, 20 Jun 2018 17:34:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180620153438.GP13685@dhcp22.suse.cz>
References: <20180620103736.13880-1-mhocko@kernel.org>
 <20180620151812.GA2441@cmpxchg.org>
 <20180620153148.GO13685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620153148.GO13685@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 17:31:48, Michal Hocko wrote:
> On Wed 20-06-18 11:18:12, Johannes Weiner wrote:
[...]
> > 1) Why warn for kernel allocations, but not userspace ones? This
> > should have a comment at least.
> 
> I am not sure I understand. We do warn for all allocations types of
> mem_cgroup_out_of_memory fails as long as we are not in a legacy -
> oom_disabled case.

OK, I can see it now. It wasn't in the quoted context and I just forgot
that WARN(!current->memcg_may_oom, ...). Well, I do not remember why
I've made it conditional and you are right it doesn't make any sense.
Probably a different code flow back then.

Updated to warn regardless of memcg_may_oom.
-- 
Michal Hocko
SUSE Labs
