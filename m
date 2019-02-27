Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4124FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E72A2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfB0Ssf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62259 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfB0Sse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:48:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78E7D30CF844;
        Wed, 27 Feb 2019 18:48:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37FA219C7B;
        Wed, 27 Feb 2019 18:48:34 +0000 (UTC)
Date:   Wed, 27 Feb 2019 13:48:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 42/77] dm: fix clone_bio() to trigger
 blk_recount_segments()
Message-ID: <20190227184833.GA16859@redhat.com>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-42-sashal@kernel.org>
 <20190215034909.GB17226@redhat.com>
 <20190227173821.GK10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227173821.GK10616@sasha-vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 27 Feb 2019 18:48:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27 2019 at 12:38pm -0500,
Sasha Levin <sashal@kernel.org> wrote:

> On Thu, Feb 14, 2019 at 10:49:09PM -0500, Mike Snitzer wrote:
> >On Thu, Feb 14 2019 at  9:08pm -0500,
> >Sasha Levin <sashal@kernel.org> wrote:
> >
> >>From: Mike Snitzer <snitzer@redhat.com>
> >>
> >>[ Upstream commit 57c36519e4b949f89381053f7283f5d605595b42 ]
> >>
> >>DM's clone_bio() now benefits from using bio_trim() by fixing the fact
> >>that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
> >>which triggers blk_recount_segments() via bio_phys_segments().
> >>
> >>Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >>Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >>Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >Please no, I later effectively reverted this change with commit
> >fa8db4948f522 ("dm: don't use bio_trim() afterall")
> 
> I've dropped it, thank you.
> 
> >(As and aside, I really shouldn't have to defend against stable@ bots
> >picking up a commit, like 57c36519e4b949f, that wasn't marked for
> >stable@.)
> 
> Is it the case that this commit isn't appropriate for stable for some
> reason, or was it just buggy?

Commit 57c36519e4b9 exposed a bug elsewhere, as fixed by a truly
"stable" fix:
ff0c129d3b5ec ("dm crypt: don't overallocate the integrity tag space")

So the end result is commit 57c36519e4b9 is just bad to bring to a
"stable" kernel.  It unlocks another bug for no meaningful benefit.

Mike
