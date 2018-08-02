Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA89C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5716214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5716214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHBNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732076AbeHBNTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC2B9AD1B;
        Thu,  2 Aug 2018 11:29:02 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:29:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Message-ID: <20180802112901.GH10808@dhcp22.suse.cz>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
 <1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
 <20180730090041.GC24267@dhcp22.suse.cz>
 <5B619599.1000307@intel.com>
 <20180801113444.GK16767@dhcp22.suse.cz>
 <5B62DDCC.3030100@intel.com>
 <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
 <5B62EAAC.8000505@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B62EAAC.8000505@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-08-18 19:27:40, Wei Wang wrote:
> On 08/02/2018 07:00 PM, Tetsuo Handa wrote:
> > On 2018/08/02 19:32, Wei Wang wrote:
> > > On 08/01/2018 07:34 PM, Michal Hocko wrote:
> > > > Do you have any numbers for how does this work in practice?
> > > It works in this way: for example, we can set the parameter, balloon_pages_to_shrink,
> > > to shrink 1GB memory once shrink scan is called. Now, we have a 8GB guest, and we balloon
> > > out 7GB. When shrink scan is called, the balloon driver will get back 1GB memory and give
> > > them back to mm, then the ballooned memory becomes 6GB.
> > Since shrinker might be called concurrently (am I correct?),
> 
> Not sure about it being concurrently, but I think it would be called
> repeatedly as should_continue_reclaim() returns true.

Multiple direct reclaimers might indeed invoke it concurrently.
-- 
Michal Hocko
SUSE Labs
