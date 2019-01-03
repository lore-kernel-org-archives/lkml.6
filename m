Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEBBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972C220883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546510340;
	bh=PUR5CssjH+2enrGOTlKuIt/Um6feZcfvsI8sLyyyWZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MfAdcvYtLWWZhHvahlBbUJowhH/cSacahfpABmE1HlGkbQLLMmU6aj4Q+XLwcinXM
	 jgtgDE7gLyRs2GJqxWHNWuEg8UCZYcS4E2L4bigo+gU/ysTA8FuTtX689LVvUscPqn
	 T4STv1RAFrgvzi+P4rraJuoMUND6y+MMc20t+KvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfACKMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:12:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:48918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728530AbfACKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:12:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46FF8AD4B;
        Thu,  3 Jan 2019 10:12:16 +0000 (UTC)
Date:   Thu, 3 Jan 2019 11:12:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
Message-ID: <20190103101215.GH31793@dhcp22.suse.cz>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 04:05:30, Yang Shi wrote:
> 
> Currently, force empty reclaims memory synchronously when writing to
> memory.force_empty.  It may take some time to return and the afterwards
> operations are blocked by it.  Although it can be interrupted by signal,
> it still seems suboptimal.

Why it is suboptimal? We are doing that operation on behalf of the
process requesting it. What should anybody else pay for it? In other
words why should we hide the overhead?

> Now css offline is handled by worker, and the typical usecase of force
> empty is before memcg offline.  So, handling force empty in css offline
> sounds reasonable.

Hmm, so I guess you are talking about
echo 1 > $MEMCG/force_empty
rmdir $MEMCG

and you are complaining that the operation takes too long. Right? Why do
you care actually?
-- 
Michal Hocko
SUSE Labs
