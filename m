Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F22C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D840C20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbfAPJnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:43:02 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:58525 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391752AbfAPJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:43:01 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id E9D991C261C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:42:58 +0000 (GMT)
Received: (qmail 18492 invoked from network); 16 Jan 2019 09:42:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2019 09:42:58 -0000
Date:   Wed, 16 Jan 2019 09:42:57 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/25] mm, compaction: Skip pageblocks with reserved pages
Message-ID: <20190116094257.GB27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-7-mgorman@techsingularity.net>
 <657ee6fc-48df-59ab-70b7-6066513e3b22@suse.cz>
 <20190115125045.GA27437@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190115125045.GA27437@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:50:45PM +0000, Mel Gorman wrote:
> > AFAICS memory allocator is not the only user of PageReserved. There
> > seems to be some drivers as well, notably the DRM subsystem via
> > drm_pci_alloc(). There's an effort to clean those up [1] but until then,
> > there might be some false positives here.
> > 
> > [1] https://marc.info/?l=linux-mm&m=154747078617898&w=2
> > 
> 
> Hmm, I'm tempted to leave this anyway. The reservations for PCI space are
> likely to be persistent and I also do not expect them to grow much. While
> I consider it to be partially abuse to use PageReserved like this, it
> should get cleaned up slowly over time. If this turns out to be wrong,
> I'll attempt to fix the responsible driver that is scattering
> PageReserved around the place and at worst, revert this if it turns out
> to be a major problem in practice. Any objections?
> 

I decided to drop this anyway as the series does not hinge on it, it's a
relatively minor improvement overall and I don't want to halt the entire
series over it. The maintain that the system would recover even if the
driver released the pages as the check would eventually fail and then be
cleared after a reset. The only downside from the patch that I can see
really is that it's a small maintenance overhead due to an apparent
duplicated check. The CPU overhead of compaction will be slightly higher
due to the revert but there are other options on the horizon that would
bring down that overhead again.

-- 
Mel Gorman
SUSE Labs
