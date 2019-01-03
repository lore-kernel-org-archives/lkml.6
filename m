Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA121872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546543424;
	bh=xvncojBUe26ihPmTV38uurQuIpybNKstjbPx4KplcEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xGG8jHI1ZgJarfzAP7MQB8qMqWu1zHfx0UuGtNN77VO8MQRJFB64B3/Vw4YbIgtXZ
	 ttBIPfimlBpU5dC4ln7J0Uc5b1BQLjHOK5r/T6EBLFNTnB1KiVEm3k5IaMyGPIFZeq
	 dvZmpyDahVnE3fTuXbf1js/41BPs5+c0s1goWnwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfACTXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:23:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:43646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfACTXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:23:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3600AFA5;
        Thu,  3 Jan 2019 19:23:40 +0000 (UTC)
Date:   Thu, 3 Jan 2019 20:23:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
Message-ID: <20190103192339.GA31793@dhcp22.suse.cz>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190103101215.GH31793@dhcp22.suse.cz>
 <b3ad06ed-f620-7aa0-5697-a1bbe2d7bfe1@linux.alibaba.com>
 <20190103181329.GW31793@dhcp22.suse.cz>
 <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
 <20190103185333.GX31793@dhcp22.suse.cz>
 <d610c665-890f-3bf0-1e2a-437150b6ddfb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d610c665-890f-3bf0-1e2a-437150b6ddfb@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 11:10:00, Yang Shi wrote:
> 
> 
> On 1/3/19 10:53 AM, Michal Hocko wrote:
> > On Thu 03-01-19 10:40:54, Yang Shi wrote:
> > > 
> > > On 1/3/19 10:13 AM, Michal Hocko wrote:
[...]
> > > > Is there any reason for your scripts to be strictly sequential here? In
> > > > other words why cannot you offload those expensive operations to a
> > > > detached context in _userspace_?
> > > I would say it has not to be strictly sequential. The above script is just
> > > an example to illustrate the pattern. But, sometimes it may hit such pattern
> > > due to the complicated cluster scheduling and container scheduling in the
> > > production environment, for example the creation process might be scheduled
> > > to the same CPU which is doing force_empty. I have to say I don't know too
> > > much about the internals of the container scheduling.
> > In that case I do not see a strong reason to implement the offloding
> > into the kernel. It is an additional code and semantic to maintain.
> 
> Yes, it does introduce some additional code and semantic, but IMHO, it is
> quite simple and very straight forward, isn't it? Just utilize the existing
> css offline worker. And, that a couple of lines of code do improve some
> throughput issues for some real usecases.

I do not really care it is few LOC. It is more important that it is
conflating force_empty into offlining logic. There was a good reason to
remove reparenting/emptying the memcg during the offline. Considering
that you can offload force_empty from userspace trivially then I do not
see any reason to implement it in the kernel.

> > I think it is more important to discuss whether we want to introduce
> > force_empty in cgroup v2.
> 
> We would prefer have it in v2 as well.

Then bring this up in a separate email thread please.
-- 
Michal Hocko
SUSE Labs
