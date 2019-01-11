Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF920874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547221498;
	bh=iB9YSW+6tEh4UUPc/YgVvZMH62OXRNTa42Sk2nc5vrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J80heO9cHlrrmNQL1fz6LR+sFgaYSFM3BDgvUu1h/ceSF5JSIFpwGApIwyM4V0cUM
	 x3VCYfAvyxFS6u4gvErYrvqRfycAAfVrwvPpm5TO+hboOmzS2uzYaZGU5ghMHeg3Gd
	 epiy2AL/T4FS7xgFD5ndVFapNeSluO3r+8MamF+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfAKPo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfAKPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:44:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3485520700;
        Fri, 11 Jan 2019 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547221495;
        bh=iB9YSW+6tEh4UUPc/YgVvZMH62OXRNTa42Sk2nc5vrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ic13tt78sIGXPW1hjsKYGjAqyNsQ1d019EUQlKZTpgHD2+Puv8fr8762NF4JTvcem
         t8V6K04j1ZZo8dsUfBIcSsOoTb3sJy63IdgRRECAcHPyVSbY1bcrBW6Kk8Z+Bq39Ji
         HF/u/J53iBnGCZs+gjpen3RYbLvOPP3Sn52alF10=
Date:   Fri, 11 Jan 2019 16:44:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ming Lin <ming.l@ssi.samsung.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 4.4 72/88] block: dont deal with discard limit in
 blkdev_issue_discard()
Message-ID: <20190111154453.GA17051@kroah.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <20190111131058.120784730@linuxfoundation.org>
 <20190111142539.GA10601@redhat.com>
 <20190111143514.GA8530@kroah.com>
 <20190111150605.GA10771@redhat.com>
 <20190111151757.GA15261@kroah.com>
 <20190111152314.GA10825@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111152314.GA10825@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:23:15AM -0500, Mike Snitzer wrote:
> On Fri, Jan 11 2019 at 10:17am -0500,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Jan 11, 2019 at 10:06:05AM -0500, Mike Snitzer wrote:
> > > On Fri, Jan 11 2019 at  9:35am -0500,
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Fri, Jan 11, 2019 at 09:25:39AM -0500, Mike Snitzer wrote:
> > > > > On Fri, Jan 11 2019 at  9:08am -0500,
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > 
> > > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > > > 
> > > > > > ------------------
> > > > > > 
> > > > > > From: Ming Lei <ming.lei@redhat.com>
> > > > > > 
> > > > > > commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 upstream.
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > Please also pick up this commit:
> > > > > 89f5fa47476eda56402e29fff3c5097f5c2a1e19 ("dm: call blk_queue_split() to
> > > > > impose device limits on bios")
> > > > 
> > > > That's going to be hard as the dependancy for that patch is not here in
> > > > 4.4.y, and this patch itself isn't even in anything older than 4.19.y.
> > > 
> > > Right, I quickly replied to this thread with followup of the 3 prereq
> > > patches needed to get 89f5fa47476 to apply.
> > > 
> > > > So why add it here to 4.4.y only?
> > > 
> > > Because you're looking to pull in a commit into 4.4 that causes problems
> > > elsewhere.
> > >  
> > > > Can you send the needed patch series to the stable@ mailing list for the
> > > > different stable trees if this needs to get into them?
> > > 
> > > I'll try to get to that, but it is low priority for me.  And in the
> > > meantime.. DM will be broken in 4.4 if you take 744889b7cb.. wheeeee.
> > 
> > Ok, then I should drop this patch from 4.4, I can do that.  Looks like
> > it's not in 4.9 either, so that's another good reason to not take it
> > here as well.
> > 
> > Any objection to just dropping it?
> 
> I'd prefer that for sure.  I don't think the empty discard issue that
> commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 addresses is worth the
> other DM breakage.  But I'm biased ;)

Ok, this was added because af097f5d199e ("block: break discard
submissions into the user defined size") was also wanting to be added to
the 4.4.y tree.  And this commit was "supposed" to be fixing a problem
in that commit.

I guess we should just stick with what we have in 4.4.y for now, as
there hasn't been any complaints :)

I'll drop both of these now, thanks.

greg k-h
