Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E55C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFDA214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFDA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeHVTh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:37:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbeHVTh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:37:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A975B042;
        Wed, 22 Aug 2018 16:12:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 531581E361C; Wed, 22 Aug 2018 18:12:28 +0200 (CEST)
Date:   Wed, 22 Aug 2018 18:12:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jeremy Cline <jcline@redhat.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 0/2] fs/quota: Fix potential spectre v1 gadgets
Message-ID: <20180822161228.GG23037@quack2.suse.cz>
References: <20180731013731.1987-1-jcline@redhat.com>
 <20180731184344.yspy7sjbec74d5w6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731184344.yspy7sjbec74d5w6@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 13:43:44, Josh Poimboeuf wrote:
> On Tue, Jul 31, 2018 at 01:37:29AM +0000, Jeremy Cline wrote:
> > Hi folks,
> > 
> > This series unifies XQM_MAXQUOTAS with MAXQUOTAS, which were both being
> > used to perform bounds checks on arrays, and then sanitizes 'type' so it
> > can't be used in speculative out-of-bounds array access.
> > 
> > Jeremy Cline (2):
> >   fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
> >   fs/quota: Fix spectre gadget in do_quotactl
> > 
> >  fs/quota/quota.c               | 14 +++++++-------
> >  include/linux/quota.h          |  8 +-------
> >  include/uapi/linux/dqblk_xfs.h |  5 -----
> >  3 files changed, 8 insertions(+), 19 deletions(-)
> 
> Looks good to me, though this might hinge on the discussion with
> Andreas:
> 
>   https://lkml.kernel.org/r/E3E7B6AF-3819-4998-9B12-DACB4EBC14F1@dilger.ca

Actually, XQM_MAXQUOTAS is a different kind of beast than EXT4_MAXQUOTAS
and friends. XQM_MAXQUOTAS is maximum allowed type number for some
quotactl(8) syscall commands. After quite some effort we have unified the
interfaces for all quotactl commands so they support the same set of quota
types and we don't really plan for these two diverge in the future again. So
the cleanup makes sense.

OTOH EXT4_MAXQUOTAS defines how many quota types ext4 filesystem supports
and that definitely needs to stay a separate constant from the number of
quota types generic infrastructure supports... So here I agree with
Andreas.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
