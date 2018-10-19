Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55329ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B421479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118B421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJSKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJSKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:43 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24A48A64;
        Fri, 19 Oct 2018 02:11:48 +0000 (UTC)
Date:   Thu, 18 Oct 2018 19:11:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-Id: <20181018191147.33e8d5e1ebd785c06aab7b30@linux-foundation.org>
In-Reply-To: <20180926142227.GZ6278@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
        <20180925120326.24392-3-mhocko@kernel.org>
        <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
        <20180926141708.GX6278@dhcp22.suse.cz>
        <20180926142227.GZ6278@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 16:22:27 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > MPOL_PREFERRED is handled by policy_node() before we call __alloc_pages_nodemask.
> > __GFP_THISNODE is applied only when we are not using
> > __GFP_DIRECT_RECLAIM which is handled in alloc_hugepage_direct_gfpmask
> > now.
> > Lastly MPOL_BIND wasn't handled explicitly but in the end the removed
> > late check would remove __GFP_THISNODE for it as well. So in the end we
> > are doing the same thing unless I miss something
> 
> Forgot to add. One notable exception would be that the previous code
> would allow to hit
> 	WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> in policy_node if the requested node (e.g. cpu local one) was outside of
> the mbind nodemask. This is not possible now. We haven't heard about any
> such warning yet so it is unlikely that it happens though.

Perhaps a changelog addition is needed to cover the above?

I assume that David's mbind() concern has gone away.

No acks or reviewed-by's yet?
