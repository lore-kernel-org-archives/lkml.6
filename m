Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C155C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AFA21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AFA21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeHXUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:15:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbeHXUPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:15:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C318BAF5B;
        Fri, 24 Aug 2018 16:40:04 +0000 (UTC)
Date:   Fri, 24 Aug 2018 18:40:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180824164003.GW29735@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113629.GI29735@dhcp22.suse.cz>
 <103b1b33-1a1d-27a1-dcf8-5c8ad60056a6@i-love.sakura.ne.jp>
 <20180824133207.GR29735@dhcp22.suse.cz>
 <72844762-7398-c770-1702-f945573f4059@i-love.sakura.ne.jp>
 <20180824151239.GC4244@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824151239.GC4244@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 11:12:40, Jerome Glisse wrote:
[...]
> I am fine with Michal patch, i already said so couple month ago first time
> this discussion did pop up, Michal you can add:
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

So I guess the below is the patch you were talking about?

From f7ac75277d526dccd011f343818dc6af627af2af Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 24 Aug 2018 15:32:24 +0200
Subject: [PATCH] mm, mmu_notifier: be explicit about range invalition
 non-blocking mode

If invalidate_range_start is called for !blocking mode then all
callbacks have to guarantee they will no block/sleep. The same obviously
applies to invalidate_range_end because this operation pairs with the
former and they are called from the same context. Make sure this is
appropriately documented.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mmu_notifier.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 133ba78820ee..698e371aafe3 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -153,7 +153,9 @@ struct mmu_notifier_ops {
 	 *
 	 * If blockable argument is set to false then the callback cannot
 	 * sleep and has to return with -EAGAIN. 0 should be returned
-	 * otherwise.
+	 * otherwise. Please note that if invalidate_range_start approves
+	 * a non-blocking behavior then the same applies to
+	 * invalidate_range_end.
 	 *
 	 */
 	int (*invalidate_range_start)(struct mmu_notifier *mn,
-- 
2.18.0

-- 
Michal Hocko
SUSE Labs
