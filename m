Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F277C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E007820846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E007820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeFUHbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:31:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932225AbeFUHbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:31:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0141AF67;
        Thu, 21 Jun 2018 07:31:43 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:31:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180621073142.GA10465@dhcp22.suse.cz>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 15:36:45, David Rientjes wrote:
[...]
> That makes me think that "oom_notify_list" isn't very intuitive: it can 
> free memory as a last step prior to oom kill.  OOM notify, to me, sounds 
> like its only notifying some callbacks about the condition.  Maybe 
> oom_reclaim_list and then rename this to oom_reclaim_pages()?

Yes agreed and that is the reason I keep saying we want to get rid of
this yet-another-reclaim mechanism. We already have shrinkers which are
the main source of non-lru pages reclaim. Why do we even need
oom_reclaim_pages? What is fundamentally different here? Sure those
pages should be reclaimed as the last resort but we already do have
priority for slab shrinking so we know that the system is struggling
when reaching the lowest priority. Isn't that enough to express the need
for current oom notifier implementations?
-- 
Michal Hocko
SUSE Labs
