Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8404C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5320871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA5320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeKSTsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:48:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:58612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbeKSTsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:48:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6671BABA1;
        Mon, 19 Nov 2018 09:25:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 293271E0D8A; Mon, 19 Nov 2018 10:25:15 +0100 (CET)
Date:   Mon, 19 Nov 2018 10:25:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH] udf: fix dvd mounting error
Message-ID: <20181119092515.GA16427@quack2.suse.cz>
References: <20181115122600.15821-1-sudipm.mukherjee@gmail.com>
 <20181116125633.GG24157@quack2.suse.cz>
 <20181116143314.qn7jmtyz4ad4bax6@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116143314.qn7jmtyz4ad4bax6@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 14:33:14, Sudip Mukherjee wrote:
> > From e1a7680b960fe25821f2419b4c0b1215f8ab2f9b Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Fri, 16 Nov 2018 13:43:17 +0100
> > Subject: [PATCH] udf: Allow mounting volumes with incorrect identification
> >  strings
> > 
> > Commit c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
> > started to be more strict when checking whether converted strings are
> > properly formatted. Sudip reports that there are DVDs where the volume
> > identification string is actually too long - UDF reports:
> > 
> > [  632.309320] UDF-fs: incorrect dstring lengths (32/32)
> > 
> > during mount and fails the mount. This is mostly harmless failure as we
> > don't need volume identification (and even less volume set
> > identification) for anything. So just truncate the volume identification
> > string if it is too long and replace it with 'Invalid' if we just cannot
> > convert it for other reasons. This keeps slightly incorrect media still
> > mountable.
> > 
> > CC: stable@vger.kernel.org
> > Fixes: c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
> > Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> It works perfectly. Thanks.
> 
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks for testing!

> > -	if (ret < 0)
> > -		goto out_bh;
> > -
> > -	strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
> > +	if (ret < 0) {
> > +		strcpy(UDF_SB(sb)->s_volume_ident, "Invalid");
> 
> Just a suggestion. Even on failed cases, having the volume identification
> as "Invalid" might confuse the users. Since you have a maximum limit as 31
> maybe something more meaningful like "No Name" ?

I agree something long might be better. I think 'InvalidName' might be
better than 'No Name'. Thanks for suggestion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
