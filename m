Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F230C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D269F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D269F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeJRRM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:12:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeJRRM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:12:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EDCCAD8E;
        Thu, 18 Oct 2018 09:12:51 +0000 (UTC)
Date:   Thu, 18 Oct 2018 11:12:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Convert mem_cgroup_id::ref to refcount_t type
Message-ID: <20181018091250.GA18839@dhcp22.suse.cz>
References: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
 <20181016124939.GA13278@andrea>
 <a990eed4-611b-8464-c2aa-56684fee0ee5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a990eed4-611b-8464-c2aa-56684fee0ee5@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-10-18 16:19:40, Kirill Tkhai wrote:
> Hi, Andrea,
> 
> On 16.10.2018 15:49, Andrea Parri wrote:
> > Hi Kirill,
> > 
> > On Tue, Oct 09, 2018 at 08:46:56PM +0300, Kirill Tkhai wrote:
> >> This will allow to use generic refcount_t interfaces
> >> to check counters overflow instead of currently existing
> >> VM_BUG_ON(). The only difference after the patch is
> >> VM_BUG_ON() may cause BUG(), while refcount_t fires
> >> with WARN().
> > 
> > refcount_{sub_and_test,inc_not_zero}() are documented to provide
> > "slightly" more relaxed ordering than their atomic_* counterpart,
> > c.f.,
> > 
> >   Documentation/core-api/refcount-vs-atomic.rst
> >   lib/refcount.c (inline comments)
> > 
> > IIUC, this semantic change won't cause problems here (but please
> > double-check? ;D ).
> 
> I just don't see a place, where we may think about using a modification
> of struct mem_cgroup::id::ref as a memory barrier to order something,
> and all this looks safe for me.

If there was any it would surely be unintentional. memcg->id.ref is a clear
reference counter pattern for the id lifetime.
-- 
Michal Hocko
SUSE Labs
