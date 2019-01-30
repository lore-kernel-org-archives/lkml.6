Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C8C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838BD2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548833459;
	bh=Ttyxbei1fPmVxxn3tNOV5sMQ2I56pjznzWDkDfrFXQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWkw/lv+u2FRZDgmF1fYqXURQUnZ5GaV9pz2dNwbdyGhvmU/uF092pF1zuAgpxSSL
	 5/zy76gqsKNhCvH+Swpt9oWn6s4BiTVdvAWeNPBKW0k/rqnpo9OYLDd2aloaoXFVv9
	 Mps5RMLdOP4vU8sMCwt8lp3O/r/lHuaCOhaY96ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfA3Ha5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfA3Ha5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:30:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02822084C;
        Wed, 30 Jan 2019 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548833456;
        bh=Ttyxbei1fPmVxxn3tNOV5sMQ2I56pjznzWDkDfrFXQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDcf5/YcGbdCsVUxZD646xhhGtQ7b8mietEaXC6EMaW2bSJUQldFaWZ7OgDRf+qTJ
         gRiRv3tiEYkfCxeWyfCm9dpJlVAnxke5IPdH7CUfepdrioQEmm4pjZXSPGFY6877Fl
         wemYSiuq9MmMy5fe2fcN7qj9kMwvkdCjejIxSnWQ=
Date:   Wed, 30 Jan 2019 08:30:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.4 068/104] loop: Fold __loop_release into loop_release
Message-ID: <20190130073053.GA4665@kroah.com>
References: <20190124190154.968308875@linuxfoundation.org>
 <20190124190203.062416837@linuxfoundation.org>
 <20190128133103.GD27972@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128133103.GD27972@quack2.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:31:03PM +0100, Jan Kara wrote:
> On Thu 24-01-19 20:19:57, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jan Kara <jack@suse.cz>
> > 
> > commit 967d1dc144b50ad005e5eecdfadfbcfb399ffff6 upstream.
> > 
> > __loop_release() has a single call site. Fold it there. This is
> > currently not a huge win but it will make following replacement of
> > loop_index_mutex more obvious.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> 
> Hello Greg!
> 
> This and the following two (patches 69 & 70) loop patches are just
> preparatory cleanups for commits 0da03cab87e632 "loop: Fix deadlock when
> calling blkdev_reread_part()" and 1dded9acf6dc9a "loop: Avoid circular
> locking dependency between loop_ctl_mutex and bd_mutex". As such they don't
> fix anything and it doesn't make sense to carry them in stable unless
> someone backports also the other patches in the series including the fixes
> themselves (which honestly I don't think is worth it for stable).

Ah, you are right, sorry about that.  I was backporting the loop fixes
and these ended up working on 4.4.y, but as you say, were not needed
unless the later patches also showed up.  I'll go revert them now,
thanks.

greg k-h
