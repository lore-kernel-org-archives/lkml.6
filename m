Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C320849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544532760;
	bh=ygB5XEfjwtKC94Gkjb+BP/g3qBIhGhK3c1Ednf+yKNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cfCM+sJBABgqwtUKBOzrjQDYzauETijOneVqSP+7OyUgNzMTijPb7uzgBPeDU4XpC
	 sLf2MFLZJPOQzGmReyKCf5xxDFyIfwEx4bhi5fFxm7g5h9uBb0LXV5b+UwVa4FUMnd
	 mKOXf+fxl+4r3/PLZLb7nE81/qvCSf+ORNMPaEkc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C320849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeLKMwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:52:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:57396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeLKMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:52:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EE89AFAA;
        Tue, 11 Dec 2018 12:52:35 +0000 (UTC)
Date:   Tue, 11 Dec 2018 13:52:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@suse.de
Cc:     akpm@linux-foundation.org, david@redhat.com,
        pasha.tatashin@soleen.com, dan.j.williams@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
 prematurely
Message-ID: <20181211125234.GI1286@dhcp22.suse.cz>
References: <20181211085042.2696-1-osalvador@suse.de>
 <20181211101818.GE1286@dhcp22.suse.cz>
 <6009dea8a638aaa5b88088a117297edf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6009dea8a638aaa5b88088a117297edf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 13:22:27, osalvador@suse.de wrote:
> On 2018-12-11 11:18, Michal Hocko wrote:
[...]
> > The main question here is. Do we want to migrate as much as possible or
> > do we want to be conservative and bail out early. The later could be an
> > advantage if the next attempt could fail the whole operation because the
> > impact of the failed operation would be somehow reduced. The former
> > should be better for throughput because easily done stuff is done first.
> > 
> > I would go with the throuput because our failure mode is to bail out
> > much earlier - even before we try to migrate. Even though the detection
> > is not perfect it works reasonably well for most usecases.
> 
> I agree here.
> I think it is better to do as much work as possible at once.

This would be great to mention in the changelog. Because that is the
real justification for the change IMHO.

-- 
Michal Hocko
SUSE Labs
