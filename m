Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE1D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJDOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbeJDOaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:30:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9E5FAE4D;
        Thu,  4 Oct 2018 07:38:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 15E801E3614; Thu,  4 Oct 2018 09:38:09 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:38:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181004073809.GD29482@quack2.suse.cz>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 17:55:41, Paolo Valente wrote:
> > On 03.10.2018 08:29, Paolo Valente wrote:
> >> As also Linus Torvalds complained [1], people feel lost among
> >> I/O-scheduler options.  Actual differences across I/O schedulers are
> >> basically obscure to non experts.  In this respect, Linux-kernel
> >> 'users' are way more than a few top-level distros that can afford a
> >> strong performance team, and that, basing on the input of such a team,
> >> might venture light-heartedly to change a critical component like an
> >> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
> >> are not distros that use udev.
> > 
> > I feel a contradiction in this counter-argument. On one hand, there are lots of, let's call them, home users, that use major distributions with udev, so the distribution maintainers can reasonably decide which scheduler to use for which type of device based on the udev rule and common sense provided via Documentation/ by linux-block devs. Moreover, most likely, those rules should be similar or the same across all the major distros and available via some (systemd?) upstream.
> > 
> 
> Let me basically repeat Mark's answer here, with my words.
> 
> Unfortunately, facts mismatch with your optimistic view: after so many
> years and concordant test results, only very few distributions
> switched to bfq, no major distribution did (AFAIK).  As I already
> wrote, the reason is the one pointed out by Torvalds [1].  Do you want
> a simple example?  Take the last sentence in Jan's email in this
> thread: "I *personally would* consider bfq a safer default ...  but *I
> don't feel too strongly* about it." And he is definitely a storage
> expert.

Yeah, but let me add that currently all our released kernels still use legacy
block stack for SCSI by default and thus CFQ/deadline. And once we feel
scsi-mq + BFQ is comparable enough for rotating disks (which may be after
your latest changes, Andreas will be running some larger evaluation), we
are going to switch to that instead of scsi + CFQ. So it's not like for us
it is a question between deadline-mq and BFQ, it is rather between scsi +
CFQ vs scsi-mq + BFQ.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
