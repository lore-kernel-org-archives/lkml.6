Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F063C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJENWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:22:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:38748 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeJENWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:22:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 23:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="89376997"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2018 23:24:54 -0700
Received: from abityuts-desk.fi.intel.com (abityuts-desk.fi.intel.com [10.237.68.39])
        by linux.intel.com (Postfix) with ESMTP id E7F375801E6;
        Thu,  4 Oct 2018 23:24:49 -0700 (PDT)
Message-ID: <1538720688.14984.143.camel@gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Bart Van Assche <bvanassche@acm.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Oct 2018 09:24:48 +0300
In-Reply-To: <1538683746.230807.9.camel@acm.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1538582091.205649.20.camel@acm.org>
         <20181004202553.71c2599c@alans-desktop> <1538683746.230807.9.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 13:09 -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 20:25 +0100, Alan Cox wrote:
> > > I agree with Jens that it's best to leave it to the Linux distributors to
> > > select a default I/O scheduler.
> > 
> > That assumes such a thing exists. The kernel knows what devices it is
> > dealing with. The kernel 'default' ought to be 'whatever is usually best
> > for this device'. A distro cannot just pick a correct single default
> > because NVME and USB sticks are both normal and rather different in needs.
> 
> Which I/O scheduler works best also depends which workload the user will run.
> BFQ has significant advantages for interactive workloads like video replay
> with concurrent background I/O but probably slows down kernel builds. That's
> why I'm not sure whether the kernel should select the default I/O scheduler.

Whats wrong with this simple hierarchy?

1. Block core selects the default scheduler.
2. Driver can overrule it early.
3. Userspace can overrule the default later.

Everyone is happy.

Good defaults in block core are great. Those defaults + #3 may cover
99% of the population.

1% of the population can use #2. See, Linus wants "bfq" for ubiblock.
Why wouldn't we to let him work with UBI community, show that bfq is 
best for ubiblock, and just let the UBI community overrule the block
core's default.

If some day in the future there is a very good reason, we can even make
this to be a module parameter, and people could just boot with
'ubiblock.iosched=bfq'.
