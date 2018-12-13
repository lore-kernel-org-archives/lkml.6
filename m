Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2589C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD82C2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD82C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeLMW5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:57:41 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:33401 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbeLMW5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:57:41 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 14 Dec 2018 09:27:38 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gXZvF-0002OX-0B; Fri, 14 Dec 2018 09:57:37 +1100
Date:   Fri, 14 Dec 2018 09:57:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     zhangjun <openzhangj@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: ubifs: fix page_count in ->ubifs_migrate_page()
Message-ID: <20181213225736.GF29416@dastard>
References: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
 <5829763.q4qAXljTxb@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5829763.q4qAXljTxb@blindfold>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:23:37PM +0100, Richard Weinberger wrote:
> Hello zhangjun,
> 
> thanks a lot for bringing this up!
> 
> Am Mittwoch, 12. Dezember 2018, 15:13:57 CET schrieb zhangjun:
> > Because the PagePrivate() in UBIFS is different meanings,
> > alloc_cma() will fail when one dirty page cache located in
> > the type of MIGRATE_CMA
> > 
> > If not adjust the 'extra_count' for dirty page,
> > ubifs_migrate_page() -> migrate_page_move_mapping() will
> > always return -EAGAIN for:
> > 	expected_count += page_has_private(page)
> > This causes the migration to fail until the page cache is cleaned
> > 
> > In general, PagePrivate() indicates that buff_head is already bound
> > to this page, and at the same time page_count() will also increase.


That's an invalid assumption.

We should not be trying to infer what PagePrivate() means in code
that has no business using looking at it i.e. page->private is private
information for the owner of the page, and it's life cycle and
intent are unknown to anyone other than the page owner.

e.g. on XFS, a page cache page's page->private /might/ contain a
struct iomap_page, or it might be NULL. Assigning a struct
iomap_page to the page does not change the reference count on the
page.  IOWs, the page needs to be handled exactly the same
way by external code regardless of whether there is somethign
attached to page->private or not.

Hence it looks to me like the migration code is making invalid
assumptions about PagePrivate inferring reference counts and so the
migration code needs to be fixed. Requiring filesystems to work
around invalid assumptions in the migration code is a sure recipe
for problems with random filesystems using page->private for their
own internal purposes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
