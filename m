Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0197C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FD20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883FD20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeLKQjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:39:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbeLKQjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:39:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07BBEAF89;
        Tue, 11 Dec 2018 16:39:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D0F91E13F8; Tue, 11 Dec 2018 17:39:52 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:39:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181211163952.GB4020@quack2.suse.cz>
References: <20181211132645.31053-1-mhocko@kernel.org>
 <20181211151542.2rjti4glj75honje@kshutemo-mobl1>
 <20181211162149.GL1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211162149.GL1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 17:21:49, Michal Hocko wrote:
> On Tue 11-12-18 18:15:42, Kirill A. Shutemov wrote:
> > For instance, DAX page fault will setup page table entry on its own and
> > return VM_FAULT_NOPAGE. It uses vmf_insert_mixed() to setup the page table
> > and ignores your pre-allocated page table.
> 
> Does this happen with a page locked and with __GFP_ACCOUNT allocation. I
> am not familiar with that code but I do not see it from a quick look.

DAX has no page to lock and also no writeback to do so the deadlock isn't
really possible when DAX is in use...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
