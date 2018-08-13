Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9894C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFAC217FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFAC217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeHMLhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:56026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728215AbeHMLhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 522A0AD3C;
        Mon, 13 Aug 2018 08:56:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E17BC1E051E; Mon, 13 Aug 2018 10:56:35 +0200 (CEST)
Date:   Mon, 13 Aug 2018 10:56:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, ak@linux.intel.com,
        mawilcox@microsoft.com, viro@zeniv.linux.org.uk,
        ross.zwisler@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [BUG] mm: truncate: a possible sleep-in-atomic-context bug in
 truncate_exceptional_pvec_entries()
Message-ID: <20180813085635.GA8927@quack2.suse.cz>
References: <f863cf8d-615f-c622-812a-a6370efe757b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f863cf8d-615f-c622-812a-a6370efe757b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 13-08-18 11:10:23, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] schedule
> fs/dax.c, 259: schedule in get_unlocked_mapping_entry
> fs/dax.c, 450: get_unlocked_mapping_entry in __dax_invalidate_mapping_entry
> fs/dax.c, 471: __dax_invalidate_mapping_entry in dax_delete_mapping_entry
> mm/truncate.c, 97: dax_delete_mapping_entry in
> truncate_exceptional_pvec_entries
> mm/truncate.c, 82: spin_lock_irq in truncate_exceptional_pvec_entries
> 
> I do not find a good way to fix, so I only report.
> This is found by my static analysis tool (DSAC).

Thanks for report but this is a false positive. Note that the lock is
acquired only if we are not operating on DAX mapping but we can get to
dax_delete_mapping_entry() only if we are operating on DAX mapping.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
